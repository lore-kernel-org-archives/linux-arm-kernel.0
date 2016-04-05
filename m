From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 5 Apr 2016 16:47:40 -0700
Subject: [PATCH v2 5/5] dmaengine: qcom: bam_dma: rename
 BAM_MAX_DATA_SIZE define
In-Reply-To: <1459896982-30171-6-git-send-email-stanimir.varbanov@linaro.org>
References: <1459896982-30171-1-git-send-email-stanimir.varbanov@linaro.org>
 <1459896982-30171-6-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <20160405234739.GF11586@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 01:56:22AM +0300, Stanimir Varbanov wrote:
> It seems that the define has not been with acurate name and
> makes confusion while reading the code. The more acurate
> name should be BAM_FIFO_SIZE.

And not sure by that, what do you mean by FIFO size. In dmaengine context we
typically refer to FIFO as periphral FIFO size. But the changes belo imple
that you are uisng this for block..?

> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 7e5ad1c25e21..969b48176745 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -342,7 +342,7 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
>  
>  #define BAM_DESC_FIFO_SIZE	SZ_32K
>  #define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)
> -#define BAM_MAX_DATA_SIZE	(SZ_32K - 8)
> +#define BAM_FIFO_SIZE	(SZ_32K - 8)
>  
>  struct bam_chan {
>  	struct virt_dma_chan vc;
> @@ -459,7 +459,7 @@ static void bam_chan_init_hw(struct bam_chan *bchan,
>  	 */
>  	writel_relaxed(ALIGN(bchan->fifo_phys, sizeof(struct bam_desc_hw)),
>  			bam_addr(bdev, bchan->id, BAM_P_DESC_FIFO_ADDR));
> -	writel_relaxed(BAM_MAX_DATA_SIZE,
> +	writel_relaxed(BAM_FIFO_SIZE,
>  			bam_addr(bdev, bchan->id, BAM_P_FIFO_SIZES));
>  
>  	/* enable the per pipe interrupts, enable EOT, ERR, and INT irqs */
> @@ -605,7 +605,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  
>  	/* calculate number of required entries */
>  	for_each_sg(sgl, sg, sg_len, i)
> -		num_alloc += DIV_ROUND_UP(sg_dma_len(sg), BAM_MAX_DATA_SIZE);
> +		num_alloc += DIV_ROUND_UP(sg_dma_len(sg), BAM_FIFO_SIZE);
>  
>  	/* allocate enough room to accomodate the number of entries */
>  	async_desc = kzalloc(sizeof(*async_desc) +
> @@ -636,10 +636,10 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  			desc->addr = cpu_to_le32(sg_dma_address(sg) +
>  						 curr_offset);
>  
> -			if (remainder > BAM_MAX_DATA_SIZE) {
> -				desc->size = cpu_to_le16(BAM_MAX_DATA_SIZE);
> -				remainder -= BAM_MAX_DATA_SIZE;
> -				curr_offset += BAM_MAX_DATA_SIZE;
> +			if (remainder > BAM_FIFO_SIZE) {
> +				desc->size = cpu_to_le16(BAM_FIFO_SIZE);
> +				remainder -= BAM_FIFO_SIZE;
> +				curr_offset += BAM_FIFO_SIZE;
>  			} else {
>  				desc->size = cpu_to_le16(remainder);
>  				remainder = 0;
> @@ -1174,7 +1174,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	/* set max dma segment size */
>  	bdev->common.dev = bdev->dev;
>  	bdev->common.dev->dma_parms = &bdev->dma_parms;
> -	ret = dma_set_max_seg_size(bdev->common.dev, BAM_MAX_DATA_SIZE);
> +	ret = dma_set_max_seg_size(bdev->common.dev, BAM_FIFO_SIZE);
>  	if (ret) {
>  		dev_err(bdev->dev, "cannot set maximum segment size\n");
>  		goto err_bam_channel_exit;
> -- 
> 1.9.1
> 

-- 
~Vinod
