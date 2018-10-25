From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Thu, 25 Oct 2018 17:23:50 +0200
Subject: [PATCH v2 2/2] drm/exynos: fimd: Make pixel blend mode configurable
In-Reply-To: <1540481030-15019-1-git-send-email-c.manszewski@samsung.com>
References: <1540481030-15019-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181025152412eucas1p290814b0ac4ce25e64fa166b691819e69@eucas1p2.samsung.com>
Message-ID: <20181025152412eucas1p290814b0ac4ce25e64fa166b691819e69~g41r7Mkz81123611236eucas1p2W@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fimd hardware supports different blend modes. Add pixel blend mode
property and make it configurable, by modifying the blend equation.

Tested on TRATS2 with Exynos 4412 CPU, on top of linux-next-20181019.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
changes in v2:
 - add premultiplied mode by setting blending equation accordingly,

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 68 ++++++++++++++++++++++++++------
 include/video/samsung_fimd.h             |  9 +++++
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 9c4ff60326b9..fbf9bfa20e9a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -231,10 +231,10 @@ static const uint32_t fimd_formats[] = {
 
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
 
 static inline void fimd_set_bits(struct fimd_context *ctx, u32 reg, u32 mask,
@@ -567,13 +567,52 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
 	writel(val, ctx->regs + VIDCON0);
 }
 
+static void fimd_win_set_bldeq(struct fimd_context *ctx, unsigned int win,
+			       unsigned int alpha, unsigned int pixel_alpha)
+{
+	u32 mask = BLENDEQ_A_FUNC_F(0xf) | BLENDEQ_B_FUNC_F(0xf);
+	u32 val = 0;
+
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+	case DRM_MODE_BLEND_COVERAGE:
+		val |= BLENDEQ_A_FUNC_F(BLENDEQ_ALPHA_A);
+		val |= BLENDEQ_B_FUNC_F(BLENDEQ_ONE_MINUS_ALPHA_A);
+		break;
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+			val |= BLENDEQ_A_FUNC_F(BLENDEQ_ALPHA0);
+			val |= BLENDEQ_B_FUNC_F(BLENDEQ_ONE_MINUS_ALPHA_A);
+		} else {
+			val |= BLENDEQ_A_FUNC_F(BLENDEQ_ONE);
+			val |= BLENDEQ_B_FUNC_F(BLENDEQ_ONE_MINUS_ALPHA_A);
+		}
+		break;
+	}
+	fimd_set_bits(ctx, BLENDEQx(win), mask, val);
+}
+
 static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
-				unsigned int alpha)
+				unsigned int alpha, unsigned int pixel_alpha)
 {
 	u32 win_alpha_l = (alpha >> 8) & 0xf;
 	u32 win_alpha_h = alpha >> 12;
 	u32 val = 0;
 
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		val |= WINCON1_ALPHA_SEL;
+		val |= WINCON1_BLD_PIX;
+		val |= WINCON1_ALPHA_MUL;
+		break;
+	}
+	fimd_set_bits(ctx, WINCON(win), WINCONx_BLEND_MODE_MASK, val);
+
 	/* OSD alpha */
 	val = VIDISD14C_ALPHA0_R(win_alpha_h) |
 		VIDISD14C_ALPHA0_G(win_alpha_h) |
@@ -604,6 +643,12 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 	uint32_t pixel_format = fb->format->format;
 	unsigned int alpha = state->base.alpha;
 	u32 val = WINCONx_ENWIN;
+	unsigned int pixel_alpha;
+
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
 
 	/*
 	 * In case of s3c64xx, window 0 doesn't support alpha channel.
@@ -637,11 +682,9 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 		break;
 	case DRM_FORMAT_ARGB8888:
 	default:
-		val |= WINCON1_BPPMODE_25BPP_A1888
-			| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
+		val |= WINCON1_BPPMODE_25BPP_A1888;
 		val |= WINCONx_WSWP;
 		val |= WINCONx_BURSTLEN_16WORD;
-		val |= WINCON1_ALPHA_MUL;
 		break;
 	}
 
@@ -657,12 +700,13 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 		val &= ~WINCONx_BURSTLEN_MASK;
 		val |= WINCONx_BURSTLEN_4WORD;
 	}
-
-	writel(val, ctx->regs + WINCON(win));
+	fimd_set_bits(ctx, WINCON(win), ~WINCONx_BLEND_MODE_MASK, val);
 
 	/* hardware window 0 doesn't support alpha channel. */
-	if (win != 0)
-		fimd_win_set_bldmod(ctx, win, alpha);
+	if (win != 0) {
+		fimd_win_set_bldmod(ctx, win, alpha, pixel_alpha);
+		fimd_win_set_bldeq(ctx, win, alpha, pixel_alpha);
+	}
 }
 
 static void fimd_win_set_colkey(struct fimd_context *ctx, unsigned int win)
diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index f070b7c0d2cf..4ba5efe8d086 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -198,6 +198,7 @@
 #define WINCONx_BURSTLEN_8WORD			(0x1 << 9)
 #define WINCONx_BURSTLEN_4WORD			(0x2 << 9)
 #define WINCONx_ENWIN				(1 << 0)
+#define WINCONx_BLEND_MODE_MASK			(0xc2)
 
 #define WINCON0_BPPMODE_MASK			(0xf << 2)
 #define WINCON0_BPPMODE_SHIFT			2
@@ -438,6 +439,14 @@
 #define WPALCON_W0PAL_16BPP_565			(0x6 << 0)
 
 /* Blending equation control */
+#define BLENDEQx(_win)				(0x244 + ((_win - 1) * 4))
+#define BLENDEQ_ZERO				0x0
+#define BLENDEQ_ONE				0x1
+#define BLENDEQ_ALPHA_A				0x2
+#define BLENDEQ_ONE_MINUS_ALPHA_A		0x3
+#define BLENDEQ_ALPHA0				0x6
+#define BLENDEQ_B_FUNC_F(_x)			(_x << 6)
+#define BLENDEQ_A_FUNC_F(_x)			(_x << 0)
 #define BLENDCON				0x260
 #define BLENDCON_NEW_MASK			(1 << 0)
 #define BLENDCON_NEW_8BIT_ALPHA_VALUE		(1 << 0)
-- 
2.7.4
