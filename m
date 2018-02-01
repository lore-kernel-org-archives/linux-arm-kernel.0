From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  1 Feb 2018 13:55:12 +0100
Subject: [PATCH 4/5 v2] drm/pl111: Support variants with broken VBLANK
In-Reply-To: <20180201125513.5482-1-linus.walleij@linaro.org>
References: <20180201125513.5482-1-linus.walleij@linaro.org>
Message-ID: <20180201125513.5482-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early Integrator CLCD synthesized in the Integrator CP and
IM-PD1 FPGAs are broken: their vertical and next base interrupts
are not functional. Support these variants by simply disabling
the use of the vblank interrupt on these variants.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_display.c   |  6 ++++--
 drivers/gpu/drm/pl111/pl111_drm.h       |  2 ++
 drivers/gpu/drm/pl111/pl111_drv.c       | 19 +++++++++++--------
 drivers/gpu/drm/pl111/pl111_versatile.c |  1 +
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 4d4e38b4c9d5..d75923896609 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -256,7 +256,8 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 	cntl |= CNTL_LCDPWR;
 	writel(cntl, priv->regs + priv->ctrl);
 
-	drm_crtc_vblank_on(crtc);
+	if (!priv->variant->broken_vblank)
+		drm_crtc_vblank_on(crtc);
 }
 
 void pl111_display_disable(struct drm_simple_display_pipe *pipe)
@@ -266,7 +267,8 @@ void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 	u32 cntl;
 
-	drm_crtc_vblank_off(crtc);
+	if (!priv->variant->broken_vblank)
+		drm_crtc_vblank_off(crtc);
 
 	/* Power Down */
 	cntl = readl(priv->regs + priv->ctrl);
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index f75c5d4645b2..d74076c6b7ef 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -40,6 +40,7 @@ struct drm_minor;
  *	BGR/RGB routing
  * @broken_clockdivider: the clock divider is broken and we need to
  *	use the supplied clock directly
+ * @broken_vblank: the vblank IRQ is broken on this variant
  * @formats: array of supported pixel formats on this variant
  * @nformats: the length of the array of supported pixel formats
  */
@@ -48,6 +49,7 @@ struct pl111_variant_data {
 	bool is_pl110;
 	bool external_bgr;
 	bool broken_clockdivider;
+	bool broken_vblank;
 	const u32 *formats;
 	unsigned int nformats;
 };
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 6967cd5428b2..e6fa897c740c 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -131,10 +131,12 @@ static int pl111_modeset_init(struct drm_device *dev)
 	if (ret)
 		return ret;
 
-	ret = drm_vblank_init(dev, 1);
-	if (ret != 0) {
-		dev_err(dev->dev, "Failed to init vblank\n");
-		goto out_bridge;
+	if (!priv->variant->broken_vblank) {
+		ret = drm_vblank_init(dev, 1);
+		if (ret != 0) {
+			dev_err(dev->dev, "Failed to init vblank\n");
+			goto out_bridge;
+		}
 	}
 
 	drm_mode_config_reset(dev);
@@ -184,10 +186,6 @@ static struct drm_driver pl111_drm_driver = {
 	.dumb_create = drm_gem_cma_dumb_create,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops = &drm_gem_cma_vm_ops,
-
-	.enable_vblank = pl111_enable_vblank,
-	.disable_vblank = pl111_disable_vblank,
-
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_import = drm_gem_prime_import,
@@ -213,6 +211,11 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	if (!priv)
 		return -ENOMEM;
 
+	if (!variant->broken_vblank) {
+		pl111_drm_driver.enable_vblank = pl111_enable_vblank;
+		pl111_drm_driver.disable_vblank = pl111_disable_vblank;
+	}
+
 	drm = drm_dev_alloc(&pl111_drm_driver, dev);
 	if (IS_ERR(drm))
 		return PTR_ERR(drm);
diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 0f228543a97c..26427b838b2c 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -238,6 +238,7 @@ static const struct pl111_variant_data pl110_integrator = {
 	.name = "PL110 Integrator",
 	.is_pl110 = true,
 	.broken_clockdivider = true,
+	.broken_vblank = true,
 	.formats = pl110_integrator_pixel_formats,
 	.nformats = ARRAY_SIZE(pl110_integrator_pixel_formats),
 };
-- 
2.14.3
