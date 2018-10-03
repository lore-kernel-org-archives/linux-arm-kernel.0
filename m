From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Wed,  3 Oct 2018 11:40:43 +0200
Subject: [PATCH 1/2] drm/exynos: decon: Make plane alpha configurable
In-Reply-To: <1538559644-30269-1-git-send-email-c.manszewski@samsung.com>
References: <1538559644-30269-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181003094058eucas1p10dba450852a4ce8dc521b15e63ebabfa@eucas1p1.samsung.com>
Message-ID: <20181003094058eucas1p10dba450852a4ce8dc521b15e63ebabfa~aD9ubxJ5A1867918679eucas1p1K@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The decon hardware supports variable plane alpha. Currently planes
are opaque, make this configurable.

Tested on TM2 with Exynos 5433 CPU, on top of exynos-drm-next.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 30 +++++++++++++++++++++++++++
 drivers/gpu/drm/exynos/regs-decon5433.h       |  4 ++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 94529aa82339..dff540160199 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -84,6 +84,14 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	[CURSON_WIN] = DRM_PLANE_TYPE_CURSOR,
 };
 
+static const unsigned int capabilities[WINDOWS_NR] = {
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+};
+
 static inline void decon_set_bits(struct decon_context *ctx, u32 reg, u32 mask,
 				  u32 val)
 {
@@ -259,6 +267,24 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	decon_set_bits(ctx, DECON_UPDATE, STANDALONE_UPDATE_F, ~0);
 }
 
+static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
+				 struct drm_framebuffer *fb)
+{
+	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane_state *state =
+		to_exynos_plane_state(plane.base.state);
+	unsigned int alpha = state->base.alpha;
+	u32 win_alpha = alpha >> 8;
+	u32 val = 0;
+
+	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		val = VIDOSD_Wx_ALPHA_R_F(win_alpha) | VIDOSD_Wx_ALPHA_G_F(win_alpha) |
+			VIDOSD_Wx_ALPHA_B_F(win_alpha);
+		decon_set_bits(ctx, DECON_VIDOSDxC(win), 0xffffff, val);
+		decon_set_bits(ctx, DECON_BLENDCON, BLEND_NEW, BLEND_NEW);
+	}
+}
+
 static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 				 struct drm_framebuffer *fb)
 {
@@ -267,6 +293,8 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	val = readl(ctx->addr + DECON_WINCONx(win));
 	val &= WINCONx_ENWIN_F;
 
+	decon_win_set_bldmod(ctx, win, fb);
+
 	switch (fb->format->format) {
 	case DRM_FORMAT_XRGB1555:
 		val |= WINCONx_BPPMODE_16BPP_I1555;
@@ -288,6 +316,7 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val |= WINCONx_BPPMODE_32BPP_A8888;
 		val |= WINCONx_WSWP_F | WINCONx_BLD_PIX_F | WINCONx_ALPHA_SEL_F;
 		val |= WINCONx_BURSTLEN_16WORD;
+		val |= WINCONx_ALPHA_MUL_F;
 		break;
 	}
 
@@ -561,6 +590,7 @@ static int decon_bind(struct device *dev, struct device *master, void *data)
 		ctx->configs[win].num_pixel_formats = ARRAY_SIZE(decon_formats);
 		ctx->configs[win].zpos = win - ctx->first_win;
 		ctx->configs[win].type = decon_win_types[win];
+		ctx->configs[win].capabilities = capabilities[win];
 
 		ret = exynos_plane_init(drm_dev, &ctx->planes[win], win,
 					&ctx->configs[win]);
diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index 19ad9e47945e..f42d8f0adf5d 100644
--- a/drivers/gpu/drm/exynos/regs-decon5433.h
+++ b/drivers/gpu/drm/exynos/regs-decon5433.h
@@ -104,6 +104,7 @@
 #define WINCONx_BURSTLEN_16WORD		(0x0 << 10)
 #define WINCONx_BURSTLEN_8WORD		(0x1 << 10)
 #define WINCONx_BURSTLEN_4WORD		(0x2 << 10)
+#define WINCONx_ALPHA_MUL_F		(1 << 7)
 #define WINCONx_BLD_PIX_F		(1 << 6)
 #define WINCONx_BPPMODE_MASK		(0xf << 2)
 #define WINCONx_BPPMODE_16BPP_565	(0x5 << 2)
@@ -206,4 +207,7 @@
 #define CRCCTRL_CRCEN			(0x1 << 0)
 #define CRCCTRL_MASK			(0x7)
 
+/* BLENDCON */
+#define BLEND_NEW			(1 << 0)
+
 #endif /* EXYNOS_REGS_DECON5433_H */
-- 
2.7.4
