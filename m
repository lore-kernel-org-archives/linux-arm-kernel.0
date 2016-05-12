From: yt.shen@mediatek.com (yt.shen at mediatek.com)
Date: Thu, 12 May 2016 19:49:54 +0800
Subject: [RFC 2/3] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1463053795-55455-1-git-send-email-yt.shen@mediatek.com>
References: <1463053795-55455-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1463053795-55455-3-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YT Shen <yt.shen@mediatek.com>

This patch add support for the Mediatek MT2701 DISP subsystem.
There is only one OVL engine in MT2701, and we have shadow
register support here.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |   49 ++++++---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   36 +++++--
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   78 +++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |  151 ++++++++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h      |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   63 +++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   15 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   72 +++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |    9 ++
 drivers/gpu/drm/mediatek/mtk_drm_gem.c      |    4 +
 10 files changed, 373 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 8f62671f..e4a10bd6 100644
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
 
+static struct mtk_ddp_comp_driver_data mt2701_ovl_driver_data = {
+	.ovl = {0x0040, 1 << 12, 0}
+};
+
+static struct mtk_ddp_comp_driver_data mt8173_ovl_driver_data = {
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
index 5fb80cb..41a6f36 100644
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
 
+static struct mtk_ddp_comp_driver_data mt2701_rdma_driver_data = {
+	.rdma_fifo_pseudo_size = SZ_4K,
+};
+
+static struct mtk_ddp_comp_driver_data mt8173_rdma_driver_data = {
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
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 3095fc1..6ecd35b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -315,6 +315,42 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 	pm_runtime_put(drm->dev);
 }
 
+static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
+{
+	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
+	struct mtk_ddp_comp *ovl = mtk_crtc->ddp_comp[0];
+	unsigned int i;
+
+	/*
+	 * TODO: instead of updating the registers here, we should prepare
+	 * working registers in atomic_commit and let the hardware command
+	 * queue update module registers on vblank.
+	 */
+	if (state->pending_config) {
+		mtk_ddp_comp_config(ovl, state->pending_width,
+				    state->pending_height,
+				    state->pending_vrefresh);
+
+		state->pending_config = false;
+	}
+
+	if (mtk_crtc->pending_planes) {
+		for (i = 0; i < OVL_LAYER_NR; i++) {
+			struct drm_plane *plane = &mtk_crtc->planes[i].base;
+			struct mtk_plane_state *plane_state;
+
+			plane_state = to_mtk_plane_state(plane->state);
+
+			if (plane_state->pending.config) {
+				mtk_ddp_comp_layer_config(ovl, i, plane_state);
+				plane_state->pending.config = false;
+			}
+		}
+		mtk_crtc->pending_planes = false;
+	}
+}
+
 static void mtk_drm_crtc_enable(struct drm_crtc *crtc)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
@@ -375,6 +411,7 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 {
 	struct mtk_crtc_state *state = to_mtk_crtc_state(crtc->state);
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_drm_private *priv = crtc->dev->dev_private;
 
 	if (mtk_crtc->event && state->base.event)
 		DRM_ERROR("new event while there is still a pending event\n");
@@ -385,12 +422,16 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 		mtk_crtc->event = state->base.event;
 		state->base.event = NULL;
 	}
+
+	if (priv->data->shadow_register)
+		mtk_disp_mutex_acquire(mtk_crtc->mutex);
 }
 
 static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 				      struct drm_crtc_state *old_crtc_state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_drm_private *priv = crtc->dev->dev_private;
 	unsigned int pending_planes = 0;
 	int i;
 
@@ -409,6 +450,11 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 	if (pending_planes)
 		mtk_crtc->pending_planes = true;
+
+	if (priv->data->shadow_register) {
+		mtk_crtc_ddp_config(crtc);
+		mtk_disp_mutex_release(mtk_crtc->mutex);
+	}
 }
 
 static const struct drm_crtc_funcs mtk_crtc_funcs = {
@@ -453,36 +499,10 @@ err_cleanup_crtc:
 void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *ovl)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
-	unsigned int i;
+	struct mtk_drm_private *priv = crtc->dev->dev_private;
 
-	/*
-	 * TODO: instead of updating the registers here, we should prepare
-	 * working registers in atomic_commit and let the hardware command
-	 * queue update module registers on vblank.
-	 */
-	if (state->pending_config) {
-		mtk_ddp_comp_config(ovl, state->pending_width,
-				    state->pending_height,
-				    state->pending_vrefresh);
-
-		state->pending_config = false;
-	}
-
-	if (mtk_crtc->pending_planes) {
-		for (i = 0; i < OVL_LAYER_NR; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i].base;
-			struct mtk_plane_state *plane_state;
-
-			plane_state = to_mtk_plane_state(plane->state);
-
-			if (plane_state->pending.config) {
-				mtk_ddp_comp_layer_config(ovl, i, plane_state);
-				plane_state->pending.config = false;
-			}
-		}
-		mtk_crtc->pending_planes = false;
-	}
+	if (!priv->data->shadow_register)
+		mtk_crtc_ddp_config(crtc);
 
 	mtk_drm_finish_page_flip(mtk_crtc);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 17ba935..699e039 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -31,26 +32,38 @@
 #define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
 #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
 
+#define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
+#define DISP_REG_CONFIG_OUT_SEL			0x04c
+#define DISP_REG_CONFIG_DSI_SEL			0x050
+
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
+#define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
 #define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
 
-#define MUTEX_MOD_DISP_OVL0		BIT(11)
-#define MUTEX_MOD_DISP_OVL1		BIT(12)
-#define MUTEX_MOD_DISP_RDMA0		BIT(13)
-#define MUTEX_MOD_DISP_RDMA1		BIT(14)
-#define MUTEX_MOD_DISP_RDMA2		BIT(15)
-#define MUTEX_MOD_DISP_WDMA0		BIT(16)
-#define MUTEX_MOD_DISP_WDMA1		BIT(17)
-#define MUTEX_MOD_DISP_COLOR0		BIT(18)
-#define MUTEX_MOD_DISP_COLOR1		BIT(19)
-#define MUTEX_MOD_DISP_AAL		BIT(20)
-#define MUTEX_MOD_DISP_GAMMA		BIT(21)
-#define MUTEX_MOD_DISP_UFOE		BIT(22)
-#define MUTEX_MOD_DISP_PWM0		BIT(23)
-#define MUTEX_MOD_DISP_PWM1		BIT(24)
-#define MUTEX_MOD_DISP_OD		BIT(25)
+#define MUTEX_MOD_MT8173_DISP_OVL0		BIT(11)
+#define MUTEX_MOD_MT8173_DISP_OVL1		BIT(12)
+#define MUTEX_MOD_MT8173_DISP_RDMA0		BIT(13)
+#define MUTEX_MOD_MT8173_DISP_RDMA1		BIT(14)
+#define MUTEX_MOD_MT8173_DISP_RDMA2		BIT(15)
+#define MUTEX_MOD_MT8173_DISP_WDMA0		BIT(16)
+#define MUTEX_MOD_MT8173_DISP_WDMA1		BIT(17)
+#define MUTEX_MOD_MT8173_DISP_COLOR0		BIT(18)
+#define MUTEX_MOD_MT8173_DISP_COLOR1		BIT(19)
+#define MUTEX_MOD_MT8173_DISP_AAL		BIT(20)
+#define MUTEX_MOD_MT8173_DISP_GAMMA		BIT(21)
+#define MUTEX_MOD_MT8173_DISP_UFOE		BIT(22)
+#define MUTEX_MOD_MT8173_DISP_PWM0		BIT(23)
+#define MUTEX_MOD_MT8173_DISP_PWM1		BIT(24)
+#define MUTEX_MOD_MT8173_DISP_OD		BIT(25)
+
+#define MUTEX_MOD_MT2701_DISP_OVL		BIT(3)
+#define MUTEX_MOD_MT2701_DISP_WDMA		BIT(6)
+#define MUTEX_MOD_MT2701_DISP_COLOR		BIT(7)
+#define MUTEX_MOD_MT2701_DISP_BLS		BIT(9)
+#define MUTEX_MOD_MT2701_DISP_RDMA0		BIT(10)
+#define MUTEX_MOD_MT2701_DISP_RDMA1		BIT(12)
 
 #define MUTEX_SOF_SINGLE_MODE		0
 #define MUTEX_SOF_DSI0			1
@@ -67,6 +80,10 @@
 #define DPI0_SEL_IN_RDMA1		0x1
 #define COLOR1_SEL_IN_OVL1		0x1
 
+#define OVL_MOUT_EN_RDMA		0x1
+#define BLS_TO_DSI_RDMA1_TO_DPI1	0x8
+#define DSI_SEL_IN_BLS			0x0
+
 struct mtk_disp_mutex {
 	int id;
 	bool claimed;
@@ -77,24 +94,34 @@ struct mtk_ddp {
 	struct clk			*clk;
 	void __iomem			*regs;
 	struct mtk_disp_mutex		mutex[10];
+	const unsigned int		*mutex_mod;
 };
 
-static const unsigned int mutex_mod[DDP_COMPONENT_ID_MAX] = {
-	[DDP_COMPONENT_AAL] = MUTEX_MOD_DISP_AAL,
-	[DDP_COMPONENT_COLOR0] = MUTEX_MOD_DISP_COLOR0,
-	[DDP_COMPONENT_COLOR1] = MUTEX_MOD_DISP_COLOR1,
-	[DDP_COMPONENT_GAMMA] = MUTEX_MOD_DISP_GAMMA,
-	[DDP_COMPONENT_OD] = MUTEX_MOD_DISP_OD,
-	[DDP_COMPONENT_OVL0] = MUTEX_MOD_DISP_OVL0,
-	[DDP_COMPONENT_OVL1] = MUTEX_MOD_DISP_OVL1,
-	[DDP_COMPONENT_PWM0] = MUTEX_MOD_DISP_PWM0,
-	[DDP_COMPONENT_PWM1] = MUTEX_MOD_DISP_PWM1,
-	[DDP_COMPONENT_RDMA0] = MUTEX_MOD_DISP_RDMA0,
-	[DDP_COMPONENT_RDMA1] = MUTEX_MOD_DISP_RDMA1,
-	[DDP_COMPONENT_RDMA2] = MUTEX_MOD_DISP_RDMA2,
-	[DDP_COMPONENT_UFOE] = MUTEX_MOD_DISP_UFOE,
-	[DDP_COMPONENT_WDMA0] = MUTEX_MOD_DISP_WDMA0,
-	[DDP_COMPONENT_WDMA1] = MUTEX_MOD_DISP_WDMA1,
+static const unsigned int mutex_mod_mt2701[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_BLS] = MUTEX_MOD_MT2701_DISP_BLS,
+	[DDP_COMPONENT_COLOR0] = MUTEX_MOD_MT2701_DISP_COLOR,
+	[DDP_COMPONENT_OVL0] = MUTEX_MOD_MT2701_DISP_OVL,
+	[DDP_COMPONENT_RDMA0] = MUTEX_MOD_MT2701_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MUTEX_MOD_MT2701_DISP_RDMA1,
+	[DDP_COMPONENT_WDMA0] = MUTEX_MOD_MT2701_DISP_WDMA,
+};
+
+static const unsigned int mutex_mod_mt8173[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL] = MUTEX_MOD_MT8173_DISP_AAL,
+	[DDP_COMPONENT_COLOR0] = MUTEX_MOD_MT8173_DISP_COLOR0,
+	[DDP_COMPONENT_COLOR1] = MUTEX_MOD_MT8173_DISP_COLOR1,
+	[DDP_COMPONENT_GAMMA] = MUTEX_MOD_MT8173_DISP_GAMMA,
+	[DDP_COMPONENT_OD] = MUTEX_MOD_MT8173_DISP_OD,
+	[DDP_COMPONENT_OVL0] = MUTEX_MOD_MT8173_DISP_OVL0,
+	[DDP_COMPONENT_OVL1] = MUTEX_MOD_MT8173_DISP_OVL1,
+	[DDP_COMPONENT_PWM0] = MUTEX_MOD_MT8173_DISP_PWM0,
+	[DDP_COMPONENT_PWM1] = MUTEX_MOD_MT8173_DISP_PWM1,
+	[DDP_COMPONENT_RDMA0] = MUTEX_MOD_MT8173_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MUTEX_MOD_MT8173_DISP_RDMA1,
+	[DDP_COMPONENT_RDMA2] = MUTEX_MOD_MT8173_DISP_RDMA2,
+	[DDP_COMPONENT_UFOE] = MUTEX_MOD_MT8173_DISP_UFOE,
+	[DDP_COMPONENT_WDMA0] = MUTEX_MOD_MT8173_DISP_WDMA0,
+	[DDP_COMPONENT_WDMA1] = MUTEX_MOD_MT8173_DISP_WDMA1,
 };
 
 static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
@@ -106,6 +133,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
 		*addr = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
 		value = OVL0_MOUT_EN_COLOR0;
+	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
+		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
+		value = OVL_MOUT_EN_RDMA;
 	} else if (cur == DDP_COMPONENT_OD && next == DDP_COMPONENT_RDMA0) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
 		value = OD_MOUT_EN_RDMA0;
@@ -143,6 +173,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
 		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
 		value = COLOR1_SEL_IN_OVL1;
+	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
+		*addr = DISP_REG_CONFIG_DSI_SEL;
+		value = DSI_SEL_IN_BLS;
 	} else {
 		value = 0;
 	}
@@ -150,6 +183,15 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
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
@@ -162,6 +204,8 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
 		writel_relaxed(reg, config_regs + addr);
 	}
 
+	mtk_ddp_mux_sel(config_regs, cur, next);
+
 	value = mtk_ddp_sel_in(cur, next, &addr);
 	if (value) {
 		reg = readl_relaxed(config_regs + addr) | value;
@@ -247,7 +291,7 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 		break;
 	default:
 		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
-		reg |= mutex_mod[id];
+		reg |= ddp->mutex_mod[id];
 		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
 		return;
 	}
@@ -273,7 +317,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 		break;
 	default:
 		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
-		reg &= ~mutex_mod[id];
+		reg &= ~(ddp->mutex_mod[id]);
 		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
 		break;
 	}
@@ -299,8 +343,40 @@ void mtk_disp_mutex_disable(struct mtk_disp_mutex *mutex)
 	writel(0, ddp->regs + DISP_REG_MUTEX_EN(mutex->id));
 }
 
+void mtk_disp_mutex_acquire(struct mtk_disp_mutex *mutex)
+{
+	struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
+					   mutex[mutex->id]);
+
+	unsigned int cnt = 0;
+
+	writel(1, ddp->regs + DISP_REG_MUTEX_EN(mutex->id));
+	writel(1, ddp->regs + DISP_REG_MUTEX(mutex->id));
+	while (!(readl(ddp->regs + DISP_REG_MUTEX(mutex->id)) & 0x2)) {
+		if (cnt++ > 10000)
+			break;
+		udelay(1);
+	}
+}
+
+void mtk_disp_mutex_release(struct mtk_disp_mutex *mutex)
+{
+	struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
+					   mutex[mutex->id]);
+
+	writel(0, ddp->regs + DISP_REG_MUTEX(mutex->id));
+}
+
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
@@ -326,6 +402,9 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 		return PTR_ERR(ddp->regs);
 	}
 
+	of_id = of_match_device(ddp_driver_dt_match, &pdev->dev);
+	ddp->mutex_mod = of_id->data;
+
 	platform_set_drvdata(pdev, ddp);
 
 	return 0;
@@ -336,12 +415,6 @@ static int mtk_ddp_remove(struct platform_device *pdev)
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
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
index 92c1175..f9a7991 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
@@ -37,5 +37,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 				enum mtk_ddp_comp_id id);
 void mtk_disp_mutex_unprepare(struct mtk_disp_mutex *mutex);
 void mtk_disp_mutex_put(struct mtk_disp_mutex *mutex);
+void mtk_disp_mutex_acquire(struct mtk_disp_mutex *mutex);
+void mtk_disp_mutex_release(struct mtk_disp_mutex *mutex);
 
 #endif /* MTK_DRM_DDP_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 3970fcf..a1a1297 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -25,6 +25,11 @@
 #include "mtk_drm_plane.h"
 #include "mtk_drm_ddp_comp.h"
 
+#define DISP_REG_BLS_EN				0x0000
+#define DISP_REG_BLS_SRC_SIZE			0x0018
+#define DISP_REG_BLS_PWM_DUTY			0x00a0
+#define DISP_REG_BLS_PWM_CON			0x00a8
+
 #define DISP_OD_EN				0x0000
 #define DISP_OD_INTEN				0x0008
 #define DISP_OD_INTSTA				0x000c
@@ -34,9 +39,8 @@
 #define DISP_REG_UFO_START			0x0000
 
 #define DISP_COLOR_CFG_MAIN			0x0400
-#define DISP_COLOR_START			0x0c00
-#define DISP_COLOR_WIDTH			0x0c50
-#define DISP_COLOR_HEIGHT			0x0c54
+#define DISP_COLOR_WIDTH			0x50
+#define DISP_COLOR_HEIGHT			0x54
 
 #define	OD_RELAY_MODE		BIT(0)
 
@@ -45,18 +49,30 @@
 #define	COLOR_BYPASS_ALL	BIT(7)
 #define	COLOR_SEQ_SEL		BIT(13)
 
+#define BLS_PWM_CLKDIV		BIT(16)
+#define BLS_PWM_EN		BIT(16)
+
+static void mtk_bls_config(struct mtk_ddp_comp *comp, unsigned int w,
+		unsigned int h, unsigned int vrefresh)
+{
+	writel(h << 16 | w, comp->regs + DISP_REG_BLS_SRC_SIZE);
+	writel(0, comp->regs + DISP_REG_BLS_PWM_DUTY);
+	writel(BLS_PWM_CLKDIV, comp->regs + DISP_REG_BLS_PWM_CON);
+	writel(BLS_PWM_EN, comp->regs + DISP_REG_BLS_EN);
+}
+
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
@@ -76,6 +92,10 @@ static void mtk_ufoe_start(struct mtk_ddp_comp *comp)
 	writel(UFO_BYPASS, comp->regs + DISP_REG_UFO_START);
 }
 
+static const struct mtk_ddp_comp_funcs ddp_bls = {
+	.config = mtk_bls_config,
+};
+
 static const struct mtk_ddp_comp_funcs ddp_color = {
 	.config = mtk_color_config,
 	.start = mtk_color_start,
@@ -103,6 +123,7 @@ static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_PWM] = "pwm",
 	[MTK_DISP_MUTEX] = "mutex",
 	[MTK_DISP_OD] = "od",
+	[MTK_DISP_BLS] = "bls",
 };
 
 struct mtk_ddp_comp_match {
@@ -113,6 +134,7 @@ struct mtk_ddp_comp_match {
 
 static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, NULL },
+	[DDP_COMPONENT_BLS]	= { MTK_DISP_BLS,	0, &ddp_bls },
 	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
 	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
 	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
@@ -131,6 +153,32 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
 };
 
+static struct mtk_ddp_comp_driver_data mt2701_color_driver_data = {
+	.color_offset = 0x0f00,
+};
+
+static struct mtk_ddp_comp_driver_data mt8173_color_driver_data = {
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
@@ -177,6 +225,9 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 
 	type = mtk_ddp_matches[comp_id].type;
 
+	if (type == MTK_DISP_COLOR)
+		comp->data = mtk_color_get_driver_data(node);
+
 	/* Only DMA capable components need the LARB property */
 	comp->larb_dev = NULL;
 	if (type != MTK_DISP_OVL &&
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 6b13ba9..8939206 100644
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
 
@@ -75,6 +77,18 @@ struct mtk_ddp_comp_funcs {
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
@@ -82,6 +96,7 @@ struct mtk_ddp_comp {
 	struct device *larb_dev;
 	enum mtk_ddp_comp_id id;
 	const struct mtk_ddp_comp_funcs *funcs;
+	struct mtk_ddp_comp_driver_data *data;
 };
 
 static inline void mtk_ddp_comp_config(struct mtk_ddp_comp *comp,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 2774cbd..472ed21 100644
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
@@ -128,6 +141,22 @@ static const enum mtk_ddp_comp_id mtk_ddp_ext[] = {
 	DDP_COMPONENT_DPI0,
 };
 
+static struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
+	.main_path = mtk_ddp_main_2701,
+	.main_len = ARRAY_SIZE(mtk_ddp_main_2701),
+	.ext_path = mtk_ddp_ext_2701,
+	.ext_len = ARRAY_SIZE(mtk_ddp_ext_2701),
+	.shadow_register = true,
+};
+
+static struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
+	.main_path = mtk_ddp_main_8173,
+	.main_len = ARRAY_SIZE(mtk_ddp_main_8173),
+	.ext_path = mtk_ddp_ext_8173,
+	.ext_len = ARRAY_SIZE(mtk_ddp_ext_8173),
+	.shadow_register = false,
+};
+
 static int mtk_drm_kms_init(struct drm_device *drm)
 {
 	struct mtk_drm_private *private = drm->dev_private;
@@ -170,17 +199,19 @@ static int mtk_drm_kms_init(struct drm_device *drm)
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
@@ -316,21 +347,44 @@ static const struct component_master_ops mtk_drm_ops = {
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
@@ -347,6 +401,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 	mutex_init(&private->commit.lock);
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
+	private->data = mtk_drm_get_driver_data(pdev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	private->config_regs = devm_ioremap_resource(dev, mem);
@@ -497,11 +552,6 @@ static int mtk_drm_sys_resume(struct device *dev)
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
index aa93894..2aa2ac1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -28,6 +28,14 @@ struct drm_fb_helper;
 struct drm_property;
 struct regmap;
 
+struct mtk_mmsys_driver_data {
+	const enum mtk_ddp_comp_id *main_path;
+	unsigned int main_len;
+	const enum mtk_ddp_comp_id *ext_path;
+	unsigned int ext_len;
+	bool shadow_register;
+};
+
 struct mtk_drm_private {
 	struct drm_device *drm;
 	struct device *dma_dev;
@@ -40,6 +48,7 @@ struct mtk_drm_private {
 	void __iomem *config_regs;
 	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
 	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
+	struct mtk_mmsys_driver_data *data;
 
 	struct {
 		struct drm_atomic_state *state;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index a773bfa..d70776c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -108,6 +108,10 @@ int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
 	int ret;
 
 	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
+	/*
+	* align to 8 bytes since Mali requires it.
+	*/
+	args->pitch = ALIGN(args->pitch, 8);
 	args->size = args->pitch * args->height;
 
 	mtk_gem = mtk_drm_gem_create(dev, args->size, false);
-- 
1.7.9.5
