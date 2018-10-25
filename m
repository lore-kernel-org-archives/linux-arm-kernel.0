From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Thu, 25 Oct 2018 18:21:53 +0200
Subject: [PATCH v4 2/2] drm/exynos: decon: Make pixel blend mode configurable
In-Reply-To: <1540484513-24274-1-git-send-email-c.manszewski@samsung.com>
References: <1540484513-24274-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181025162204eucas1p1e53a6081e5251ba3419c0a996ff055cc@eucas1p1.samsung.com>
Message-ID: <20181025162204eucas1p1e53a6081e5251ba3419c0a996ff055cc~g5oNlZp252803828038eucas1p1h@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The decon hardware supports different blend modes. Add pixel blend mode
property and make it configurable, by modifying the blend equation.

Tested on TM2 with Exynos 5433 CPU, on top of linux-next-20181019.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
v4 changes:
 - set blend equation for DRM_MODE_BLEND_PIXEL_NONE explicitly,
v3 changes:
 - fix compilation errors (previouslsy wrong patch was sent),
v2 changes:
 - add premultiplied mode by setting blending equation accordingly,
 - remove no longer used blend mode settings from decon_win_set_pixfmt,

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 65 ++++++++++++++++++++++-----
 drivers/gpu/drm/exynos/regs-decon5433.h       | 15 +++++++
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 2578db16750d..68a42079679c 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -86,10 +86,10 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 
 static const unsigned int capabilities[WINDOWS_NR] = {
 	0,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
 };
 
 static inline void decon_set_bits(struct decon_context *ctx, u32 reg, u32 mask,
@@ -267,13 +267,51 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	decon_set_bits(ctx, DECON_UPDATE, STANDALONE_UPDATE_F, ~0);
 }
 
+static void decon_win_set_bldeq(struct decon_context *ctx, unsigned int win,
+				unsigned int alpha, unsigned int pixel_alpha)
+{
+	u32 mask = BLENDERQ_A_FUNC_F(0xf) | BLENDERQ_B_FUNC_F(0xf);
+	u32 val = 0;
+
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+	case DRM_MODE_BLEND_COVERAGE:
+		val |= BLENDERQ_A_FUNC_F(BLENDERQ_ALPHA_A);
+		val |= BLENDERQ_B_FUNC_F(BLENDERQ_ONE_MINUS_ALPHA_A);
+		break;
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+			val |= BLENDERQ_A_FUNC_F(BLENDERQ_ALPHA0);
+			val |= BLENDERQ_B_FUNC_F(BLENDERQ_ONE_MINUS_ALPHA_A);
+		} else {
+			val |= BLENDERQ_A_FUNC_F(BLENDERQ_ONE);
+			val |= BLENDERQ_B_FUNC_F(BLENDERQ_ONE_MINUS_ALPHA_A);
+		}
+		break;
+	}
+	decon_set_bits(ctx, DECON_BLENDERQx(win), mask, val);
+}
 
 static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
-				 unsigned int alpha)
+				 unsigned int alpha, unsigned int pixel_alpha)
 {
 	u32 win_alpha = alpha >> 8;
 	u32 val = 0;
 
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		val |= WINCONx_ALPHA_SEL_F;
+		val |= WINCONx_BLD_PIX_F;
+		val |= WINCONx_ALPHA_MUL_F;
+		break;
+	}
+	decon_set_bits(ctx, DECON_WINCONx(win), WINCONx_BLEND_MODE_MASK, val);
+
 	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
 		val = VIDOSD_Wx_ALPHA_R_F(win_alpha) |
 		      VIDOSD_Wx_ALPHA_G_F(win_alpha) |
@@ -291,8 +329,14 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	struct exynos_drm_plane_state *state =
 		to_exynos_plane_state(plane.base.state);
 	unsigned int alpha = state->base.alpha;
+	unsigned int pixel_alpha;
 	unsigned long val;
 
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
+
 	val = readl(ctx->addr + DECON_WINCONx(win));
 	val &= WINCONx_ENWIN_F;
 
@@ -315,9 +359,8 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	case DRM_FORMAT_ARGB8888:
 	default:
 		val |= WINCONx_BPPMODE_32BPP_A8888;
-		val |= WINCONx_WSWP_F | WINCONx_BLD_PIX_F | WINCONx_ALPHA_SEL_F;
+		val |= WINCONx_WSWP_F;
 		val |= WINCONx_BURSTLEN_16WORD;
-		val |= WINCONx_ALPHA_MUL_F;
 		break;
 	}
 
@@ -335,10 +378,12 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val &= ~WINCONx_BURSTLEN_MASK;
 		val |= WINCONx_BURSTLEN_8WORD;
 	}
+	decon_set_bits(ctx, DECON_WINCONx(win), ~WINCONx_BLEND_MODE_MASK, val);
 
-	writel(val, ctx->addr + DECON_WINCONx(win));
-	if (win > 0)
-		decon_win_set_bldmod(ctx, win, alpha);
+	if (win > 0) {
+		decon_win_set_bldmod(ctx, win, alpha, pixel_alpha);
+		decon_win_set_bldeq(ctx, win, alpha, pixel_alpha);
+	}
 }
 
 static void decon_shadow_protect(struct decon_context *ctx, bool protect)
diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index 72648bda3142..63db6974bf14 100644
--- a/drivers/gpu/drm/exynos/regs-decon5433.h
+++ b/drivers/gpu/drm/exynos/regs-decon5433.h
@@ -117,6 +117,7 @@
 #define WINCONx_BPPMODE_16BPP_A4444	(0xe << 2)
 #define WINCONx_ALPHA_SEL_F		(1 << 1)
 #define WINCONx_ENWIN_F			(1 << 0)
+#define WINCONx_BLEND_MODE_MASK		(0xc2)
 
 /* SHADOWCON */
 #define SHADOWCON_PROTECT_MASK		GENMASK(14, 10)
@@ -213,4 +214,18 @@
 /* BLENDCON */
 #define BLEND_NEW			(1 << 0)
 
+/* BLENDERQx */
+#define BLENDERQ_ZERO			0x0
+#define BLENDERQ_ONE			0x1
+#define BLENDERQ_ALPHA_A		0x2
+#define BLENDERQ_ONE_MINUS_ALPHA_A	0x3
+#define BLENDERQ_ALPHA0			0x6
+#define BLENDERQ_Q_FUNC_F(n)		(n << 18)
+#define BLENDERQ_P_FUNC_F(n)		(n << 12)
+#define BLENDERQ_B_FUNC_F(n)		(n << 6)
+#define BLENDERQ_A_FUNC_F(n)		(n << 0)
+
+/* BLENDCON */
+#define BLEND_NEW			(1 << 0)
+
 #endif /* EXYNOS_REGS_DECON5433_H */
-- 
2.7.4
