From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 1 Dec 2015 17:04:58 +0530
Subject: [PATCH V7 3/3] dma: add Qualcomm Technologies HIDMA channel driver
In-Reply-To: <565CAC4C.7080909@codeaurora.org>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
 <1448245707-27499-4-git-send-email-okaya@codeaurora.org>
 <20151130085948.GC3901@localhost> <565CAC4C.7080909@codeaurora.org>
Message-ID: <20151201113458.GL3901@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 03:06:36PM -0500, Sinan Kaya wrote:
> I have split the debugfs support from this patch to its own patch. Any
> other idea on how else you'd break the code? I can take one more step
> and separate the lower layer from the OS layer by using stub functions
> on the initial commit.

Yes the ll.c can be a separate patch and no need to add placeholders as
makefile can be last

> > 
> >> +static enum dma_status hidma_tx_status(struct dma_chan *dmach,
> >> +			dma_cookie_t cookie, struct dma_tx_state *txstate)
> >> +{
> >> +	struct hidma_chan *mchan = to_hidma_chan(dmach);
> >> +	enum dma_status ret;
> >> +
> >> +	if (mchan->paused)
> >> +		ret = DMA_PAUSED;
> > 
> > This is not quite right. The status query is for a descriptor and NOT for
> > channel. Here if the descriptor queried was running then it would be paused
> > for the rest pending txn, it would be DMA_IN_PROGRESS.
> 
> The channel can be paused by the hypervisor. If it is paused, then no
> other transaction will go through including the pending requests. That's
> why, I'm checking the state first.

You are missing the point. Channel can be paused, yes but the descriptor
is in queue and is not paused. The descriptor running is paused, yes.
There is subtle difference between these

> >> +static dma_cookie_t hidma_tx_submit(struct dma_async_tx_descriptor *txd)
> >> +{
> >> +	struct hidma_chan *mchan = to_hidma_chan(txd->chan);
> >> +	struct hidma_dev *dmadev = mchan->dmadev;
> >> +	struct hidma_desc *mdesc;
> >> +	unsigned long irqflags;
> >> +	dma_cookie_t cookie;
> >> +
> >> +	if (!hidma_ll_isenabled(dmadev->lldev))
> >> +		return -ENODEV;
> > 
> > is this not too late for this check, you should fail this on prepare
> > method
> 
> The channels can be paused by the hypervisor at runtime after the guest
> OS boot. The client might have allocated the channels during guest
> machine boot. If a channel is paused and client makes a request, client
> will never get the callback. By placing this check, I'm looking at the
> runtime status of the channel and rejecting the transmit request right
> ahead.

In this case you have request already given to you, here the request is
submitted to the pending queue, if hypervisor has paused you, so the entire
txn queue is paused. But from API semantics I would argue that this should be
accepted and suffer the same fate as already submitted txns

> 
> > 
> > 
> >> +static int hidma_alloc_chan_resources(struct dma_chan *dmach)
> >> +{
> >> +	struct hidma_chan *mchan = to_hidma_chan(dmach);
> >> +	struct hidma_dev *dmadev = mchan->dmadev;
> >> +	struct hidma_desc *mdesc, *tmp;
> >> +	unsigned long irqflags;
> >> +	LIST_HEAD(descs);
> >> +	unsigned int i;
> >> +	int rc = 0;
> >> +
> >> +	if (mchan->allocated)
> >> +		return 0;
> >> +
> >> +	/* Alloc descriptors for this channel */
> >> +	for (i = 0; i < dmadev->nr_descriptors; i++) {
> >> +		mdesc = kzalloc(sizeof(struct hidma_desc), GFP_KERNEL);
> > 
> > GFP_NOWAIT pls, this can be called from atomic context
> 
> I'll change it, but why would anyone allocate a channel in an interrupt
> handler?

remember this is dmaengine, where people traditionally wanted to offload
from cpu and were not allowed to sleep.

I think am okay with this one..

> 
> > 
> >> +		if (!mdesc) {
> >> +			rc = -ENOMEM;
> >> +			break;
> >> +		}
> >> +		dma_async_tx_descriptor_init(&mdesc->desc, dmach);
> >> +		mdesc->desc.flags = DMA_CTRL_ACK;
> > 
> > what is the purpose of setting this flag here
> 
> It means that the code only supports interrupt. Maybe, you can correct
> me here. I couldn't see a very useful info about the DMA engine flags.
> My understanding is that DMA_CTRL_ACK means user wants an interrupt
> based callback.

Right user wants, you are not user though

> 
> If DMA_CTRL_ACK is not specified, then user wants to poll for the
> results. The current code only supports the interrupt based delivery for
> callbacks. Polling support is another to-do in my list for small sized
> transfers.

See the documentation for flags and usage. The point here is that user
should set this. I know some old driver do this but that is not right

> 
> > 
> >> +static void hidma_free_chan_resources(struct dma_chan *dmach)
> >> +{
> >> +	struct hidma_chan *mchan = to_hidma_chan(dmach);
> >> +	struct hidma_dev *mdma = mchan->dmadev;
> >> +	struct hidma_desc *mdesc, *tmp;
> >> +	unsigned long irqflags;
> >> +	LIST_HEAD(descs);
> >> +
> >> +	if (!list_empty(&mchan->prepared) || !list_empty(&mchan->active) ||
> >> +		!list_empty(&mchan->completed)) {
> >> +		/*
> >> +		 * We have unfinished requests waiting.
> >> +		 * Terminate the request from the hardware.
> > 
> > that sounds as bug.. free should be called when txn are completed/aborted
> 
> Let me see what other drivers are doing...
> 
> > 
> >> +		 */
> >> +		hidma_cleanup_pending_tre(mdma->lldev, ERR_INFO_SW,
> >> +					ERR_CODE_UNEXPECTED_TERMINATE);
> >> +
> >> +		/* Give enough time for completions to be called. */
> >> +		msleep(100);
> > 
> > should we not poll/read after delay, also we are still in atomic context
> > 
> >> +	}
> >> +
> >> +	spin_lock_irqsave(&mchan->lock, irqflags);
> >> +	/* Channel must be idle */
> > 
> > sorry I do not like that assumption
> > 
> >> +	/* return all user requests */
> >> +	list_for_each_entry_safe(mdesc, tmp, &list, node) {
> >> +		struct dma_async_tx_descriptor *txd = &mdesc->desc;
> >> +		dma_async_tx_callback callback = mdesc->desc.callback;
> >> +		void *param = mdesc->desc.callback_param;
> >> +		enum dma_status status;
> >> +
> >> +		dma_descriptor_unmap(txd);
> >> +
> >> +		status = hidma_ll_status(dmadev->lldev, mdesc->tre_ch);
> >> +		/*
> >> +		 * The API requires that no submissions are done from a
> >> +		 * callback, so we don't need to drop the lock here
> >> +		 */
> > 
> > That is correct assumption for async_tx and which is deprecated now.
> > In fact the converse is true for rest!
> 
> I copied this function from another driver. The cookie/unmap business
> seemed scary to me. Can you point me to a good/recent implementation if
> this is deprecated?


> 
> > 
> >> +static int hidma_pause(struct dma_chan *chan)
> >> +{
> >> +	struct hidma_chan *mchan;
> >> +	struct hidma_dev *dmadev;
> >> +
> >> +	mchan = to_hidma_chan(chan);
> >> +	dmadev = to_hidma_dev(mchan->chan.device);
> >> +	if (!mchan->paused) {
> >> +		pm_runtime_get_sync(dmadev->ddev.dev);
> >> +		if (hidma_ll_pause(dmadev->lldev))
> >> +			dev_warn(dmadev->ddev.dev, "channel did not stop\n");
> >> +		mchan->paused = true;
> >> +		pm_runtime_mark_last_busy(dmadev->ddev.dev);
> >> +		pm_runtime_put_autosuspend(dmadev->ddev.dev);
> >> +	}
> >> +	return 0;
> >> +}
> > 
> > This is interesting, we associate pause/resume for slave dma ops and not for
> > memcpy ops, what is the reason for adding pause/resume here?
> 
> Why is it limited to the slave device only? I can queue a bunch of
> requests. I can pause and resume their execution with the current
> implementation.

Traditionally no one paused memcpy... People want the copy to be done with
as fast as possible :)

> 
> > 
> >> +static int hidma_remove(struct platform_device *pdev)
> >> +{
> >> +	struct hidma_dev *dmadev = platform_get_drvdata(pdev);
> >> +
> >> +	pm_runtime_get_sync(dmadev->ddev.dev);
> >> +	dma_async_device_unregister(&dmadev->ddev);
> >> +	hidma_debug_uninit(dmadev);
> >> +	hidma_ll_uninit(dmadev->lldev);
> >> +	hidma_free(dmadev);
> >> +
> >> +	dev_info(&pdev->dev, "HI-DMA engine removed\n");
> >> +	pm_runtime_put_sync_suspend(&pdev->dev);
> >> +	pm_runtime_disable(&pdev->dev);
> > 
> > and your irq is still active and can invoke your irq handler!
> > 
> 
> why? I shutdown the IRQ in hidma_ll_uninit and request the interrupt
> with devm_request_irq. As soon as this driver is removed, the interrupt
> should be released by the managed code.

but there is a delay between that and free getting called. Since you don't
free up explicitly you can still have irq and tasklets scheduled.

Recommendation is that free up irq or ensure none are scheduled and
disabled

-- 
~Vinod
