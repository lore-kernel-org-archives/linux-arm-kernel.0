From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jan 2017 17:28:17 +0100
Subject: [PATCH v14 3/5] tee: add OP-TEE driver
In-Reply-To: <1484744296-30003-4-git-send-email-jens.wiklander@linaro.org>
References: <1484744296-30003-1-git-send-email-jens.wiklander@linaro.org>
 <1484744296-30003-4-git-send-email-jens.wiklander@linaro.org>
Message-ID: <12500736.cNG1jjvVpX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 18, 2017 1:58:14 PM CET Jens Wiklander wrote:
> Adds a OP-TEE driver which also can be compiled as a loadable module.
> 
> * Targets ARM and ARM64
> * Supports using reserved memory from OP-TEE as shared memory
> * Probes OP-TEE version using SMCs
> * Accepts requests on privileged and unprivileged device
> * Uses OPTEE message protocol version 2 to communicate with secure world

I had not really followed the last versions, and I've looked through
it now for things that seemed odd to me, either because I don't understand
them or because they could be improved. I'll try to read it again after
I've seen clarifications on these points.

Generally speaking I haven't seen any show-stoppers so far.

> +struct optee_call_waiter {
> +	struct list_head list_node;
> +	struct completion c;
> +	bool completed;
> +};

It seems wrong to have both a 'struct completion' and 'bool completed' here,
as completion already contains such a flag and is designed to update that
atomically.

> +static void optee_cq_complete_one(struct optee_call_queue *cq)
> +{
> +	struct optee_call_waiter *w;
> +
> +	list_for_each_entry(w, &cq->waiters, list_node) {
> +		if (!w->completed) {
> +			complete(&w->c);
> +			w->completed = true;
> +			break;
> +		}
> +	}
> +}
> +
> +static void optee_cq_wait_final(struct optee_call_queue *cq,
> +				struct optee_call_waiter *w)
> +{
> +	mutex_lock(&cq->mutex);
> +
> +	/* Get out of the list */
> +	list_del(&w->list_node);
> +
> +	optee_cq_complete_one(cq);
> +	/*
> +	 * If we're completed we've got a completion that some other task
> +	 * could have used instead.
> +	 */
> +	if (w->completed)
> +		optee_cq_complete_one(cq);
> +
> +	mutex_unlock(&cq->mutex);
> +}

This deserves some more comments: the function name suggests that you are
waiting for a specific optee_call_waiter, but then it calls
optee_cq_complete_one(), which unconditionally completes the first
incomplete completion and it never waits.

> +static struct tee_shm_pool *
> +optee_config_shm_ioremap(struct device *dev, optee_invoke_fn *invoke_fn,
> +			 void __iomem **ioremaped_shm)
> +{
> +	union {
> +		struct arm_smccc_res smccc;
> +		struct optee_smc_get_shm_config_result result;
> +	} res;
> +	struct tee_shm_pool *pool;
> +	unsigned long vaddr;
> +	phys_addr_t paddr;
> +	size_t size;
> +	phys_addr_t begin;
> +	phys_addr_t end;
> +	void __iomem *va;
> +	struct tee_shm_pool_mem_info priv_info;
> +	struct tee_shm_pool_mem_info dmabuf_info;
> +
> +	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
> +	if (res.result.status != OPTEE_SMC_RETURN_OK) {
> +		dev_info(dev, "shm service not available\n");
> +		return ERR_PTR(-ENOENT);
> +	}
> +
> +	if (res.result.settings != OPTEE_SMC_SHM_CACHED) {
> +		dev_err(dev, "only normal cached shared memory supported\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	begin = roundup(res.result.start, PAGE_SIZE);
> +	end = rounddown(res.result.start + res.result.size, PAGE_SIZE);
> +	paddr = begin;
> +	size = end - begin;
> +
> +	if (size < 2 * OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE) {
> +		dev_err(dev, "too small shared memory area\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	va = ioremap_cache(paddr, size);
> +	if (!va) {
> +		dev_err(dev, "shared memory ioremap failed\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +	vaddr = (unsigned long)va;

I think you should call memremap() instead of ioremap_cache() here and assume
that you are talking to actual RAM.

> +static int __init optee_driver_init(void)
> +{
> +	struct device_node *node;
> +
> +	/*
> +	 * Preferred path is /firmware/optee, but it's the matching that
> +	 * matters.
> +	 */
> +	for_each_matching_node(node, optee_match)
> +		of_platform_device_create(node, NULL, NULL);
> +
> +	return platform_driver_register(&optee_driver);
> +}
> +module_init(optee_driver_init);
> +
> +static void __exit optee_driver_exit(void)
> +{
> +	platform_driver_unregister(&optee_driver);
> +}
> +module_exit(optee_driver_exit);

What is the platform driver good for if the same module has to create the
platform devices itself?

I'd just skip it and do

	for_each_matching_node(node, optee_match)
		optee_probe(node);

I also suspect that module unloading is broken here if you don't clean
up the platform devices in the end, so you should already remove the
exit function to prevent unloading.

> +struct optee_msg_arg {
> +	u32 cmd;
> +	u32 func;
> +	u32 session;
> +	u32 cancel_id;
> +	u32 pad;
> +	u32 ret;
> +	u32 ret_origin;
> +	u32 num_params;
> +
> +	/*
> +	 * this struct is 8 byte aligned since the 'struct optee_msg_param'
> +	 * which follows requires 8 byte alignment.
> +	 *
> +	 * Commented out element used to visualize the layout dynamic part
> +	 * of the struct. This field is not available at all if
> +	 * num_params == 0.
> +	 *
> +	 * params is accessed through the macro OPTEE_MSG_GET_PARAMS
> +	 *
> +	 * struct optee_msg_param params[num_params];
> +	 */
> +} __aligned(8);
> +
> +/**
> + * OPTEE_MSG_GET_PARAMS - return pointer to struct optee_msg_param *
> + *
> + * @x: Pointer to a struct optee_msg_arg
> + *
> + * Returns a pointer to the params[] inside a struct optee_msg_arg.
> + */
> +#define OPTEE_MSG_GET_PARAMS(x) \
> +	(struct optee_msg_param *)(((struct optee_msg_arg *)(x)) + 1)

If you make the last member of optee_msg_arg

	struct optee_msg_param params[0];

then you can remove both the macro here and the alignment attribute.

> +/*****************************************************************************
> + * Part 2 - requests from normal world
> + *****************************************************************************/
> +
> +/*
> + * Return the following UID if using API specified in this file without
> + * further extensions:
> + * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
> + * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_UID_1,
> + * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
> + */
> +#define OPTEE_MSG_UID_0			0x384fb3e0
> +#define OPTEE_MSG_UID_1			0xe7f811e3
> +#define OPTEE_MSG_UID_2			0xaf630002
> +#define OPTEE_MSG_UID_3			0xa5d5c51b
> +#define OPTEE_MSG_FUNCID_CALLS_UID	0xFF01
> +
> +/*
> + * Returns 2.0 if using API specified in this file without further
> + * extensions. Represented in 2 32-bit words in OPTEE_MSG_REVISION_MAJOR
> + * and OPTEE_MSG_REVISION_MINOR
> + */
> +#define OPTEE_MSG_REVISION_MAJOR	2
> +#define OPTEE_MSG_REVISION_MINOR	0
> +#define OPTEE_MSG_FUNCID_CALLS_REVISION	0xFF03
> +
> +/*
> + * Get UUID of Trusted OS.
> + *
> + * Used by non-secure world to figure out which Trusted OS is installed.
> + * Note that returned UUID is the UUID of the Trusted OS, not of the API.
> + *
> + * Returns UUID in 4 32-bit words in the same way as
> + * OPTEE_MSG_FUNCID_CALLS_UID described above.
> + */
> +#define OPTEE_MSG_OS_OPTEE_UUID_0	0x486178e0
> +#define OPTEE_MSG_OS_OPTEE_UUID_1	0xe7f811e3
> +#define OPTEE_MSG_OS_OPTEE_UUID_2	0xbc5e0002
> +#define OPTEE_MSG_OS_OPTEE_UUID_3	0xa5d5c51b
> +#define OPTEE_MSG_FUNCID_GET_OS_UUID	0x0000
> +
> +/*
> + * Get revision of Trusted OS.
> + *
> + * Used by non-secure world to figure out which version of the Trusted OS
> + * is installed. Note that the returned revision is the revision of the
> + * Trusted OS, not of the API.
> + *
> + * Returns revision in 2 32-bit words in the same way as
> + * OPTEE_MSG_CALLS_REVISION described above.
> + */
> +#define OPTEE_MSG_OS_OPTEE_REVISION_MAJOR	1
> +#define OPTEE_MSG_OS_OPTEE_REVISION_MINOR	0
> +#define OPTEE_MSG_FUNCID_GET_OS_REVISION	0x0001

Just for my understanding, what is the significance of these numbers,
i.e. which code (user space, kernel driver, trusted OS) provides
the uuid and which one provides the version? The code comments almost
make sense to me, but I don't see why specific versions are listed
in this header.

What is the expected behavior when one side reports a version that
is unknown? Can one side claim to be backwards compatible with
a previous version, or does each new version need support on
all three sides?

> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> new file mode 100644
> index 000000000000..0b9c1a2accd0
> --- /dev/null
> +++ b/drivers/tee/optee/rpc.c
> +static void handle_rpc_func_cmd_wq(struct optee *optee,
> +				   struct optee_msg_arg *arg)
> +{
> +	struct optee_msg_param *params;
> +
> +	if (arg->num_params != 1)
> +		goto bad;
> +
> +	params = OPTEE_MSG_GET_PARAMS(arg);
> +	if ((params->attr & OPTEE_MSG_ATTR_TYPE_MASK) !=
> +			OPTEE_MSG_ATTR_TYPE_VALUE_INPUT)
> +		goto bad;
> +
> +	switch (params->u.value.a) {
> +	case OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP:
> +		wq_sleep(&optee->wait_queue, params->u.value.b);
> +		break;
> +	case OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP:
> +		wq_wakeup(&optee->wait_queue, params->u.value.b);
> +		break;
> +	default:
> +		goto bad;
> +	}
> +
> +	arg->ret = TEEC_SUCCESS;
> +	return;
> +bad:
> +	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +}
> +

I'm trying to understand what this is good for. What I can see is that
you have a user space process calling into the kernel asking the tee
to do some command, and then the tee can ask the kernel to wait for
something to happen, or notify it that something has happened.

If we wait here, the user process gets suspended until this has
actually happened.

Am I reading this correctly? If yes, what is the intended use case?
Is there some process that is meant to always wait here? What
if we ever need to wait for more than one thing at a time (think
select or poll?)

> +	params = OPTEE_MSG_GET_PARAMS(arg);
> +	if ((params->attr & OPTEE_MSG_ATTR_TYPE_MASK) !=
> +			OPTEE_MSG_ATTR_TYPE_VALUE_INPUT)
> +		goto bad;
> +
> +	msec_to_wait = params->u.value.a;
> +
> +	/* set task's state to interruptible sleep */
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	/* take a nap */
> +	schedule_timeout(msecs_to_jiffies(msec_to_wait));

This can be done simpler with msleep();

	Arnd
