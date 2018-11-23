From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:56 +0100
Subject: [PATCH v2 24/43] drm/sun4i: frontend: Configure and enable YUV to RGB
 CSC when needed
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-25-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In prevision of adding support for YUV formats, set the YUV to RGB
colorspace conversion coefficients if required and don't bypass the
CSC engine when converting.

The BT601 coefficients from the A33 BSP are copied over from the backend
code. Because of module inter-dependency, we can't have the frontend use
these coefficients from the backend directly.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 39 ++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 ++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 7fa8fb3eb7aa..5626334c6e87 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -48,6 +48,28 @@ static const u32 sun4i_frontend_horz_coef[64] = {
 	0x03ff0000, 0x0000fd41, 0x01ff0000, 0x0000fe42,
 };
 
+/*
+ * These coefficients are taken from the A33 BSP from Allwinner.
+ *
+ * The first three values of each row are coded as 13-bit signed fixed-point
+ * numbers, with 10 bits for the fractional part. The fourth value is a
+ * constant coded as a 14-bit signed fixed-point number with 4 bits for the
+ * fractional part.
+ *
+ * The values in table order give the following colorspace translation:
+ * G = 1.164 * Y - 0.391 * U - 0.813 * V + 135
+ * R = 1.164 * Y + 1.596 * V - 222
+ * B = 1.164 * Y + 2.018 * U + 276
+ *
+ * This seems to be a conversion from Y[16:235] UV[16:240] to RGB[0:255],
+ * following the BT601 spec.
+ */
+static const u32 sunxi_bt601_yuv2rgb_coef[12] = {
+	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
+	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
+	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
+};
+
 static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 {
 	int i;
@@ -181,6 +203,8 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	uint32_t format = fb->format->format;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
+	unsigned int i;
+	u32 bypass;
 	int ret;
 
 	ret = sun4i_frontend_drm_format_to_input_fmt(format, &in_fmt_val);
@@ -218,9 +242,20 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG, 0x400);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG, 0x400);
 
+	if (fb->format->is_yuv && !drm_format_is_yuv(out_fmt)) {
+		/* Setup the CSC engine for YUV to RGB conversion. */
+		bypass = 0;
+
+		for (i = 0; i < ARRAY_SIZE(sunxi_bt601_yuv2rgb_coef); i++)
+			regmap_write(frontend->regs,
+				     SUN4I_FRONTEND_CSC_COEF_REG(i),
+				     sunxi_bt601_yuv2rgb_coef[i]);
+	} else {
+		bypass = SUN4I_FRONTEND_BYPASS_CSC_EN;
+	}
+
 	regmap_update_bits(frontend->regs, SUN4I_FRONTEND_BYPASS_REG,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN);
+			   SUN4I_FRONTEND_BYPASS_CSC_EN, bypass);
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_INPUT_FMT_REG,
 		     in_mod_val | in_fmt_val | in_ps_val);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 800a193eebc2..fb097c34e160 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -35,6 +35,8 @@
 #define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_BGRX8888	1
 #define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_XRGB8888	2
 
+#define SUN4I_FRONTEND_CSC_COEF_REG(c)		(0x070 + (0x4 * (c)))
+
 #define SUN4I_FRONTEND_CH0_INSIZE_REG		0x100
 #define SUN4I_FRONTEND_INSIZE(h, w)			((((h) - 1) << 16) | (((w) - 1)))
 
-- 
2.19.1
