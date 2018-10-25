From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Thu, 25 Oct 2018 17:23:49 +0200
Subject: [PATCH v2 1/2] drm/exynos: fimd: Make plane alpha configurable
In-Reply-To: <1540481030-15019-1-git-send-email-c.manszewski@samsung.com>
References: <1540481030-15019-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181025152411eucas1p1d9c15aaa67585ac888b72ef67c258b44@eucas1p1.samsung.com>
Message-ID: <20181025152411eucas1p1d9c15aaa67585ac888b72ef67c258b44~g41qpKjGp2269722697eucas1p1G@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fimd hardware supports variable plane alpha. Currently planes
are opaque, make this configurable.

Tested on TRATS2 with Exynos 4412 CPU, on top of linux-next-20181019.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
v2 changes:
 - write blue lower ALPHA0 value correctly,
 - set ALPHA1 to zero,
 - move local variables from set_bldmod to set_pixfmt,
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 75 +++++++++++++++++++++++---------
 include/video/samsung_fimd.h             |  1 +
 2 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index b7f56935a46b..9c4ff60326b9 100644
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
@@ -552,13 +567,43 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
 	writel(val, ctx->regs + VIDCON0);
 }
 
+static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
+				unsigned int alpha)
+{
+	u32 win_alpha_l = (alpha >> 8) & 0xf;
+	u32 win_alpha_h = alpha >> 12;
+	u32 val = 0;
+
+	/* OSD alpha */
+	val = VIDISD14C_ALPHA0_R(win_alpha_h) |
+		VIDISD14C_ALPHA0_G(win_alpha_h) |
+		VIDISD14C_ALPHA0_B(win_alpha_h) |
+		VIDISD14C_ALPHA1_R(0x0) |
+		VIDISD14C_ALPHA1_G(0x0) |
+		VIDISD14C_ALPHA1_B(0x0);
+	writel(val, ctx->regs + VIDOSD_C(win));
+
+	val = VIDW_ALPHA_R(win_alpha_l) | VIDW_ALPHA_G(win_alpha_l) |
+		VIDW_ALPHA_B(win_alpha_l);
+	writel(val, ctx->regs + VIDWnALPHA0(win));
+
+	val = VIDW_ALPHA_R(0x0) | VIDW_ALPHA_G(0x0) |
+		VIDW_ALPHA_B(0x0);
+	writel(val, ctx->regs + VIDWnALPHA1(win));
+
+	fimd_set_bits(ctx, BLENDCON, BLENDCON_NEW_MASK,
+			BLENDCON_NEW_8BIT_ALPHA_VALUE);
+}
 
 static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
-				uint32_t pixel_format, int width)
+				struct drm_framebuffer *fb, int width)
 {
-	unsigned long val;
-
-	val = WINCONx_ENWIN;
+	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane_state *state =
+		to_exynos_plane_state(plane.base.state);
+	uint32_t pixel_format = fb->format->format;
+	unsigned int alpha = state->base.alpha;
+	u32 val = WINCONx_ENWIN;
 
 	/*
 	 * In case of s3c64xx, window 0 doesn't support alpha channel.
@@ -596,6 +641,7 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 			| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
 		val |= WINCONx_WSWP;
 		val |= WINCONx_BURSTLEN_16WORD;
+		val |= WINCON1_ALPHA_MUL;
 		break;
 	}
 
@@ -615,22 +661,8 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
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
+		fimd_win_set_bldmod(ctx, win, alpha);
 }
 
 static void fimd_win_set_colkey(struct fimd_context *ctx, unsigned int win)
@@ -786,7 +818,7 @@ static void fimd_update_plane(struct exynos_drm_crtc *crtc,
 		DRM_DEBUG_KMS("osd size = 0x%x\n", (unsigned int)val);
 	}
 
-	fimd_win_set_pixfmt(ctx, win, fb->format->format, state->src.w);
+	fimd_win_set_pixfmt(ctx, win, fb, state->src.w);
 
 	/* hardware window 0 doesn't support color key. */
 	if (win != 0)
@@ -988,6 +1020,7 @@ static int fimd_bind(struct device *dev, struct device *master, void *data)
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
