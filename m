From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 10 Aug 2016 15:30:25 +0800
Subject: [PATCH v6 09/10] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1470378970.16554.27.camel@mtksdaap41>
References: <1470308844-20895-1-git-send-email-yt.shen@mediatek.com>
 <1470308844-20895-10-git-send-email-yt.shen@mediatek.com>
 <1470378970.16554.27.camel@mtksdaap41>
Message-ID: <1470814225.27526.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Fri, 2016-08-05 at 14:36 +0800, CK Hu wrote:
> Hi, YT:
> 
> On Thu, 2016-08-04 at 19:07 +0800, YT Shen wrote:
> > This patch add support for the Mediatek MT2701 DISP subsystem.
> > There is only one OVL engine in MT2701.
> > 
> > Signed-off-by: YT Shen <yt.shen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    6 ++++++
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    6 ++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |   17 +++++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |    7 ++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |    1 +
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   29 +++++++++++++++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_dsi.c          |    1 +
> >  drivers/gpu/drm/mediatek/mtk_mipi_tx.c      |   31 ++++++++++++++++++++++++++-
> >  8 files changed, 97 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > index eb5c05e..1da0a71 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > @@ -286,11 +286,17 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static const struct mtk_ddp_comp_driver_data mt2701_ovl_driver_data = {
> > +	.ovl = {0x0040, 1 << 12, 0}
> > +};
> > +
> >  static const struct mtk_ddp_comp_driver_data mt8173_ovl_driver_data = {
> >  	.ovl = {0x0f40, 0, 1 << 12}
> >  };
> >  
> >  static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
> > +	{ .compatible = "mediatek,mt2701-disp-ovl",
> > +	  .data = &mt2701_ovl_driver_data},
> >  	{ .compatible = "mediatek,mt8173-disp-ovl",
> >  	  .data = &mt8173_ovl_driver_data},
> >  	{},
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > index fb0db50..506a353 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > @@ -225,11 +225,17 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static const struct mtk_ddp_comp_driver_data mt2701_rdma_driver_data = {
> > +	.rdma_fifo_pseudo_size = SZ_4K,
> > +};
> > +
> >  static const struct mtk_ddp_comp_driver_data mt8173_rdma_driver_data = {
> >  	.rdma_fifo_pseudo_size = SZ_8K,
> >  };
> >  
> >  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
> > +	{ .compatible = "mediatek,mt2701-disp-rdma",
> > +	  .data = &mt2701_rdma_driver_data},
> >  	{ .compatible = "mediatek,mt8173-disp-rdma",
> >  	  .data = &mt8173_rdma_driver_data},
> >  	{},
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index a9b209c..8130f3d 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -60,6 +60,13 @@
> >  #define MT8173_MUTEX_MOD_DISP_PWM1		BIT(24)
> >  #define MT8173_MUTEX_MOD_DISP_OD		BIT(25)
> >  
> > +#define MT2701_MUTEX_MOD_DISP_OVL		BIT(3)
> > +#define MT2701_MUTEX_MOD_DISP_WDMA		BIT(6)
> > +#define MT2701_MUTEX_MOD_DISP_COLOR		BIT(7)
> > +#define MT2701_MUTEX_MOD_DISP_BLS		BIT(9)
> > +#define MT2701_MUTEX_MOD_DISP_RDMA0		BIT(10)
> > +#define MT2701_MUTEX_MOD_DISP_RDMA1		BIT(12)
> > +
> >  #define MUTEX_SOF_SINGLE_MODE		0
> >  #define MUTEX_SOF_DSI0			1
> >  #define MUTEX_SOF_DSI1			2
> > @@ -92,6 +99,15 @@ struct mtk_ddp {
> >  	const unsigned int		*mutex_mod;
> >  };
> >  
> > +static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> > +	[DDP_COMPONENT_BLS] = MT2701_MUTEX_MOD_DISP_BLS,
> > +	[DDP_COMPONENT_COLOR0] = MT2701_MUTEX_MOD_DISP_COLOR,
> > +	[DDP_COMPONENT_OVL0] = MT2701_MUTEX_MOD_DISP_OVL,
> > +	[DDP_COMPONENT_RDMA0] = MT2701_MUTEX_MOD_DISP_RDMA0,
> > +	[DDP_COMPONENT_RDMA1] = MT2701_MUTEX_MOD_DISP_RDMA1,
> > +	[DDP_COMPONENT_WDMA0] = MT2701_MUTEX_MOD_DISP_WDMA,
> > +};
> > +
> >  static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> >  	[DDP_COMPONENT_AAL] = MT8173_MUTEX_MOD_DISP_AAL,
> >  	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
> > @@ -390,6 +406,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
> >  }
> >  
> >  static const struct of_device_id ddp_driver_dt_match[] = {
> > +	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
> >  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
> >  	{},
> >  };
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > index 4b4e449..465819b 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > @@ -112,6 +112,7 @@ struct mtk_ddp_comp_match {
> >  
> >  static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> >  	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, NULL },
> > +	[DDP_COMPONENT_BLS]	= { MTK_DISP_PWM,	0, NULL },
> >  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
> >  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
> >  	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
> > @@ -130,11 +131,17 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> >  	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
> >  };
> >  
> > +static const struct mtk_ddp_comp_driver_data mt2701_color_driver_data = {
> > +	.color_offset = 0x0f00,
> > +};
> > +
> >  static const struct mtk_ddp_comp_driver_data mt8173_color_driver_data = {
> >  	.color_offset = 0x0c00,
> >  };
> >  
> >  static const struct of_device_id mtk_disp_color_driver_dt_match[] = {
> > +	{ .compatible = "mediatek,mt2701-disp-color",
> > +	  .data = &mt2701_color_driver_data},
> >  	{ .compatible = "mediatek,mt8173-disp-color",
> >  	  .data = &mt8173_color_driver_data},
> >  	{},
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > index 53065c7..0850aa4 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > @@ -40,6 +40,7 @@ enum mtk_ddp_comp_type {
> >  
> >  enum mtk_ddp_comp_id {
> >  	DDP_COMPONENT_AAL,
> > +	DDP_COMPONENT_BLS,
> >  	DDP_COMPONENT_COLOR0,
> >  	DDP_COMPONENT_COLOR1,
> >  	DDP_COMPONENT_DPI0,
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index 80b4f54..2503f04 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -109,6 +109,19 @@ static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
> >  	.atomic_commit = mtk_atomic_commit,
> >  };
> >  
> > +static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
> > +	DDP_COMPONENT_OVL0,
> > +	DDP_COMPONENT_RDMA0,
> > +	DDP_COMPONENT_COLOR0,
> > +	DDP_COMPONENT_BLS,
> > +	DDP_COMPONENT_DSI0,
> > +};
> > +
> > +static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
> > +	DDP_COMPONENT_RDMA1,
> > +	DDP_COMPONENT_DPI0,
> > +};
> > +
> >  static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
> >  	DDP_COMPONENT_OVL0,
> >  	DDP_COMPONENT_COLOR0,
> > @@ -128,6 +141,14 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
> >  	DDP_COMPONENT_DPI0,
> >  };
> >  
> > +static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
> > +	.main_path = mt2701_mtk_ddp_main,
> > +	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
> > +	.ext_path = mt2701_mtk_ddp_ext,
> > +	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
> > +	.shadow_register = true,
> > +};
> > +
> >  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> >  	.main_path = mt8173_mtk_ddp_main,
> >  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
> > @@ -331,16 +352,22 @@ static const struct component_master_ops mtk_drm_ops = {
> >  };
> >  
> >  static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
> > +	{ .compatible = "mediatek,mt2701-disp-ovl",   .data = (void *)MTK_DISP_OVL },
> >  	{ .compatible = "mediatek,mt8173-disp-ovl",   .data = (void *)MTK_DISP_OVL },
> > +	{ .compatible = "mediatek,mt2701-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
> >  	{ .compatible = "mediatek,mt8173-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
> >  	{ .compatible = "mediatek,mt8173-disp-wdma",  .data = (void *)MTK_DISP_WDMA },
> > +	{ .compatible = "mediatek,mt2701-disp-color", .data = (void *)MTK_DISP_COLOR },
> >  	{ .compatible = "mediatek,mt8173-disp-color", .data = (void *)MTK_DISP_COLOR },
> >  	{ .compatible = "mediatek,mt8173-disp-aal",   .data = (void *)MTK_DISP_AAL},
> >  	{ .compatible = "mediatek,mt8173-disp-gamma", .data = (void *)MTK_DISP_GAMMA, },
> >  	{ .compatible = "mediatek,mt8173-disp-ufoe",  .data = (void *)MTK_DISP_UFOE },
> > +	{ .compatible = "mediatek,mt2701-dsi",	      .data = (void *)MTK_DSI },
> >  	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
> >  	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
> > +	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> >  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> > +	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_PWM },
> >  	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
> >  	{ .compatible = "mediatek,mt8173-disp-od",    .data = (void *)MTK_DISP_OD },
> >  	{ }
> > @@ -514,6 +541,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
> >  			 mtk_drm_sys_resume);
> >  
> >  static const struct of_device_id mtk_drm_of_ids[] = {
> > +	{ .compatible = "mediatek,mt2701-mmsys",
> > +	  .data = &mt2701_mmsys_driver_data},
> >  	{ .compatible = "mediatek,mt8173-mmsys",
> >  	  .data = &mt8173_mmsys_driver_data},
> >  	{ }
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 3373019..8b8a629 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -1300,6 +1300,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> >  }
> >  
> >  static const struct of_device_id mtk_dsi_of_match[] = {
> > +	{ .compatible = "mediatek,mt2701-dsi" },
> >  	{ .compatible = "mediatek,mt8173-dsi" },
> >  	{ },
> >  };
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > index 0666f15..6c2aec0 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/phy/phy.h>
> >  
> > @@ -87,6 +88,9 @@
> >  
> >  #define MIPITX_DSI_PLL_CON2	0x58
> >  
> > +#define MIPITX_DSI_PLL_TOP	0x64
> > +#define RG_DSI_MPPLL_PRESERVE		(0xff << 8)
> > +
> >  #define MIPITX_DSI_PLL_PWR	0x68
> >  #define RG_DSI_MPPLL_SDM_PWR_ON		BIT(0)
> >  #define RG_DSI_MPPLL_SDM_ISO_EN		BIT(1)
> > @@ -123,10 +127,16 @@
> >  #define SW_LNT2_HSTX_PRE_OE		BIT(24)
> >  #define SW_LNT2_HSTX_OE			BIT(25)
> >  
> > +struct mtk_mipitx_data {
> > +	const u32 data;
> > +};
> > +
> >  struct mtk_mipi_tx {
> >  	struct device *dev;
> >  	void __iomem *regs;
> >  	u32 data_rate;
> > +	const struct mtk_mipitx_data *driver_data;
> > +
> >  	struct clk_hw pll_hw;
> >  	struct clk *pll;
> >  };
> > @@ -245,6 +255,10 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> >  	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
> >  			       RG_DSI_MPPLL_SDM_SSC_EN);
> >  
> > +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
> > +				RG_DSI_MPPLL_PRESERVE,
> > +				mipi_tx->driver_data->data);
> 
> This part look like it should be moved to patch of "drm/mediatek: add
> *driver_data for different hardware settings".
OK.

> 
> > +
> >  	return 0;
> >  }
> >  
> > @@ -257,6 +271,9 @@ static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
> >  	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> >  			       RG_DSI_MPPLL_PLL_EN);
> >  
> > +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
> > +				RG_DSI_MPPLL_PRESERVE, 0);
> 
> This part look like it should be moved to patch of "drm/mediatek: add
> *driver_data for different hardware settings".
OK.

> 
> > +
> >  	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
> >  				RG_DSI_MPPLL_SDM_ISO_EN |
> >  				RG_DSI_MPPLL_SDM_PWR_ON,
> > @@ -393,6 +410,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
> >  	if (!mipi_tx)
> >  		return -ENOMEM;
> >  
> > +	mipi_tx->driver_data = of_device_get_match_data(dev);
> >  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	mipi_tx->regs = devm_ioremap_resource(dev, mem);
> >  	if (IS_ERR(mipi_tx->regs)) {
> > @@ -450,8 +468,19 @@ static int mtk_mipi_tx_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static const struct mtk_mipitx_data mt2701_mipitx_data = {
> > +	.data = (3 << 8)
> > +};
> > +
> > +static const struct mtk_mipitx_data mt8173_mipitx_data = {
> > +	.data = (0 << 8)
> > +};
> 
> mt8173_mipitx_data look like it should be moved to patch of
> "drm/mediatek: add *driver_data for different hardware settings". And
> you just add mt2701_mipitx_data in this patch.
We will move the 8173 parts into "drm/mediatek: add *driver_data for
different hardware settings", and put the remaining in this patch.

Regards,
yt.shen

> 
> > +
> >  static const struct of_device_id mtk_mipi_tx_match[] = {
> > -	{ .compatible = "mediatek,mt8173-mipi-tx", },
> > +	{ .compatible = "mediatek,mt2701-mipi-tx",
> > +	  .data = &mt2701_mipitx_data },
> > +	{ .compatible = "mediatek,mt8173-mipi-tx",
> > +	  .data = &mt8173_mipitx_data },
> >  	{},
> >  };
> >  
> 
> Regards,
> CK
> 
