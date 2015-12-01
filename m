From: agross@codeaurora.org (Andy Gross)
Date: Tue, 1 Dec 2015 11:23:07 -0600
Subject: [PATCH 3/4] dmaengine: qcom_bam_dma: use correct pipe FIFO size
In-Reply-To: <1448961299-15161-4-git-send-email-stanimir.varbanov@linaro.org>
References: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
 <1448961299-15161-4-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <20151201172307.GA26687@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 11:14:58AM +0200, Stanimir Varbanov wrote:
> The pipe fifo size register must instruct the bam hw
> how many hw descriptors can be pushed to fifo. Currently
> we isntruct the hw with 32KBytes but wrap the tail in
> bam_start_dma in BAM_P_EVNT_REG on 4095 i.e. 32760. This
> leads to stalled transactions when the tail wraps.
> 
> Fix this by use the correct fifo size in BAM_P_FIFO_SIZES
> register i.e. 32K - 8.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/dma/qcom_bam_dma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
> index 0f06f3b7a72b..6d290de9ab2b 100644
> --- a/drivers/dma/qcom_bam_dma.c
> +++ b/drivers/dma/qcom_bam_dma.c
> @@ -458,7 +458,7 @@ static void bam_chan_init_hw(struct bam_chan *bchan,
>  	 */
>  	writel_relaxed(ALIGN(bchan->fifo_phys, sizeof(struct bam_desc_hw)),
>  			bam_addr(bdev, bchan->id, BAM_P_DESC_FIFO_ADDR));
> -	writel_relaxed(BAM_DESC_FIFO_SIZE,
> +	writel_relaxed(BAM_MAX_DATA_SIZE,
>  			bam_addr(bdev, bchan->id, BAM_P_FIFO_SIZES));

This is just using the #define.  That is ok, but if you use this instead of the
BAM_P_FIFO_SIZES then you need to fix your comment.  Or actually use the
register value.... otherwise looks fine.
