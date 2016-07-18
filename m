From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 18 Jul 2016 10:33:57 +0800
Subject: [PATCH v3 2/2] drm/mediatek: set mt8173 dithering function
In-Reply-To: <1467877029-45236-3-git-send-email-bibby.hsieh@mediatek.com>
References: <1467877029-45236-1-git-send-email-bibby.hsieh@mediatek.com>
 <1467877029-45236-3-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1468809237.30644.28.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

Some comments inline.

On Thu, 2016-07-07 at 15:37 +0800, Bibby Hsieh wrote:
> Some panels only accept bpc (bit per color) 6-bit.
> But, the default bpc in mt8173 display data path is 8-bit.
> If we didn't enable dithering function to convert bpc,
> display cannot show the smooth grayscale image.
> 
> In mt8173, the dithering function in OD (OverDrive) and
> GAMMA module, we have to config them with
> connector->display_mode.bpc when CRTC initial.
> 
> 1. Clear the default value at *_DITHER_5 and *_DITHER_7 register.
> 2. Calculate the LSB_ERR_SHIFT bits and ADD_LSHIFT bits two values.
> i.e. Input bpc of OD is 10 bits, we assume the bpc of panel is 6-bit,
> so, we need to set 4-bit to LSB_ERR_SHIFT and ADD_LSHIFT bits respectively.
> 3. Then, set the OD or GAMMA to dithering mode depends on path-1 or path-2.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    3 +-
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    3 +-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   21 ++++++--
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   77 +++++++++++++++++++++++----
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |    6 +--
>  5 files changed, 92 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 8f62671f..019b7ca 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -103,7 +103,8 @@ static void mtk_ovl_stop(struct mtk_ddp_comp *comp)
>  }
>  
>  static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
> -			   unsigned int h, unsigned int vrefresh)
> +			   unsigned int h, unsigned int vrefresh,
> +			   unsigned int bpc)
>  {
>  	if (w != 0 && h != 0)
>  		writel_relaxed(h << 16 | w, comp->regs + DISP_REG_OVL_ROI_SIZE);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 5fb80cb..0df05f9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -106,7 +106,8 @@ static void mtk_rdma_stop(struct mtk_ddp_comp *comp)
>  }
>  
>  static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> -			    unsigned int height, unsigned int vrefresh)
> +			    unsigned int height, unsigned int vrefresh,
> +			    unsigned int bpc)
>  {
>  	unsigned int threshold;
>  	unsigned int reg;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index ee219bb..18c9d0d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -222,7 +222,9 @@ static void mtk_crtc_ddp_clk_disable(struct mtk_drm_crtc *mtk_crtc)
>  static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>  {
>  	struct drm_crtc *crtc = &mtk_crtc->base;
> -	unsigned int width, height, vrefresh;
> +	struct drm_connector *connector;
> +	struct drm_encoder *encoder;
> +	unsigned int width, height, vrefresh, bpc = 0;
>  	int ret;
>  	int i;
>  
> @@ -234,6 +236,19 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>  	height = crtc->state->adjusted_mode.vdisplay;
>  	vrefresh = crtc->state->adjusted_mode.vrefresh;
>  
> +	drm_for_each_encoder(encoder, crtc->dev) {
> +		if (encoder->crtc != crtc)
> +			continue;
> +
> +		drm_for_each_connector(connector, crtc->dev) {
> +			if (connector->encoder != encoder)
> +				continue;
> +			if (connector->display_info.bpc >= 3 &&

I think you should left this HW constrain in mtk_od_config() and
mtk_gamma_config(). Here just calculate the expected bpc.

> +			    (bpc == 0 || bpc > connector->display_info.bpc))

I think bpc should be initialized as HW default bpc and you can remove
this condiction 'bpc == 0' because we should set bpc to HW default bpc
while all connnector bpc is greater than HW default bpc.

> +				bpc = connector->display_info.bpc;
> +		}
> +	}
> +
>  	ret = pm_runtime_get_sync(crtc->dev->dev);
>  	if (ret < 0) {
>  		DRM_ERROR("Failed to enable power domain: %d\n", ret);
> @@ -266,7 +281,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>  	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
>  		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
>  
> -		mtk_ddp_comp_config(comp, width, height, vrefresh);
> +		mtk_ddp_comp_config(comp, width, height, vrefresh, bpc);
>  		mtk_ddp_comp_start(comp);
>  	}
>  
> @@ -469,7 +484,7 @@ void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *ovl)
>  	if (state->pending_config) {
>  		mtk_ddp_comp_config(ovl, state->pending_width,
>  				    state->pending_height,
> -				    state->pending_vrefresh);
> +				    state->pending_vrefresh, 0);

Why set bpc as 0 here? Maybe you have a assumption that OVL don't care
the bpc parameter. If one day OVL care it and we do not review here, the
bugs happen.

>  
>  		state->pending_config = false;
>  	}
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 56c5894..c10faac 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -30,7 +30,26 @@
>  #define DISP_OD_INTEN				0x0008
>  #define DISP_OD_INTSTA				0x000c
>  #define DISP_OD_CFG				0x0020
> +#define OD_RELAYMODE				BIT(0)
> +#define OD_DITHERING				BIT(2)
>  #define DISP_OD_SIZE				0x0030
> +#define DISP_OD_DITHER_5			0x0114
> +#define DISP_OD_DITHER_7			0x011c
> +#define DISP_OD_DITHER_15			0x013c
> +#define DITHER_LSB_ERR_SHIFT_R(x)		(((x) & 0x7) << 28)
> +#define DITHER_OVFLW_BIT_R(x)			(((x) & 0x7) << 24)
> +#define DITHER_ADD_LSHIFT_R(x)			(((x) & 0x7) << 20)
> +#define DITHER_ADD_RSHIFT_R(x)			(((x) & 0x7) << 16)
> +#define DITHER_NEW_BIT_MODE			BIT(0)
> +#define DISP_OD_DITHER_16			0x140
> +#define DITHER_LSB_ERR_SHIFT_B(x)		(((x) & 0x7) << 28)
> +#define DITHER_OVFLW_BIT_B(x)			(((x) & 0x7) << 24)
> +#define DITHER_ADD_LSHIFT_B(x)			(((x) & 0x7) << 20)
> +#define DITHER_ADD_RSHIFT_B(x)			(((x) & 0x7) << 16)
> +#define DITHER_LSB_ERR_SHIFT_G(x)		(((x) & 0x7) << 12)
> +#define DITHER_OVFLW_BIT_G(x)			(((x) & 0x7) << 8)
> +#define DITHER_ADD_LSHIFT_G(x)			(((x) & 0x7) << 4)
> +#define DITHER_ADD_RSHIFT_G(x)			(((x) & 0x7) << 0)
>  
>  #define DISP_REG_UFO_START			0x0000
>  
> @@ -44,25 +63,28 @@
>  
>  #define DISP_GAMMA_EN				0x000
>  #define DISP_GAMMA_CFG				0x020
> +#define GAMMA_EN				BIT(0)
> +#define GAMMA_LUT_EN				BIT(1)
> +#define GAMMA_DITHERING				BIT(2)
>  #define DISP_GAMMA_SIZE				0x030
>  #define DISP_GAMMA_LUT				0x700
> +#define DISP_GAMMA_DITHER_5			0x0114
> +#define DISP_GAMMA_DITHER_7			0x011c
> +#define DISP_GAMMA_DITHER_15			0x013c
> +#define DISP_GAMMA_DITHER_16			0x0140
>  
>  #define LUT_10BIT_MASK				0x3ff
>  
>  #define AAL_EN			BIT(0)
>  
> -#define GAMMA_EN		BIT(0)
> -#define GAMMA_LUT_EN		BIT(1)
> -
> -#define	OD_RELAY_MODE		BIT(0)
> -
>  #define	UFO_BYPASS		BIT(2)
>  
>  #define	COLOR_BYPASS_ALL	BIT(7)
>  #define	COLOR_SEQ_SEL		BIT(13)
>  
>  static void mtk_color_config(struct mtk_ddp_comp *comp, unsigned int w,
> -			     unsigned int h, unsigned int vrefresh)
> +			     unsigned int h, unsigned int vrefresh,
> +			     unsigned int bpc)
>  {
>  	writel(w, comp->regs + DISP_COLOR_WIDTH);
>  	writel(h, comp->regs + DISP_COLOR_HEIGHT);
> @@ -76,14 +98,33 @@ static void mtk_color_start(struct mtk_ddp_comp *comp)
>  }
>  
>  static void mtk_od_config(struct mtk_ddp_comp *comp, unsigned int w,
> -			  unsigned int h, unsigned int vrefresh)
> +			  unsigned int h, unsigned int vrefresh,
> +			  unsigned int bpc)
>  {
>  	writel(w << 16 | h, comp->regs + DISP_OD_SIZE);
> +	if (bpc >= 3 && bpc < 10) {

Use symbol to replace magic number can improve the readability. For
example.

#define DITHER_MIN_BITS 3
#define DITHER_MAX_BITS 8

> +		writel(0, comp->regs + DISP_OD_DITHER_5);
> +		writel(0, comp->regs + DISP_OD_DITHER_7);
> +		writel(DITHER_LSB_ERR_SHIFT_R(10 - bpc) |
> +		       DITHER_ADD_LSHIFT_R(10 - bpc) |
> +		       DITHER_NEW_BIT_MODE,
> +		       comp->regs + DISP_OD_DITHER_15);
> +		writel(DITHER_LSB_ERR_SHIFT_B(10 - bpc) |
> +		       DITHER_ADD_LSHIFT_B(10 - bpc) |
> +		       DITHER_LSB_ERR_SHIFT_G(10 - bpc) |
> +		       DITHER_ADD_LSHIFT_G(10 - bpc),
> +		       comp->regs + DISP_OD_DITHER_16);
> +		writel(OD_DITHERING,
> +		       comp->regs + DISP_OD_CFG);
> +	} else {
> +		writel(OD_RELAYMODE,
> +		       comp->regs + DISP_OD_CFG);
> +	}
> +
>  }
>  
>  static void mtk_od_start(struct mtk_ddp_comp *comp)
>  {
> -	writel(OD_RELAY_MODE, comp->regs + DISP_OD_CFG);
>  	writel(1, comp->regs + DISP_OD_EN);
>  }
>  
> @@ -93,7 +134,8 @@ static void mtk_ufoe_start(struct mtk_ddp_comp *comp)
>  }
>  
>  static void mtk_aal_config(struct mtk_ddp_comp *comp, unsigned int w,
> -			   unsigned int h, unsigned int vrefresh)
> +			   unsigned int h, unsigned int vrefresh,
> +			   unsigned int bpc)
>  {
>  	writel(h << 16 | w, comp->regs + DISP_AAL_SIZE);
>  }
> @@ -109,9 +151,24 @@ static void mtk_aal_stop(struct mtk_ddp_comp *comp)
>  }
>  
>  static void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
> -			     unsigned int h, unsigned int vrefresh)
> +			     unsigned int h, unsigned int vrefresh,
> +			     unsigned int bpc)
>  {
>  	writel(h << 16 | w, comp->regs + DISP_GAMMA_SIZE);
> +	if (bpc >= 3 && bpc < 10) {
> +		writel(0, comp->regs + DISP_GAMMA_DITHER_5);
> +		writel(0, comp->regs + DISP_GAMMA_DITHER_7);
> +		writel(DITHER_LSB_ERR_SHIFT_R(10 - bpc) |
> +		       DITHER_ADD_LSHIFT_R(10 - bpc) |
> +		       DITHER_NEW_BIT_MODE,
> +		       comp->regs + DISP_GAMMA_DITHER_15);
> +		writel(DITHER_LSB_ERR_SHIFT_B(10 - bpc) |
> +		       DITHER_ADD_LSHIFT_B(10 - bpc) |
> +		       DITHER_LSB_ERR_SHIFT_G(10 - bpc) |
> +		       DITHER_ADD_LSHIFT_G(10 - bpc),
> +		       comp->regs + DISP_GAMMA_DITHER_16);
> +		writel(GAMMA_DITHERING, comp->regs + DISP_GAMMA_CFG);
> +	}

This part is the same as mtk_od_config(), so it's better to have a
function 'mtk_dither_config()' and both mtk_od_config() and
mtk_gamma_config() call this function.

>  }
>  
>  static void mtk_gamma_start(struct mtk_ddp_comp *comp)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 07e17fe..c7c2e92 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -65,7 +65,7 @@ struct mtk_ddp_comp;
>  
>  struct mtk_ddp_comp_funcs {
>  	void (*config)(struct mtk_ddp_comp *comp, unsigned int w,
> -		       unsigned int h, unsigned int vrefresh);
> +		       unsigned int h, unsigned int vrefresh, unsigned int bpc);
>  	void (*start)(struct mtk_ddp_comp *comp);
>  	void (*stop)(struct mtk_ddp_comp *comp);
>  	void (*enable_vblank)(struct mtk_ddp_comp *comp, struct drm_crtc *crtc);
> @@ -89,10 +89,10 @@ struct mtk_ddp_comp {
>  
>  static inline void mtk_ddp_comp_config(struct mtk_ddp_comp *comp,
>  				       unsigned int w, unsigned int h,
> -				       unsigned int vrefresh)
> +				       unsigned int vrefresh, unsigned int bpc)
>  {
>  	if (comp->funcs && comp->funcs->config)
> -		comp->funcs->config(comp, w, h, vrefresh);
> +		comp->funcs->config(comp, w, h, vrefresh, bpc);
>  }
>  
>  static inline void mtk_ddp_comp_start(struct mtk_ddp_comp *comp)
