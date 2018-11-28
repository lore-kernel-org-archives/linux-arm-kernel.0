From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Wed, 28 Nov 2018 16:32:12 +0100
Subject: [PATCH 2/2] drm/exynos: mixer: Fix color range setting
In-Reply-To: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
References: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181128153235eucas1p192a346be6aa9ca28a1000238db4c6fc8@eucas1p1.samsung.com>
Message-ID: <1543419132-16099-3-git-send-email-c.manszewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Color format and color range was set based on resolution. Change that,
by splitting range and format. Leave color format setting as it is,
set color range based on drm_display_mode using
drm_default_quant_range helper function.

Tested on Odroid-U3 with Exynos 4412 CPU, kernel next-20181128
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 17 ++++++++++++-----
 drivers/gpu/drm/exynos/regs-mixer.h   |  9 +++++----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index bcc26c10095a..2a25822bd6a1 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -381,14 +381,16 @@ static void mixer_cfg_scan(struct mixer_context *ctx, int width, int height)
 	mixer_reg_writemask(ctx, MXR_CFG, val, MXR_CFG_SCAN_MASK);
 }
 
-static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, unsigned int height)
+static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, struct drm_display_mode *mode)
 {
+	enum hdmi_quantization_range range = drm_default_rgb_quant_range(mode);
 	u32 val;
 
-	if (height < 720) {
-		val = MXR_CFG_RGB601_0_255;
+	if (mode->vdisplay < 720) {
+		val = MXR_CFG_RGB601;
 	} else {
-		val = MXR_CFG_RGB709_16_235;
+		val = MXR_CFG_RGB709;
+
 		/* Configure the BT.709 CSC matrix for full range RGB. */
 		mixer_reg_write(ctx, MXR_CM_COEFF_Y,
 			MXR_CSC_CT( 0.184,  0.614,  0.063) |
@@ -399,6 +401,11 @@ static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, unsigned int height)
 			MXR_CSC_CT( 0.440, -0.399, -0.040));
 	}
 
+	if (range == HDMI_QUANTIZATION_RANGE_FULL)
+		val |= MXR_CFG_QUANT_RANGE_FULL;
+	else
+		val |= MXR_CFG_QUANT_RANGE_LIMITED;
+
 	mixer_reg_writemask(ctx, MXR_CFG, val, MXR_CFG_RGB_FMT_MASK);
 }
 
@@ -455,7 +462,7 @@ static void mixer_commit(struct mixer_context *ctx)
 	struct drm_display_mode *mode = &ctx->crtc->base.state->adjusted_mode;
 
 	mixer_cfg_scan(ctx, mode->hdisplay, mode->vdisplay);
-	mixer_cfg_rgb_fmt(ctx, mode->vdisplay);
+	mixer_cfg_rgb_fmt(ctx, mode);
 	mixer_run(ctx);
 }
 
diff --git a/drivers/gpu/drm/exynos/regs-mixer.h b/drivers/gpu/drm/exynos/regs-mixer.h
index d2b8194a07bf..5ff095b0c1b3 100644
--- a/drivers/gpu/drm/exynos/regs-mixer.h
+++ b/drivers/gpu/drm/exynos/regs-mixer.h
@@ -85,10 +85,11 @@
 /* bits for MXR_CFG */
 #define MXR_CFG_LAYER_UPDATE		(1 << 31)
 #define MXR_CFG_LAYER_UPDATE_COUNT_MASK (3 << 29)
-#define MXR_CFG_RGB601_0_255		(0 << 9)
-#define MXR_CFG_RGB601_16_235		(1 << 9)
-#define MXR_CFG_RGB709_0_255		(2 << 9)
-#define MXR_CFG_RGB709_16_235		(3 << 9)
+#define MXR_CFG_QUANT_RANGE_FULL	(0 << 9)
+#define MXR_CFG_QUANT_RANGE_LIMITED	(1 << 9)
+#define MXR_CFG_RGB601			(0 << 10)
+#define MXR_CFG_RGB709			(1 << 10)
+
 #define MXR_CFG_RGB_FMT_MASK		0x600
 #define MXR_CFG_OUT_YUV444		(0 << 8)
 #define MXR_CFG_OUT_RGB888		(1 << 8)
-- 
2.7.4
