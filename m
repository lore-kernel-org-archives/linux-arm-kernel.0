From: shawnguo@kernel.org (Shawn Guo)
Date: Mon,  9 Jan 2017 22:35:43 +0800
Subject: [PATCH v4 2/3] drm: zte: add .atomic_disable hook to disable graphic
 layer
In-Reply-To: <1483972544-12731-1-git-send-email-shawnguo@kernel.org>
References: <1483972544-12731-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1483972544-12731-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

There are a few hardware bits for each graphic layer to control main/aux
channel and clock selection, as well as the layer enabling.  These bits
sit outside the layer block itself, but in VOU control glue block.  We
currently set these bits up at CRTC initialization for once, and do not
support disabling the layer.

This patch creates a pair of functions zx_vou_layer_enable[disable] to
be invoked from plane hooks .atomic_update and .atomic_disable to set up
and tear down the layer.  This is generic for both graphic and video
layers, so it will make the overlay plane support to be added later much
easier.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/zte/zx_plane.c | 15 +++++++++
 drivers/gpu/drm/zte/zx_plane.h |  1 +
 drivers/gpu/drm/zte/zx_vou.c   | 70 ++++++++++++++++++++++++++++++------------
 drivers/gpu/drm/zte/zx_vou.h   |  3 ++
 4 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
index 78d29b1db91c..5445eebf830f 100644
--- a/drivers/gpu/drm/zte/zx_plane.c
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -197,12 +197,27 @@ static void zx_gl_plane_atomic_update(struct drm_plane *plane,
 	/* Enable HBSC block */
 	zx_writel_mask(hbsc + HBSC_CTRL0, HBSC_CTRL_EN, HBSC_CTRL_EN);
 
+	zx_vou_layer_enable(plane);
+
 	zx_gl_set_update(zplane);
 }
 
+static void zx_plane_atomic_disable(struct drm_plane *plane,
+				    struct drm_plane_state *old_state)
+{
+	struct zx_plane *zplane = to_zx_plane(plane);
+	void __iomem *hbsc = zplane->hbsc;
+
+	zx_vou_layer_disable(plane);
+
+	/* Disable HBSC block */
+	zx_writel_mask(hbsc + HBSC_CTRL0, HBSC_CTRL_EN, 0);
+}
+
 static const struct drm_plane_helper_funcs zx_gl_plane_helper_funcs = {
 	.atomic_check = zx_gl_plane_atomic_check,
 	.atomic_update = zx_gl_plane_atomic_update,
+	.atomic_disable = zx_plane_atomic_disable,
 };
 
 static void zx_plane_destroy(struct drm_plane *plane)
diff --git a/drivers/gpu/drm/zte/zx_plane.h b/drivers/gpu/drm/zte/zx_plane.h
index 264a92e0b532..933611ddffd0 100644
--- a/drivers/gpu/drm/zte/zx_plane.h
+++ b/drivers/gpu/drm/zte/zx_plane.h
@@ -18,6 +18,7 @@ struct zx_plane {
 	void __iomem *csc;
 	void __iomem *hbsc;
 	void __iomem *rsz;
+	const struct vou_layer_bits *bits;
 };
 
 #define to_zx_plane(plane) container_of(plane, struct zx_plane, plane)
diff --git a/drivers/gpu/drm/zte/zx_vou.c b/drivers/gpu/drm/zte/zx_vou.c
index d5c801f6f97b..3fb4fc04e693 100644
--- a/drivers/gpu/drm/zte/zx_vou.c
+++ b/drivers/gpu/drm/zte/zx_vou.c
@@ -65,7 +65,6 @@ struct zx_crtc_bits {
 	u32 polarity_shift;
 	u32 int_frame_mask;
 	u32 tc_enable;
-	u32 gl_enable;
 };
 
 static const struct zx_crtc_bits main_crtc_bits = {
@@ -73,7 +72,6 @@ struct zx_crtc_bits {
 	.polarity_shift = MAIN_POL_SHIFT,
 	.int_frame_mask = TIMING_INT_MAIN_FRAME,
 	.tc_enable = MAIN_TC_EN,
-	.gl_enable = OSD_CTRL0_GL0_EN,
 };
 
 static const struct zx_crtc_bits aux_crtc_bits = {
@@ -81,7 +79,6 @@ struct zx_crtc_bits {
 	.polarity_shift = AUX_POL_SHIFT,
 	.int_frame_mask = TIMING_INT_AUX_FRAME,
 	.tc_enable = AUX_TC_EN,
-	.gl_enable = OSD_CTRL0_GL1_EN,
 };
 
 struct zx_crtc {
@@ -97,6 +94,24 @@ struct zx_crtc {
 
 #define to_zx_crtc(x) container_of(x, struct zx_crtc, crtc)
 
+struct vou_layer_bits {
+	u32 enable;
+	u32 chnsel;
+	u32 clksel;
+};
+
+static const struct vou_layer_bits zx_gl_bits[GL_NUM] = {
+	{
+		.enable = OSD_CTRL0_GL0_EN,
+		.chnsel = OSD_CTRL0_GL0_SEL,
+		.clksel = VOU_CLK_GL0_SEL,
+	}, {
+		.enable = OSD_CTRL0_GL1_EN,
+		.chnsel = OSD_CTRL0_GL1_SEL,
+		.clksel = VOU_CLK_GL1_SEL,
+	},
+};
+
 struct zx_vou_hw {
 	struct device *dev;
 	void __iomem *osd;
@@ -220,10 +235,6 @@ static void zx_crtc_enable(struct drm_crtc *crtc)
 	/* Enable channel */
 	zx_writel_mask(zcrtc->chnreg + CHN_CTRL0, CHN_ENABLE, CHN_ENABLE);
 
-	/* Enable Graphic Layer */
-	zx_writel_mask(vou->osd + OSD_CTRL0, bits->gl_enable,
-		       bits->gl_enable);
-
 	drm_crtc_vblank_on(crtc);
 
 	ret = clk_set_rate(zcrtc->pixclk, mode->clock * 1000);
@@ -247,9 +258,6 @@ static void zx_crtc_disable(struct drm_crtc *crtc)
 
 	drm_crtc_vblank_off(crtc);
 
-	/* Disable Graphic Layer */
-	zx_writel_mask(vou->osd + OSD_CTRL0, bits->gl_enable, 0);
-
 	/* Disable channel */
 	zx_writel_mask(zcrtc->chnreg + CHN_CTRL0, CHN_ENABLE, 0);
 
@@ -316,6 +324,7 @@ static int zx_crtc_init(struct drm_device *drm, struct zx_vou_hw *vou,
 		zplane->csc = vou->osd + MAIN_CSC_OFFSET;
 		zplane->hbsc = vou->osd + MAIN_HBSC_OFFSET;
 		zplane->rsz = vou->otfppu + MAIN_RSZ_OFFSET;
+		zplane->bits = &zx_gl_bits[0];
 		zcrtc->chnreg = vou->osd + OSD_MAIN_CHN;
 		zcrtc->regs = &main_crtc_regs;
 		zcrtc->bits = &main_crtc_bits;
@@ -324,6 +333,7 @@ static int zx_crtc_init(struct drm_device *drm, struct zx_vou_hw *vou,
 		zplane->csc = vou->osd + AUX_CSC_OFFSET;
 		zplane->hbsc = vou->osd + AUX_HBSC_OFFSET;
 		zplane->rsz = vou->otfppu + AUX_RSZ_OFFSET;
+		zplane->bits = &zx_gl_bits[1];
 		zcrtc->chnreg = vou->osd + OSD_AUX_CHN;
 		zcrtc->regs = &aux_crtc_regs;
 		zcrtc->bits = &aux_crtc_bits;
@@ -411,6 +421,36 @@ void zx_vou_disable_vblank(struct drm_device *drm, unsigned int pipe)
 		       zcrtc->bits->int_frame_mask, 0);
 }
 
+void zx_vou_layer_enable(struct drm_plane *plane)
+{
+	struct zx_crtc *zcrtc = to_zx_crtc(plane->state->crtc);
+	struct zx_vou_hw *vou = zcrtc->vou;
+	struct zx_plane *zplane = to_zx_plane(plane);
+	const struct vou_layer_bits *bits = zplane->bits;
+
+	if (zcrtc->chn_type == VOU_CHN_MAIN) {
+		zx_writel_mask(vou->osd + OSD_CTRL0, bits->chnsel, 0);
+		zx_writel_mask(vou->vouctl + VOU_CLK_SEL, bits->clksel, 0);
+	} else {
+		zx_writel_mask(vou->osd + OSD_CTRL0, bits->chnsel,
+			       bits->chnsel);
+		zx_writel_mask(vou->vouctl + VOU_CLK_SEL, bits->clksel,
+			       bits->clksel);
+	}
+
+	zx_writel_mask(vou->osd + OSD_CTRL0, bits->enable, bits->enable);
+}
+
+void zx_vou_layer_disable(struct drm_plane *plane)
+{
+	struct zx_crtc *zcrtc = to_zx_crtc(plane->crtc);
+	struct zx_vou_hw *vou = zcrtc->vou;
+	struct zx_plane *zplane = to_zx_plane(plane);
+	const struct vou_layer_bits *bits = zplane->bits;
+
+	zx_writel_mask(vou->osd + OSD_CTRL0, bits->enable, 0);
+}
+
 static irqreturn_t vou_irq_handler(int irq, void *dev_id)
 {
 	struct zx_vou_hw *vou = dev_id;
@@ -469,19 +509,9 @@ static void vou_dtrc_init(struct zx_vou_hw *vou)
 
 static void vou_hw_init(struct zx_vou_hw *vou)
 {
-	/* Set GL0 to main channel and GL1 to aux channel */
-	zx_writel_mask(vou->osd + OSD_CTRL0, OSD_CTRL0_GL0_SEL, 0);
-	zx_writel_mask(vou->osd + OSD_CTRL0, OSD_CTRL0_GL1_SEL,
-		       OSD_CTRL0_GL1_SEL);
-
 	/* Release reset for all VOU modules */
 	zx_writel(vou->vouctl + VOU_SOFT_RST, ~0);
 
-	/* Select main clock for GL0 and aux clock for GL1 module */
-	zx_writel_mask(vou->vouctl + VOU_CLK_SEL, VOU_CLK_GL0_SEL, 0);
-	zx_writel_mask(vou->vouctl + VOU_CLK_SEL, VOU_CLK_GL1_SEL,
-		       VOU_CLK_GL1_SEL);
-
 	/* Enable clock auto-gating for all VOU modules */
 	zx_writel(vou->vouctl + VOU_CLK_REQEN, ~0);
 
diff --git a/drivers/gpu/drm/zte/zx_vou.h b/drivers/gpu/drm/zte/zx_vou.h
index 349e06cd86f4..4b4339be641b 100644
--- a/drivers/gpu/drm/zte/zx_vou.h
+++ b/drivers/gpu/drm/zte/zx_vou.h
@@ -43,4 +43,7 @@ struct vou_inf {
 int zx_vou_enable_vblank(struct drm_device *drm, unsigned int pipe);
 void zx_vou_disable_vblank(struct drm_device *drm, unsigned int pipe);
 
+void zx_vou_layer_enable(struct drm_plane *plane);
+void zx_vou_layer_disable(struct drm_plane *plane);
+
 #endif /* __ZX_VOU_H__ */
-- 
1.9.1
