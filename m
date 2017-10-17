From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Oct 2017 12:19:04 +0200
Subject: [PATCH 2/2 v2] drm: bridge: Add THS8134A/B support to dumb VGA DAC
In-Reply-To: <20171017101904.22308-1-linus.walleij@linaro.org>
References: <20171017101904.22308-1-linus.walleij@linaro.org>
Message-ID: <20171017101904.22308-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extends the dumb VGA DAC bridge to handle the THS8134A
and THS8134B VGA DACs in addition to those already handled.

The THS8134A, THS8134B and as it turns out also THS8135 need to
have data clocked out at the negative edge of the clock pulse,
since they clock it into the DAC at the positive edge (so by
then it needs to be stable) so we need some extra logic to flag
this on the connector to the driver.

The semantics of the flag DRM_BUS_FLAG_PIXDATA_NEGEDGE in
<drm/drm_connector.h> clearly indicates that this flag tells
when to *drive* the data, not when the receiver *reads* it,
so the TI variants needs to be handled like this.

Introduce a variant struct and contain the information there,
and add a bit of helpful comments about how this works so
people will get it right when adding new DACs or connectiong
new display drivers to DACs.

The fact that THS8135 might be working on some systems today
is probably due to the fact that the display driver cannot
configure when the data is clocked out and the electronics
have simply been designed around it so it works anyways.

The phenomenon is very real on the ARM reference designs using
PL111 where the hardware can control which edge to push out
the data.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 51 ++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 831a606c4706..9cd19e4c33c9 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 
@@ -19,9 +20,18 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 
+/**
+ * struct vga_dac_info - characteristics of the DAC
+ * @clk_edge_latch: this defines the clock edge latch for the variant
+ */
+struct vga_dac_info {
+	u32 clk_edge_latch;
+};
+
 struct dumb_vga {
 	struct drm_bridge	bridge;
 	struct drm_connector	connector;
+	struct vga_dac_info const *variant;
 
 	struct i2c_adapter	*ddc;
 	struct regulator	*vdd;
@@ -55,7 +65,9 @@ static int dumb_vga_get_modes(struct drm_connector *connector)
 	}
 
 	drm_mode_connector_update_edid_property(connector, edid);
-	return drm_add_edid_modes(connector, edid);
+	ret = drm_add_edid_modes(connector, edid);
+	connector->display_info.bus_flags |= vga->variant->clk_edge_latch;
+	return ret;
 
 fallback:
 	/*
@@ -67,6 +79,8 @@ static int dumb_vga_get_modes(struct drm_connector *connector)
 	/* And prefer a mode pretty much anyone can handle */
 	drm_set_preferred_mode(connector, 1024, 768);
 
+	connector->display_info.bus_flags |= vga->variant->clk_edge_latch;
+
 	return ret;
 }
 
@@ -183,6 +197,7 @@ static int dumb_vga_probe(struct platform_device *pdev)
 	if (!vga)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, vga);
+	vga->variant = of_device_get_match_data(&pdev->dev);
 
 	vga->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
 	if (IS_ERR(vga->vdd)) {
@@ -226,10 +241,38 @@ static int dumb_vga_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct vga_dac_info default_dac_variant = {
+	/*
+	 * These DACs read data on the negative edge. For example in the
+	 * ADV7123 datasheet (revision D, page 8) there is a timing diagram
+	 * making this clear. So consequently we need to latch the data
+	 * on the positive edge.
+	 */
+	.clk_edge_latch = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+};
+
+static const struct vga_dac_info ti_ths_dac_variant = {
+	/*
+	 * The TI DACs read the data on the positive edge of the CLK,
+	 * so consequently we need to latch the data on the negative
+	 * edge.
+	 */
+	.clk_edge_latch = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
+};
+
 static const struct of_device_id dumb_vga_match[] = {
-	{ .compatible = "dumb-vga-dac" },
-	{ .compatible = "adi,adv7123" },
-	{ .compatible = "ti,ths8135" },
+	{
+		.compatible = "dumb-vga-dac",
+		.data = &default_dac_variant,
+	},
+	{
+		.compatible = "adi,adv7123",
+		.data = &default_dac_variant,
+	},
+	{
+		.compatible = "ti,ths813x",
+		.data = &ti_ths_dac_variant,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dumb_vga_match);
-- 
2.13.5
