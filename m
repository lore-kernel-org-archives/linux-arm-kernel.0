From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 11 Aug 2016 11:11:25 +0200
Subject: [PATCH v4.5 3/4] drm/mediatek: Add gamma correction.
In-Reply-To: <1469672575-5847-4-git-send-email-bibby.hsieh@mediatek.com>
References: <1469672575-5847-1-git-send-email-bibby.hsieh@mediatek.com>
 <1469672575-5847-4-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1470906685.2493.34.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 2f3f4dda747c0619594d13996e65598ab675c60c Mon Sep 17 00:00:00 2001
From: Bibby Hsieh <bibby.hsieh@mediatek.com>
Date: Thu, 28 Jul 2016 10:22:54 +0800
Subject: [PATCH] drm/mediatek: Add gamma correction.

Add gamma set function to correct brightness values.
It applies arbitrary mapping curve to compensate the
incorrect transfer function of the panel.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
I have applied this patch with one change from v4:
 - Use drm_crtc_enable_color_mgmt instead of drm_crtc_helper_enable_color_mgmt
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  7 ++++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 31 +++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 10 ++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 24aa3ba..e3ac280 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -409,6 +409,9 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 	if (pending_planes)
 		mtk_crtc->pending_planes = true;
+	if (crtc->state->color_mgmt_changed)
+		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
+			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
 }
 
 static const struct drm_crtc_funcs mtk_crtc_funcs = {
@@ -418,6 +421,7 @@ static const struct drm_crtc_funcs mtk_crtc_funcs = {
 	.reset			= mtk_drm_crtc_reset,
 	.atomic_duplicate_state	= mtk_drm_crtc_duplicate_state,
 	.atomic_destroy_state	= mtk_drm_crtc_destroy_state,
+	.gamma_set		= drm_atomic_helper_legacy_gamma_set,
 };
 
 static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
@@ -568,7 +572,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 				&mtk_crtc->planes[1].base, pipe);
 	if (ret < 0)
 		goto unprepare;
-
+	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
+	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, false, MTK_LUT_SIZE);
 	priv->crtc[pipe] = &mtk_crtc->base;
 	priv->num_pipes++;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
index 81e5566..d332564 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
@@ -19,6 +19,7 @@
 #include "mtk_drm_plane.h"
 
 #define OVL_LAYER_NR	4
+#define MTK_LUT_SIZE	512
 
 int mtk_drm_crtc_enable_vblank(struct drm_device *drm, unsigned int pipe);
 void mtk_drm_crtc_disable_vblank(struct drm_device *drm, unsigned int pipe);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index ba895c8..42cd587 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -24,6 +24,7 @@
 #include "mtk_drm_drv.h"
 #include "mtk_drm_plane.h"
 #include "mtk_drm_ddp_comp.h"
+#include "mtk_drm_crtc.h"
 
 #define DISP_OD_EN				0x0000
 #define DISP_OD_INTEN				0x0008
@@ -42,7 +43,11 @@
 #define DISP_AAL_SIZE				0x0030
 
 #define DISP_GAMMA_EN				0x0000
+#define DISP_GAMMA_CFG				0x0020
 #define DISP_GAMMA_SIZE				0x0030
+#define DISP_GAMMA_LUT				0x0700
+
+#define LUT_10BIT_MASK				0x03ff
 
 #define	OD_RELAY_MODE		BIT(0)
 
@@ -54,6 +59,7 @@
 #define AAL_EN			BIT(0)
 
 #define GAMMA_EN		BIT(0)
+#define GAMMA_LUT_EN		BIT(1)
 
 static void mtk_color_config(struct mtk_ddp_comp *comp, unsigned int w,
 			     unsigned int h, unsigned int vrefresh)
@@ -118,13 +124,38 @@ static void mtk_gamma_stop(struct mtk_ddp_comp *comp)
 	writel_relaxed(0x0, comp->regs  + DISP_GAMMA_EN);
 }
 
+static void mtk_gamma_set(struct mtk_ddp_comp *comp,
+			  struct drm_crtc_state *state)
+{
+	unsigned int i, reg;
+	struct drm_color_lut *lut;
+	void __iomem *lut_base;
+	u32 word;
+
+	if (state->gamma_lut) {
+		reg = readl(comp->regs + DISP_GAMMA_CFG);
+		reg = reg | GAMMA_LUT_EN;
+		writel(reg, comp->regs + DISP_GAMMA_CFG);
+		lut_base = comp->regs + DISP_GAMMA_LUT;
+		lut = (struct drm_color_lut *)state->gamma_lut->data;
+		for (i = 0; i < MTK_LUT_SIZE; i++) {
+			word = (((lut[i].red >> 6) & LUT_10BIT_MASK) << 20) +
+				(((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
+				((lut[i].blue >> 6) & LUT_10BIT_MASK);
+			writel(word, (lut_base + i * 4));
+		}
+	}
+}
+
 static const struct mtk_ddp_comp_funcs ddp_aal = {
+	.gamma_set = mtk_gamma_set,
 	.config = mtk_aal_config,
 	.start = mtk_aal_start,
 	.stop = mtk_aal_stop,
 };
 
 static const struct mtk_ddp_comp_funcs ddp_gamma = {
+	.gamma_set = mtk_gamma_set,
 	.config = mtk_gamma_config,
 	.start = mtk_gamma_start,
 	.stop = mtk_gamma_stop,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 6b13ba9..f4b7e0a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -21,6 +21,7 @@ struct device_node;
 struct drm_crtc;
 struct drm_device;
 struct mtk_plane_state;
+struct drm_crtc_state;
 
 enum mtk_ddp_comp_type {
 	MTK_DISP_OVL,
@@ -73,6 +74,8 @@ struct mtk_ddp_comp_funcs {
 	void (*layer_off)(struct mtk_ddp_comp *comp, unsigned int idx);
 	void (*layer_config)(struct mtk_ddp_comp *comp, unsigned int idx,
 			     struct mtk_plane_state *state);
+	void (*gamma_set)(struct mtk_ddp_comp *comp,
+			  struct drm_crtc_state *state);
 };
 
 struct mtk_ddp_comp {
@@ -139,6 +142,13 @@ static inline void mtk_ddp_comp_layer_config(struct mtk_ddp_comp *comp,
 		comp->funcs->layer_config(comp, idx, state);
 }
 
+static inline void mtk_ddp_gamma_set(struct mtk_ddp_comp *comp,
+				     struct drm_crtc_state *state)
+{
+	if (comp->funcs && comp->funcs->gamma_set)
+		comp->funcs->gamma_set(comp, state);
+}
+
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type);
 int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
-- 
2.8.1
