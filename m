From: yt.shen@mediatek.com (YT Shen)
Date: Fri, 15 Jul 2016 18:07:50 +0800
Subject: [PATCH v4 4/8] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
References: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1468577274-6178-5-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the Mediatek MT2701 DISP subsystem.
There is only one OVL engine in MT2701.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |    6 ++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |    6 ++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |   41 +++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |    7 +++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |    1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   31 ++++++++++++++++++++
 6 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index eb5c05e..1da0a71 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -286,11 +286,17 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_ddp_comp_driver_data mt2701_ovl_driver_data = {
+	.ovl = {0x0040, 1 << 12, 0}
+};
+
 static const struct mtk_ddp_comp_driver_data mt8173_ovl_driver_data = {
 	.ovl = {0x0f40, 0, 1 << 12}
 };
 
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-ovl",
+	  .data = &mt2701_ovl_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-ovl",
 	  .data = &mt8173_ovl_driver_data},
 	{},
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index fb0db50..506a353 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -225,11 +225,17 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_ddp_comp_driver_data mt2701_rdma_driver_data = {
+	.rdma_fifo_pseudo_size = SZ_4K,
+};
+
 static const struct mtk_ddp_comp_driver_data mt8173_rdma_driver_data = {
 	.rdma_fifo_pseudo_size = SZ_8K,
 };
 
 static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-rdma",
+	  .data = &mt2701_rdma_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-rdma",
 	  .data = &mt8173_rdma_driver_data},
 	{},
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index fa53806..ee0326a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -32,6 +32,10 @@
 #define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
 #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
 
+#define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
+#define DISP_REG_CONFIG_OUT_SEL			0x04c
+#define DISP_REG_CONFIG_DSI_SEL			0x050
+
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
@@ -54,6 +58,13 @@
 #define MT8173_MUTEX_MOD_DISP_PWM1		BIT(24)
 #define MT8173_MUTEX_MOD_DISP_OD		BIT(25)
 
+#define MT2701_MUTEX_MOD_DISP_OVL		BIT(3)
+#define MT2701_MUTEX_MOD_DISP_WDMA		BIT(6)
+#define MT2701_MUTEX_MOD_DISP_COLOR		BIT(7)
+#define MT2701_MUTEX_MOD_DISP_BLS		BIT(9)
+#define MT2701_MUTEX_MOD_DISP_RDMA0		BIT(10)
+#define MT2701_MUTEX_MOD_DISP_RDMA1		BIT(12)
+
 #define MUTEX_SOF_SINGLE_MODE		0
 #define MUTEX_SOF_DSI0			1
 #define MUTEX_SOF_DSI1			2
@@ -69,6 +80,10 @@
 #define DPI0_SEL_IN_RDMA1		0x1
 #define COLOR1_SEL_IN_OVL1		0x1
 
+#define OVL_MOUT_EN_RDMA		0x1
+#define BLS_TO_DSI_RDMA1_TO_DPI1	0x8
+#define DSI_SEL_IN_BLS			0x0
+
 struct mtk_disp_mutex {
 	int id;
 	bool claimed;
@@ -82,6 +97,15 @@ struct mtk_ddp {
 	const unsigned int		*mutex_mod;
 };
 
+static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_BLS] = MT2701_MUTEX_MOD_DISP_BLS,
+	[DDP_COMPONENT_COLOR0] = MT2701_MUTEX_MOD_DISP_COLOR,
+	[DDP_COMPONENT_OVL0] = MT2701_MUTEX_MOD_DISP_OVL,
+	[DDP_COMPONENT_RDMA0] = MT2701_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MT2701_MUTEX_MOD_DISP_RDMA1,
+	[DDP_COMPONENT_WDMA0] = MT2701_MUTEX_MOD_DISP_WDMA,
+};
+
 static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL] = MT8173_MUTEX_MOD_DISP_AAL,
 	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
@@ -109,6 +133,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
 		*addr = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
 		value = OVL0_MOUT_EN_COLOR0;
+	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
+		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
+		value = OVL_MOUT_EN_RDMA;
 	} else if (cur == DDP_COMPONENT_OD && next == DDP_COMPONENT_RDMA0) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
 		value = OD_MOUT_EN_RDMA0;
@@ -146,6 +173,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
 		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
 		value = COLOR1_SEL_IN_OVL1;
+	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
+		*addr = DISP_REG_CONFIG_DSI_SEL;
+		value = DSI_SEL_IN_BLS;
 	} else {
 		value = 0;
 	}
@@ -153,6 +183,14 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	return value;
 }
 
+static void mtk_ddp_sout_sel(void __iomem *config_regs,
+			    enum mtk_ddp_comp_id cur, enum mtk_ddp_comp_id next)
+{
+	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0)
+		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
+			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+}
+
 void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next)
@@ -165,6 +203,8 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
 		writel_relaxed(reg, config_regs + addr);
 	}
 
+	mtk_ddp_sout_sel(config_regs, cur, next);
+
 	value = mtk_ddp_sel_in(cur, next, &addr);
 	if (value) {
 		reg = readl_relaxed(config_regs + addr) | value;
@@ -362,6 +402,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ddp_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
 	{},
 };
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 4b4e449..465819b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -112,6 +112,7 @@ struct mtk_ddp_comp_match {
 
 static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, NULL },
+	[DDP_COMPONENT_BLS]	= { MTK_DISP_PWM,	0, NULL },
 	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
 	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
 	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
@@ -130,11 +131,17 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
 };
 
+static const struct mtk_ddp_comp_driver_data mt2701_color_driver_data = {
+	.color_offset = 0x0f00,
+};
+
 static const struct mtk_ddp_comp_driver_data mt8173_color_driver_data = {
 	.color_offset = 0x0c00,
 };
 
 static const struct of_device_id mtk_disp_color_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-color",
+	  .data = &mt2701_color_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-color",
 	  .data = &mt8173_color_driver_data},
 	{},
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 53065c7..0850aa4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -40,6 +40,7 @@ enum mtk_ddp_comp_type {
 
 enum mtk_ddp_comp_id {
 	DDP_COMPONENT_AAL,
+	DDP_COMPONENT_BLS,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_DPI0,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 80b4f54..13cf160 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -109,6 +109,19 @@ static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
 	.atomic_commit = mtk_atomic_commit,
 };
 
+static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_BLS,
+	DDP_COMPONENT_DSI0,
+};
+
+static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
+	DDP_COMPONENT_RDMA1,
+	DDP_COMPONENT_DPI0,
+};
+
 static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
@@ -128,6 +141,14 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
 	DDP_COMPONENT_DPI0,
 };
 
+static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
+	.main_path = mt2701_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
+	.ext_path = mt2701_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
+	.shadow_register = true,
+};
+
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.main_path = mt8173_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
@@ -331,16 +352,24 @@ static const struct component_master_ops mtk_drm_ops = {
 };
 
 static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
+	{ .compatible = "mediatek,mt2701-disp-ovl",   .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8173-disp-ovl",   .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt2701-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
+	{ .compatible = "mediatek,mt2701-disp-wdma",  .data = (void *)MTK_DISP_WDMA },
 	{ .compatible = "mediatek,mt8173-disp-wdma",  .data = (void *)MTK_DISP_WDMA },
+	{ .compatible = "mediatek,mt2701-disp-color", .data = (void *)MTK_DISP_COLOR },
 	{ .compatible = "mediatek,mt8173-disp-color", .data = (void *)MTK_DISP_COLOR },
 	{ .compatible = "mediatek,mt8173-disp-aal",   .data = (void *)MTK_DISP_AAL},
 	{ .compatible = "mediatek,mt8173-disp-gamma", .data = (void *)MTK_DISP_GAMMA, },
 	{ .compatible = "mediatek,mt8173-disp-ufoe",  .data = (void *)MTK_DISP_UFOE },
+	{ .compatible = "mediatek,mt2701-dsi",	      .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt2701-dpi",	      .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
+	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_PWM },
 	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
 	{ .compatible = "mediatek,mt8173-disp-od",    .data = (void *)MTK_DISP_OD },
 	{ }
@@ -514,6 +543,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
 static const struct of_device_id mtk_drm_of_ids[] = {
+	{ .compatible = "mediatek,mt2701-mmsys",
+	  .data = &mt2701_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
 	  .data = &mt8173_mmsys_driver_data},
 	{ }
-- 
1.7.9.5
