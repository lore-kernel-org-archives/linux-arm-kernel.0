From: yt.shen@mediatek.com (yt.shen at mediatek.com)
Date: Fri, 20 May 2016 23:05:33 +0800
Subject: [RFC v2 2/5] drm/mediatke: add support for Mediatek SoC MT2701
In-Reply-To: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1463756736-46573-3-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YT Shen <yt.shen@mediatek.com>

This patch add support for the Mediatek MT2701 DISP subsystem.
There is only one OVL engine in MT2701.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |   63 +++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   70 ++++++++++++++++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |    8 +++
 5 files changed, 126 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index d6aafd4..529569d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -31,6 +31,10 @@
 #define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
 #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
 
+#define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
+#define DISP_REG_CONFIG_OUT_SEL			0x04c
+#define DISP_REG_CONFIG_DSI_SEL			0x050
+
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
@@ -52,6 +56,13 @@
 #define MUTEX_MOD_DISP_PWM1_MT8173		BIT(24)
 #define MUTEX_MOD_DISP_OD_MT8173		BIT(25)
 
+#define MUTEX_MOD_DISP_OVL_MT2701		BIT(3)
+#define MUTEX_MOD_DISP_WDMA_MT2701		BIT(6)
+#define MUTEX_MOD_DISP_COLOR_MT2701		BIT(7)
+#define MUTEX_MOD_DISP_BLS_MT2701		BIT(9)
+#define MUTEX_MOD_DISP_RDMA0_MT2701		BIT(10)
+#define MUTEX_MOD_DISP_RDMA1_MT2701		BIT(12)
+
 #define MUTEX_SOF_SINGLE_MODE		0
 #define MUTEX_SOF_DSI0			1
 #define MUTEX_SOF_DSI1			2
@@ -67,6 +78,10 @@
 #define DPI0_SEL_IN_RDMA1		0x1
 #define COLOR1_SEL_IN_OVL1		0x1
 
+#define OVL_MOUT_EN_RDMA		0x1
+#define BLS_TO_DSI_RDMA1_TO_DPI1	0x8
+#define DSI_SEL_IN_BLS			0x0
+
 struct mtk_disp_mutex {
 	int id;
 	bool claimed;
@@ -77,6 +92,16 @@ struct mtk_ddp {
 	struct clk			*clk;
 	void __iomem			*regs;
 	struct mtk_disp_mutex		mutex[10];
+	const unsigned int		*mutex_mod;
+};
+
+static const unsigned int mutex_mod_mt2701[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_BLS] = MUTEX_MOD_DISP_BLS_MT2701,
+	[DDP_COMPONENT_COLOR0] = MUTEX_MOD_DISP_COLOR_MT2701,
+	[DDP_COMPONENT_OVL0] = MUTEX_MOD_DISP_OVL_MT2701,
+	[DDP_COMPONENT_RDMA0] = MUTEX_MOD_DISP_RDMA0_MT2701,
+	[DDP_COMPONENT_RDMA1] = MUTEX_MOD_DISP_RDMA1_MT2701,
+	[DDP_COMPONENT_WDMA0] = MUTEX_MOD_DISP_WDMA_MT2701,
 };
 
 static const unsigned int mutex_mod_mt8173[DDP_COMPONENT_ID_MAX] = {
@@ -106,6 +131,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
 		*addr = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
 		value = OVL0_MOUT_EN_COLOR0;
+	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
+		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
+		value = OVL_MOUT_EN_RDMA;
 	} else if (cur == DDP_COMPONENT_OD && next == DDP_COMPONENT_RDMA0) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
 		value = OD_MOUT_EN_RDMA0;
@@ -143,6 +171,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
 		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
 		value = COLOR1_SEL_IN_OVL1;
+	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
+		*addr = DISP_REG_CONFIG_DSI_SEL;
+		value = DSI_SEL_IN_BLS;
 	} else {
 		value = 0;
 	}
@@ -150,6 +181,15 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	return value;
 }
 
+static void mtk_ddp_mux_sel(void __iomem *config_regs,
+			    enum mtk_ddp_comp_id cur, enum mtk_ddp_comp_id next)
+{
+	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
+		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
+			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+	}
+}
+
 void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next)
@@ -162,6 +202,8 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
 		writel_relaxed(reg, config_regs + addr);
 	}
 
+	mtk_ddp_mux_sel(config_regs, cur, next);
+
 	value = mtk_ddp_sel_in(cur, next, &addr);
 	if (value) {
 		reg = readl_relaxed(config_regs + addr) | value;
@@ -247,7 +289,7 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 		break;
 	default:
 		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
-		reg |= mutex_mod[id];
+		reg |= ddp->mutex_mod[id];
 		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
 		return;
 	}
@@ -273,7 +315,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 		break;
 	default:
 		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
-		reg &= ~mutex_mod[id];
+		reg &= ~(ddp->mutex_mod[id]);
 		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
 		break;
 	}
@@ -299,8 +341,16 @@ void mtk_disp_mutex_disable(struct mtk_disp_mutex *mutex)
 	writel(0, ddp->regs + DISP_REG_MUTEX_EN(mutex->id));
 }
 
+static const struct of_device_id ddp_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mutex_mod_mt2701},
+	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mutex_mod_mt8173},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
+
 static int mtk_ddp_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct mtk_ddp *ddp;
 	struct resource *regs;
@@ -326,6 +376,9 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 		return PTR_ERR(ddp->regs);
 	}
 
+	of_id = of_match_device(ddp_driver_dt_match, &pdev->dev);
+	ddp->mutex_mod = of_id->data;
+
 	platform_set_drvdata(pdev, ddp);
 
 	return 0;
@@ -336,12 +389,6 @@ static int mtk_ddp_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ddp_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-mutex" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
-
 struct platform_driver mtk_ddp_driver = {
 	.probe		= mtk_ddp_probe,
 	.remove		= mtk_ddp_remove,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 3970fcf..0360fd6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -103,6 +103,7 @@ static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_PWM] = "pwm",
 	[MTK_DISP_MUTEX] = "mutex",
 	[MTK_DISP_OD] = "od",
+	[MTK_DISP_BLS] = "bls",
 };
 
 struct mtk_ddp_comp_match {
@@ -113,6 +114,7 @@ struct mtk_ddp_comp_match {
 
 static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, NULL },
+	[DDP_COMPONENT_BLS]	= { MTK_DISP_BLS,	0, NULL },
 	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
 	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
 	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 6b13ba9..1c344e4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -35,6 +35,7 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_PWM,
 	MTK_DISP_MUTEX,
 	MTK_DISP_OD,
+	MTK_DISP_BLS,
 	MTK_DDP_COMP_TYPE_MAX,
 };
 
@@ -57,6 +58,7 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_UFOE,
 	DDP_COMPONENT_WDMA0,
 	DDP_COMPONENT_WDMA1,
+	DDP_COMPONENT_BLS,
 	DDP_COMPONENT_ID_MAX,
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 2774cbd..8b562ab 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -109,7 +109,20 @@ static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
 	.atomic_commit = mtk_atomic_commit,
 };
 
-static const enum mtk_ddp_comp_id mtk_ddp_main[] = {
+static const enum mtk_ddp_comp_id mtk_ddp_main_2701[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_BLS,
+	DDP_COMPONENT_DSI0,
+};
+
+static const enum mtk_ddp_comp_id mtk_ddp_ext_2701[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_DSI0,
+};
+
+static const enum mtk_ddp_comp_id mtk_ddp_main_8173[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_AAL,
@@ -120,7 +133,7 @@ static const enum mtk_ddp_comp_id mtk_ddp_main[] = {
 	DDP_COMPONENT_PWM0,
 };
 
-static const enum mtk_ddp_comp_id mtk_ddp_ext[] = {
+static const enum mtk_ddp_comp_id mtk_ddp_ext_8173[] = {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_GAMMA,
@@ -128,6 +141,20 @@ static const enum mtk_ddp_comp_id mtk_ddp_ext[] = {
 	DDP_COMPONENT_DPI0,
 };
 
+static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
+	.main_path = mtk_ddp_main_2701,
+	.main_len = ARRAY_SIZE(mtk_ddp_main_2701),
+	.ext_path = mtk_ddp_ext_2701,
+	.ext_len = ARRAY_SIZE(mtk_ddp_ext_2701),
+};
+
+static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
+	.main_path = mtk_ddp_main_8173,
+	.main_len = ARRAY_SIZE(mtk_ddp_main_8173),
+	.ext_path = mtk_ddp_ext_8173,
+	.ext_len = ARRAY_SIZE(mtk_ddp_ext_8173),
+};
+
 static int mtk_drm_kms_init(struct drm_device *drm)
 {
 	struct mtk_drm_private *private = drm->dev_private;
@@ -170,17 +197,19 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	 * and each statically assigned to a crtc:
 	 * OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0 ...
 	 */
-	ret = mtk_drm_crtc_create(drm, mtk_ddp_main, ARRAY_SIZE(mtk_ddp_main));
+	ret = mtk_drm_crtc_create(drm, private->data->main_path,
+				  private->data->main_len);
 	if (ret < 0)
 		goto err_component_unbind;
 	/* ... and OVL1 -> COLOR1 -> GAMMA -> RDMA1 -> DPI0. */
-	ret = mtk_drm_crtc_create(drm, mtk_ddp_ext, ARRAY_SIZE(mtk_ddp_ext));
+	ret = mtk_drm_crtc_create(drm, private->data->ext_path,
+				  private->data->ext_len);
 	if (ret < 0)
 		goto err_component_unbind;
 
 	/* Use OVL device for all DMA memory allocations */
-	np = private->comp_node[mtk_ddp_main[0]] ?:
-	     private->comp_node[mtk_ddp_ext[0]];
+	np = private->comp_node[private->data->main_path[0]] ?:
+	     private->comp_node[private->data->ext_path[0]];
 	pdev = of_find_device_by_node(np);
 	if (!pdev) {
 		ret = -ENODEV;
@@ -316,21 +345,44 @@ static const struct component_master_ops mtk_drm_ops = {
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
 	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
 	{ .compatible = "mediatek,mt8173-disp-od",    .data = (void *)MTK_DISP_OD },
+	{ .compatible = "mediatek,mt2701-disp-bls",   .data = (void *)MTK_DISP_BLS },
 	{ }
 };
 
+static const struct of_device_id mtk_drm_of_ids[] = {
+	{ .compatible = "mediatek,mt2701-mmsys", .data = &mt2701_mmsys_driver_data},
+	{ .compatible = "mediatek,mt8173-mmsys", .data = &mt8173_mmsys_driver_data},
+	{ }
+};
+
+static inline struct mtk_mmsys_driver_data *mtk_drm_get_driver_data(
+	struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+		of_match_device(mtk_drm_of_ids, &pdev->dev);
+
+	return (struct mtk_mmsys_driver_data *)of_id->data;
+}
+
 static int mtk_drm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -347,6 +399,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 	mutex_init(&private->commit.lock);
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
+	private->data = mtk_drm_get_driver_data(pdev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	private->config_regs = devm_ioremap_resource(dev, mem);
@@ -497,11 +550,6 @@ static int mtk_drm_sys_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
-static const struct of_device_id mtk_drm_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-mmsys", },
-	{ }
-};
-
 static struct platform_driver mtk_drm_platform_driver = {
 	.probe	= mtk_drm_probe,
 	.remove	= mtk_drm_remove,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index aa93894..fa0b106 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -28,6 +28,13 @@ struct drm_fb_helper;
 struct drm_property;
 struct regmap;
 
+struct mtk_mmsys_driver_data {
+	const enum mtk_ddp_comp_id *main_path;
+	unsigned int main_len;
+	const enum mtk_ddp_comp_id *ext_path;
+	unsigned int ext_len;
+};
+
 struct mtk_drm_private {
 	struct drm_device *drm;
 	struct device *dma_dev;
@@ -40,6 +47,7 @@ struct mtk_drm_private {
 	void __iomem *config_regs;
 	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
 	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
+	const struct mtk_mmsys_driver_data *data;
 
 	struct {
 		struct drm_atomic_state *state;
-- 
1.7.9.5
