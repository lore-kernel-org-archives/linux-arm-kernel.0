From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 9 Aug 2018 10:41:26 +0800
Subject: [PATCH v4 08/14] drm/mediatek: add YUYV/UYVY color format
 support for RDMA
In-Reply-To: <1533780949-30141-9-git-send-email-stu.hsieh@mediatek.com>
References: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
 <1533780949-30141-9-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533782486.29986.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Thu, 2018-08-09 at 10:15 +0800, Stu Hsieh wrote:
> This patch add YUYV/UYVY color format support for RDMA
> and transform matrix for YUYV/UYVY.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 1f57f86c7910..8b015c2d4418 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -33,6 +33,8 @@
>  #define RDMA_ENGINE_EN					BIT(0)
>  #define RDMA_MODE_MEMORY				BIT(1)
>  #define DISP_REG_RDMA_SIZE_CON_0		0x0014
> +#define RDMA_MATRIX_ENABLE				BIT(17)
> +#define RDMA_MATRIX_INT_MTX_BT601_to_RGB		(6 << 20)
>  #define DISP_REG_RDMA_SIZE_CON_1		0x0018
>  #define DISP_REG_RDMA_TARGET_LINE		0x001c
>  #define DISP_RDMA_MEM_CON			0x0024
> @@ -46,12 +48,15 @@
>  #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
>  #define DISP_RDMA_MEM_START_ADDR		0x0f00
>  
> +#define RDMA_MATRIX_INT_MTX_SEL			GENMASK(23, 20)
>  #define RDMA_MEM_GMC				0x40402020
>  
>  #define MEM_MODE_INPUT_FORMAT_RGB565		0x0
>  #define MEM_MODE_INPUT_FORMAT_RGB888		(0x001 << 4)
>  #define MEM_MODE_INPUT_FORMAT_RGBA8888		(0x002 << 4)
>  #define MEM_MODE_INPUT_FORMAT_ARGB8888		(0x003 << 4)
> +#define MEM_MODE_INPUT_FORMAT_UYVY		(0x004 << 4)
> +#define MEM_MODE_INPUT_FORMAT_YUYV		(0x005 << 4)
>  
>  struct mtk_disp_rdma_data {
>  	unsigned int fifo_size;
> @@ -181,6 +186,10 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
>  	case DRM_FORMAT_XBGR8888:
>  	case DRM_FORMAT_ABGR8888:
>  		return MEM_MODE_INPUT_FORMAT_RGBA8888 | MEM_MODE_INPUT_SWAP;
> +	case DRM_FORMAT_UYVY:
> +		return MEM_MODE_INPUT_FORMAT_UYVY;
> +	case DRM_FORMAT_YUYV:
> +		return MEM_MODE_INPUT_FORMAT_YUYV;
>  	}
>  }
>  
> @@ -197,6 +206,17 @@ static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  	con = rdma_fmt_convert(rdma, fmt);
>  	writel_relaxed(con, comp->regs + DISP_RDMA_MEM_CON);
>  
> +	if (fmt == DRM_FORMAT_UYVY || fmt == DRM_FORMAT_YUYV) {
> +		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0,
> +				 RDMA_MATRIX_ENABLE, RDMA_MATRIX_ENABLE);
> +		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0,
> +				 RDMA_MATRIX_INT_MTX_SEL,
> +				 RDMA_MATRIX_INT_MTX_BT601_to_RGB);
> +	} else {
> +		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0,
> +				 RDMA_MATRIX_ENABLE, 0);
> +	}
> +
>  	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
>  	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
>  	writel(RDMA_MEM_GMC, comp->regs + DISP_RDMA_MEM_GMC_SETTING_0);
