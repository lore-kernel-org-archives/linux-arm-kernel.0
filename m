From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  1 Feb 2018 13:55:11 +0100
Subject: [PATCH 3/5 v2] drm/pl111: Support variants with broken clock divider
In-Reply-To: <20180201125513.5482-1-linus.walleij@linaro.org>
References: <20180201125513.5482-1-linus.walleij@linaro.org>
Message-ID: <20180201125513.5482-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early Integrator CLCD synthesized in the Integrator CP and
IM-PD1 FPGAs are broken: their clock dividers do not work
properly. Support disabling the clock divider and drive the
clock directly from the parent under these circumstances.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_display.c   | 8 ++++++++
 drivers/gpu/drm/pl111/pl111_drm.h       | 3 +++
 drivers/gpu/drm/pl111/pl111_versatile.c | 1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 55ada00ec974..4d4e38b4c9d5 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -138,6 +138,9 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 	tim2 = readl(priv->regs + CLCD_TIM2);
 	tim2 &= (TIM2_BCD | TIM2_PCD_LO_MASK | TIM2_PCD_HI_MASK);
 
+	if (priv->variant->broken_clockdivider)
+		tim2 |= TIM2_BCD;
+
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
 		tim2 |= TIM2_IHS;
 
@@ -455,6 +458,11 @@ pl111_init_clock_divider(struct drm_device *drm)
 		dev_err(drm->dev, "CLCD: unable to get clcdclk.\n");
 		return PTR_ERR(parent);
 	}
+	/* If the clock divider is broken, use the parent directly */
+	if (priv->variant->broken_clockdivider) {
+		priv->clk = parent;
+		return 0;
+	}
 	parent_name = __clk_get_name(parent);
 
 	spin_lock_init(&priv->tim2_lock);
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index c2f410f0b12e..f75c5d4645b2 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -38,6 +38,8 @@ struct drm_minor;
  * @is_pl110: this is the early PL110 variant
  * @external_bgr: this is the Versatile Pl110 variant with external
  *	BGR/RGB routing
+ * @broken_clockdivider: the clock divider is broken and we need to
+ *	use the supplied clock directly
  * @formats: array of supported pixel formats on this variant
  * @nformats: the length of the array of supported pixel formats
  */
@@ -45,6 +47,7 @@ struct pl111_variant_data {
 	const char *name;
 	bool is_pl110;
 	bool external_bgr;
+	bool broken_clockdivider;
 	const u32 *formats;
 	unsigned int nformats;
 };
diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 893d527fb42f..0f228543a97c 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -237,6 +237,7 @@ static const u32 pl110_versatile_pixel_formats[] = {
 static const struct pl111_variant_data pl110_integrator = {
 	.name = "PL110 Integrator",
 	.is_pl110 = true,
+	.broken_clockdivider = true,
 	.formats = pl110_integrator_pixel_formats,
 	.nformats = ARRAY_SIZE(pl110_integrator_pixel_formats),
 };
-- 
2.14.3
