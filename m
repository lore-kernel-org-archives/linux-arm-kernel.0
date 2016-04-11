From: gpramod@codeaurora.org (gpramod at codeaurora.org)
Date: Mon, 11 Apr 2016 13:21:06 +0530
Subject: [PATCH v2 2/5] dmaengine: qcom: bam_dma: clear BAM interrupt only
 if it is rised
In-Reply-To: <1459896982-30171-3-git-send-email-stanimir.varbanov@linaro.org>
References: <1459896982-30171-1-git-send-email-stanimir.varbanov@linaro.org>
 <1459896982-30171-3-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <a31a31ec563059899440ea512a34aa19@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-04-06 04:26, Stanimir Varbanov wrote:
> Currently we write BAM_IRQ_CLR register with zero even when no
> BAM_IRQ occured. This write has some bad side effects when the
> BAM instance is for the crypto engine. In case of crypto engine
> some of the BAM registers are xPU protected and they cannot be
> controlled by the driver.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Tested-by: Pramod Gurav <gpramod@codeaurora.org>

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index a486bc0f82e0..789d5f836bf7 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -801,13 +801,17 @@ static irqreturn_t bam_dma_irq(int irq, void 
> *data)
>  	if (srcs & P_IRQ)
>  		tasklet_schedule(&bdev->task);
> 
> -	if (srcs & BAM_IRQ)
> +	if (srcs & BAM_IRQ) {
>  		clr_mask = readl_relaxed(bam_addr(bdev, 0, BAM_IRQ_STTS));
> 
> -	/* don't allow reorder of the various accesses to the BAM registers 
> */
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
> 
>  	return IRQ_HANDLED;
>  }
