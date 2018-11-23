From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:50 +0100
Subject: [PATCH v2 18/43] drm/sun4i: frontend: Add proper definitions for
 format registers
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-19-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces proper definitions for the input and output format
configuration registers instead of a macro and raw values in the code,
with the intent to increase code readability and reduce indirections.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 14 ++++++--------
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  8 ++++----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index bb5977a466f3..a305b731b042 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -108,7 +108,7 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
 	case DRM_FORMAT_XRGB8888:
-		*val = 5;
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
 		return 0;
 
 	default:
@@ -120,7 +120,7 @@ static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
 	case DRM_FORMAT_XRGB8888:
-		*val = 1;
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
 		return 0;
 
 	default:
@@ -132,7 +132,7 @@ static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
 	case DRM_FORMAT_XRGB8888:
-		*val = 1;
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB;
 		return 0;
 
 	default:
@@ -144,7 +144,7 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
 	case DRM_FORMAT_XRGB8888:
-		*val = 2;
+		*val = SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_XRGB8888;
 		return 0;
 
 	default:
@@ -218,9 +218,7 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 			   SUN4I_FRONTEND_BYPASS_CSC_EN);
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_INPUT_FMT_REG,
-		     SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(in_mod_val) |
-		     SUN4I_FRONTEND_INPUT_FMT_DATA_FMT(in_fmt_val) |
-		     SUN4I_FRONTEND_INPUT_FMT_PS(in_ps_val));
+		     in_mod_val | in_fmt_val | in_ps_val);
 
 	/*
 	 * TODO: It look like the A31 and A80 at least will need the
@@ -228,7 +226,7 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	 * ARGB8888).
 	 */
 	regmap_write(frontend->regs, SUN4I_FRONTEND_OUTPUT_FMT_REG,
-		     SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT(out_fmt_val));
+		     out_fmt_val);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index a9cb908ced16..56bd5a3f9723 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -26,12 +26,12 @@
 #define SUN4I_FRONTEND_LINESTRD0_REG		0x040
 
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
-#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(mod)		((mod) << 8)
-#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT(fmt)		((fmt) << 4)
-#define SUN4I_FRONTEND_INPUT_FMT_PS(ps)			(ps)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB		(5 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB		1
 
 #define SUN4I_FRONTEND_OUTPUT_FMT_REG		0x05c
-#define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT(fmt)		(fmt)
+#define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_XRGB8888	2
 
 #define SUN4I_FRONTEND_CH0_INSIZE_REG		0x100
 #define SUN4I_FRONTEND_INSIZE(h, w)			((((h) - 1) << 16) | (((w) - 1)))
-- 
2.19.1
