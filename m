From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 26 Apr 2016 11:04:55 -0400
Subject: [PATCH V17 1/3] dmaengine: qcom_hidma: implement lower level
 hardware interface
In-Reply-To: <20160426032805.GA2274@localhost>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-2-git-send-email-okaya@codeaurora.org>
 <20160426032805.GA2274@localhost>
Message-ID: <571F8397.5000803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2016 11:28 PM, Vinod Koul wrote:
> On Mon, Apr 11, 2016 at 10:21:11AM -0400, Sinan Kaya wrote:
> 
>> + * HIDMA is not aware of IOMMU presence since it follows the DMA API. All
>> + * IOMMU latency will be built into the data movement time. By the time
>> + * interrupt happens, IOMMU lookups + data movement has already taken place.
> 
> Do you mean dmaengine API or dma mapping API here? Where is you IOMMU
> located wrt to dma controller?

I mean DMA API in this context. The code works on dma_addr_t. That means the caller
takes care of DMA mapping before coming to this code. This code is not involved in
any of the DMA mapping calls or any other IOMMU related operations. All of this 
is abstracted from this code.

The IOMMU is right in front of this device. That's why, all IOMMU operations are 
inclusive into the data transfers. 

> 
>> + *
>> + * While the first read in a typical PCI endpoint ISR flushes all outstanding
>> + * requests traditionally to the destination, this concept does not apply
>> + * here for this HW.
>> + */
>> +static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev)
>> +{
>> +	u32 status;
>> +	u32 enable;
>> +	u32 cause;
>> +
>> +	/*
>> +	 * Fine tuned for this HW...
>> +	 *
>> +	 * This ISR has been designed for this particular hardware. Relaxed
>> +	 * read and write accessors are used for performance reasons due to
>> +	 * interrupt delivery guarantees. Do not copy this code blindly and
>> +	 * expect that to work.
>> +	 */
>> +	status = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_STAT_REG);
>> +	enable = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
>> +	cause = status & enable;
>> +
>> +	while (cause) {
>> +		if ((cause & BIT(HIDMA_IRQ_TR_CH_INVALID_TRE_BIT_POS)) ||
>> +		    (cause & BIT(HIDMA_IRQ_TR_CH_TRE_RD_RSP_ER_BIT_POS)) ||
>> +		    (cause & BIT(HIDMA_IRQ_EV_CH_WR_RESP_BIT_POS)) ||
>> +		    (cause & BIT(HIDMA_IRQ_TR_CH_DATA_RD_ER_BIT_POS)) ||
>> +		    (cause & BIT(HIDMA_IRQ_TR_CH_DATA_WR_ER_BIT_POS))) {
> 
> Switch please

Cause is a combined status register. Let's say it contains 0x41. I need to check
if bit 0 or bit 6 is set in this value for each case condition. The value is not 0x40 
or 0x1. 

I created macro like this instead.

+#define HIDMA_IS_ERR_INTERRUPT(cause)                          \
+       (cause & BIT(HIDMA_IRQ_TR_CH_INVALID_TRE_BIT_POS))   || \
+       (cause & BIT(HIDMA_IRQ_TR_CH_TRE_RD_RSP_ER_BIT_POS)) || \
+       (cause & BIT(HIDMA_IRQ_EV_CH_WR_RESP_BIT_POS))       || \
+       (cause & BIT(HIDMA_IRQ_TR_CH_DATA_RD_ER_BIT_POS))    || \
+       (cause & BIT(HIDMA_IRQ_TR_CH_DATA_WR_ER_BIT_POS))

and replaced the if statement as follows

if (HIDMA_IS_ERR_INTERRUPT(cause)) {

> 
>> +			u8 err_code = HIDMA_EVRE_STATUS_ERROR;
>> +			u8 err_info = 0xFF;
>> +
>> +			/* Clear out pending interrupts */
>> +			writel(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
>> +
>> +			dev_err(lldev->dev, "error 0x%x, resetting...\n",
>> +				cause);
>> +
>> +			hidma_cleanup_pending_tre(lldev, err_info, err_code);
>> +
>> +			/* reset the channel for recovery */
>> +			if (hidma_ll_setup(lldev)) {
> 
> should this be done in ISR?

I created a new tasklet called rst_task and posted the code there. 

 /*
+ * Abort all transactions and perform a reset.
+ */
+static void hidma_ll_abort(unsigned long arg)
+{
+       u8 err_code = HIDMA_EVRE_STATUS_ERROR;
+       u8 err_info = 0xFF;
+
+       dev_err(lldev->dev, "error 0x%x, resetting...\n",
+               cause);
+
+       hidma_cleanup_pending_tre(lldev, err_info, err_code);
+
+       /* reset the channel for recovery */
+       if (hidma_ll_setup(lldev)) {
+               dev_err(lldev->dev,
+                       "channel reinitialize failed after error\n");
+               return;
+       }
+       hidma_ll_control_irq(lldev, ENABLE_IRQS);
+}

+               if (HIDMA_IS_ERR_INTERRUPT(cause)) {
                        /* Clear out pending interrupts */
                        writel(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);

-                       dev_err(lldev->dev, "error 0x%x, resetting...\n",
-                               cause);
-
-                       hidma_cleanup_pending_tre(lldev, err_info, err_code);
-
-                       /* reset the channel for recovery */
-                       if (hidma_ll_setup(lldev)) {
-                               dev_err(lldev->dev,
-                                       "channel reinitialize failed after error\n");
-                               return;
-                       }
-                       hidma_ll_enable_irq(lldev, ENABLE_IRQS);
+                       tasklet_schedule(&lldev->rst_task);
 



> 
>> +int hidma_ll_resume(struct hidma_lldev *lldev)
>> +{
>> +	return hidma_ll_enable(lldev);
>> +}
> 
> why do we need this empty function, use hidma_ll_enable.

hidma_ll_enable is a common function that gets called from multiple places. 
hidma_ll_resume and hidma_ll_pause is used by the OS interface for pausing
and resuming the DMA channel. 

> 
>> +bool hidma_ll_isenabled(struct hidma_lldev *lldev)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(lldev->trca + HIDMA_TRCA_CTRLSTS_REG);
>> +	lldev->trch_state = HIDMA_CH_STATE(val);
>> +	val = readl(lldev->evca + HIDMA_EVCA_CTRLSTS_REG);
>> +	lldev->evch_state = HIDMA_CH_STATE(val);
>> +
>> +	/* both channels have to be enabled before calling this function */
>> +	if (((lldev->trch_state == HIDMA_CH_ENABLED) ||
>> +	     (lldev->trch_state == HIDMA_CH_RUNNING)) &&
>> +	    ((lldev->evch_state == HIDMA_CH_ENABLED) ||
>> +	     (lldev->evch_state == HIDMA_CH_RUNNING)))
>> +		return true;
> 
> hmmm this looks hard to read, why not do:
> 
> is_chan_enabled(state)
> {
> 	switch (state) {
> 	case HIDMA_CH_ENABLED:
> 	case HIDMA_CH_RUNNING:
> 		return true;
> 	default:
> 		return false;
> }
> 
> and then :
> 
> 	if (is_chan_enabled(lldev->trch_state) &&
> 			is_chan_enabled(lldev->evch_state))
> 
Sure, makes sense.

> 
>> +void hidma_ll_start(struct hidma_lldev *lldev)
>> +{
>> +	hidma_ll_hw_start(lldev);
>> +}
> 
> Another dummy :(

renamed hidma_ll_hw_start to hidma_ll_start and removed this function.

> 
>> +/*
>> + * Note that even though we stop this channel
>> + * if there is a pending transaction in flight
>> + * it will complete and follow the callback.
>> + * This request will prevent further requests
>> + * to be made.
> 
> Why the odd formating?

aligned to 75 characters.

> 
>> +int hidma_ll_uninit(struct hidma_lldev *lldev)
>> +{
>> +	int rc = 0;
>> +	u32 val;
>> +
>> +	if (!lldev)
>> +		return -ENODEV;
>> +
>> +	if (lldev->initialized) {
>> +		u32 required_bytes;
>> +
>> +		lldev->initialized = 0;
>> +
>> +		required_bytes = sizeof(struct hidma_tre) * lldev->nr_tres;
>> +		tasklet_kill(&lldev->task);
>> +		memset(lldev->trepool, 0, required_bytes);
>> +		lldev->trepool = NULL;
>> +		lldev->pending_tre_count = 0;
>> +		lldev->tre_write_offset = 0;
>> +
>> +		rc = hidma_ll_reset(lldev);
>> +
>> +		/*
>> +		 * Clear all pending interrupts again.
>> +		 * Otherwise, we observe reset complete interrupts.
>> +		 */
>> +		val = readl(lldev->evca + HIDMA_EVCA_IRQ_STAT_REG);
>> +		writel(val, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
>> +		hidma_ll_enable_irq(lldev, 0);
> 
> uninit enables irq?
> 
renamed to hidma_ll_control_irq. Second argument is the bits to enable. If 0, 
interrupts are disabled.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
