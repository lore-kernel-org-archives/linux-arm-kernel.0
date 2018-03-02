From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  2 Mar 2018 10:09:48 +0100
Subject: [PATCH 4/4] drm/pl111: Support the Versatile Express
In-Reply-To: <20180302090948.6399-1-linus.walleij@linaro.org>
References: <20180302090948.6399-1-linus.walleij@linaro.org>
Message-ID: <20180302090948.6399-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Express uses a special configuration controller
deeply embedded in the system motherboard FPGA to multiplex the
two to three (!) CLCD instances out to the single SiI9022
bridge.

Set up an extra file with the logic to probe to the FPGA mux
register on the system controller bus, then parse the memory
range argument to figure out what path the CLCD signal is
actually taking, and set up the mux accordingly.

If there is a CLCD instance on the core tile (the daughterboard
with the CPUs fitted) then that CLCD instance will take
precedence since it can address all memory.

Scale down the Versatile Express to 16BPP so we can support a
1024x768 display despite the bus bandwidth restrictions on this
platform.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/Makefile          |   1 +
 drivers/gpu/drm/pl111/pl111_drm.h       |   3 +-
 drivers/gpu/drm/pl111/pl111_versatile.c |  48 ++++++++++++++-
 drivers/gpu/drm/pl111/pl111_vexpress.c  | 106 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/pl111/pl111_vexpress.h  |  22 +++++++
 5 files changed, 178 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/pl111/pl111_vexpress.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_vexpress.h

diff --git a/drivers/gpu/drm/pl111/Makefile b/drivers/gpu/drm/pl111/Makefile
index 9c5e8dba8ac6..19a8189dc54f 100644
--- a/drivers/gpu/drm/pl111/Makefile
+++ b/drivers/gpu/drm/pl111/Makefile
@@ -3,6 +3,7 @@ pl111_drm-y +=	pl111_display.o \
 		pl111_versatile.o \
 		pl111_drv.o
 
+pl111_drm-$(CONFIG_ARCH_VEXPRESS) += pl111_vexpress.o
 pl111_drm-$(CONFIG_DEBUG_FS) += pl111_debugfs.o
 
 obj-$(CONFIG_DRM_PL111) += pl111_drm.o
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 70b092670c04..e7c5d4a09238 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -64,7 +64,8 @@ struct pl111_drm_dev_private {
 	struct drm_bridge *bridge;
 	struct drm_simple_display_pipe pipe;
 
-	void *regs;
+	void __iomem *clcd_memory;
+	void __iomem *regs;
 	u32 memory_bw;
 	u32 ienb;
 	u32 ctrl;
diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index f15391d994b6..0170c34fb653 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -1,12 +1,14 @@
 #include <linux/amba/clcd-regs.h>
 #include <linux/device.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
 #include <drm/drmP.h>
 #include "pl111_versatile.h"
+#include "pl111_vexpress.h"
 #include "pl111_drm.h"
 
 static struct regmap *versatile_syscon_map;
@@ -22,6 +24,7 @@ enum versatile_clcd {
 	REALVIEW_CLCD_PB11MP,
 	REALVIEW_CLCD_PBA8,
 	REALVIEW_CLCD_PBX,
+	VEXPRESS_CLCD_V2M,
 };
 
 static const struct of_device_id versatile_clcd_of_match[] = {
@@ -53,6 +56,10 @@ static const struct of_device_id versatile_clcd_of_match[] = {
 		.compatible = "arm,realview-pbx-syscon",
 		.data = (void *)REALVIEW_CLCD_PBX,
 	},
+	{
+		.compatible = "arm,vexpress-muxfpga",
+		.data = (void *)VEXPRESS_CLCD_V2M,
+	},
 	{},
 };
 
@@ -286,12 +293,26 @@ static const struct pl111_variant_data pl111_realview = {
 	.fb_bpp = 16,
 };
 
+/*
+ * Versatile Express PL111 variant, again we just push the maximum
+ * BPP to 16 to be able to get 1024x768 without saturating the memory
+ * bus. The clockdivider also seems broken on the Versatile Express.
+ */
+static const struct pl111_variant_data pl111_vexpress = {
+	.name = "PL111 Versatile Express",
+	.formats = pl111_realview_pixel_formats,
+	.nformats = ARRAY_SIZE(pl111_realview_pixel_formats),
+	.fb_bpp = 16,
+	.broken_clockdivider = true,
+};
+
 int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 {
 	const struct of_device_id *clcd_id;
 	enum versatile_clcd versatile_clcd_type;
 	struct device_node *np;
 	struct regmap *map;
+	int ret;
 
 	np = of_find_matching_node_and_match(NULL, versatile_clcd_of_match,
 					     &clcd_id);
@@ -301,7 +322,25 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 	}
 	versatile_clcd_type = (enum versatile_clcd)clcd_id->data;
 
-	map = syscon_node_to_regmap(np);
+	/* Versatile Express special handling */
+	if (versatile_clcd_type == VEXPRESS_CLCD_V2M) {
+		struct platform_device *pdev;
+
+		/* Call into deep Vexpress configuration API */
+		pdev = of_find_device_by_node(np);
+		if (!pdev) {
+			dev_err(dev, "can't find the sysreg device, deferring\n");
+			return -EPROBE_DEFER;
+		}
+		map = dev_get_drvdata(&pdev->dev);
+		if (!map) {
+			dev_err(dev, "sysreg has not yet probed\n");
+			return -EPROBE_DEFER;
+		}
+	} else {
+		map = syscon_node_to_regmap(np);
+	}
+
 	if (IS_ERR(map)) {
 		dev_err(dev, "no Versatile syscon regmap\n");
 		return PTR_ERR(map);
@@ -340,6 +379,13 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 		priv->variant_display_disable = pl111_realview_clcd_disable;
 		dev_info(dev, "set up callbacks for RealView PL111\n");
 		break;
+	case VEXPRESS_CLCD_V2M:
+		priv->variant = &pl111_vexpress;
+		dev_info(dev, "initializing Versatile Express PL111\n");
+		ret = pl111_vexpress_clcd_init(dev, priv, map);
+		if (ret)
+			return ret;
+		break;
 	default:
 		dev_info(dev, "unknown Versatile system controller\n");
 		break;
diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.c b/drivers/gpu/drm/pl111/pl111_vexpress.c
new file mode 100644
index 000000000000..720244f497fe
--- /dev/null
+++ b/drivers/gpu/drm/pl111/pl111_vexpress.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Versatile Express PL111 handling
+ * Copyright (C) 2018 Linus Walleij
+ *
+ * This module binds to the "arm,vexpress-muxfpga" device on the
+ * Versatile Express configuration bus and sets up which CLCD instance
+ * gets muxed out on the DVI bridge.
+ */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/vexpress.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include "pl111_drm.h"
+#include "pl111_vexpress.h"
+
+#define VEXPRESS_FPGAMUX_MOTHERBOARD		0x00
+#define VEXPRESS_FPGAMUX_DAUGHTERBOARD_1	0x01
+#define VEXPRESS_FPGAMUX_DAUGHTERBOARD_2	0x02
+
+static bool daughterboard_muxed = false;
+static bool motherboard_muxed = false;
+
+int pl111_vexpress_clcd_init(struct device *dev,
+			     struct pl111_drm_dev_private *priv,
+			     struct regmap *map)
+{
+	struct device_node *memory;
+	u32 val;
+	int ret;
+
+	/*
+	 * The CLCD on the motherboard has a special memory region and
+	 * does not make use of CMA. We differentiate between the different
+	 * CLCD controllers using this memory region phandle.
+	 */
+	memory = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!memory) {
+		if (motherboard_muxed) {
+			dev_info(dev, "motherboard CLCD muxed in\n");
+			dev_info(dev, "daughterboard takes precedence\n");
+			dev_info(dev, "motherboard CLCD will not be muxed out\n");
+		}
+		dev_info(dev,
+			 "DVI muxed to daughterboard 1 (core tile) CLCD\n");
+		val = VEXPRESS_FPGAMUX_DAUGHTERBOARD_1;
+		daughterboard_muxed = true;
+	} else {
+		priv->clcd_memory = of_iomap(memory, 0);
+		if (!priv->clcd_memory)
+			dev_err(dev, "could not remap CLCD memory\n");
+		/* Fall through and try to use CMA */
+		if (daughterboard_muxed) {
+			dev_info(dev, "daughterboard takes precedence\n");
+			dev_info(dev, "motherboard CLCD will not be muxed out\n");
+			return -ENODEV;
+		}
+		dev_info(dev, "DVI muxed to motherboard CLCD\n");
+		val = VEXPRESS_FPGAMUX_MOTHERBOARD;
+		motherboard_muxed = true;
+	}
+
+	ret = regmap_write(map, 0, val);
+	if (ret) {
+		dev_err(dev, "error setting DVI muxmode\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * This sets up the regmap pointer that will then be retrieved by
+ * the detection code in pl111_versatile.c and passed in to the
+ * pl111_vexpress_clcd_init() function above.
+ */
+static int vexpress_muxfpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *map;
+
+	map = devm_regmap_init_vexpress_config(&pdev->dev);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	dev_set_drvdata(dev, map);
+
+	return 0;
+}
+
+static const struct of_device_id vexpress_muxfpga_match[] = {
+	{ .compatible = "arm,vexpress-muxfpga", }
+};
+
+static struct platform_driver vexpress_muxfpga_driver = {
+	.driver = {
+		.name = "vexpress-muxfpga",
+		.of_match_table = of_match_ptr(vexpress_muxfpga_match),
+	},
+	.probe = vexpress_muxfpga_probe,
+};
+
+module_platform_driver(vexpress_muxfpga_driver);
diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.h b/drivers/gpu/drm/pl111/pl111_vexpress.h
new file mode 100644
index 000000000000..49876417f7b6
--- /dev/null
+++ b/drivers/gpu/drm/pl111/pl111_vexpress.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+struct device;
+struct pl111_drm_dev_private;
+struct regmap;
+
+#ifdef CONFIG_ARCH_VEXPRESS
+
+int pl111_vexpress_clcd_init(struct device *dev,
+			     struct pl111_drm_dev_private *priv,
+			     struct regmap *map);
+
+#else
+
+static int inline pl111_vexpress_clcd_init(struct device *dev,
+					   struct pl111_drm_dev_private *priv,
+					   struct regmap *map)
+{
+	return -ENODEV;
+}
+
+#endif
-- 
2.14.3
