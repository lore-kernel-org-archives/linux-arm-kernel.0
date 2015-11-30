From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 30 Nov 2015 15:06:36 -0500
Subject: [PATCH V7 3/3] dma: add Qualcomm Technologies HIDMA channel driver
In-Reply-To: <20151130085948.GC3901@localhost>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
 <1448245707-27499-4-git-send-email-okaya@codeaurora.org>
 <20151130085948.GC3901@localhost>
Message-ID: <565CAC4C.7080909@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 3:59 AM, Vinod Koul wrote:
> On Sun, Nov 22, 2015 at 09:28:25PM -0500, Sinan Kaya wrote:
>> This patch adds support for hidma engine. The driver consists
>> of two logical blocks. The DMA engine interface and the
>> low-level interface. The hardware only supports memcpy/memset
>> and this driver only support memcpy interface. HW and driver
>> doesn't support slave interface.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  .../devicetree/bindings/dma/qcom_hidma.txt         |  18 +
>>  drivers/dma/qcom/Kconfig                           |  10 +
>>  drivers/dma/qcom/Makefile                          |   2 +
>>  drivers/dma/qcom/hidma.c                           | 706 ++++++++++++++++
>>  drivers/dma/qcom/hidma.h                           | 157 ++++
>>  drivers/dma/qcom/hidma_dbg.c                       | 217 +++++
>>  drivers/dma/qcom/hidma_ll.c                        | 924 +++++++++++++++++++++
>>  7 files changed, 2034 insertions(+)
> 
> This was one of the reasons for slow review of this. I started few times but
> large patches made this getting pushed back
> 
> Pls help reviewers by splitting your code which looking at this could have
> been done

I have split the debugfs support from this patch to its own patch. Any
other idea on how else you'd break the code? I can take one more step
and separate the lower layer from the OS layer by using stub functions
on the initial commit.

> 
>> +#include <linux/dmaengine.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/of_dma.h>
>> +#include <linux/property.h>
>> +#include <linux/delay.h>
>> +#include <linux/highmem.h>
>> +#include <linux/io.h>
>> +#include <linux/sched.h>
>> +#include <linux/wait.h>
>> +#include <linux/acpi.h>
>> +#include <linux/irq.h>
>> +#include <linux/atomic.h>
>> +#include <linux/pm_runtime.h>
> 
> Do you need so many headers...?

probably not, let me see what I can do about them.

> 
>> +MODULE_PARM_DESC(event_channel_idx,
>> +		"event channel index array for the notifications");
> 
> Can you explain this parameter in detail pls

OK. I added the following comment to the code.

/*
 * Each DMA channel is associated with an event channel for interrupt
 * delivery. The event channel index usually comes from the firmware through
 * ACPI/DT. When a HIDMA channel is executed in the guest machine
context (QEMU)
 * the device tree gets auto-generated based on the memory and IRQ resources
 * this driver uses on the host machine. Any device specific parameter
such as
 * event-channel gets ignored by the QEMU.
 * We are using this command line parameter to pass the event channel
index to
 * the guest machine.
 */
s

> 
>> +static void hidma_callback(void *data)
>> +{
>> +	struct hidma_desc *mdesc = data;
>> +	struct hidma_chan *mchan = to_hidma_chan(mdesc->desc.chan);
>> +	struct dma_device *ddev = mchan->chan.device;
>> +	struct hidma_dev *dmadev = to_hidma_dev(ddev);
>> +	unsigned long irqflags;
>> +	bool queued = false;
>> +
>> +	spin_lock_irqsave(&mchan->lock, irqflags);
>> +	if (mdesc->node.next) {
>> +		/* Delete from the active list, add to completed list */
>> +		list_move_tail(&mdesc->node, &mchan->completed);
>> +		queued = true;
>> +	}
>> +	spin_unlock_irqrestore(&mchan->lock, irqflags);
>> +
>> +	hidma_process_completed(dmadev);
>> +
>> +	if (queued) {
>> +		pm_runtime_mark_last_busy(dmadev->ddev.dev);
>> +		pm_runtime_put_autosuspend(dmadev->ddev.dev);
>> +	}
>> +}
> 
> Callback is typically referred to client callback upon dma completion, can
> you explain what you are trying to do here

When a DMA transfer completes, the hidma_callback function in the
hidma.c file gets called from the lower layer (hidma_ll.c) in order to
move this request from active queue into the completed queue.

hidma_process_completed eventually calls the "client callback" in it.

The PM stuff is for guaranteeing that clocks are not turned off while HW
is working on it.

I grab the PM lock in issue pending and release it in the hidma_callback.

> 
>> +static int hidma_chan_init(struct hidma_dev *dmadev, u32 dma_sig)
>> +{
>> +	struct hidma_chan *mchan;
>> +	struct dma_device *ddev;
>> +
>> +	mchan = devm_kzalloc(dmadev->ddev.dev, sizeof(*mchan), GFP_KERNEL);
>> +	if (!mchan)
>> +		return -ENOMEM;
>> +
>> +	ddev = &dmadev->ddev;
>> +	mchan->dma_sig = dma_sig;
>> +	mchan->dmadev = dmadev;
>> +	mchan->chan.device = ddev;
>> +	dma_cookie_init(&mchan->chan);
>> +
>> +	INIT_LIST_HEAD(&mchan->free);
>> +	INIT_LIST_HEAD(&mchan->prepared);
>> +	INIT_LIST_HEAD(&mchan->active);
>> +	INIT_LIST_HEAD(&mchan->completed);
>> +
>> +	spin_lock_init(&mchan->lock);
>> +	list_add_tail(&mchan->chan.device_node, &ddev->channels);
>> +	dmadev->ddev.chancnt++;
> 
> Have you looked at vchan implementation and moving list handling to this
> layer ?

I'll add vchan support later on another revision. The original code had
vchan support in it. It became a terminology mess. So, I removed it for
the moment.

Using vchan, I can take multiple clients and serve them in a single
channel later.

> 
>> +	return 0;
>> +}
>> +
>> +static void hidma_issue_pending(struct dma_chan *dmach)
>> +{
>> +	struct hidma_chan *mchan = to_hidma_chan(dmach);
>> +	struct hidma_dev *dmadev = mchan->dmadev;
>> +
>> +	/* PM will be released in hidma_callback function. */
>> +	pm_runtime_get_sync(dmadev->ddev.dev);
> 
> Oh no, this is not allowed. pm_runtime_get_sync() can sleep and
> issue_pending can be invoked from atomic context.

OK. I didn't know that. I'll try pm_runtime_get first. If it fails, I'll
post a task to do the real job with pm_runtime_get_sync.

The clocks may be off by the time the request is made. I need to grab
the PM lock before accessing the HW registers.

> 
>> +static enum dma_status hidma_tx_status(struct dma_chan *dmach,
>> +			dma_cookie_t cookie, struct dma_tx_state *txstate)
>> +{
>> +	struct hidma_chan *mchan = to_hidma_chan(dmach);
>> +	enum dma_status ret;
>> +
>> +	if (mchan->paused)
>> +		ret = DMA_PAUSED;
> 
> This is not quite right. The status query is for a descriptor and NOT for
> channel. Here if the descriptor queried was running then it would be paused
> for the rest pending txn, it would be DMA_IN_PROGRESS.

The channel can be paused by the hypervisor. If it is paused, then no
other transaction will go through including the pending requests. That's
why, I'm checking the state first.

> 
>> +static dma_cookie_t hidma_tx_submit(struct dma_async_tx_descriptor *txd)
>> +{
>> +	struct hidma_chan *mchan = to_hidma_chan(txd->chan);
>> +	struct hidma_dev *dmadev = mchan->dmadev;
>> +	struct hidma_desc *mdesc;
>> +	unsigned long irqflags;
>> +	dma_cookie_t cookie;
>> +
>> +	if (!hidma_ll_isenabled(dmadev->lldev))
>> +		return -ENODEV;
> 
> is this not too late for this check, you should fail this on prepare
> method

The channels can be paused by the hypervisor at runtime after the guest
OS boot. The client might have allocated the channels during guest
machine boot. If a channel is paused and client makes a request, client
will never get the callback. By placing this check, I'm looking at the
runtime status of the channel and rejecting the transmit request right
ahead.

> 
> 
>> +static int hidma_alloc_chan_resources(struct dma_chan *dmach)
>> +{
>> +	struct hidma_chan *mchan = to_hidma_chan(dmach);
>> +	struct hidma_dev *dmadev = mchan->dmadev;
>> +	struct hidma_desc *mdesc, *tmp;
>> +	unsigned long irqflags;
>> +	LIST_HEAD(descs);
>> +	unsigned int i;
>> +	int rc = 0;
>> +
>> +	if (mchan->allocated)
>> +		return 0;
>> +
>> +	/* Alloc descriptors for this channel */
>> +	for (i = 0; i < dmadev->nr_descriptors; i++) {
>> +		mdesc = kzalloc(sizeof(struct hidma_desc), GFP_KERNEL);
> 
> GFP_NOWAIT pls, this can be called from atomic context

I'll change it, but why would anyone allocate a channel in an interrupt
handler?

> 
>> +		if (!mdesc) {
>> +			rc = -ENOMEM;
>> +			break;
>> +		}
>> +		dma_async_tx_descriptor_init(&mdesc->desc, dmach);
>> +		mdesc->desc.flags = DMA_CTRL_ACK;
> 
> what is the purpose of setting this flag here

It means that the code only supports interrupt. Maybe, you can correct
me here. I couldn't see a very useful info about the DMA engine flags.
My understanding is that DMA_CTRL_ACK means user wants an interrupt
based callback.

If DMA_CTRL_ACK is not specified, then user wants to poll for the
results. The current code only supports the interrupt based delivery for
callbacks. Polling support is another to-do in my list for small sized
transfers.

> 
>> +static void hidma_free_chan_resources(struct dma_chan *dmach)
>> +{
>> +	struct hidma_chan *mchan = to_hidma_chan(dmach);
>> +	struct hidma_dev *mdma = mchan->dmadev;
>> +	struct hidma_desc *mdesc, *tmp;
>> +	unsigned long irqflags;
>> +	LIST_HEAD(descs);
>> +
>> +	if (!list_empty(&mchan->prepared) || !list_empty(&mchan->active) ||
>> +		!list_empty(&mchan->completed)) {
>> +		/*
>> +		 * We have unfinished requests waiting.
>> +		 * Terminate the request from the hardware.
> 
> that sounds as bug.. free should be called when txn are completed/aborted

Let me see what other drivers are doing...

> 
>> +		 */
>> +		hidma_cleanup_pending_tre(mdma->lldev, ERR_INFO_SW,
>> +					ERR_CODE_UNEXPECTED_TERMINATE);
>> +
>> +		/* Give enough time for completions to be called. */
>> +		msleep(100);
> 
> should we not poll/read after delay, also we are still in atomic context
> 
>> +	}
>> +
>> +	spin_lock_irqsave(&mchan->lock, irqflags);
>> +	/* Channel must be idle */
> 
> sorry I do not like that assumption
> 
>> +	/* return all user requests */
>> +	list_for_each_entry_safe(mdesc, tmp, &list, node) {
>> +		struct dma_async_tx_descriptor *txd = &mdesc->desc;
>> +		dma_async_tx_callback callback = mdesc->desc.callback;
>> +		void *param = mdesc->desc.callback_param;
>> +		enum dma_status status;
>> +
>> +		dma_descriptor_unmap(txd);
>> +
>> +		status = hidma_ll_status(dmadev->lldev, mdesc->tre_ch);
>> +		/*
>> +		 * The API requires that no submissions are done from a
>> +		 * callback, so we don't need to drop the lock here
>> +		 */
> 
> That is correct assumption for async_tx and which is deprecated now.
> In fact the converse is true for rest!

I copied this function from another driver. The cookie/unmap business
seemed scary to me. Can you point me to a good/recent implementation if
this is deprecated?

> 
>> +static int hidma_pause(struct dma_chan *chan)
>> +{
>> +	struct hidma_chan *mchan;
>> +	struct hidma_dev *dmadev;
>> +
>> +	mchan = to_hidma_chan(chan);
>> +	dmadev = to_hidma_dev(mchan->chan.device);
>> +	if (!mchan->paused) {
>> +		pm_runtime_get_sync(dmadev->ddev.dev);
>> +		if (hidma_ll_pause(dmadev->lldev))
>> +			dev_warn(dmadev->ddev.dev, "channel did not stop\n");
>> +		mchan->paused = true;
>> +		pm_runtime_mark_last_busy(dmadev->ddev.dev);
>> +		pm_runtime_put_autosuspend(dmadev->ddev.dev);
>> +	}
>> +	return 0;
>> +}
> 
> This is interesting, we associate pause/resume for slave dma ops and not for
> memcpy ops, what is the reason for adding pause/resume here?

Why is it limited to the slave device only? I can queue a bunch of
requests. I can pause and resume their execution with the current
implementation.

> 
>> +static int hidma_remove(struct platform_device *pdev)
>> +{
>> +	struct hidma_dev *dmadev = platform_get_drvdata(pdev);
>> +
>> +	pm_runtime_get_sync(dmadev->ddev.dev);
>> +	dma_async_device_unregister(&dmadev->ddev);
>> +	hidma_debug_uninit(dmadev);
>> +	hidma_ll_uninit(dmadev->lldev);
>> +	hidma_free(dmadev);
>> +
>> +	dev_info(&pdev->dev, "HI-DMA engine removed\n");
>> +	pm_runtime_put_sync_suspend(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
> 
> and your irq is still active and can invoke your irq handler!
> 

why? I shutdown the IRQ in hidma_ll_uninit and request the interrupt
with devm_request_irq. As soon as this driver is removed, the interrupt
should be released by the managed code.

>> +
>> +	return 0;
>> +}
>> +
>> +#if IS_ENABLED(CONFIG_ACPI)
>> +static const struct acpi_device_id hidma_acpi_ids[] = {
>> +	{"QCOM8061"},
> Qcom and ACPI, that is v interesting combination !
> 
> 

Thanks for the detailed review.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
