From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Mon,  8 Oct 2018 11:33:01 +0200
Subject: [PATCH 1/2] drm/exynos: fimd: Make plane alpha configurable
In-Reply-To: <1538991182-12961-1-git-send-email-c.manszewski@samsung.com>
References: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
 <1538991182-12961-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181008093328eucas1p2c00d65c7f8451f7628f630934c992185@eucas1p2.samsung.com>
Message-ID: <20181008093328eucas1p2c00d65c7f8451f7628f630934c992185~bmFmklSgF0357503575eucas1p25@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fimd hardware supports variable plane alpha. Currently planes
are opaque, make this configurable.

Tested on TRATS2 with Exynos 4412 CPU, on top of exynos-drm-next.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 69 +++++++++++++++++++++++---------
 include/video/samsung_fimd.h             |  1 +
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index b7f56935a46b..06d5d2422246 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -229,6 +229,21 @@ static const uint32_t fimd_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
+static const unsigned int capabilities[WINDOWS_NR] = {
+	0,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+};
+
+static inline void fimd_set_bits(struct fimd_context *ctx, u32 reg, u32 mask,
+				 u32 val)
+{
+	val = (val & mask) | (readl(ctx->regs + reg) & ~mask);
+	writel(val, ctx->regs + reg);
+}
+
 static int fimd_enable_vblank(struct exynos_drm_crtc *crtc)
 {
 	struct fimd_context *ctx = crtc->ctx;
@@ -552,10 +567,38 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
 	writel(val, ctx->regs + VIDCON0);
 }
 
+static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
+				struct drm_framebuffer *fb)
+{
+	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane_state *state =
+		to_exynos_plane_state(plane.base.state);
+	unsigned int alpha = state->base.alpha;
+	u32 win_alpha = alpha >> 8;
+	u32 val = 0;
+
+	/* OSD alpha */
+	val = VIDISD14C_ALPHA0_R(alpha >> 4) |
+		VIDISD14C_ALPHA0_G(win_alpha >> 4) |
+		VIDISD14C_ALPHA0_B(win_alpha >> 4) |
+		VIDISD14C_ALPHA1_R(win_alpha >> 4) |
+		VIDISD14C_ALPHA1_G(win_alpha >> 4) |
+		VIDISD14C_ALPHA1_B(win_alpha >> 4);
+
+	writel(val, ctx->regs + VIDOSD_C(win));
+
+	val = VIDW_ALPHA_R(win_alpha & 0xf) | VIDW_ALPHA_G(win_alpha & 0xf) |
+		VIDW_ALPHA_G(win_alpha & 0xf);
+	writel(val, ctx->regs + VIDWnALPHA0(win));
+	writel(val, ctx->regs + VIDWnALPHA1(win));
+	fimd_set_bits(ctx, BLENDCON, BLENDCON_NEW_MASK,
+			BLENDCON_NEW_8BIT_ALPHA_VALUE);
+}
 
 static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
-				uint32_t pixel_format, int width)
+				struct drm_framebuffer *fb, int width)
 {
+	uint32_t pixel_format = fb->format->format;
 	unsigned long val;
 
 	val = WINCONx_ENWIN;
@@ -596,6 +639,7 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 			| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
 		val |= WINCONx_WSWP;
 		val |= WINCONx_BURSTLEN_16WORD;
+		val |= WINCON1_ALPHA_MUL;
 		break;
 	}
 
@@ -607,7 +651,7 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 	 * still better to change dma-burst than displaying garbage.
 	 */
 
-	if (width < MIN_FB_WIDTH_FOR_16WORD_BURST) {
+	if (fb->width < MIN_FB_WIDTH_FOR_16WORD_BURST) {
 		val &= ~WINCONx_BURSTLEN_MASK;
 		val |= WINCONx_BURSTLEN_4WORD;
 	}
@@ -615,22 +659,8 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 	writel(val, ctx->regs + WINCON(win));
 
 	/* hardware window 0 doesn't support alpha channel. */
-	if (win != 0) {
-		/* OSD alpha */
-		val = VIDISD14C_ALPHA0_R(0xf) |
-			VIDISD14C_ALPHA0_G(0xf) |
-			VIDISD14C_ALPHA0_B(0xf) |
-			VIDISD14C_ALPHA1_R(0xf) |
-			VIDISD14C_ALPHA1_G(0xf) |
-			VIDISD14C_ALPHA1_B(0xf);
-
-		writel(val, ctx->regs + VIDOSD_C(win));
-
-		val = VIDW_ALPHA_R(0xf) | VIDW_ALPHA_G(0xf) |
-			VIDW_ALPHA_G(0xf);
-		writel(val, ctx->regs + VIDWnALPHA0(win));
-		writel(val, ctx->regs + VIDWnALPHA1(win));
-	}
+	if (win != 0)
+		fimd_win_set_bldmod(ctx, win, fb);
 }
 
 static void fimd_win_set_colkey(struct fimd_context *ctx, unsigned int win)
@@ -786,7 +816,7 @@ static void fimd_update_plane(struct exynos_drm_crtc *crtc,
 		DRM_DEBUG_KMS("osd size = 0x%x\n", (unsigned int)val);
 	}
 
-	fimd_win_set_pixfmt(ctx, win, fb->format->format, state->src.w);
+	fimd_win_set_pixfmt(ctx, win, fb, state->src.w);
 
 	/* hardware window 0 doesn't support color key. */
 	if (win != 0)
@@ -988,6 +1018,7 @@ static int fimd_bind(struct device *dev, struct device *master, void *data)
 		ctx->configs[i].num_pixel_formats = ARRAY_SIZE(fimd_formats);
 		ctx->configs[i].zpos = i;
 		ctx->configs[i].type = fimd_win_types[i];
+		ctx->configs[i].capabilities = capabilities[i];
 		ret = exynos_plane_init(drm_dev, &ctx->planes[i], i,
 					&ctx->configs[i]);
 		if (ret)
diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index d8fc96ed11e9..f070b7c0d2cf 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -211,6 +211,7 @@
 #define WINCON0_BPPMODE_24BPP_888		(0xb << 2)
 
 #define WINCON1_LOCALSEL_CAMIF			(1 << 23)
+#define WINCON1_ALPHA_MUL			(1 << 7)
 #define WINCON1_BLD_PIX				(1 << 6)
 #define WINCON1_BPPMODE_MASK			(0xf << 2)
 #define WINCON1_BPPMODE_SHIFT			2
-- 
2.7.4
