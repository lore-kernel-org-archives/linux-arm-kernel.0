From: yt.shen@mediatek.com (yt.shen at mediatek.com)
Date: Fri, 20 May 2016 23:05:34 +0800
Subject: [RFC v2 3/5] drm/mediatek: add *driver_data for different hardware
 settings
In-Reply-To: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1463756736-46573-4-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YT Shen <yt.shen@mediatek.com>

There are some hardware settings changed, between MT8173 & MT2701:
DISP_OVL address offset changed, color format definition changed.
DISP_RDMA fifo size changed.
DISP_COLOR offset changed.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |   49 +++++++++++++++++++--------
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   36 ++++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   40 ++++++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   13 +++++++
 4 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 8f62671f..8d2811d 100644
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
 
@@ -185,7 +183,7 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 	writel_relaxed(pitch, comp->regs + DISP_REG_OVL_PITCH(idx));
 	writel_relaxed(src_size, comp->regs + DISP_REG_OVL_SRC_SIZE(idx));
 	writel_relaxed(offset, comp->regs + DISP_REG_OVL_OFFSET(idx));
-	writel_relaxed(addr, comp->regs + DISP_REG_OVL_ADDR(idx));
+	writel_relaxed(addr, comp->regs + (comp->data->ovl.addr_offset + idx * 0x20));
 
 	if (pending->enable)
 		mtk_ovl_layer_on(comp, idx);
@@ -233,6 +231,32 @@ static const struct component_ops mtk_disp_ovl_component_ops = {
 	.unbind = mtk_disp_ovl_unbind,
 };
 
+static const struct mtk_ddp_comp_driver_data mt2701_ovl_driver_data = {
+	.ovl = {0x0040, 1 << 12, 0}
+};
+
+static const struct mtk_ddp_comp_driver_data mt8173_ovl_driver_data = {
+	.ovl = {0x0f40, 0, 1 << 12}
+};
+
+static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-ovl",
+	  .data = &mt2701_ovl_driver_data},
+	{ .compatible = "mediatek,mt8173-disp-ovl",
+	  .data = &mt8173_ovl_driver_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
+
+static inline struct mtk_ddp_comp_driver_data *mtk_ovl_get_driver_data(
+	struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+		of_match_device(mtk_disp_ovl_driver_dt_match, &pdev->dev);
+
+	return (struct mtk_ddp_comp_driver_data *)of_id->data;
+}
+
 static int mtk_disp_ovl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -269,6 +293,8 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	priv->ddp_comp.data = mtk_ovl_get_driver_data(pdev);
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = component_add(dev, &mtk_disp_ovl_component_ops);
@@ -285,11 +311,6 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-ovl", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
 
 struct platform_driver mtk_disp_ovl_driver = {
 	.probe		= mtk_disp_ovl_probe,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 5fb80cb..a20a6cd 100644
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
@@ -167,6 +167,32 @@ static const struct component_ops mtk_disp_rdma_component_ops = {
 	.unbind = mtk_disp_rdma_unbind,
 };
 
+static const struct mtk_ddp_comp_driver_data mt2701_rdma_driver_data = {
+	.rdma_fifo_pseudo_size = SZ_4K,
+};
+
+static const struct mtk_ddp_comp_driver_data mt8173_rdma_driver_data = {
+	.rdma_fifo_pseudo_size = SZ_8K,
+};
+
+static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-rdma",
+	  .data = &mt2701_rdma_driver_data},
+	{ .compatible = "mediatek,mt8173-disp-rdma",
+	  .data = &mt8173_rdma_driver_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
+
+static inline struct mtk_ddp_comp_driver_data *mtk_rdma_get_driver_data(
+	struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+		of_match_device(mtk_disp_rdma_driver_dt_match, &pdev->dev);
+
+	return (struct mtk_ddp_comp_driver_data *)of_id->data;
+}
+
 static int mtk_disp_rdma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -196,6 +222,8 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	priv->ddp_comp.data = mtk_rdma_get_driver_data(pdev);
+
 	/* Disable and clear pending interrupts */
 	writel(0x0, priv->ddp_comp.regs + DISP_REG_RDMA_INT_ENABLE);
 	writel(0x0, priv->ddp_comp.regs + DISP_REG_RDMA_INT_STATUS);
@@ -223,12 +251,6 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-rdma", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
-
 struct platform_driver mtk_disp_rdma_driver = {
 	.probe		= mtk_disp_rdma_probe,
 	.remove		= mtk_disp_rdma_remove,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 0360fd6..53f936f 100644
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
@@ -133,6 +132,32 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
 };
 
+static const struct mtk_ddp_comp_driver_data mt2701_color_driver_data = {
+	.color_offset = 0x0f00,
+};
+
+static const struct mtk_ddp_comp_driver_data mt8173_color_driver_data = {
+	.color_offset = 0x0c00,
+};
+
+static const struct of_device_id mtk_disp_color_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt2701-disp-color",
+	  .data = &mt2701_color_driver_data},
+	{ .compatible = "mediatek,mt8173-disp-color",
+	  .data = &mt8173_color_driver_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_disp_color_driver_dt_match);
+
+static inline struct mtk_ddp_comp_driver_data *mtk_color_get_driver_data(
+	struct device_node *node)
+{
+	const struct of_device_id *of_id =
+		of_match_node(mtk_disp_color_driver_dt_match, node);
+
+	return (struct mtk_ddp_comp_driver_data *)of_id->data;
+}
+
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type)
 {
@@ -179,6 +204,9 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 
 	type = mtk_ddp_matches[comp_id].type;
 
+	if (type == MTK_DISP_COLOR)
+		comp->data = mtk_color_get_driver_data(node);
+
 	/* Only DMA capable components need the LARB property */
 	comp->larb_dev = NULL;
 	if (type != MTK_DISP_OVL &&
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 1c344e4..6e2d918 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -77,6 +77,18 @@ struct mtk_ddp_comp_funcs {
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
@@ -84,6 +96,7 @@ struct mtk_ddp_comp {
 	struct device *larb_dev;
 	enum mtk_ddp_comp_id id;
 	const struct mtk_ddp_comp_funcs *funcs;
+	const struct mtk_ddp_comp_driver_data *data;
 };
 
 static inline void mtk_ddp_comp_config(struct mtk_ddp_comp *comp,
-- 
1.7.9.5
