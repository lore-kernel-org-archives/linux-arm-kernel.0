From: agross@codeaurora.org (Andy Gross)
Date: Tue, 1 Dec 2015 11:28:41 -0600
Subject: [PATCH 2/4] dmaengine: qcom_bam_dma: clear BAM interrupt only if
 it is rised
In-Reply-To: <1448961299-15161-3-git-send-email-stanimir.varbanov@linaro.org>
References: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
 <1448961299-15161-3-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <20151201172841.GC26687@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 11:14:57AM +0200, Stanimir Varbanov wrote:
> Currently we write BAM_IRQ_CLR register with zero even when no
> BAM_IRQ occured. This write has some bad side effects when the
> BAM instance is for the crypto engine. In case of crypto engine
> some of the BAM registers are xPU protected and they cannot be
> controlled by the driver.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/dma/qcom_bam_dma.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
> index dc9da477eb69..0f06f3b7a72b 100644
> --- a/drivers/dma/qcom_bam_dma.c
> +++ b/drivers/dma/qcom_bam_dma.c
> @@ -800,13 +800,17 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
>  	if (srcs & P_IRQ)
>  		tasklet_schedule(&bdev->task);
>  
> -	if (srcs & BAM_IRQ)
> +	if (srcs & BAM_IRQ) {
>  		clr_mask = readl_relaxed(bam_addr(bdev, 0, BAM_IRQ_STTS));
>  
> -	/* don't allow reorder of the various accesses to the BAM registers */
> -	mb();
> +		/*
> +		 * don't allow reorder of the various accesses to the BAM
> +		 * registers
> +		 */
> +		mb();
>  
> -	writel_relaxed(clr_mask, bam_addr(bdev, 0, BAM_IRQ_CLR));
> +		writel_relaxed(clr_mask, bam_addr(bdev, 0, BAM_IRQ_CLR));
> +	}

Looks good.  We shouldn't be accessing this unless there is actually an irq
shown in the srcs.


Thanks for catching this.


Reviewed-by: Andy Gross <agross@codeaurora.org>
