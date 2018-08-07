From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 7 Aug 2018 11:01:32 +0800
Subject: [PATCH v3 06/13] drm/mediatek: add RGB color format support for
 RDMA
In-Reply-To: <1533556700-26525-7-git-send-email-stu.hsieh@mediatek.com>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
 <1533556700-26525-7-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533610892.10818.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-08-06 at 19:58 +0800, Stu Hsieh wrote:
> This patch add RGB color format support for RDMA,
> including RGB565, RGB888, RGBA8888 and ARGB8888.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 41 ++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 08866550740f..ba72d392dc27 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -35,6 +35,8 @@
>  #define DISP_REG_RDMA_SIZE_CON_0		0x0014
>  #define DISP_REG_RDMA_SIZE_CON_1		0x0018
>  #define DISP_REG_RDMA_TARGET_LINE		0x001c
> +#define DISP_RDMA_MEM_CON			0x0024
> +#define MEM_MODE_INPUT_SWAP				BIT(8)
>  #define DISP_RDMA_MEM_SRC_PITCH			0x002c
>  #define DISP_RDMA_MEM_GMC_SETTING_0		0x0030
>  #define DISP_REG_RDMA_FIFO_CON			0x0040
> @@ -46,6 +48,11 @@
>  
>  #define RDMA_MEM_GMC				0x40402020
>  
> +#define MEM_MODE_INPUT_FORMAT_RGB565		0x0
> +#define MEM_MODE_INPUT_FORMAT_RGB888		(0x001 << 4)
> +#define MEM_MODE_INPUT_FORMAT_RGBA8888		(0x002 << 4)
> +#define MEM_MODE_INPUT_FORMAT_ARGB8888		(0x003 << 4)
> +
>  struct mtk_disp_rdma_data {
>  	unsigned int fifo_size;
>  };
> @@ -144,12 +151,46 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
>  }
>  
> +static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
> +				     unsigned int fmt)
> +{
> +	switch (fmt) {
> +	default:
> +	case DRM_FORMAT_RGB565:
> +		return MEM_MODE_INPUT_FORMAT_RGB565;
> +	case DRM_FORMAT_BGR565:
> +		return MEM_MODE_INPUT_FORMAT_RGB565 | MEM_MODE_INPUT_SWAP;
> +	case DRM_FORMAT_RGB888:
> +		return MEM_MODE_INPUT_FORMAT_RGB888;
> +	case DRM_FORMAT_BGR888:
> +		return MEM_MODE_INPUT_FORMAT_RGB888 | MEM_MODE_INPUT_SWAP;
> +	case DRM_FORMAT_RGBX8888:
> +	case DRM_FORMAT_RGBA8888:
> +		return MEM_MODE_INPUT_FORMAT_ARGB8888;

I think the alphabet order of the naming reflect the dram order for each
color. Of course, big-endian and little-endian would result in reversed
naming order. I could not understand why RDMA use ARGB8888 naming for
DRM RGBA8888. If the typo is from data sheet, I could just accept this
typo and give an explain in driver because I want to align driver with
data sheet.

Regards,
CK

> +	case DRM_FORMAT_BGRX8888:
> +	case DRM_FORMAT_BGRA8888:
> +		return MEM_MODE_INPUT_FORMAT_ARGB8888 | MEM_MODE_INPUT_SWAP;
> +	case DRM_FORMAT_XRGB8888:
> +	case DRM_FORMAT_ARGB8888:
> +		return MEM_MODE_INPUT_FORMAT_RGBA8888;
> +	case DRM_FORMAT_XBGR8888:
> +	case DRM_FORMAT_ABGR8888:
> +		return MEM_MODE_INPUT_FORMAT_RGBA8888 | MEM_MODE_INPUT_SWAP;
> +	}
> +}
> +
>  static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  				  struct mtk_plane_state *state)
>  {
> +	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
>  	struct mtk_plane_pending_state *pending = &state->pending;
>  	unsigned int addr = pending->addr;
>  	unsigned int pitch = pending->pitch & 0xffff;
> +	unsigned int fmt = pending->format;
> +	unsigned int con;
> +
> +	con = rdma_fmt_convert(rdma, fmt);
> +	writel_relaxed(con, comp->regs + DISP_RDMA_MEM_CON);
>  
>  	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
>  	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
