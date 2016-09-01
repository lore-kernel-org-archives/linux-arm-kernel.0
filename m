From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Sep 2016 17:32:00 +0200
Subject: [PATCH 3/7] drm/sun4i: Add SAT and DRC drivers
In-Reply-To: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
Message-ID: <20160901153204.11217-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A33 pipeline also has some new components called SAT and DRC. Even
though their exact features and programming model is not known (or
documented), they need to be clocked for the pipeline to carry the video
signal all the way.

Add minimal drivers for those that just claim the needed resources for the
pipeline to operate properly.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../bindings/display/sunxi/sun4i-drm.txt           |  37 +++++++
 drivers/gpu/drm/sun4i/Makefile                     |   3 +-
 drivers/gpu/drm/sun4i/sun6i_drc.c                  | 117 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_sat.c                  | 105 ++++++++++++++++++
 4 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_drc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_sat.c

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index d467ea93ac08..87c3c8dd34cb 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -51,6 +51,43 @@ Required properties:
   second the block connected to the TCON channel 1 (usually the TV
   encoder)
 
+SAT
+---
+
+The SAT, found in the A33, allows to do some color correction.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun8i-a33-sat
+  - reg: base address and size of the memory-mapped region.
+  - clock: phandles to bus clock feeding the SAT
+  - resets: phandles to the reset line driving the SAT
+
+- ports: A ports node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt. The
+  first port should be the input endpoints, the second one the outputs
+
+DRC
+---
+
+The DRC, found in the latest Allwinner SoCs (A31, A23, A33), allows to
+do some backlight control to enhance the power consumption.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun8i-a33-drc
+  - reg: base address and size of the memory-mapped region.
+  - interrupts: interrupt associated to this IP
+  - clocks: phandles to the clocks feeding the DRC
+    * ahb: the DRC interface clock
+    * mod: the DRC module clock
+    * ram: the DRC DRAM clock
+  - clock-names: the clock names mentioned above
+  - resets: phandles to the reset line driving the DRC
+
+- ports: A ports node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt. The
+  first port should be the input endpoints, the second one the outputs
 
 Display Engine Backend
 ----------------------
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 58cd55149827..f1d208941a43 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -9,5 +9,6 @@ sun4i-tcon-y += sun4i_dotclock.o
 
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_backend.o
-
+obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
+obj-$(CONFIG_DRM_SUN4I)		+= sun8i_sat.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
diff --git a/drivers/gpu/drm/sun4i/sun6i_drc.c b/drivers/gpu/drm/sun4i/sun6i_drc.c
new file mode 100644
index 000000000000..93ded536876b
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun6i_drc.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2016 Free Electrons
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+struct sun6i_drc {
+	struct clk		*bus_clk;
+	struct clk		*mod_clk;
+	struct reset_control	*reset;
+};
+
+static int sun6i_drc_bind(struct device *dev, struct device *master,
+			 void *data)
+{
+	struct sun6i_drc *drc;
+	int ret;
+
+	drc = devm_kzalloc(dev, sizeof(*drc), GFP_KERNEL);
+	if (!drc)
+		return -ENOMEM;
+	dev_set_drvdata(dev, drc);
+
+	drc->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(drc->reset)) {
+		dev_err(dev, "Couldn't get our reset line\n");
+		return PTR_ERR(drc->reset);
+	}
+
+	ret = reset_control_deassert(drc->reset);
+	if (ret) {
+		dev_err(dev, "Couldn't deassert our reset line\n");
+		return ret;
+	}
+
+	drc->bus_clk = devm_clk_get(dev, "ahb");
+	if (IS_ERR(drc->bus_clk)) {
+		dev_err(dev, "Couldn't get our bus clock\n");
+		ret = PTR_ERR(drc->bus_clk);
+		goto err_assert_reset;
+	}
+	clk_prepare_enable(drc->bus_clk);
+
+	drc->mod_clk = devm_clk_get(dev, "mod");
+	if (IS_ERR(drc->mod_clk)) {
+		dev_err(dev, "Couldn't get our mod clock\n");
+		ret = PTR_ERR(drc->mod_clk);
+		goto err_disable_bus_clk;
+	}
+
+	return clk_prepare_enable(drc->mod_clk);
+
+err_disable_bus_clk:
+	clk_disable_unprepare(drc->bus_clk);
+err_assert_reset:
+	reset_control_assert(drc->reset);
+	return ret;
+}
+
+static void sun6i_drc_unbind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct sun6i_drc *drc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(drc->mod_clk);
+	clk_disable_unprepare(drc->bus_clk);
+	reset_control_assert(drc->reset);
+}
+
+static struct component_ops sun6i_drc_ops = {
+	.bind	= sun6i_drc_bind,
+	.unbind	= sun6i_drc_unbind,
+};
+
+static int sun6i_drc_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &sun6i_drc_ops);
+}
+
+static int sun6i_drc_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &sun6i_drc_ops);
+
+	return 0;
+}
+
+static const struct of_device_id sun6i_drc_of_table[] = {
+	{ .compatible = "allwinner,sun8i-a33-drc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun6i_drc_of_table);
+
+static struct platform_driver sun6i_drc_platform_driver = {
+	.probe		= sun6i_drc_probe,
+	.remove		= sun6i_drc_remove,
+	.driver		= {
+		.name		= "sun6i-drc",
+		.of_match_table	= sun6i_drc_of_table,
+	},
+};
+module_platform_driver(sun6i_drc_platform_driver);
+
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_DESCRIPTION("Allwinner A31 Dynamic Range Control (DRC) Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sun4i/sun8i_sat.c b/drivers/gpu/drm/sun4i/sun8i_sat.c
new file mode 100644
index 000000000000..fdf07ecbcd49
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_sat.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2016 Free Electrons
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+struct sun8i_sat {
+	struct clk		*clk;
+	struct reset_control	*reset;
+};
+
+static int sun8i_sat_bind(struct device *dev, struct device *master,
+			 void *data)
+{
+	struct sun8i_sat *sat;
+	int ret;
+
+	sat = devm_kzalloc(dev, sizeof(*sat), GFP_KERNEL);
+	if (!sat)
+		return -ENOMEM;
+	dev_set_drvdata(dev, sat);
+
+	sat->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(sat->reset)) {
+		dev_err(dev, "Couldn't get our reset line\n");
+		return PTR_ERR(sat->reset);
+	}
+
+	ret = reset_control_deassert(sat->reset);
+	if (ret) {
+		dev_err(dev, "Couldn't deassert our reset line\n");
+		return ret;
+	}
+
+	sat->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(sat->clk)) {
+		dev_err(dev, "Couldn't get our clock clock\n");
+		ret = PTR_ERR(sat->clk);
+		goto err_assert_reset;
+	}
+
+	return clk_prepare_enable(sat->clk);
+
+err_assert_reset:
+	reset_control_assert(sat->reset);
+	return ret;
+}
+
+static void sun8i_sat_unbind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct sun8i_sat *sat = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(sat->clk);
+	reset_control_assert(sat->reset);
+}
+
+static struct component_ops sun8i_sat_ops = {
+	.bind	= sun8i_sat_bind,
+	.unbind	= sun8i_sat_unbind,
+};
+
+static int sun8i_sat_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &sun8i_sat_ops);
+}
+
+static int sun8i_sat_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &sun8i_sat_ops);
+
+	return 0;
+}
+
+static const struct of_device_id sun8i_sat_of_table[] = {
+	{ .compatible = "allwinner,sun8i-a33-sat" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun8i_sat_of_table);
+
+static struct platform_driver sun8i_sat_platform_driver = {
+	.probe		= sun8i_sat_probe,
+	.remove		= sun8i_sat_remove,
+	.driver		= {
+		.name		= "sun8i-sat",
+		.of_match_table	= sun8i_sat_of_table,
+	},
+};
+module_platform_driver(sun8i_sat_platform_driver);
+
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_DESCRIPTION("Allwinner A33 Saturation Enhancement (SAT) Driver");
+MODULE_LICENSE("GPL");
-- 
2.9.2
