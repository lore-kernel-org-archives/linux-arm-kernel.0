From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Sep 2016 16:46:14 +0200
Subject: [PATCH v2 3/9] drm/sun4i: backend: Handle the SAT
In-Reply-To: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
Message-ID: <20160906144620.6322-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A33 has an block called SAT that is part of the backend that needs to
be clocked and out of reset to be able for the backend to operate properly.

Extend the binding to have the SAT resources listed, and claim them when
the backend probes.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../bindings/display/sunxi/sun4i-drm.txt           |  8 +++
 drivers/gpu/drm/sun4i/sun4i_backend.c              | 60 ++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h              |  3 ++
 3 files changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index bd3136a5cba5..d3529f72ca91 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -74,6 +74,14 @@ Required properties:
   Documentation/devicetree/bindings/media/video-interfaces.txt. The
   first port should be the input endpoints, the second one the output
 
+On the A33, some additional properties are required:
+  - reg needs to have an additional region corresponding to the SAT
+  - reg-names need to be set, with "be" and "sat"
+  - clocks and clock-names need to have a phandle to the SAT bus
+    clocks, whose name will be "sat"
+  - resets and reset-names need to have a phandle to the SAT bus
+    resets, whose name will be "sat"
+
 Display Engine Frontend
 -----------------------
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 9bfd2e45fceb..91a702225ded 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -217,6 +217,51 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 }
 EXPORT_SYMBOL(sun4i_backend_update_layer_buffer);
 
+static int sun4i_backend_init_sat(struct device *dev) {
+	struct sun4i_backend *backend = dev_get_drvdata(dev);
+	int ret;
+
+	backend->sat_reset = devm_reset_control_get(dev, "sat");
+	if (IS_ERR(backend->sat_reset)) {
+		dev_err(dev, "Couldn't get the SAT reset line\n");
+		return PTR_ERR(backend->sat_reset);
+	}
+
+	ret = reset_control_deassert(backend->sat_reset);
+	if (ret) {
+		dev_err(dev, "Couldn't deassert the SAT reset line\n");
+		return ret;
+	}
+
+	backend->sat_clk = devm_clk_get(dev, "sat");
+	if (IS_ERR(backend->sat_clk)) {
+		dev_err(dev, "Couldn't get our SAT clock\n");
+		ret = PTR_ERR(backend->sat_clk);
+		goto err_assert_reset;
+	}
+
+	ret = clk_prepare_enable(backend->sat_clk);
+	if (ret) {
+		dev_err(dev, "Couldn't enable the SAT clock\n");
+		return ret;
+	}
+
+	return 0;
+
+err_assert_reset:
+	reset_control_assert(backend->sat_reset);
+	return ret;
+}
+
+static int sun4i_backend_free_sat(struct device *dev) {
+	struct sun4i_backend *backend = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(backend->sat_clk);
+	reset_control_assert(backend->sat_reset);
+
+	return 0;
+}
+
 static struct regmap_config sun4i_backend_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -291,6 +336,15 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 	}
 	clk_prepare_enable(backend->ram_clk);
 
+	if (of_device_is_compatible(dev->of_node,
+				    "allwinner,sun8i-a33-display-backend")) {
+		ret = sun4i_backend_init_sat(dev);
+		if (ret) {
+			dev_err(dev, "Couldn't init SAT resources\n");
+			goto err_disable_ram_clk;
+		}
+	}
+
 	/* Reset the registers */
 	for (i = 0x800; i < 0x1000; i += 4)
 		regmap_write(backend->regs, i, 0);
@@ -306,6 +360,8 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 
 	return 0;
 
+err_disable_ram_clk:
+	clk_disable_unprepare(backend->ram_clk);
 err_disable_mod_clk:
 	clk_disable_unprepare(backend->mod_clk);
 err_disable_bus_clk:
@@ -320,6 +376,10 @@ static void sun4i_backend_unbind(struct device *dev, struct device *master,
 {
 	struct sun4i_backend *backend = dev_get_drvdata(dev);
 
+	if (of_device_is_compatible(dev->of_node,
+				    "allwinner,sun8i-a33-display-backend"))
+		sun4i_backend_free_sat(dev);
+
 	clk_disable_unprepare(backend->ram_clk);
 	clk_disable_unprepare(backend->mod_clk);
 	clk_disable_unprepare(backend->bus_clk);
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 7070bb3434e5..e00718627748 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -146,6 +146,9 @@ struct sun4i_backend {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
 	struct clk		*ram_clk;
+
+	struct clk		*sat_clk;
+	struct reset_control	*sat_reset;
 };
 
 void sun4i_backend_apply_color_correction(struct sun4i_backend *backend);
-- 
2.9.3
