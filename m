From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Jan 2018 08:48:53 +0100
Subject: [PATCH 3/4 v7] drm/bridge: Add timing support to dumb VGA DAC
In-Reply-To: <20180112074854.9560-1-linus.walleij@linaro.org>
References: <20180112074854.9560-1-linus.walleij@linaro.org>
Message-ID: <20180112074854.9560-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extends the dumb VGA DAC bridge to handle the THS8134A
and THS8134B VGA DACs in addition to those already handled.

We assign the proper timing data to the pointer inside the
bridge struct so display controllers that need to align their
timings to the bridge can pick it up and work from there.

Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v5->v6:
- Use DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE to indicate
  the sampling edge of the clock signal.
- Skip intermediate variable for timings.
- Leave timings as NULL for really dumb VGA DACs.
- Collect Laurent's Review tag.
ChangeLog v4->v5:
- Rewrite the support using the new concept of defining
  fine-granular sampling (setup+hold) timing definitions
  stored in the bridge timings struct.
ChangeLog v3->v4:
- Actually have the code syntactically correct and compiling :(
  (Kconfig mistake.)
  (...)
  AS      usr/initramfs_data.o
  AR      usr/built-in.o
  CC      drivers/gpu/drm/bridge/dumb-vga-dac.o
  AR      drivers/gpu/drm/bridge/built-in.o
  AR      drivers/gpu/drm/built-in.o
  AR      drivers/gpu/built-in.o
  AR      drivers/built-in.o
  (...)
ChangeLog v2->v3:
- Move const specifier.
- Cut one line of code assigning bus flags.
- Preserve the "ti,ths8135" compatible for elder device trees.
ChangeLog v1->v2:
- Alphabetize includes
- Use a u32 with the bus polarity flags and just encode the
  polarity using the DRM define directly.
- Rename vendor_data to vendor_info.
- Simplify assignment of the flag as it is just a simple
  u32 now.
- Probe all TI variants on the "ti,ths813x" wildcard for now,
  we only need to know that the device is in this family to
  set the clock edge flag right.
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 59 +++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index de5e7dee7ad6..498d5948d1a8 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 
@@ -204,6 +205,7 @@ static int dumb_vga_probe(struct platform_device *pdev)
 
 	vga->bridge.funcs = &dumb_vga_bridge_funcs;
 	vga->bridge.of_node = pdev->dev.of_node;
+	vga->bridge.timings = of_device_get_match_data(&pdev->dev);
 
 	drm_bridge_add(&vga->bridge);
 
@@ -222,10 +224,61 @@ static int dumb_vga_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * We assume the ADV7123 DAC is the "default" for historical reasons
+ * Information taken from the ADV7123 datasheet, revision D.
+ * NOTE: the ADV7123EP seems to have other timings and need a new timings
+ * set if used.
+ */
+static const struct drm_bridge_timings default_dac_timings = {
+	/* Timing specifications, datasheet page 7 */
+	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.setup_time_ps = 500,
+	.hold_time_ps = 1500,
+};
+
+/*
+ * Information taken from the THS8134, THS8134A, THS8134B datasheet named
+ * "SLVS205D", dated May 1990, revised March 2000.
+ */
+static const struct drm_bridge_timings ti_ths8134_dac_timings = {
+	/* From timing diagram, datasheet page 9 */
+	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	/* From datasheet, page 12 */
+	.setup_time_ps = 3000,
+	/* I guess this means latched input */
+	.hold_time_ps = 0,
+};
+
+/*
+ * Information taken from the THS8135 datasheet named "SLAS343B", dated
+ * May 2001, revised April 2013.
+ */
+static const struct drm_bridge_timings ti_ths8135_dac_timings = {
+	/* From timing diagram, datasheet page 14 */
+	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	/* From datasheet, page 16 */
+	.setup_time_ps = 2000,
+	.hold_time_ps = 500,
+};
+
 static const struct of_device_id dumb_vga_match[] = {
-	{ .compatible = "dumb-vga-dac" },
-	{ .compatible = "adi,adv7123" },
-	{ .compatible = "ti,ths8135" },
+	{
+		.compatible = "dumb-vga-dac",
+		.data = NULL,
+	},
+	{
+		.compatible = "adi,adv7123",
+		.data = &default_dac_timings,
+	},
+	{
+		.compatible = "ti,ths8135",
+		.data = &ti_ths8135_dac_timings,
+	},
+	{
+		.compatible = "ti,ths8134",
+		.data = &ti_ths8134_dac_timings,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dumb_vga_match);
-- 
2.14.3
