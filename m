From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 11 Jan 2017 14:51:13 +0800
Subject: [PATCH v11 12/12] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484117473-46644-13-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the Mediatek MT2701 DISP subsystem.
There is only one OVL engine in MT2701.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  8 ++++++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |  6 ++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 17 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  7 +++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dsi.c          |  1 +
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c      |  6 ++++++
 7 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 4552178..a14d7d6 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -35,6 +35,7 @@
 #define DISP_REG_OVL_PITCH(n)			(0x0044 + 0x20 * (n))
 #define DISP_REG_OVL_RDMA_CTRL(n)		(0x00c0 + 0x20 * (n))
 #define DISP_REG_OVL_RDMA_GMC(n)		(0x00c8 + 0x20 * (n))
+#define DISP_REG_OVL_ADDR_MT2701		0x0040
 #define DISP_REG_OVL_ADDR_MT8173		0x0f40
 #define DISP_REG_OVL_ADDR(ovl, n)		((ovl)->data->addr + 0x20 * (n))
 
@@ -303,12 +304,19 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
+	.addr = DISP_REG_OVL_ADDR_MT2701,
+	.fmt_rgb565_is_0 = false,
+};
+
 static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
 	.addr = DISP_REG_OVL_ADDR_MT8173,
 	.fmt_rgb565_is_0 = true,
 };
 
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-ovl",
+	  .data = &mt2701_ovl_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-ovl",
 	  .data = &mt8173_ovl_driver_data},
 	{},
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index e5e5318..b68a513 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -236,11 +236,17 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_disp_rdma_data mt2701_rdma_driver_data = {
+	.fifo_size = SZ_4K,
+};
+
 static const struct mtk_disp_rdma_data mt8173_rdma_driver_data = {
 	.fifo_size = SZ_8K,
 };
 
 static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-rdma",
+	  .data = &mt2701_rdma_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-rdma",
 	  .data = &mt8173_rdma_driver_data},
 	{},
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index a9b209c..8130f3d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -60,6 +60,13 @@
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
@@ -92,6 +99,15 @@ struct mtk_ddp {
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
@@ -390,6 +406,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ddp_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
 	{},
 };
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index f6e853a..8b52416 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -39,6 +39,7 @@
 #define DISP_REG_UFO_START			0x0000
 
 #define DISP_COLOR_CFG_MAIN			0x0400
+#define DISP_COLOR_START_MT2701			0x0f00
 #define DISP_COLOR_START_MT8173			0x0c00
 #define DISP_COLOR_START(comp)			((comp)->data->color_offset)
 #define DISP_COLOR_WIDTH(comp)			(DISP_COLOR_START(comp) + 0x50)
@@ -285,11 +286,17 @@ struct mtk_ddp_comp_match {
 	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
 };
 
+static const struct mtk_disp_color_data mt2701_color_driver_data = {
+	.color_offset = DISP_COLOR_START_MT2701,
+};
+
 static const struct mtk_disp_color_data mt8173_color_driver_data = {
 	.color_offset = DISP_COLOR_START_MT8173,
 };
 
 static const struct of_device_id mtk_disp_color_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-color",
+	  .data = &mt2701_color_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-color",
 	  .data = &mt8173_color_driver_data},
 	{},
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 074fe31..7daabae 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -128,6 +128,19 @@ static int mtk_atomic_commit(struct drm_device *drm,
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
@@ -147,6 +160,14 @@ static int mtk_atomic_commit(struct drm_device *drm,
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
@@ -340,16 +361,22 @@ static void mtk_drm_unbind(struct device *dev)
 };
 
 static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
+	{ .compatible = "mediatek,mt2701-disp-ovl",   .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8173-disp-ovl",   .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt2701-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-rdma",  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-wdma",  .data = (void *)MTK_DISP_WDMA },
+	{ .compatible = "mediatek,mt2701-disp-color", .data = (void *)MTK_DISP_COLOR },
 	{ .compatible = "mediatek,mt8173-disp-color", .data = (void *)MTK_DISP_COLOR },
 	{ .compatible = "mediatek,mt8173-disp-aal",   .data = (void *)MTK_DISP_AAL},
 	{ .compatible = "mediatek,mt8173-disp-gamma", .data = (void *)MTK_DISP_GAMMA, },
 	{ .compatible = "mediatek,mt8173-disp-ufoe",  .data = (void *)MTK_DISP_UFOE },
+	{ .compatible = "mediatek,mt2701-dsi",	      .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
+	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_BLS },
 	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
 	{ .compatible = "mediatek,mt8173-disp-od",    .data = (void *)MTK_DISP_OD },
 	{ }
@@ -523,6 +550,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
 static const struct of_device_id mtk_drm_of_ids[] = {
+	{ .compatible = "mediatek,mt2701-mmsys",
+	  .data = &mt2701_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
 	  .data = &mt8173_mmsys_driver_data},
 	{ }
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 21392c4..e1832ea 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1228,6 +1228,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_dsi_of_match[] = {
+	{ .compatible = "mediatek,mt2701-dsi" },
 	{ .compatible = "mediatek,mt8173-dsi" },
 	{ },
 };
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
index fd84914..90e9131 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
@@ -465,11 +465,17 @@ static int mtk_mipi_tx_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_mipitx_data mt2701_mipitx_data = {
+	.mppll_preserve = (3 << 8)
+};
+
 static const struct mtk_mipitx_data mt8173_mipitx_data = {
 	.mppll_preserve = (0 << 8)
 };
 
 static const struct of_device_id mtk_mipi_tx_match[] = {
+	{ .compatible = "mediatek,mt2701-mipi-tx",
+	  .data = &mt2701_mipitx_data },
 	{ .compatible = "mediatek,mt8173-mipi-tx",
 	  .data = &mt8173_mipitx_data },
 	{},
-- 
1.9.1
