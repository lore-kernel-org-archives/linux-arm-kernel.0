From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Mon,  8 Oct 2018 11:33:02 +0200
Subject: [PATCH 2/2] drm/exynos: fimd: Make pixel blend mode configurable
In-Reply-To: <1538991182-12961-1-git-send-email-c.manszewski@samsung.com>
References: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
 <1538991182-12961-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181008093330eucas1p15363b8acc502292b24a6f6803073accc@eucas1p1.samsung.com>
Message-ID: <20181008093330eucas1p15363b8acc502292b24a6f6803073accc~bmFojGGtF2363023630eucas1p1_@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently blend mode is set accordingly to pixel format.
Add pixel blend mode property and make that configurable.
Fimd hardware doesn't support premultiplied mode,
choose coverage as default.

Tested on TRATS2 with Exynos 4412 CPU, on top of
exynos-drm-next using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---

Similar to exynos5433_drm_decon, the driver exposes
the "premultiplied" option for pixel blend mode property,
although hardware doesn't support it, and it's hanlded
by the driver as "coverage". Again, that's because the premultiplied
mode is required and used as default.

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 28 ++++++++++++++++++++++------
 include/video/samsung_fimd.h             |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 06d5d2422246..c4b0fb05a19b 100644
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
@@ -576,6 +576,23 @@ static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
 	unsigned int alpha = state->base.alpha;
 	u32 win_alpha = alpha >> 8;
 	u32 val = 0;
+	unsigned int pixel_alpha;
+
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
+
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+	default:
+		val |= WINCON1_ALPHA_SEL;
+		val |= WINCON1_BLD_PIX;
+		val |= WINCON1_ALPHA_MUL;
+	}
+	fimd_set_bits(ctx, WINCON(win), WINCONx_BLEND_MODE_MASK, val);
 
 	/* OSD alpha */
 	val = VIDISD14C_ALPHA0_R(alpha >> 4) |
@@ -639,7 +656,6 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 			| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
 		val |= WINCONx_WSWP;
 		val |= WINCONx_BURSTLEN_16WORD;
-		val |= WINCON1_ALPHA_MUL;
 		break;
 	}
 
@@ -656,7 +672,7 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 		val |= WINCONx_BURSTLEN_4WORD;
 	}
 
-	writel(val, ctx->regs + WINCON(win));
+	fimd_set_bits(ctx, WINCON(win), ~WINCONx_BLEND_MODE_MASK, val);
 
 	/* hardware window 0 doesn't support alpha channel. */
 	if (win != 0)
diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index f070b7c0d2cf..bb1d5baa74d6 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -198,6 +198,7 @@
 #define WINCONx_BURSTLEN_8WORD			(0x1 << 9)
 #define WINCONx_BURSTLEN_4WORD			(0x2 << 9)
 #define WINCONx_ENWIN				(1 << 0)
+#define WINCONx_BLEND_MODE_MASK			(0xc2)
 
 #define WINCON0_BPPMODE_MASK			(0xf << 2)
 #define WINCON0_BPPMODE_SHIFT			2
-- 
2.7.4
