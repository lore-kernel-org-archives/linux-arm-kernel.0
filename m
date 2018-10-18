From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Thu, 18 Oct 2018 14:51:46 +0200
Subject: [PATCH v3 1/2] drm/exynos: decon: Make plane alpha configurable
In-Reply-To: <1539867107-3383-1-git-send-email-c.manszewski@samsung.com>
References: <1539867107-3383-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181018125208eucas1p1e78fba86800edc4ceae4bbda95871ea1@eucas1p1.samsung.com>
Message-ID: <20181018125208eucas1p1e78fba86800edc4ceae4bbda95871ea1~etP6-rVKA0658506585eucas1p1y@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The decon hardware supports variable plane alpha. Currently planes
are opaque, make this configurable.

Tested on TM2 with Exynos 5433 CPU, on top of exynos-drm-next,
commit: c530174b90fa

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
v2 changes:
 - remove window blend property for the first (0) layer
 (currently zpos is immutable),
 - remove unused parameter in decon_win_set_bldmod,
 - move local variables to decon_win_set_pixfmt,
 - add alpha parameter in decon_win_set_bldmod,
 - don't call decon_win_set_bldmod for the first (0) layer,
 - move decon_win_set_bldmod call to bottom of decon_win_set_pixfmt,

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 33 +++++++++++++++++++++++++++
 drivers/gpu/drm/exynos/regs-decon5433.h       |  7 ++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 94529aa82339..2578db16750d 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -84,6 +84,14 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	[CURSON_WIN] = DRM_PLANE_TYPE_CURSOR,
 };
 
+static const unsigned int capabilities[WINDOWS_NR] = {
+	0,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+};
+
 static inline void decon_set_bits(struct decon_context *ctx, u32 reg, u32 mask,
 				  u32 val)
 {
@@ -259,9 +267,30 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	decon_set_bits(ctx, DECON_UPDATE, STANDALONE_UPDATE_F, ~0);
 }
 
+
+static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
+				 unsigned int alpha)
+{
+	u32 win_alpha = alpha >> 8;
+	u32 val = 0;
+
+	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		val = VIDOSD_Wx_ALPHA_R_F(win_alpha) |
+		      VIDOSD_Wx_ALPHA_G_F(win_alpha) |
+		      VIDOSD_Wx_ALPHA_B_F(win_alpha);
+		decon_set_bits(ctx, DECON_VIDOSDxC(win),
+			       VIDOSDxC_ALPHA0_RGB_MASK, val);
+		decon_set_bits(ctx, DECON_BLENDCON, BLEND_NEW, BLEND_NEW);
+	}
+}
+
 static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 				 struct drm_framebuffer *fb)
 {
+	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane_state *state =
+		to_exynos_plane_state(plane.base.state);
+	unsigned int alpha = state->base.alpha;
 	unsigned long val;
 
 	val = readl(ctx->addr + DECON_WINCONx(win));
@@ -288,6 +317,7 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val |= WINCONx_BPPMODE_32BPP_A8888;
 		val |= WINCONx_WSWP_F | WINCONx_BLD_PIX_F | WINCONx_ALPHA_SEL_F;
 		val |= WINCONx_BURSTLEN_16WORD;
+		val |= WINCONx_ALPHA_MUL_F;
 		break;
 	}
 
@@ -307,6 +337,8 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	}
 
 	writel(val, ctx->addr + DECON_WINCONx(win));
+	if (win > 0)
+		decon_win_set_bldmod(ctx, win, alpha);
 }
 
 static void decon_shadow_protect(struct decon_context *ctx, bool protect)
@@ -561,6 +593,7 @@ static int decon_bind(struct device *dev, struct device *master, void *data)
 		ctx->configs[win].num_pixel_formats = ARRAY_SIZE(decon_formats);
 		ctx->configs[win].zpos = win - ctx->first_win;
 		ctx->configs[win].type = decon_win_types[win];
+		ctx->configs[win].capabilities = capabilities[win];
 
 		ret = exynos_plane_init(drm_dev, &ctx->planes[win], win,
 					&ctx->configs[win]);
diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index 19ad9e47945e..72648bda3142 100644
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
@@ -121,6 +122,9 @@
 #define SHADOWCON_PROTECT_MASK		GENMASK(14, 10)
 #define SHADOWCON_Wx_PROTECT(n)		(1 << (10 + (n)))
 
+/* VIDOSDxC */
+#define VIDOSDxC_ALPHA0_RGB_MASK	(0xffffff)
+
 /* VIDOSDxD */
 #define VIDOSD_Wx_ALPHA_R_F(n)		(((n) & 0xff) << 16)
 #define VIDOSD_Wx_ALPHA_G_F(n)		(((n) & 0xff) << 8)
@@ -206,4 +210,7 @@
 #define CRCCTRL_CRCEN			(0x1 << 0)
 #define CRCCTRL_MASK			(0x7)
 
+/* BLENDCON */
+#define BLEND_NEW			(1 << 0)
+
 #endif /* EXYNOS_REGS_DECON5433_H */
-- 
2.7.4
