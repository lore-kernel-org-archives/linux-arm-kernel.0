From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Jan 2018 14:20:31 +0100
Subject: [PATCH 2/4] drm/pl111: Properly detect the PL110+ variant
In-Reply-To: <20180126132033.19744-1-linus.walleij@linaro.org>
References: <20180126132033.19744-1-linus.walleij@linaro.org>
Message-ID: <20180126132033.19744-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a bit of refactoring we can contain the variant data for
the "PL110+" version that is somewhere inbetween PL110 and PL111.
This is used on the ARM Versatile AB and Versatile PB.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_drm.h |   2 +
 drivers/gpu/drm/pl111/pl111_drv.c | 106 +++++++++++++++++++++-----------------
 2 files changed, 60 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 440f53ebee8c..9cc0d424ff16 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -36,12 +36,14 @@ struct drm_minor;
  * struct pl111_variant_data - encodes IP differences
  * @name: the name of this variant
  * @is_pl110: this is the early PL110 variant
+ * @is_pl110_plus: this is the Versatile Pl110+ variant
  * @formats: array of supported pixel formats on this variant
  * @nformats: the length of the array of supported pixel formats
  */
 struct pl111_variant_data {
 	const char *name;
 	bool is_pl110;
+	bool is_pl110_plus;
 	const u32 *formats;
 	unsigned int nformats;
 };
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 31a0c4268cc6..8da75089dc59 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -200,12 +200,67 @@ static struct drm_driver pl111_drm_driver = {
 #endif
 };
 
+/*
+ * This variant exist in early versions like the ARM Integrator
+ * and this version lacks the 565 and 444 pixel formats.
+ */
+static const u32 pl110_pixel_formats[] = {
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_XRGB1555,
+};
+
+static const struct pl111_variant_data pl110_variant = {
+	.name = "PL110",
+	.is_pl110 = true,
+	.formats = pl110_pixel_formats,
+	.nformats = ARRAY_SIZE(pl110_pixel_formats),
+};
+
+/* This is the in-between PL110+ variant found in the ARM Versatile */
+static const struct pl111_variant_data pl110_plus_variant = {
+	.name = "PL110+",
+	.is_pl110 = true,
+	.is_pl110_plus = true,
+	.formats = pl110_pixel_formats,
+	.nformats = ARRAY_SIZE(pl110_pixel_formats),
+};
+
+/* RealView, Versatile Express etc use this modern variant */
+static const u32 pl111_pixel_formats[] = {
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_XBGR4444,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_XRGB4444,
+};
+
+static const struct pl111_variant_data pl111_variant = {
+	.name = "PL111",
+	.formats = pl111_pixel_formats,
+	.nformats = ARRAY_SIZE(pl111_pixel_formats),
+};
+
 static int pl111_amba_probe(struct amba_device *amba_dev,
 			    const struct amba_id *id)
 {
 	struct device *dev = &amba_dev->dev;
 	struct pl111_drm_dev_private *priv;
-	struct pl111_variant_data *variant = id->data;
+	const struct pl111_variant_data *variant = id->data;
 	struct drm_device *drm;
 	int ret;
 
@@ -219,7 +274,6 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	amba_set_drvdata(amba_dev, drm);
 	priv->drm = drm;
 	drm->dev_private = priv;
-	priv->variant = variant;
 
 	/*
 	 * The PL110 and PL111 variants have two registers
@@ -236,6 +290,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 		 */
 		if (of_machine_is_compatible("arm,versatile-ab") ||
 		    of_machine_is_compatible("arm,versatile-pb")) {
+			variant = &pl110_plus_variant;
 			priv->ienb = CLCD_PL111_IENB;
 			priv->ctrl = CLCD_PL111_CNTL;
 		} else {
@@ -246,6 +301,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 		priv->ienb = CLCD_PL111_IENB;
 		priv->ctrl = CLCD_PL111_CNTL;
 	}
+	priv->variant = variant;
 
 	priv->regs = devm_ioremap_resource(dev, &amba_dev->res);
 	if (IS_ERR(priv->regs)) {
@@ -298,52 +354,6 @@ static int pl111_amba_remove(struct amba_device *amba_dev)
 	return 0;
 }
 
-/*
- * This variant exist in early versions like the ARM Integrator
- * and this version lacks the 565 and 444 pixel formats.
- */
-static const u32 pl110_pixel_formats[] = {
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ABGR1555,
-	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
-	DRM_FORMAT_XRGB1555,
-};
-
-static const struct pl111_variant_data pl110_variant = {
-	.name = "PL110",
-	.is_pl110 = true,
-	.formats = pl110_pixel_formats,
-	.nformats = ARRAY_SIZE(pl110_pixel_formats),
-};
-
-/* RealView, Versatile Express etc use this modern variant */
-static const u32 pl111_pixel_formats[] = {
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_BGR565,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_ABGR1555,
-	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
-	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_ABGR4444,
-	DRM_FORMAT_XBGR4444,
-	DRM_FORMAT_ARGB4444,
-	DRM_FORMAT_XRGB4444,
-};
-
-static const struct pl111_variant_data pl111_variant = {
-	.name = "PL111",
-	.formats = pl111_pixel_formats,
-	.nformats = ARRAY_SIZE(pl111_pixel_formats),
-};
-
 static const struct amba_id pl111_id_table[] = {
 	{
 		.id = 0x00041110,
-- 
2.14.3
