From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 21 Jun 2017 14:14:56 -0700
Subject: [v2] drm: mediatek: change the variable type of rdma threshold
In-Reply-To: <1495187843-6882-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1495187843-6882-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <20170621211456.GA21176@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 05:57:23PM +0800, Bibby Hsieh wrote:
> For some greater resolution, the rdma threshold
> variable will overflow.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 0df05f9..9afdcd7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -37,7 +37,7 @@
>  #define DISP_REG_RDMA_FIFO_CON			0x0040
>  #define RDMA_FIFO_UNDERFLOW_EN				BIT(31)
>  #define RDMA_FIFO_PSEUDO_SIZE(bytes)			(((bytes) / 16) << 16)
> -#define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes)		((bytes) / 16)
> +#define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes) (((bytes) / 16) & 0x3ff)

I agree with the earlier comment; clamp_val() might be more appropriate here
and would avoid unexpected results.

>  
>  /**
>   * struct mtk_disp_rdma - DISP_RDMA driver structure
> @@ -109,7 +109,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  			    unsigned int height, unsigned int vrefresh,
>  			    unsigned int bpc)
>  {
> -	unsigned int threshold;
> +	unsigned long long threshold;
>  	unsigned int reg;
>  
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
> @@ -121,7 +121,8 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  	 * output threshold to 6 microseconds with 7/6 overhead to
>  	 * account for blanking, and with a pixel depth of 4 bytes:
>  	 */
> -	threshold = width * height * vrefresh * 4 * 7 / 1000000;
> +	threshold = (unsigned long long)width * height * vrefresh *
> +		    4 * 7 / 1000000;

This is a 64 bit divide operation. It will result in a build failure
if compiled for a 32 bit kernel (eg arm:allmodconfig).

ERROR: "__aeabi_uldivmod" [drivers/gpu/drm/mediatek/mediatek-drm.ko] undefined!

Guenter
