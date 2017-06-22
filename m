From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 22 Jun 2017 16:44:04 +0800
Subject: [PATCH v3] drm: mediatek: change the variable type of rdma
 threshold
In-Reply-To: <1498099413-13357-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1498099413-13357-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1498121044.20158.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-06-22 at 10:43 +0800, Bibby Hsieh wrote:
> For some greater resolution, the rdma threshold
> variable will overflow.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 0df05f9..8540aaa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -109,7 +109,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  			    unsigned int height, unsigned int vrefresh,
>  			    unsigned int bpc)
>  {
> -	unsigned int threshold;
> +	unsigned long long threshold;
>  	unsigned int reg;
>  
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
> @@ -121,10 +121,11 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  	 * output threshold to 6 microseconds with 7/6 overhead to
>  	 * account for blanking, and with a pixel depth of 4 bytes:
>  	 */
> -	threshold = width * height * vrefresh * 4 * 7 / 1000000;
> +	threshold = div_u64((unsigned long long)width * height * vrefresh *
> +			    4 * 7, 1000000);
>  	reg = RDMA_FIFO_UNDERFLOW_EN |
>  	      RDMA_FIFO_PSEUDO_SIZE(SZ_8K) |
> -	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
> +	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(clamp_val(threshold, 0, 0x3ff0));

Hi, Bibby:

Please symbolize '0x3ff0'.

Regards,
CK

>  	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
>  }
>  
