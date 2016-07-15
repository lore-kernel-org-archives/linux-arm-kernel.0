From: yt.shen@mediatek.com (YT Shen)
Date: Fri, 15 Jul 2016 18:07:48 +0800
Subject: [PATCH v4 2/8] drm/mediatek: add *driver_data for different hardware
 settings
In-Reply-To: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
References: <1468577274-6178-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1468577274-6178-3-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some hardware settings changed, between MT8173 & MT2701:
DISP_OVL address offset changed, color format definition changed.
DISP_RDMA fifo size changed.
DISP_COLOR offset changed.
And add prefix for mtk_ddp_main & mtk_ddp_ext & mutex_mod.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |   26 ++++++++++++++++----------
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   11 +++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |   11 +++++++----
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   27 +++++++++++++++++++++------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   13 +++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   25 ++++++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |    8 ++++++++
 7 files changed, 92 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 8f62671f..eb5c05e 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -40,8 +40,6 @@
 #define	OVL_RDMA_MEM_GMC	0x40402020
 
 #define OVL_CON_BYTE_SWAP	BIT(24)
-#define OVL_CON_CLRFMT_RGB565	(0 << 12)
-#define OVL_CON_CLRFMT_RGB888	(1 << 12)
 #define OVL_CON_CLRFMT_RGBA8888	(2 << 12)
 #define OVL_CON_CLRFMT_ARGB8888	(3 << 12)
 #define	OVL_CON_AEN		BIT(8)
@@ -136,18 +134,18 @@ static void mtk_ovl_layer_off(struct mtk_ddp_comp *comp, unsigned int idx)
 	writel(0x0, comp->regs + DISP_REG_OVL_RDMA_CTRL(idx));
 }
 
-static unsigned int ovl_fmt_convert(unsigned int fmt)
+static unsigned int ovl_fmt_convert(struct mtk_ddp_comp *comp, unsigned int fmt)
 {
 	switch (fmt) {
 	default:
 	case DRM_FORMAT_RGB565:
-		return OVL_CON_CLRFMT_RGB565;
+		return comp->data->ovl.fmt_rgb565;
 	case DRM_FORMAT_BGR565:
-		return OVL_CON_CLRFMT_RGB565 | OVL_CON_BYTE_SWAP;
+		return comp->data->ovl.fmt_rgb565 | OVL_CON_BYTE_SWAP;
 	case DRM_FORMAT_RGB888:
-		return OVL_CON_CLRFMT_RGB888;
+		return comp->data->ovl.fmt_rgb888;
 	case DRM_FORMAT_BGR888:
-		return OVL_CON_CLRFMT_RGB888 | OVL_CON_BYTE_SWAP;
+		return comp->data->ovl.fmt_rgb888 | OVL_CON_BYTE_SWAP;
 	case DRM_FORMAT_RGBX8888:
 	case DRM_FORMAT_RGBA8888:
 		return OVL_CON_CLRFMT_ARGB8888;
@@ -177,7 +175,7 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 	if (!pending->enable)
 		mtk_ovl_layer_off(comp, idx);
 
-	con = ovl_fmt_convert(fmt);
+	con = ovl_fmt_convert(comp, fmt);
 	if (idx != 0)
 		con |= OVL_CON_AEN | OVL_CON_ALPHA;
 
@@ -185,7 +183,8 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 	writel_relaxed(pitch, comp->regs + DISP_REG_OVL_PITCH(idx));
 	writel_relaxed(src_size, comp->regs + DISP_REG_OVL_SRC_SIZE(idx));
 	writel_relaxed(offset, comp->regs + DISP_REG_OVL_OFFSET(idx));
-	writel_relaxed(addr, comp->regs + DISP_REG_OVL_ADDR(idx));
+	writel_relaxed(addr, comp->regs + comp->data->ovl.addr_offset
+					+ idx * 0x20);
 
 	if (pending->enable)
 		mtk_ovl_layer_on(comp, idx);
@@ -269,6 +268,8 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	priv->ddp_comp.data = of_device_get_match_data(dev);
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = component_add(dev, &mtk_disp_ovl_component_ops);
@@ -285,8 +286,13 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_ddp_comp_driver_data mt8173_ovl_driver_data = {
+	.ovl = {0x0f40, 0, 1 << 12}
+};
+
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-ovl", },
+	{ .compatible = "mediatek,mt8173-disp-ovl",
+	  .data = &mt8173_ovl_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 5fb80cb..fb0db50 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -122,7 +122,7 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	 */
 	threshold = width * height * vrefresh * 4 * 7 / 1000000;
 	reg = RDMA_FIFO_UNDERFLOW_EN |
-	      RDMA_FIFO_PSEUDO_SIZE(SZ_8K) |
+	      RDMA_FIFO_PSEUDO_SIZE(comp->data->rdma_fifo_pseudo_size) |
 	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
 	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
 }
@@ -207,6 +207,8 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	priv->ddp_comp.data = of_device_get_match_data(dev);
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = component_add(dev, &mtk_disp_rdma_component_ops);
@@ -223,8 +225,13 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_ddp_comp_driver_data mt8173_rdma_driver_data = {
+	.rdma_fifo_pseudo_size = SZ_8K,
+};
+
 static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-rdma", },
+	{ .compatible = "mediatek,mt8173-disp-rdma",
+	  .data = &mt8173_rdma_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 2fc4321..8030769 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -77,9 +77,10 @@ struct mtk_ddp {
 	struct clk			*clk;
 	void __iomem			*regs;
 	struct mtk_disp_mutex		mutex[10];
+	const unsigned int		*mutex_mod;
 };
 
-static const unsigned int mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL] = MT8173_MUTEX_MOD_DISP_AAL,
 	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
 	[DDP_COMPONENT_COLOR1] = MT8173_MUTEX_MOD_DISP_COLOR1,
@@ -247,7 +248,7 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 		break;
 	default:
 		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
-		reg |= mutex_mod[id];
+		reg |= ddp->mutex_mod[id];
 		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
 		return;
 	}
@@ -273,7 +274,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 		break;
 	default:
 		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
-		reg &= ~mutex_mod[id];
+		reg &= ~(ddp->mutex_mod[id]);
 		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
 		break;
 	}
@@ -326,6 +327,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 		return PTR_ERR(ddp->regs);
 	}
 
+	ddp->mutex_mod = of_device_get_match_data(dev);
+
 	platform_set_drvdata(pdev, ddp);
 
 	return 0;
@@ -337,7 +340,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ddp_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-mutex" },
+	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 3970fcf..4b4e449 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -34,9 +34,8 @@
 #define DISP_REG_UFO_START			0x0000
 
 #define DISP_COLOR_CFG_MAIN			0x0400
-#define DISP_COLOR_START			0x0c00
-#define DISP_COLOR_WIDTH			0x0c50
-#define DISP_COLOR_HEIGHT			0x0c54
+#define DISP_COLOR_WIDTH			0x50
+#define DISP_COLOR_HEIGHT			0x54
 
 #define	OD_RELAY_MODE		BIT(0)
 
@@ -48,15 +47,15 @@
 static void mtk_color_config(struct mtk_ddp_comp *comp, unsigned int w,
 			     unsigned int h, unsigned int vrefresh)
 {
-	writel(w, comp->regs + DISP_COLOR_WIDTH);
-	writel(h, comp->regs + DISP_COLOR_HEIGHT);
+	writel(w, comp->regs + comp->data->color_offset + DISP_COLOR_WIDTH);
+	writel(h, comp->regs + comp->data->color_offset + DISP_COLOR_HEIGHT);
 }
 
 static void mtk_color_start(struct mtk_ddp_comp *comp)
 {
 	writel(COLOR_BYPASS_ALL | COLOR_SEQ_SEL,
 	       comp->regs + DISP_COLOR_CFG_MAIN);
-	writel(0x1, comp->regs + DISP_COLOR_START);
+	writel(0x1, comp->regs + comp->data->color_offset);
 }
 
 static void mtk_od_config(struct mtk_ddp_comp *comp, unsigned int w,
@@ -131,6 +130,16 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
 };
 
+static const struct mtk_ddp_comp_driver_data mt8173_color_driver_data = {
+	.color_offset = 0x0c00,
+};
+
+static const struct of_device_id mtk_disp_color_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt8173-disp-color",
+	  .data = &mt8173_color_driver_data},
+	{},
+};
+
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type)
 {
@@ -153,6 +162,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	enum mtk_ddp_comp_type type;
 	struct device_node *larb_node;
 	struct platform_device *larb_pdev;
+	const struct of_device_id *match;
 
 	if (comp_id < 0 || comp_id >= DDP_COMPONENT_ID_MAX)
 		return -EINVAL;
@@ -177,6 +187,11 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 
 	type = mtk_ddp_matches[comp_id].type;
 
+	if (type == MTK_DISP_COLOR) {
+		match = of_match_node(mtk_disp_color_driver_dt_match, node);
+		comp->data = match->data;
+	}
+
 	/* Only DMA capable components need the LARB property */
 	comp->larb_dev = NULL;
 	if (type != MTK_DISP_OVL &&
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 6b13ba9..53065c7 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -75,6 +75,18 @@ struct mtk_ddp_comp_funcs {
 			     struct mtk_plane_state *state);
 };
 
+struct mtk_ddp_comp_driver_data {
+	union {
+		struct ovl {
+			unsigned int addr_offset;
+			unsigned int fmt_rgb565;
+			unsigned int fmt_rgb888;
+		} ovl;
+		unsigned int rdma_fifo_pseudo_size;
+		unsigned int color_offset;
+	};
+};
+
 struct mtk_ddp_comp {
 	struct clk *clk;
 	void __iomem *regs;
@@ -82,6 +94,7 @@ struct mtk_ddp_comp {
 	struct device *larb_dev;
 	enum mtk_ddp_comp_id id;
 	const struct mtk_ddp_comp_funcs *funcs;
+	const struct mtk_ddp_comp_driver_data *data;
 };
 
 static inline void mtk_ddp_comp_config(struct mtk_ddp_comp *comp,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index b1223d5..80b4f54 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -109,7 +109,7 @@ static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
 	.atomic_commit = mtk_atomic_commit,
 };
 
-static const enum mtk_ddp_comp_id mtk_ddp_main[] = {
+static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_AAL,
@@ -120,7 +120,7 @@ static const enum mtk_ddp_comp_id mtk_ddp_main[] = {
 	DDP_COMPONENT_PWM0,
 };
 
-static const enum mtk_ddp_comp_id mtk_ddp_ext[] = {
+static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_GAMMA,
@@ -128,6 +128,13 @@ static const enum mtk_ddp_comp_id mtk_ddp_ext[] = {
 	DDP_COMPONENT_DPI0,
 };
 
+static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
+	.main_path = mt8173_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
+	.ext_path = mt8173_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
+};
+
 static int mtk_drm_kms_init(struct drm_device *drm)
 {
 	struct mtk_drm_private *private = drm->dev_private;
@@ -170,17 +177,19 @@ static int mtk_drm_kms_init(struct drm_device *drm)
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
@@ -353,6 +362,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 	mutex_init(&private->commit.lock);
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
+	private->data = of_device_get_match_data(dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	private->config_regs = devm_ioremap_resource(dev, mem);
@@ -504,7 +514,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
 static const struct of_device_id mtk_drm_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-mmsys", },
+	{ .compatible = "mediatek,mt8173-mmsys",
+	  .data = &mt8173_mmsys_driver_data},
 	{ }
 };
 
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
