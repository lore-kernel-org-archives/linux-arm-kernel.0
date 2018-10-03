From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Wed,  3 Oct 2018 11:40:44 +0200
Subject: [PATCH 2/2] drm/exynos: decon: Make pixel blend mode configurable
In-Reply-To: <1538559644-30269-1-git-send-email-c.manszewski@samsung.com>
References: <1538559644-30269-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181003094100eucas1p23bfb9604dbd50ee77f11a85d2c626471@eucas1p2.samsung.com>
Message-ID: <20181003094100eucas1p23bfb9604dbd50ee77f11a85d2c626471~aD9wOUXM61807118071eucas1p2b@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently blend mode is set accordingly to pixel format.
Add pixel blend mode property and make that configurable.
Decon hardware doesn't support premultiplied mode,
chose coverage as default.

Tested on TM2 with Exynos 5433 CPU, on top of exynos-drm-next
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---

Currently, the driver exposes the "premultiplied" option for
pixel blend mode property, and handles it as "coverage".
This is due to the fact, that "premultiplied" mode is mandatory
and is used as default. The question is - how to correctly deal with
hardare that doesn't support premultiplied mode?

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 29 ++++++++++++++++++++++-----
 drivers/gpu/drm/exynos/regs-decon5433.h       |  1 +
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index dff540160199..15609c9f2fda 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -84,12 +84,13 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	[CURSON_WIN] = DRM_PLANE_TYPE_CURSOR,
 };
 
+
 static const unsigned int capabilities[WINDOWS_NR] = {
 	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
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
@@ -276,6 +277,24 @@ static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
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
+		val |= WINCONx_ALPHA_SEL_F;
+		val |= WINCONx_BLD_PIX_F;
+		val |= WINCONx_ALPHA_MUL_F;
+		break;
+	}
+	decon_set_bits(ctx, DECON_WINCONx(win), WINCONx_BLEND_MODE_MASK, val);
 
 	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
 		val = VIDOSD_Wx_ALPHA_R_F(win_alpha) | VIDOSD_Wx_ALPHA_G_F(win_alpha) |
@@ -335,7 +354,7 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val |= WINCONx_BURSTLEN_8WORD;
 	}
 
-	writel(val, ctx->addr + DECON_WINCONx(win));
+	decon_set_bits(ctx, DECON_WINCONx(win), ~WINCONx_BLEND_MODE_MASK, val);
 }
 
 static void decon_shadow_protect(struct decon_context *ctx, bool protect)
diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index f42d8f0adf5d..17b7324922c1 100644
--- a/drivers/gpu/drm/exynos/regs-decon5433.h
+++ b/drivers/gpu/drm/exynos/regs-decon5433.h
@@ -117,6 +117,7 @@
 #define WINCONx_BPPMODE_16BPP_A4444	(0xe << 2)
 #define WINCONx_ALPHA_SEL_F		(1 << 1)
 #define WINCONx_ENWIN_F			(1 << 0)
+#define WINCONx_BLEND_MODE_MASK		(0xc2)
 
 /* SHADOWCON */
 #define SHADOWCON_PROTECT_MASK		GENMASK(14, 10)
-- 
2.7.4
