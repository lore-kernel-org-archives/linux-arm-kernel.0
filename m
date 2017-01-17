From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 17 Jan 2017 10:37:11 +0800
Subject: [PATCH v11 03/12] drm/mediatek: add *driver_data for different
 hardware settings
In-Reply-To: <1484117473-46644-4-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
 <1484117473-46644-4-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484620631.15251.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Wed, 2017-01-11 at 14:51 +0800, YT Shen wrote:
> There are some hardware settings changed, between MT8173 & MT2701:
> DISP_OVL address offset changed, color format definition changed.
> DISP_RDMA fifo size changed.
> DISP_COLOR offset changed.
> MIPI_TX pll setting changed.
> And add prefix for mtk_ddp_main & mtk_ddp_ext & mutex_mod.
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>

Acked-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 41 ++++++++++++-----
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 18 +++++++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 71 +++++++++++++++--------------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 57 +++++++++++++++++++----
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 25 +++++++---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |  8 ++++
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c      | 24 +++++++++-
>  7 files changed, 181 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index ce2759f..4552178 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -35,18 +35,27 @@
>  #define DISP_REG_OVL_PITCH(n)			(0x0044 + 0x20 * (n))
>  #define DISP_REG_OVL_RDMA_CTRL(n)		(0x00c0 + 0x20 * (n))
>  #define DISP_REG_OVL_RDMA_GMC(n)		(0x00c8 + 0x20 * (n))
> -#define DISP_REG_OVL_ADDR(n)			(0x0f40 + 0x20 * (n))
> +#define DISP_REG_OVL_ADDR_MT8173		0x0f40
> +#define DISP_REG_OVL_ADDR(ovl, n)		((ovl)->data->addr + 0x20 * (n))
>  
>  #define	OVL_RDMA_MEM_GMC	0x40402020
>  
>  #define OVL_CON_BYTE_SWAP	BIT(24)
> -#define OVL_CON_CLRFMT_RGB565	(0 << 12)
> -#define OVL_CON_CLRFMT_RGB888	(1 << 12)
> +#define OVL_CON_CLRFMT_RGB	(1 << 12)
>  #define OVL_CON_CLRFMT_RGBA8888	(2 << 12)
>  #define OVL_CON_CLRFMT_ARGB8888	(3 << 12)
> +#define OVL_CON_CLRFMT_RGB565(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
> +					0 : OVL_CON_CLRFMT_RGB)
> +#define OVL_CON_CLRFMT_RGB888(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
> +					OVL_CON_CLRFMT_RGB : 0)
>  #define	OVL_CON_AEN		BIT(8)
>  #define	OVL_CON_ALPHA		0xff
>  
> +struct mtk_disp_ovl_data {
> +	unsigned int addr;
> +	bool fmt_rgb565_is_0;
> +};
> +
>  /**
>   * struct mtk_disp_ovl - DISP_OVL driver structure
>   * @ddp_comp - structure containing type enum and hardware resources
> @@ -55,6 +64,7 @@
>  struct mtk_disp_ovl {
>  	struct mtk_ddp_comp		ddp_comp;
>  	struct drm_crtc			*crtc;
> +	const struct mtk_disp_ovl_data	*data;
>  };
>  
>  static inline struct mtk_disp_ovl *comp_to_ovl(struct mtk_ddp_comp *comp)
> @@ -141,18 +151,18 @@ static void mtk_ovl_layer_off(struct mtk_ddp_comp *comp, unsigned int idx)
>  	writel(0x0, comp->regs + DISP_REG_OVL_RDMA_CTRL(idx));
>  }
>  
> -static unsigned int ovl_fmt_convert(unsigned int fmt)
> +static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt)
>  {
>  	switch (fmt) {
>  	default:
>  	case DRM_FORMAT_RGB565:
> -		return OVL_CON_CLRFMT_RGB565;
> +		return OVL_CON_CLRFMT_RGB565(ovl);
>  	case DRM_FORMAT_BGR565:
> -		return OVL_CON_CLRFMT_RGB565 | OVL_CON_BYTE_SWAP;
> +		return OVL_CON_CLRFMT_RGB565(ovl) | OVL_CON_BYTE_SWAP;
>  	case DRM_FORMAT_RGB888:
> -		return OVL_CON_CLRFMT_RGB888;
> +		return OVL_CON_CLRFMT_RGB888(ovl);
>  	case DRM_FORMAT_BGR888:
> -		return OVL_CON_CLRFMT_RGB888 | OVL_CON_BYTE_SWAP;
> +		return OVL_CON_CLRFMT_RGB888(ovl) | OVL_CON_BYTE_SWAP;
>  	case DRM_FORMAT_RGBX8888:
>  	case DRM_FORMAT_RGBA8888:
>  		return OVL_CON_CLRFMT_ARGB8888;
> @@ -171,6 +181,7 @@ static unsigned int ovl_fmt_convert(unsigned int fmt)
>  static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  				 struct mtk_plane_state *state)
>  {
> +	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
>  	struct mtk_plane_pending_state *pending = &state->pending;
>  	unsigned int addr = pending->addr;
>  	unsigned int pitch = pending->pitch & 0xffff;
> @@ -182,7 +193,7 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  	if (!pending->enable)
>  		mtk_ovl_layer_off(comp, idx);
>  
> -	con = ovl_fmt_convert(fmt);
> +	con = ovl_fmt_convert(ovl, fmt);
>  	if (idx != 0)
>  		con |= OVL_CON_AEN | OVL_CON_ALPHA;
>  
> @@ -190,7 +201,7 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  	writel_relaxed(pitch, comp->regs + DISP_REG_OVL_PITCH(idx));
>  	writel_relaxed(src_size, comp->regs + DISP_REG_OVL_SRC_SIZE(idx));
>  	writel_relaxed(offset, comp->regs + DISP_REG_OVL_OFFSET(idx));
> -	writel_relaxed(addr, comp->regs + DISP_REG_OVL_ADDR(idx));
> +	writel_relaxed(addr, comp->regs + DISP_REG_OVL_ADDR(ovl, idx));
>  
>  	if (pending->enable)
>  		mtk_ovl_layer_on(comp, idx);
> @@ -267,6 +278,8 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	priv->data = of_device_get_match_data(dev);
> +
>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = devm_request_irq(dev, irq, mtk_disp_ovl_irq_handler,
> @@ -290,8 +303,14 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
> +	.addr = DISP_REG_OVL_ADDR_MT8173,
> +	.fmt_rgb565_is_0 = true,
> +};
> +
>  static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
> -	{ .compatible = "mediatek,mt8173-disp-ovl", },
> +	{ .compatible = "mediatek,mt8173-disp-ovl",
> +	  .data = &mt8173_ovl_driver_data},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 21eff6f..e5e5318 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -38,6 +38,11 @@
>  #define RDMA_FIFO_UNDERFLOW_EN				BIT(31)
>  #define RDMA_FIFO_PSEUDO_SIZE(bytes)			(((bytes) / 16) << 16)
>  #define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes)		((bytes) / 16)
> +#define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
> +
> +struct mtk_disp_rdma_data {
> +	unsigned int fifo_size;
> +};
>  
>  /**
>   * struct mtk_disp_rdma - DISP_RDMA driver structure
> @@ -47,6 +52,7 @@
>  struct mtk_disp_rdma {
>  	struct mtk_ddp_comp		ddp_comp;
>  	struct drm_crtc			*crtc;
> +	const struct mtk_disp_rdma_data	*data;
>  };
>  
>  static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *comp)
> @@ -114,6 +120,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  {
>  	unsigned int threshold;
>  	unsigned int reg;
> +	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
>  
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
> @@ -126,7 +133,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  	 */
>  	threshold = width * height * vrefresh * 4 * 7 / 1000000;
>  	reg = RDMA_FIFO_UNDERFLOW_EN |
> -	      RDMA_FIFO_PSEUDO_SIZE(SZ_8K) |
> +	      RDMA_FIFO_PSEUDO_SIZE(RDMA_FIFO_SIZE(rdma)) |
>  	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
>  	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
>  }
> @@ -211,6 +218,8 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	priv->data = of_device_get_match_data(dev);
> +
>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = component_add(dev, &mtk_disp_rdma_component_ops);
> @@ -227,8 +236,13 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct mtk_disp_rdma_data mt8173_rdma_driver_data = {
> +	.fifo_size = SZ_8K,
> +};
> +
>  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
> -	{ .compatible = "mediatek,mt8173-disp-rdma", },
> +	{ .compatible = "mediatek,mt8173-disp-rdma",
> +	  .data = &mt8173_rdma_driver_data},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 17ba935..8030769 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -36,21 +36,21 @@
>  #define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
>  #define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
>  
> -#define MUTEX_MOD_DISP_OVL0		BIT(11)
> -#define MUTEX_MOD_DISP_OVL1		BIT(12)
> -#define MUTEX_MOD_DISP_RDMA0		BIT(13)
> -#define MUTEX_MOD_DISP_RDMA1		BIT(14)
> -#define MUTEX_MOD_DISP_RDMA2		BIT(15)
> -#define MUTEX_MOD_DISP_WDMA0		BIT(16)
> -#define MUTEX_MOD_DISP_WDMA1		BIT(17)
> -#define MUTEX_MOD_DISP_COLOR0		BIT(18)
> -#define MUTEX_MOD_DISP_COLOR1		BIT(19)
> -#define MUTEX_MOD_DISP_AAL		BIT(20)
> -#define MUTEX_MOD_DISP_GAMMA		BIT(21)
> -#define MUTEX_MOD_DISP_UFOE		BIT(22)
> -#define MUTEX_MOD_DISP_PWM0		BIT(23)
> -#define MUTEX_MOD_DISP_PWM1		BIT(24)
> -#define MUTEX_MOD_DISP_OD		BIT(25)
> +#define MT8173_MUTEX_MOD_DISP_OVL0		BIT(11)
> +#define MT8173_MUTEX_MOD_DISP_OVL1		BIT(12)
> +#define MT8173_MUTEX_MOD_DISP_RDMA0		BIT(13)
> +#define MT8173_MUTEX_MOD_DISP_RDMA1		BIT(14)
> +#define MT8173_MUTEX_MOD_DISP_RDMA2		BIT(15)
> +#define MT8173_MUTEX_MOD_DISP_WDMA0		BIT(16)
> +#define MT8173_MUTEX_MOD_DISP_WDMA1		BIT(17)
> +#define MT8173_MUTEX_MOD_DISP_COLOR0		BIT(18)
> +#define MT8173_MUTEX_MOD_DISP_COLOR1		BIT(19)
> +#define MT8173_MUTEX_MOD_DISP_AAL		BIT(20)
> +#define MT8173_MUTEX_MOD_DISP_GAMMA		BIT(21)
> +#define MT8173_MUTEX_MOD_DISP_UFOE		BIT(22)
> +#define MT8173_MUTEX_MOD_DISP_PWM0		BIT(23)
> +#define MT8173_MUTEX_MOD_DISP_PWM1		BIT(24)
> +#define MT8173_MUTEX_MOD_DISP_OD		BIT(25)
>  
>  #define MUTEX_SOF_SINGLE_MODE		0
>  #define MUTEX_SOF_DSI0			1
> @@ -77,24 +77,25 @@ struct mtk_ddp {
>  	struct clk			*clk;
>  	void __iomem			*regs;
>  	struct mtk_disp_mutex		mutex[10];
> +	const unsigned int		*mutex_mod;
>  };
>  
> -static const unsigned int mutex_mod[DDP_COMPONENT_ID_MAX] = {
> -	[DDP_COMPONENT_AAL] = MUTEX_MOD_DISP_AAL,
> -	[DDP_COMPONENT_COLOR0] = MUTEX_MOD_DISP_COLOR0,
> -	[DDP_COMPONENT_COLOR1] = MUTEX_MOD_DISP_COLOR1,
> -	[DDP_COMPONENT_GAMMA] = MUTEX_MOD_DISP_GAMMA,
> -	[DDP_COMPONENT_OD] = MUTEX_MOD_DISP_OD,
> -	[DDP_COMPONENT_OVL0] = MUTEX_MOD_DISP_OVL0,
> -	[DDP_COMPONENT_OVL1] = MUTEX_MOD_DISP_OVL1,
> -	[DDP_COMPONENT_PWM0] = MUTEX_MOD_DISP_PWM0,
> -	[DDP_COMPONENT_PWM1] = MUTEX_MOD_DISP_PWM1,
> -	[DDP_COMPONENT_RDMA0] = MUTEX_MOD_DISP_RDMA0,
> -	[DDP_COMPONENT_RDMA1] = MUTEX_MOD_DISP_RDMA1,
> -	[DDP_COMPONENT_RDMA2] = MUTEX_MOD_DISP_RDMA2,
> -	[DDP_COMPONENT_UFOE] = MUTEX_MOD_DISP_UFOE,
> -	[DDP_COMPONENT_WDMA0] = MUTEX_MOD_DISP_WDMA0,
> -	[DDP_COMPONENT_WDMA1] = MUTEX_MOD_DISP_WDMA1,
> +static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> +	[DDP_COMPONENT_AAL] = MT8173_MUTEX_MOD_DISP_AAL,
> +	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
> +	[DDP_COMPONENT_COLOR1] = MT8173_MUTEX_MOD_DISP_COLOR1,
> +	[DDP_COMPONENT_GAMMA] = MT8173_MUTEX_MOD_DISP_GAMMA,
> +	[DDP_COMPONENT_OD] = MT8173_MUTEX_MOD_DISP_OD,
> +	[DDP_COMPONENT_OVL0] = MT8173_MUTEX_MOD_DISP_OVL0,
> +	[DDP_COMPONENT_OVL1] = MT8173_MUTEX_MOD_DISP_OVL1,
> +	[DDP_COMPONENT_PWM0] = MT8173_MUTEX_MOD_DISP_PWM0,
> +	[DDP_COMPONENT_PWM1] = MT8173_MUTEX_MOD_DISP_PWM1,
> +	[DDP_COMPONENT_RDMA0] = MT8173_MUTEX_MOD_DISP_RDMA0,
> +	[DDP_COMPONENT_RDMA1] = MT8173_MUTEX_MOD_DISP_RDMA1,
> +	[DDP_COMPONENT_RDMA2] = MT8173_MUTEX_MOD_DISP_RDMA2,
> +	[DDP_COMPONENT_UFOE] = MT8173_MUTEX_MOD_DISP_UFOE,
> +	[DDP_COMPONENT_WDMA0] = MT8173_MUTEX_MOD_DISP_WDMA0,
> +	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
>  };
>  
>  static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> @@ -247,7 +248,7 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  		break;
>  	default:
>  		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
> -		reg |= mutex_mod[id];
> +		reg |= ddp->mutex_mod[id];
>  		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
>  		return;
>  	}
> @@ -273,7 +274,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  		break;
>  	default:
>  		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
> -		reg &= ~mutex_mod[id];
> +		reg &= ~(ddp->mutex_mod[id]);
>  		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
>  		break;
>  	}
> @@ -326,6 +327,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>  		return PTR_ERR(ddp->regs);
>  	}
>  
> +	ddp->mutex_mod = of_device_get_match_data(dev);
> +
>  	platform_set_drvdata(pdev, ddp);
>  
>  	return 0;
> @@ -337,7 +340,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id ddp_driver_dt_match[] = {
> -	{ .compatible = "mediatek,mt8173-disp-mutex" },
> +	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 48cc01f..3ff788c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -39,9 +39,10 @@
>  #define DISP_REG_UFO_START			0x0000
>  
>  #define DISP_COLOR_CFG_MAIN			0x0400
> -#define DISP_COLOR_START			0x0c00
> -#define DISP_COLOR_WIDTH			0x0c50
> -#define DISP_COLOR_HEIGHT			0x0c54
> +#define DISP_COLOR_START_MT8173			0x0c00
> +#define DISP_COLOR_START(comp)			((comp)->data->color_offset)
> +#define DISP_COLOR_WIDTH(comp)			(DISP_COLOR_START(comp) + 0x50)
> +#define DISP_COLOR_HEIGHT(comp)			(DISP_COLOR_START(comp) + 0x54)
>  
>  #define DISP_AAL_EN				0x0000
>  #define DISP_AAL_SIZE				0x0030
> @@ -80,6 +81,20 @@
>  #define DITHER_ADD_LSHIFT_G(x)			(((x) & 0x7) << 4)
>  #define DITHER_ADD_RSHIFT_G(x)			(((x) & 0x7) << 0)
>  
> +struct mtk_disp_color_data {
> +	unsigned int color_offset;
> +};
> +
> +struct mtk_disp_color {
> +	struct mtk_ddp_comp			ddp_comp;
> +	const struct mtk_disp_color_data	*data;
> +};
> +
> +static inline struct mtk_disp_color *comp_to_color(struct mtk_ddp_comp *comp)
> +{
> +	return container_of(comp, struct mtk_disp_color, ddp_comp);
> +}
> +
>  void mtk_dither_set(struct mtk_ddp_comp *comp, unsigned int bpc,
>  		    unsigned int CFG)
>  {
> @@ -107,15 +122,19 @@ static void mtk_color_config(struct mtk_ddp_comp *comp, unsigned int w,
>  			     unsigned int h, unsigned int vrefresh,
>  			     unsigned int bpc)
>  {
> -	writel(w, comp->regs + DISP_COLOR_WIDTH);
> -	writel(h, comp->regs + DISP_COLOR_HEIGHT);
> +	struct mtk_disp_color *color = comp_to_color(comp);
> +
> +	writel(w, comp->regs + DISP_COLOR_WIDTH(color));
> +	writel(h, comp->regs + DISP_COLOR_HEIGHT(color));
>  }
>  
>  static void mtk_color_start(struct mtk_ddp_comp *comp)
>  {
> +	struct mtk_disp_color *color = comp_to_color(comp);
> +
>  	writel(COLOR_BYPASS_ALL | COLOR_SEQ_SEL,
>  	       comp->regs + DISP_COLOR_CFG_MAIN);
> -	writel(0x1, comp->regs + DISP_COLOR_START);
> +	writel(0x1, comp->regs + DISP_COLOR_START(color));
>  }
>  
>  static void mtk_od_config(struct mtk_ddp_comp *comp, unsigned int w,
> @@ -264,6 +283,16 @@ struct mtk_ddp_comp_match {
>  	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
>  };
>  
> +static const struct mtk_disp_color_data mt8173_color_driver_data = {
> +	.color_offset = DISP_COLOR_START_MT8173,
> +};
> +
> +static const struct of_device_id mtk_disp_color_driver_dt_match[] = {
> +	{ .compatible = "mediatek,mt8173-disp-color",
> +	  .data = &mt8173_color_driver_data},
> +	{},
> +};
> +
>  int mtk_ddp_comp_get_id(struct device_node *node,
>  			enum mtk_ddp_comp_type comp_type)
>  {
> @@ -286,10 +315,24 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  	enum mtk_ddp_comp_type type;
>  	struct device_node *larb_node;
>  	struct platform_device *larb_pdev;
> +	const struct of_device_id *match;
> +	struct mtk_disp_color *color;
>  
>  	if (comp_id < 0 || comp_id >= DDP_COMPONENT_ID_MAX)
>  		return -EINVAL;
>  
> +	type = mtk_ddp_matches[comp_id].type;
> +	if (type == MTK_DISP_COLOR) {
> +		devm_kfree(dev, comp);
> +		color = devm_kzalloc(dev, sizeof(*color), GFP_KERNEL);
> +		if (!color)
> +			return -ENOMEM;
> +
> +		match = of_match_node(mtk_disp_color_driver_dt_match, node);
> +		color->data = match->data;
> +		comp = &color->ddp_comp;
> +	}
> +
>  	comp->id = comp_id;
>  	comp->funcs = funcs ?: mtk_ddp_matches[comp_id].funcs;
>  
> @@ -308,8 +351,6 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  	if (IS_ERR(comp->clk))
>  		comp->clk = NULL;
>  
> -	type = mtk_ddp_matches[comp_id].type;
> -
>  	/* Only DMA capable components need the LARB property */
>  	comp->larb_dev = NULL;
>  	if (type != MTK_DISP_OVL &&
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 4b7fe7e..074fe31 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -128,7 +128,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	.atomic_commit = mtk_atomic_commit,
>  };
>  
> -static const enum mtk_ddp_comp_id mtk_ddp_main[] = {
> +static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
>  	DDP_COMPONENT_OVL0,
>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_AAL,
> @@ -139,7 +139,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	DDP_COMPONENT_PWM0,
>  };
>  
> -static const enum mtk_ddp_comp_id mtk_ddp_ext[] = {
> +static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
>  	DDP_COMPONENT_OVL1,
>  	DDP_COMPONENT_COLOR1,
>  	DDP_COMPONENT_GAMMA,
> @@ -147,6 +147,13 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	DDP_COMPONENT_DPI0,
>  };
>  
> +static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> +	.main_path = mt8173_mtk_ddp_main,
> +	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
> +	.ext_path = mt8173_mtk_ddp_ext,
> +	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
> +};
> +
>  static int mtk_drm_kms_init(struct drm_device *drm)
>  {
>  	struct mtk_drm_private *private = drm->dev_private;
> @@ -189,17 +196,19 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	 * and each statically assigned to a crtc:
>  	 * OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0 ...
>  	 */
> -	ret = mtk_drm_crtc_create(drm, mtk_ddp_main, ARRAY_SIZE(mtk_ddp_main));
> +	ret = mtk_drm_crtc_create(drm, private->data->main_path,
> +				  private->data->main_len);
>  	if (ret < 0)
>  		goto err_component_unbind;
>  	/* ... and OVL1 -> COLOR1 -> GAMMA -> RDMA1 -> DPI0. */
> -	ret = mtk_drm_crtc_create(drm, mtk_ddp_ext, ARRAY_SIZE(mtk_ddp_ext));
> +	ret = mtk_drm_crtc_create(drm, private->data->ext_path,
> +				  private->data->ext_len);
>  	if (ret < 0)
>  		goto err_component_unbind;
>  
>  	/* Use OVL device for all DMA memory allocations */
> -	np = private->comp_node[mtk_ddp_main[0]] ?:
> -	     private->comp_node[mtk_ddp_ext[0]];
> +	np = private->comp_node[private->data->main_path[0]] ?:
> +	     private->comp_node[private->data->ext_path[0]];
>  	pdev = of_find_device_by_node(np);
>  	if (!pdev) {
>  		ret = -ENODEV;
> @@ -362,6 +371,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  
>  	mutex_init(&private->commit.lock);
>  	INIT_WORK(&private->commit.work, mtk_atomic_work);
> +	private->data = of_device_get_match_data(dev);
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	private->config_regs = devm_ioremap_resource(dev, mem);
> @@ -513,7 +523,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
>  			 mtk_drm_sys_resume);
>  
>  static const struct of_device_id mtk_drm_of_ids[] = {
> -	{ .compatible = "mediatek,mt8173-mmsys", },
> +	{ .compatible = "mediatek,mt8173-mmsys",
> +	  .data = &mt8173_mmsys_driver_data},
>  	{ }
>  };
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index aa93894..fa0b106 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -28,6 +28,13 @@
>  struct drm_property;
>  struct regmap;
>  
> +struct mtk_mmsys_driver_data {
> +	const enum mtk_ddp_comp_id *main_path;
> +	unsigned int main_len;
> +	const enum mtk_ddp_comp_id *ext_path;
> +	unsigned int ext_len;
> +};
> +
>  struct mtk_drm_private {
>  	struct drm_device *drm;
>  	struct device *dma_dev;
> @@ -40,6 +47,7 @@ struct mtk_drm_private {
>  	void __iomem *config_regs;
>  	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
>  	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
> +	const struct mtk_mmsys_driver_data *data;
>  
>  	struct {
>  		struct drm_atomic_state *state;
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> index 1c366f8..c4a0165 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
>  
> @@ -87,6 +88,9 @@
>  
>  #define MIPITX_DSI_PLL_CON2	0x58
>  
> +#define MIPITX_DSI_PLL_TOP	0x64
> +#define RG_DSI_MPPLL_PRESERVE		(0xff << 8)
> +
>  #define MIPITX_DSI_PLL_PWR	0x68
>  #define RG_DSI_MPPLL_SDM_PWR_ON		BIT(0)
>  #define RG_DSI_MPPLL_SDM_ISO_EN		BIT(1)
> @@ -123,10 +127,15 @@
>  #define SW_LNT2_HSTX_PRE_OE		BIT(24)
>  #define SW_LNT2_HSTX_OE			BIT(25)
>  
> +struct mtk_mipitx_data {
> +	const u32 mppll_preserve;
> +};
> +
>  struct mtk_mipi_tx {
>  	struct device *dev;
>  	void __iomem *regs;
>  	unsigned int data_rate;
> +	const struct mtk_mipitx_data *driver_data;
>  	struct clk_hw pll_hw;
>  	struct clk *pll;
>  };
> @@ -243,6 +252,10 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
>  	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
>  			       RG_DSI_MPPLL_SDM_SSC_EN);
>  
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
> +				RG_DSI_MPPLL_PRESERVE,
> +				mipi_tx->driver_data->mppll_preserve);
> +
>  	return 0;
>  }
>  
> @@ -255,6 +268,9 @@ static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
>  	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
>  			       RG_DSI_MPPLL_PLL_EN);
>  
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
> +				RG_DSI_MPPLL_PRESERVE, 0);
> +
>  	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
>  				RG_DSI_MPPLL_SDM_ISO_EN |
>  				RG_DSI_MPPLL_SDM_PWR_ON,
> @@ -391,6 +407,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  	if (!mipi_tx)
>  		return -ENOMEM;
>  
> +	mipi_tx->driver_data = of_device_get_match_data(dev);
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mipi_tx->regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(mipi_tx->regs)) {
> @@ -448,8 +465,13 @@ static int mtk_mipi_tx_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct mtk_mipitx_data mt8173_mipitx_data = {
> +	.mppll_preserve = (0 << 8)
> +};
> +
>  static const struct of_device_id mtk_mipi_tx_match[] = {
> -	{ .compatible = "mediatek,mt8173-mipi-tx", },
> +	{ .compatible = "mediatek,mt8173-mipi-tx",
> +	  .data = &mt8173_mipitx_data },
>  	{},
>  };
>  
