From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jan 2017 17:57:51 +0100
Subject: [PATCH v14 3/5] tee: add OP-TEE driver
In-Reply-To: <20170119145621.GA4958@jax>
References: <1484744296-30003-1-git-send-email-jens.wiklander@linaro.org>
 <12500736.cNG1jjvVpX@wuerfel> <20170119145621.GA4958@jax>
Message-ID: <8183743.bSJXZpMh95@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 19, 2017 3:56:23 PM CET Jens Wiklander wrote:
> On Wed, Jan 18, 2017 at 05:28:17PM +0100, Arnd Bergmann wrote:
> > On Wednesday, January 18, 2017 1:58:14 PM CET Jens Wiklander wrote:

> > > +static void optee_cq_complete_one(struct optee_call_queue *cq)
> > > +{
> > > +	struct optee_call_waiter *w;
> > > +
> > > +	list_for_each_entry(w, &cq->waiters, list_node) {
> > > +		if (!w->completed) {
> > > +			complete(&w->c);
> > > +			w->completed = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +static void optee_cq_wait_final(struct optee_call_queue *cq,
> > > +				struct optee_call_waiter *w)
> > > +{
> > > +	mutex_lock(&cq->mutex);
> > > +
> > > +	/* Get out of the list */
> > > +	list_del(&w->list_node);
> > > +
> > > +	optee_cq_complete_one(cq);
> > > +	/*
> > > +	 * If we're completed we've got a completion that some other task
> > > +	 * could have used instead.
> > > +	 */
> > > +	if (w->completed)
> > > +		optee_cq_complete_one(cq);
> > > +
> > > +	mutex_unlock(&cq->mutex);
> > > +}
> > 
> > This deserves some more comments: the function name suggests that you are
> > waiting for a specific optee_call_waiter, but then it calls
> > optee_cq_complete_one(), which unconditionally completes the first
> > incomplete completion and it never waits.
> 
> OK, I'm updating these functions with more comments. The purpose of
> these functions is to deal with resource shortage in secure world.
> There's a limit on how many threads that execute concurrently in secure
> world. optee_cq_wait_for_completion() waits for any task returning from
> a call to secure world, optee_cq_complete_one() doesn't care who's
> completed as long as tasks aren't stuck when there's available resources
> in secure world.

Ok, that is indeed not clear from the code but your explanation makes
perfect sense, thanks!

> > > +static int __init optee_driver_init(void)
> > > +{
> > > +	struct device_node *node;
> > > +
> > > +	/*
> > > +	 * Preferred path is /firmware/optee, but it's the matching that
> > > +	 * matters.
> > > +	 */
> > > +	for_each_matching_node(node, optee_match)
> > > +		of_platform_device_create(node, NULL, NULL);
> > > +
> > > +	return platform_driver_register(&optee_driver);
> > > +}
> > > +module_init(optee_driver_init);
> > > +
> > > +static void __exit optee_driver_exit(void)
> > > +{
> > > +	platform_driver_unregister(&optee_driver);
> > > +}
> > > +module_exit(optee_driver_exit);
> > 
> > What is the platform driver good for if the same module has to create the
> > platform devices itself?
> 
> The platform device(s) are created here because the optee node is below
> "/firmware" instead of the root where it would have had the platform
> device created automatically.
> 
> I think it's useful to be able to unload the module, the early reviews
> of this patch set was much focused around that. Regardless I'll need
> some device as parent for the devices created during optee_probe() and
> using a platform device for that seems natural.
> 
> I'd rather keep the platform driver. Perhaps some variant of the pattern
> in qcom_scm_init() (drivers/firmware/qcom_scm.c) is useful, except that
> I need to find out what to do about the life cycle of the objects
> created with of_platform_populate().

My point was that I don't think we need devices here at all. It's different
when you talk to external hardware that has register resource etc that
can be best abstracted as a real device, but for other firmware features
we don't normally add one.

Module unloading can also be done without the device.

> > 
> > I'd just skip it and do
> > 
> > 	for_each_matching_node(node, optee_match)
> > 		optee_probe(node);
> > 
> > I also suspect that module unloading is broken here if you don't clean
> > up the platform devices in the end, so you should already remove the
> > exit function to prevent unloading.
> 
> Does the platform devices really need cleaning? I mean
> of_platform_default_populate_init() creates a bunch of platform devices
> which are just left there even if unused. Here we're doing the same
> thing except that we're doing it for a specific node in the DT.

I think it will work if you don't clean them up, but it feels wrong
to have a loadable module that creates devices when loaded but doesn't
remove them when unloaded.

This could be done differently by having the device creation done in
one driver and the the user of that device in another driver, but I
think just killing off the device achieves the same in a simpler way.

> > > +/*
> > > + * Get revision of Trusted OS.
> > > + *
> > > + * Used by non-secure world to figure out which version of the Trusted OS
> > > + * is installed. Note that the returned revision is the revision of the
> > > + * Trusted OS, not of the API.
> > > + *
> > > + * Returns revision in 2 32-bit words in the same way as
> > > + * OPTEE_MSG_CALLS_REVISION described above.
> > > + */
> > > +#define OPTEE_MSG_OS_OPTEE_REVISION_MAJOR	1
> > > +#define OPTEE_MSG_OS_OPTEE_REVISION_MINOR	0
> > > +#define OPTEE_MSG_FUNCID_GET_OS_REVISION	0x0001
> > 
> > Just for my understanding, what is the significance of these numbers,
> > i.e. which code (user space, kernel driver, trusted OS) provides
> > the uuid and which one provides the version? The code comments almost
> > make sense to me, but I don't see why specific versions are listed
> > in this header.
> 
> You're right, OPTEE_MSG_OS_OPTEE_REVISION_* should be removed. The
> actual version the secure OS is of a mostly informational nature. The
> same goes the OS UUID, but I suppose the actual UUID used by the
> upstream version of OP-TEE OS could be interesting to know.
...
> > What is the expected behavior when one side reports a version that
> > is unknown? Can one side claim to be backwards compatible with
> > a previous version, or does each new version need support on
> > all three sides?
> 
> The UUID and version of the message protocol are important to match
> correctly as otherwise it could mean that there's something unexpected
> in secure world that following the message protocol would be undefined
> behaviour. All changes to the message protocol should be backwards
> compatible in the sense that the driver and secure world need to
> negotiate eventual extensions while probing. That's what we're doing in
> optee_msg_exchange_capabilities().

Ok, then maybe the "compatible" identifier in DT should be sufficient
to ensure that the capability exchange works, and the rest be based
on that?

We tend to avoid version checks for APIs in the kernel because they
never work in practice, but the capability check should be fine.

> > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > new file mode 100644
> > > index 000000000000..0b9c1a2accd0
> > > --- /dev/null
> > > +++ b/drivers/tee/optee/rpc.c
> > > +static void handle_rpc_func_cmd_wq(struct optee *optee,
> > > +				   struct optee_msg_arg *arg)
> > > +{
> > > +	struct optee_msg_param *params;
> > > +
> > > +	if (arg->num_params != 1)
> > > +		goto bad;
> > > +
> > > +	params = OPTEE_MSG_GET_PARAMS(arg);
> > > +	if ((params->attr & OPTEE_MSG_ATTR_TYPE_MASK) !=
> > > +			OPTEE_MSG_ATTR_TYPE_VALUE_INPUT)
> > > +		goto bad;
> > > +
> > > +	switch (params->u.value.a) {
> > > +	case OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP:
> > > +		wq_sleep(&optee->wait_queue, params->u.value.b);
> > > +		break;
> > > +	case OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP:
> > > +		wq_wakeup(&optee->wait_queue, params->u.value.b);
> > > +		break;
> > > +	default:
> > > +		goto bad;
> > > +	}
> > > +
> > > +	arg->ret = TEEC_SUCCESS;
> > > +	return;
> > > +bad:
> > > +	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > > +}
> > > +
> > 
> > I'm trying to understand what this is good for. What I can see is that
> > you have a user space process calling into the kernel asking the tee
> > to do some command, and then the tee can ask the kernel to wait for
> > something to happen, or notify it that something has happened.
> > 
> > If we wait here, the user process gets suspended until this has
> > actually happened.
> > 
> > Am I reading this correctly? If yes, what is the intended use case?
> > Is there some process that is meant to always wait here? What
> > if we ever need to wait for more than one thing at a time (think
> > select or poll?)
> 
> I'm updating the comments for OPTEE_MSG_RPC_CMD_WAIT_QUEUE with:
> "If secure world need to wait for a secure world mutex it issues a sleep
> request instead of spinning in secure world. Conversely is a wakeup
> request issued when a secure world mutex with a thread waiting thread is
> unlocked."
> 
> The way we're waking up a sleeping thread is a bit limiting in some
> circumstances.
> 
> One case is where we need to do it from a secure interrupt handler.
> Because there's no way of doing this kind of RPC to normal world from a
> secure interrupt handler. In that case it wouldn't be mutex the thread
> is waiting for though.
> 
> Another case is where there's several guest running in the system and
> more than one guests has access to secure world. If guest2 waits for
> mutex which guest1 is releasing, how can guest2 be notified? Normal RPC
> is impossible here also.
> 
> The only way around this limitation I've come up with so far is by doing
> the wakeup via a software generated interrupt destined to the correct
> guest. However this problem is beyond the scope of this patch set.

Ok, I see.

	Arnd
