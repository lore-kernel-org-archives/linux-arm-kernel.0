From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 11 Apr 2016 09:52:03 -0400
Subject: [PATCH V16 1/3] dmaengine: qcom_hidma: implement lower level
 hardware interface
In-Reply-To: <1460381663-16765-2-git-send-email-okaya@codeaurora.org>
References: <1460381663-16765-1-git-send-email-okaya@codeaurora.org>
 <1460381663-16765-2-git-send-email-okaya@codeaurora.org>
Message-ID: <570BAC03.1020005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

On 4/11/2016 9:34 AM, Sinan Kaya wrote:

> +
> +/*
> + * The interrupt handler for HIDMA will try to consume as many pending
> + * EVRE from the event queue as possible. Each EVRE has an associated
> + * TRE that holds the user interface parameters. EVRE reports the
> + * result of the transaction. Hardware guarantees ordering between EVREs
> + * and TREs. We use last processed offset to figure out which TRE is
> + * associated with which EVRE. If two TREs are consumed by HW, the EVREs
> + * are in order in the event ring.
> + *
> + * This handler will do a one pass for consuming EVREs. Other EVREs may
> + * be delivered while we are working. It will try to consume incoming
> + * EVREs one more time and return.
> + *
> + * For unprocessed EVREs, hardware will trigger another interrupt until
> + * all the interrupt bits are cleared.
> + *
> + * Hardware guarantees that by the time interrupt is observed, all data
> + * transactions in flight are delivered to their respective places and
> + * are visible to the CPU.
> + *
> + * On demand paging for IOMMU is only supported for PCIe via PRI
> + * (Page Request Interface) not for HIDMA. All other hardware instances
> + * including HIDMA work on pinned DMA addresses.
> + *
> + * HIDMA is not aware of IOMMU presence since it follows the DMA API. All
> + * IOMMU latency will be built into the data movement time. By the time
> + * interrupt happens, IOMMU lookups + data movement has already taken place.
> + *
> + * While the first read in a typical PCI endpoint ISR flushes all outstanding
> + * requests traditionally to the destination, this concept does not apply
> + * here for this HW.
> + */
> +static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev)
> +{
> +	u32 status;
> +	u32 enable;
> +	u32 cause;
> +
> +	/*
> +	 * Fine tuned for this HW...
> +	 *
> +	 * This ISR has been designed for this particular hardware. Relaxed
> +	 * read and write accessors are used for performance reasons due to
> +	 * interrupt delivery guarantees. Do not copy this code blindly and
> +	 * expect that to work.
> +	 */
> +	status = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_STAT_REG);
> +	enable = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
> +	cause = status & enable;
> +
> +	if ((cause & BIT(HIDMA_IRQ_TR_CH_INVALID_TRE_BIT_POS)) ||
> +	    (cause & BIT(HIDMA_IRQ_TR_CH_TRE_RD_RSP_ER_BIT_POS)) ||
> +	    (cause & BIT(HIDMA_IRQ_EV_CH_WR_RESP_BIT_POS)) ||
> +	    (cause & BIT(HIDMA_IRQ_TR_CH_DATA_RD_ER_BIT_POS)) ||
> +	    (cause & BIT(HIDMA_IRQ_TR_CH_DATA_WR_ER_BIT_POS))) {
> +		u8 err_code = HIDMA_EVRE_STATUS_ERROR;
> +		u8 err_info = 0xFF;
> +
> +		/* Clear out pending interrupts */
> +		writel(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
> +
> +		dev_err(lldev->dev, "error 0x%x, resetting...\n", cause);
> +
> +		hidma_cleanup_pending_tre(lldev, err_info, err_code);
> +
> +		/* reset the channel for recovery */
> +		if (hidma_ll_setup(lldev)) {
> +			dev_err(lldev->dev,
> +				"channel reinitialize failed after error\n");
> +			return;
> +		}
> +		hidma_ll_enable_irq(lldev, ENABLE_IRQS);
> +		return;
> +	}
> +
> +	/*
> +	 * Try to consume as many EVREs as possible.
> +	 */
> +	while (cause) {

I should have put this to the top of this function. I'm having to back port bug fixes. 
This was a merge problem. I can fix this on the next version.

> +		while (lldev->pending_tre_count)
> +			hidma_handle_tre_completion(lldev);
> +
> +		/* We consumed TREs or there are pending TREs or EVREs. */
> +		writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
> +
> +		/*
> +		 * Another interrupt might have arrived while we are
> +		 * processing this one. Read the new cause.
> +		 */
> +		status = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_STAT_REG);
> +		enable = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
> +		cause = status & enable;
> +	}
> +}
> +


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
