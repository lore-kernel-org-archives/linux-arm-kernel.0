From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 7 Jul 2016 15:37:08 +0800
Subject: [PATCH v3 1/2] drm/mediatek: Add gamma correction
In-Reply-To: <1467877029-45236-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1467877029-45236-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1467877029-45236-2-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apply gamma function to correct brightness values.
It applies arbitrary mapping curve to compensate the
incorrect transfer function of the panel.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |    8 +++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |    1 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   89 ++++++++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   10 +++
 4 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 24aa3ba..ee219bb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -409,6 +409,10 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 	if (pending_planes)
 		mtk_crtc->pending_planes = true;
+	if (crtc->state->color_mgmt_changed)
+		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
+			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
+
 }
 
 static const struct drm_crtc_funcs mtk_crtc_funcs = {
@@ -418,6 +422,7 @@ static const struct drm_crtc_funcs mtk_crtc_funcs = {
 	.reset			= mtk_drm_crtc_reset,
 	.atomic_duplicate_state	= mtk_drm_crtc_duplicate_state,
 	.atomic_destroy_state	= mtk_drm_crtc_destroy_state,
+	.gamma_set		= drm_atomic_helper_legacy_gamma_set,
 };
 
 static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
@@ -569,6 +574,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	if (ret < 0)
 		goto unprepare;
 
+	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
+	drm_helper_crtc_enable_color_mgmt(&mtk_crtc->base, MTK_LUT_SIZE,
+					  MTK_LUT_SIZE);
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
index 3970fcf..56c5894 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -24,6 +24,7 @@
 #include "mtk_drm_drv.h"
 #include "mtk_drm_plane.h"
 #include "mtk_drm_ddp_comp.h"
+#include "mtk_drm_crtc.h"
 
 #define DISP_OD_EN				0x0000
 #define DISP_OD_INTEN				0x0008
@@ -38,6 +39,21 @@
 #define DISP_COLOR_WIDTH			0x0c50
 #define DISP_COLOR_HEIGHT			0x0c54
 
+#define DISP_AAL_EN				0x000
+#define DISP_AAL_SIZE				0x030
+
+#define DISP_GAMMA_EN				0x000
+#define DISP_GAMMA_CFG				0x020
+#define DISP_GAMMA_SIZE				0x030
+#define DISP_GAMMA_LUT				0x700
+
+#define LUT_10BIT_MASK				0x3ff
+
+#define AAL_EN			BIT(0)
+
+#define GAMMA_EN		BIT(0)
+#define GAMMA_LUT_EN		BIT(1)
+
 #define	OD_RELAY_MODE		BIT(0)
 
 #define	UFO_BYPASS		BIT(2)
@@ -76,6 +92,61 @@ static void mtk_ufoe_start(struct mtk_ddp_comp *comp)
 	writel(UFO_BYPASS, comp->regs + DISP_REG_UFO_START);
 }
 
+static void mtk_aal_config(struct mtk_ddp_comp *comp, unsigned int w,
+			   unsigned int h, unsigned int vrefresh)
+{
+	writel(h << 16 | w, comp->regs + DISP_AAL_SIZE);
+}
+
+static void mtk_aal_start(struct mtk_ddp_comp *comp)
+{
+	writel(AAL_EN, comp->regs  + DISP_AAL_EN);
+}
+
+static void mtk_aal_stop(struct mtk_ddp_comp *comp)
+{
+	writel_relaxed(0x0, comp->regs  + DISP_AAL_EN);
+}
+
+static void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
+			     unsigned int h, unsigned int vrefresh)
+{
+	writel(h << 16 | w, comp->regs + DISP_GAMMA_SIZE);
+}
+
+static void mtk_gamma_start(struct mtk_ddp_comp *comp)
+{
+	writel(GAMMA_EN, comp->regs  + DISP_GAMMA_EN);
+}
+
+static void mtk_gamma_stop(struct mtk_ddp_comp *comp)
+{
+	writel_relaxed(0x0, comp->regs  + DISP_GAMMA_EN);
+}
+
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
+			      (((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
+			      ((lut[i].blue >> 6) & LUT_10BIT_MASK);
+			writel(word, (lut_base + i * 4));
+		}
+	}
+}
+
 static const struct mtk_ddp_comp_funcs ddp_color = {
 	.config = mtk_color_config,
 	.start = mtk_color_start,
@@ -90,6 +161,20 @@ static const struct mtk_ddp_comp_funcs ddp_ufoe = {
 	.start = mtk_ufoe_start,
 };
 
+static const struct mtk_ddp_comp_funcs ddp_aal = {
+	.gamma_set = mtk_gamma_set,
+	.config = mtk_aal_config,
+	.start = mtk_aal_start,
+	.stop = mtk_aal_stop,
+};
+
+static const struct mtk_ddp_comp_funcs ddp_gamma = {
+	.gamma_set = mtk_gamma_set,
+	.config = mtk_gamma_config,
+	.start = mtk_gamma_start,
+	.stop = mtk_gamma_stop,
+};
+
 static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_OVL] = "ovl",
 	[MTK_DISP_RDMA] = "rdma",
@@ -112,13 +197,13 @@ struct mtk_ddp_comp_match {
 };
 
 static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
-	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, NULL },
+	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, &ddp_aal },
 	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
 	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
 	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
 	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
 	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
-	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, NULL },
+	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
 	[DDP_COMPONENT_OD]	= { MTK_DISP_OD,	0, &ddp_od },
 	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, NULL },
 	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 6b13ba9..07e17fe 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -20,6 +20,7 @@ struct device;
 struct device_node;
 struct drm_crtc;
 struct drm_device;
+struct drm_crtc_state;
 struct mtk_plane_state;
 
 enum mtk_ddp_comp_type {
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
1.7.9.5
