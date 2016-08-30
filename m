From: afd@ti.com (Andrew F. Davis)
Date: Tue, 30 Aug 2016 15:23:24 -0500
Subject: [PATCH v11 3/4] tee: add OP-TEE driver
In-Reply-To: <1471870856-18684-4-git-send-email-jens.wiklander@linaro.org>
References: <1471870856-18684-1-git-send-email-jens.wiklander@linaro.org>
 <1471870856-18684-4-git-send-email-jens.wiklander@linaro.org>
Message-ID: <050a2ce4-e175-d09e-ddff-3b0cbe766d88@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2016 08:00 AM, Jens Wiklander wrote:
> +	/*
> +	 * We add ourselves to the queue, but we don't wait. This
> +	 * guarentees that we don't lose a completion if secure world

             ^^ spelling
[snip]

> +static struct tee_shm *get_msg_arg(struct tee_context *ctx, size_t num_params,
> +				   struct optee_msg_arg **msg_arg,
> +				   phys_addr_t *msg_parg)
> +{
> +	int rc;
> +	struct tee_shm *shm;
> +	struct optee_msg_arg *ma;
> +
> +	shm = tee_shm_alloc(ctx, OPTEE_MSG_GET_ARG_SIZE(num_params),
> +			    TEE_SHM_MAPPED);
> +	if (IS_ERR(shm))
> +		return shm;

Lack of newlines are an issue throughout this series so I'll just point
it out once here, these are not logically close steps in my mind, I
would space this out a bit. Same for return, a newline before the final
return just looks nice.

> +	ma = tee_shm_get_va(shm, 0);
> +	if (IS_ERR(ma)) {
> +		rc = PTR_ERR(ma);
> +		goto out;
> +	}
> +	rc = tee_shm_get_pa(shm, 0, msg_parg);
> +	if (rc)
> +		goto out;
> +
> +	memset(ma, 0, OPTEE_MSG_GET_ARG_SIZE(num_params));
> +	ma->num_params = num_params;
> +	*msg_arg = ma;
> +out:
> +	if (rc) {
> +		tee_shm_free(shm);
> +		return ERR_PTR(rc);
> +	}
> +	return shm;
> +}
> +
> +int optee_open_session(struct tee_context *ctx,
> +		       struct tee_ioctl_open_session_arg *arg,
> +		       struct tee_param *param)
> +{
> +	struct optee_context_data *ctxdata = ctx->data;
> +	int rc;
> +	struct tee_shm *shm;
> +	struct optee_msg_arg *msg_arg;
> +	phys_addr_t msg_parg;
> +	struct optee_msg_param *msg_param;
> +	struct optee_session *sess = NULL;
> +
> +	/* +2 for the meta parameters added below */
> +	shm = get_msg_arg(ctx, arg->num_params + 2, &msg_arg, &msg_parg);
> +	if (IS_ERR(shm))
> +		return PTR_ERR(shm);
> +
> +	msg_arg->cmd = OPTEE_MSG_CMD_OPEN_SESSION;
> +	msg_arg->cancel_id = arg->cancel_id;
> +	msg_param = OPTEE_MSG_GET_PARAMS(msg_arg);
> +
> +	/*
> +	 * Initialize and add the meta parameters needed when opening a
> +	 * session.
> +	 */
> +	msg_param[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT |
> +			    OPTEE_MSG_ATTR_META;
> +	msg_param[1].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT |
> +			    OPTEE_MSG_ATTR_META;
> +	memcpy(&msg_param[0].u.value, arg->uuid, sizeof(arg->uuid));
> +	memcpy(&msg_param[1].u.value, arg->uuid, sizeof(arg->clnt_uuid));
> +	msg_param[1].u.value.c = arg->clnt_login;
> +
> +	rc = optee_to_msg_param(msg_param + 2, arg->num_params, param);
> +	if (rc)
> +		goto out;

Everyone of these gotos will kfree(NULL), it doesn't hurt, but is there
someway you can restructure the error path?

> +
> +	sess = kzalloc(sizeof(*sess), GFP_KERNEL);
> +	if (!sess) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (optee_do_call_with_arg(ctx, msg_parg)) {
> +		msg_arg->ret = TEEC_ERROR_COMMUNICATION;
> +		msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
> +	}
> +
> +	if (msg_arg->ret == TEEC_SUCCESS) {
> +		/* A new session has been created, add it to the list. */
> +		sess->session_id = msg_arg->session;
> +		mutex_lock(&ctxdata->mutex);
> +		list_add(&sess->list_node, &ctxdata->sess_list);
> +		mutex_unlock(&ctxdata->mutex);
> +		sess = NULL;
> +	}
> +
> +	if (optee_from_msg_param(param, arg->num_params, msg_param + 2)) {
> +		arg->ret = TEEC_ERROR_COMMUNICATION;
> +		arg->ret_origin = TEEC_ORIGIN_COMMS;
> +		/* Close session again to avoid leakage */
> +		optee_close_session(ctx, msg_arg->session);
> +	} else {
> +		arg->session = msg_arg->session;
> +		arg->ret = msg_arg->ret;
> +		arg->ret_origin = msg_arg->ret_origin;
> +	}
> +out:
> +	kfree(sess);
> +	tee_shm_free(shm);
> +	return rc;
> +}

[snip]

> +static void optee_release(struct tee_context *ctx)
> +{
> +	struct optee_context_data *ctxdata = ctx->data;
> +	struct tee_device *teedev = ctx->teedev;
> +	struct optee *optee = tee_get_drvdata(teedev);
> +	struct tee_shm *shm;
> +	struct optee_msg_arg *arg = NULL;
> +	phys_addr_t parg;
> +
> +	if (!ctxdata)
> +		return;
> +
> +	shm = tee_shm_alloc(ctx, sizeof(struct optee_msg_arg), TEE_SHM_MAPPED);
> +	if (!IS_ERR(shm)) {
> +		arg = tee_shm_get_va(shm, 0);
> +		/*
> +		 * If va2pa fails for some reason, we can't call
> +		 * optee_close_session(), only free the memory. Secure OS
> +		 * will leak sessions and finally refuse more session, but
> +		 * we will at least let normal world reclaim its memory.
> +		 */
> +		if (!IS_ERR(arg))
> +			tee_shm_va2pa(shm, arg, &parg);
> +	}
> +
> +	while (true) {

This looks like it could be restructured using list_for_each_entry_safe.

> +		struct optee_session *sess;
> +
> +		sess = list_first_entry_or_null(&ctxdata->sess_list,
> +						struct optee_session,
> +						list_node);
> +		if (!sess)
> +			break;
> +		list_del(&sess->list_node);
> +		if (!IS_ERR_OR_NULL(arg)) {
> +			memset(arg, 0, sizeof(*arg));
> +			arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
> +			arg->session = sess->session_id;
> +			optee_do_call_with_arg(ctx, parg);
> +		}
> +		kfree(sess);
> +	}
> +	kfree(ctxdata);
> +
> +	if (!IS_ERR(shm))
> +		tee_shm_free(shm);
> +
> +	ctx->data = NULL;
> +
> +	if (teedev == optee->supp_teedev) {
> +		mutex_lock(&optee->supp.ctx_mutex);
> +		optee->supp.ctx = NULL;
> +		mutex_unlock(&optee->supp.ctx_mutex);
> +	}
> +}

[snip]

> +static struct tee_shm_pool *
> +optee_config_shm_ioremap(struct device *dev, optee_invoke_fn *invoke_fn,
> +			 void __iomem **ioremaped_shm)
> +{
> +	struct arm_smccc_res res;
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
> +	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0 != OPTEE_SMC_RETURN_OK) {
> +		dev_info(dev, "shm service not available\n");
> +		return ERR_PTR(-ENOENT);
> +	}
> +
> +	if (res.a3 != OPTEE_SMC_SHM_CACHED) {
> +		dev_err(dev, "only normal cached shared memory supported\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	begin = roundup(res.a1, PAGE_SIZE);
> +	end = rounddown(res.a1 + res.a2, PAGE_SIZE);

res.a1/2/3 is really hard to review and understand, would it work better
to use a union or cast for the output of invoke_fn based on the function
type?

In the header that defines what the returned info from these calls means
add:

struct OPTEE_SMC_GET_SHM_CONFIG_RESULT {
	unsigned long status;
	unsigned long start;
	unsigned long size;
	unsigned long settings;
};

then:

union something result;

begin = roundup(result.ret.start, PAGE_SIZE);
end = rounddown(result.ret.start + result.ret.size, PAGE_SIZE);

or similar with just casting to the better named struct type.

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
> +
> +	priv_info.vaddr = vaddr;
> +	priv_info.paddr = paddr;
> +	priv_info.size = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> +	dmabuf_info.vaddr = vaddr + OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> +	dmabuf_info.paddr = paddr + OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> +	dmabuf_info.size = size - OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> +
> +	pool = tee_shm_pool_alloc_res_mem(dev, &priv_info, &dmabuf_info);
> +	if (IS_ERR(pool))
> +		iounmap(va);

Should we error out here? It gets handled later but this doesn't flow
right for me, this doesn't sow that this is an error case and makes it
look like ioremaped_shm = va is just an alternative to iounmap(va),
maybe do this:

	pool = tee_shm_pool_alloc_res_mem(dev, ...
	if (IS_ERR(pool)) {
		iounmap(va);
		goto out;
	}

	*ioremaped_shm = va;
out:


> +	else
> +		*ioremaped_shm = va;
> +	return pool;
> +}

[snip]

> +static int optee_probe(struct platform_device *pdev)
> +{
> +	optee_invoke_fn *invoke_fn;
> +	struct tee_shm_pool *pool;
> +	struct optee *optee = NULL;
> +	void __iomem *ioremaped_shm = NULL;
> +	struct tee_device *teedev;
> +	u32 sec_caps;
> +	int rc;
> +
> +	rc = get_invoke_func(&pdev->dev, &invoke_fn);
> +	if (rc)
> +		return rc;
> +
> +	if (!optee_msg_api_uid_is_optee_api(invoke_fn) ||
> +	    !optee_msg_api_revision_is_compatible(invoke_fn) ||
> +	    !optee_msg_exchange_capabilities(invoke_fn, &sec_caps))
> +		return -EINVAL;

When I was testing and the TEE would fail to get started this was a
frustrating source of silent errors.

I would recommend each of these be broken out and have an error message
describing why probe failed.

> +
> +	/*
> +	 * We have no other option for shared memory, if secure world
> +	 * doesn't have any reserved memory we can use we can't continue.
> +	 */
> +	if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVERED_SHM))
> +		return -EINVAL;
> +
> +	pool = optee_config_shm_ioremap(&pdev->dev, invoke_fn, &ioremaped_shm);
> +	if (IS_ERR(pool))
> +		return PTR_ERR(pool);
> +
> +	optee = devm_kzalloc(&pdev->dev, sizeof(*optee), GFP_KERNEL);
> +	if (!optee) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	optee->dev = &pdev->dev;
> +	optee->invoke_fn = invoke_fn;
> +
> +	teedev = tee_device_alloc(&optee_desc, &pdev->dev, pool, optee);
> +	if (IS_ERR(teedev)) {
> +		rc = PTR_ERR(teedev);
> +		goto err;
> +	}
> +	optee->teedev = teedev;
> +
> +	teedev = tee_device_alloc(&optee_supp_desc, &pdev->dev, pool, optee);
> +	if (IS_ERR(teedev)) {
> +		rc = PTR_ERR(teedev);
> +		goto err;
> +	}
> +	optee->supp_teedev = teedev;
> +
> +	rc = tee_device_register(optee->teedev);
> +	if (rc)
> +		goto err;
> +
> +	rc = tee_device_register(optee->supp_teedev);
> +	if (rc)
> +		goto err;
> +
> +	mutex_init(&optee->call_queue.mutex);
> +	INIT_LIST_HEAD(&optee->call_queue.waiters);
> +	optee_wait_queue_init(&optee->wait_queue);
> +	optee_supp_init(&optee->supp);
> +	optee->ioremaped_shm = ioremaped_shm;
> +	optee->pool = pool;
> +
> +	platform_set_drvdata(pdev, optee);
> +
> +	optee_enable_shm_cache(optee);
> +
> +	dev_info(&pdev->dev, "initialized driver\n");
> +	return 0;
> +err:
> +	if (optee) {

Just because optee points to valid memory, doesn't mean we should
unregister right? These might not have been registered.

> +		tee_device_unregister(optee->teedev);
> +		tee_device_unregister(optee->supp_teedev);
> +	}
> +	if (pool)
> +		tee_shm_pool_free(pool);
> +	if (ioremaped_shm)
> +		iounmap(optee->ioremaped_shm);
> +	return rc;
> +}
> +
> +static int optee_remove(struct platform_device *pdev)
> +{
> +	struct optee *optee = platform_get_drvdata(pdev);
> +
> +	optee_disable_shm_cache(optee);
> +
> +	tee_device_unregister(optee->teedev);
> +	tee_device_unregister(optee->supp_teedev);
> +	tee_shm_pool_free(optee->pool);
> +	if (optee->ioremaped_shm)
> +		iounmap(optee->ioremaped_shm);
> +	optee_wait_queue_exit(&optee->wait_queue);
> +	optee_supp_uninit(&optee->supp);
> +	mutex_destroy(&optee->call_queue.mutex);

Can these be reordered to match the reverse of the order they are used
in probe?

> +	return 0;
> +}
> +

[snip]

> +#define OPTEE_MSG_ATTR_CACHE_SHIFT		16
> +#define OPTEE_MSG_ATTR_CACHE_MASK		0x7

GENMASK

> +#define OPTEE_MSG_ATTR_CACHE_PREDEFINED		0
> +

[snip]

> +/**
> + * struct optee_msg_param_value - values
> + * @a: first value
> + * @b: second value
> + * @c: third value
> + */
> +struct optee_msg_param_value {
> +	u64 a;
> +	u64 b;
> +	u64 c;
> +};
> +

I think this is my favorite struct and kernel doc ever :)

Like a lot of the comment docs in this file it is documentation for
documentation sake, but it doesn't actually say anything.

> +/**
> + * struct optee_msg_param - parameter
> + * @attr: attributes
> + * @memref: a memory reference
> + * @value: a value
> + *

[snip]

> +/*
> + * Function specified by SMC Calling convention
> + *
> + * Return one of the following UIDs if using API specified in this file
> + * without further extentions:

"extensions" is spelt wrong everywhere in this series.

> + * 65cb6b93-af0c-4617-8ed6-644a8d1140f8
> + * see also OPTEE_SMC_UID_* in optee_msg.h
> + */
> +#define OPTEE_SMC_FUNCID_CALLS_UID OPTEE_MSG_FUNCID_CALLS_UID
> +#define OPTEE_SMC_CALLS_UID \
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> +			   ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> +			   OPTEE_SMC_FUNCID_CALLS_UID)

[snip]

> +	case OPTEE_SMC_RPC_FUNC_IRQ:
> +		/*
> +		 * An IRQ was raised while secure world was executing,
> +		 * since all IRQs a handled in Linux a dummy RPC is

                                 ^^ are

> diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> index 1d7e212..3cb0ad0 100644
> --- a/drivers/tee/tee_shm_pool.c
> +++ b/drivers/tee/tee_shm_pool.c
> @@ -28,6 +28,8 @@ static int pool_op_gen_alloc(struct tee_shm_pool_mgr *poolm,
>  	va = gen_pool_alloc(genpool, s);
>  	if (!va)
>  		return -ENOMEM;
> +
> +	memset((void *)va, 0, s);

Should be in the other patch.

>  	shm->kaddr = (void *)va;
>  	shm->paddr = gen_pool_virt_to_phys(genpool, va);
>  	shm->size = s;
> 
