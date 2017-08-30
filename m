From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 Aug 2017 20:07:08 +0200
Subject: [PATCH 4/7] drm/pl111: Enable PL110 variant
In-Reply-To: <20170830180711.2791-1-linus.walleij@linaro.org>
References: <20170830180711.2791-1-linus.walleij@linaro.org>
Message-ID: <20170830180711.2791-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We detect and enable the use of the PL110 variant, an earlier
incarnation of PL111. The only real difference is that the
control and interrupt enable registers have swapped place.
The Versatile AB and Versatile PB have a variant inbetween
PL110 and PL111, it is PL110 but they have already swapped the
two registers so those two need a bit of special handling.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_display.c | 27 +++--------
 drivers/gpu/drm/pl111/pl111_drm.h     | 17 +++++++
 drivers/gpu/drm/pl111/pl111_drv.c     | 84 ++++++++++++++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index ef86ef60aed1..6447f36c243a 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -201,7 +201,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		break;
 	}
 
-	writel(cntl, priv->regs + CLCD_PL111_CNTL);
+	writel(cntl, priv->regs + priv->ctrl);
 
 	drm_panel_enable(priv->panel);
 
@@ -219,7 +219,7 @@ void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 	drm_panel_disable(priv->panel);
 
 	/* Disable and Power Down */
-	writel(0, priv->regs + CLCD_PL111_CNTL);
+	writel(0, priv->regs + priv->ctrl);
 
 	drm_panel_unprepare(priv->panel);
 
@@ -259,7 +259,7 @@ int pl111_enable_vblank(struct drm_device *drm, unsigned int crtc)
 {
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
-	writel(CLCD_IRQ_NEXTBASE_UPDATE, priv->regs + CLCD_PL111_IENB);
+	writel(CLCD_IRQ_NEXTBASE_UPDATE, priv->regs + priv->ienb);
 
 	return 0;
 }
@@ -268,7 +268,7 @@ void pl111_disable_vblank(struct drm_device *drm, unsigned int crtc)
 {
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
-	writel(0, priv->regs + CLCD_PL111_IENB);
+	writel(0, priv->regs + priv->ienb);
 }
 
 static int pl111_display_prepare_fb(struct drm_simple_display_pipe *pipe,
@@ -412,22 +412,6 @@ int pl111_display_init(struct drm_device *drm)
 	struct device_node *endpoint;
 	u32 tft_r0b0g0[3];
 	int ret;
-	static const u32 formats[] = {
-		DRM_FORMAT_ABGR8888,
-		DRM_FORMAT_XBGR8888,
-		DRM_FORMAT_ARGB8888,
-		DRM_FORMAT_XRGB8888,
-		DRM_FORMAT_BGR565,
-		DRM_FORMAT_RGB565,
-		DRM_FORMAT_ABGR1555,
-		DRM_FORMAT_XBGR1555,
-		DRM_FORMAT_ARGB1555,
-		DRM_FORMAT_XRGB1555,
-		DRM_FORMAT_ABGR4444,
-		DRM_FORMAT_XBGR4444,
-		DRM_FORMAT_ARGB4444,
-		DRM_FORMAT_XRGB4444,
-	};
 
 	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
 	if (!endpoint)
@@ -456,7 +440,8 @@ int pl111_display_init(struct drm_device *drm)
 
 	ret = drm_simple_display_pipe_init(drm, &priv->pipe,
 					   &pl111_display_funcs,
-					   formats, ARRAY_SIZE(formats),
+					   priv->variant->formats,
+					   priv->variant->nformats,
 					   priv->connector);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 8804af0f8997..b316a8a0fbc0 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -31,6 +31,20 @@
 
 struct drm_minor;
 
+/**
+ * struct pl111_variant_data - encodes IP differences
+ * @name: the name of this variant
+ * @is_pl110: this is the early PL110 variant
+ * @formats: array of supported pixel formats on this variant
+ * @nformats: the length of the array of supported pixel formats
+ */
+struct pl111_variant_data {
+	const char *name;
+	bool is_pl110;
+	const u32 *formats;
+	unsigned int nformats;
+};
+
 struct pl111_drm_dev_private {
 	struct drm_device *drm;
 
@@ -42,6 +56,8 @@ struct pl111_drm_dev_private {
 	struct drm_fbdev_cma *fbdev;
 
 	void *regs;
+	u32 ienb;
+	u32 ctrl;
 	/* The pixel clock (a reference to our clock divider off of CLCDCLK). */
 	struct clk *clk;
 	/* pl111's internal clock divider. */
@@ -50,6 +66,7 @@ struct pl111_drm_dev_private {
 	 * subsystem and pl111_display_enable().
 	 */
 	spinlock_t tim2_lock;
+	struct pl111_variant_data *variant;
 };
 
 int pl111_display_init(struct drm_device *dev);
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index e66cbf202e17..f6863c0fb809 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -206,6 +206,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 {
 	struct device *dev = &amba_dev->dev;
 	struct pl111_drm_dev_private *priv;
+	struct pl111_variant_data *variant = id->data;
 	struct drm_device *drm;
 	int ret;
 
@@ -219,6 +220,33 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	amba_set_drvdata(amba_dev, drm);
 	priv->drm = drm;
 	drm->dev_private = priv;
+	priv->variant = variant;
+
+	/*
+	 * The PL110 and PL111 variants have two registers
+	 * swapped: interrupt enable and control. For this reason
+	 * we use offsets that we can change per variant.
+	 */
+	if (variant->is_pl110) {
+		/*
+		 * The ARM Versatile boards are even more special:
+		 * their PrimeCell ID say they are PL110 but the
+		 * control and interrupt enable registers are anyway
+		 * swapped to the PL111 order so they are not following
+		 * the PL110 datasheet.
+		 */
+		if (of_machine_is_compatible("arm,versatile-ab") ||
+		    of_machine_is_compatible("arm,versatile-pb")) {
+			priv->ienb = CLCD_PL111_IENB;
+			priv->ctrl = CLCD_PL111_CNTL;
+		} else {
+			priv->ienb = CLCD_PL110_IENB;
+			priv->ctrl = CLCD_PL110_CNTL;
+		}
+	} else {
+		priv->ienb = CLCD_PL111_IENB;
+		priv->ctrl = CLCD_PL111_CNTL;
+	}
 
 	priv->regs = devm_ioremap_resource(dev, &amba_dev->res);
 	if (IS_ERR(priv->regs)) {
@@ -227,10 +255,10 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	}
 
 	/* turn off interrupts before requesting the irq */
-	writel(0, priv->regs + CLCD_PL111_IENB);
+	writel(0, priv->regs + priv->ienb);
 
 	ret = devm_request_irq(dev, amba_dev->irq[0], pl111_irq, 0,
-			       "pl111", priv);
+			       variant->name, priv);
 	if (ret != 0) {
 		dev_err(dev, "%s failed irq %d\n", __func__, ret);
 		return ret;
@@ -269,10 +297,62 @@ static int pl111_amba_remove(struct amba_device *amba_dev)
 	return 0;
 }
 
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
+struct pl111_variant_data pl110_variant = {
+	.name = "PL110",
+	.is_pl110 = true,
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
+struct pl111_variant_data pl111_variant = {
+	.name = "PL111",
+	.formats = pl111_pixel_formats,
+	.nformats = ARRAY_SIZE(pl111_pixel_formats),
+};
+
 static struct amba_id pl111_id_table[] = {
 	{
+		.id = 0x00041110,
+		.mask = 0x000fffff,
+		.data = &pl110_variant,
+	},
+	{
 		.id = 0x00041111,
 		.mask = 0x000fffff,
+		.data = &pl111_variant,
 	},
 	{0, 0},
 };
-- 
2.13.5
