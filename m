From: stefan@agner.ch (Stefan Agner)
Date: Mon, 28 Mar 2016 19:00:00 -0700
Subject: [PATCH v2 6/8] drm/fsl-dcu: add TCON driver
In-Reply-To: <1459216802-32094-1-git-send-email-stefan@agner.ch>
References: <1459216802-32094-1-git-send-email-stefan@agner.ch>
Message-ID: <1459216802-32094-7-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver for the TCON (timing controller) module. The TCON module
is a separate module attached after the DCU (display controller
unit). Each DCU instance has its own, directly connected TCON
instance. The DCU's RGB and timing signals are passing through
the TCON module. TCON can provide timing signals for raw TFT panels
or operate in a bypass mode which leaves all signals unaltered.

The driver currently only supports the bypass mode.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../devicetree/bindings/display/fsl,dcu.txt        |   2 +
 .../devicetree/bindings/display/fsl,tcon.txt       |  18 ++++
 drivers/gpu/drm/fsl-dcu/Makefile                   |   3 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |   3 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h          |   1 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  11 +++
 drivers/gpu/drm/fsl-dcu/fsl_tcon.c                 | 108 +++++++++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_tcon.h                 |  33 +++++++
 8 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/fsl,tcon.txt
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_tcon.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_tcon.h

diff --git a/Documentation/devicetree/bindings/display/fsl,dcu.txt b/Documentation/devicetree/bindings/display/fsl,dcu.txt
index f299e1e..b19bf12 100644
--- a/Documentation/devicetree/bindings/display/fsl,dcu.txt
+++ b/Documentation/devicetree/bindings/display/fsl,dcu.txt
@@ -14,6 +14,7 @@ Required properties:
 Optional properties:
 - clocks:		Second handle for pixel clock.
 - clock-names:		Second name "pix" for pixel clock.
+- fsl,tcon:		The phandle to the timing controller node.
 
 Examples:
 dcu: dcu at 2ce0000 {
@@ -23,4 +24,5 @@ dcu: dcu at 2ce0000 {
 	clock-names = "dcu";
 	big-endian;
 	fsl,panel = <&panel>;
+	fsl,tcon = <&tcon>;
 };
diff --git a/Documentation/devicetree/bindings/display/fsl,tcon.txt b/Documentation/devicetree/bindings/display/fsl,tcon.txt
new file mode 100644
index 0000000..2e1015e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/fsl,tcon.txt
@@ -0,0 +1,18 @@
+Device Tree bindings for Freescale TCON Driver
+
+Required properties:
+- compatible:		Should be one of
+	* "fsl,vf610-tcon".
+
+- reg:			Address and length of the register set for dcu.
+- clocks:		From common clock binding: handle to tcon ipg clock.
+- clock-names:		From common clock binding: Shall be "ipg".
+
+Examples:
+timing-controller at 4003d000 {
+	compatible = "fsl,vf610-tcon";
+	reg = <0x4003d000 0x1000>;
+	clocks = <&clks VF610_CLK_TCON0>;
+	clock-names = "ipg";
+	status = "okay";
+};
diff --git a/drivers/gpu/drm/fsl-dcu/Makefile b/drivers/gpu/drm/fsl-dcu/Makefile
index 6ea1523..b35a292 100644
--- a/drivers/gpu/drm/fsl-dcu/Makefile
+++ b/drivers/gpu/drm/fsl-dcu/Makefile
@@ -3,5 +3,6 @@ fsl-dcu-drm-y := fsl_dcu_drm_drv.o \
 		 fsl_dcu_drm_rgb.o \
 		 fsl_dcu_drm_plane.o \
 		 fsl_dcu_drm_crtc.o \
-		 fsl_dcu_drm_fbdev.o
+		 fsl_dcu_drm_fbdev.o \
+		 fsl_tcon.o
 obj-$(CONFIG_DRM_FSL_DCU)	+= fsl-dcu-drm.o
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 093a60b..f62bff2 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -27,6 +27,7 @@
 
 #include "fsl_dcu_drm_crtc.h"
 #include "fsl_dcu_drm_drv.h"
+#include "fsl_tcon.h"
 
 static bool fsl_dcu_drm_is_volatile_reg(struct device *dev, unsigned int reg)
 {
@@ -357,6 +358,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 		goto unregister_pix_clk;
 	}
 
+	fsl_dev->tcon = fsl_tcon_init(dev);
+
 	drm = drm_dev_alloc(driver, dev);
 	if (!drm) {
 		ret = -ENOMEM;
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
index f60ec0a..c275f90 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -184,6 +184,7 @@ struct fsl_dcu_drm_device {
 	int irq;
 	struct clk *clk;
 	struct clk *pix_clk;
+	struct fsl_tcon *tcon;
 	/*protects hardware register*/
 	spinlock_t irq_lock;
 	struct drm_device *drm;
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 8780deb..f586f1e 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -17,6 +17,7 @@
 #include <drm/drm_panel.h>
 
 #include "fsl_dcu_drm_drv.h"
+#include "fsl_tcon.h"
 
 static int
 fsl_dcu_drm_encoder_atomic_check(struct drm_encoder *encoder,
@@ -28,10 +29,20 @@ fsl_dcu_drm_encoder_atomic_check(struct drm_encoder *encoder,
 
 static void fsl_dcu_drm_encoder_disable(struct drm_encoder *encoder)
 {
+	struct drm_device *dev = encoder->dev;
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+
+	if (fsl_dev->tcon)
+		fsl_tcon_bypass_disable(fsl_dev->tcon);
 }
 
 static void fsl_dcu_drm_encoder_enable(struct drm_encoder *encoder)
 {
+	struct drm_device *dev = encoder->dev;
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+
+	if (fsl_dev->tcon)
+		fsl_tcon_bypass_enable(fsl_dev->tcon);
 }
 
 static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_tcon.c b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
new file mode 100644
index 0000000..e5001a1
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright 2015 Toradex AG
+ *
+ * Stefan Agner <stefan@agner.ch>
+ *
+ * Freescale TCON device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "fsl_tcon.h"
+
+void fsl_tcon_bypass_disable(struct fsl_tcon *tcon)
+{
+	regmap_update_bits(tcon->regs, FSL_TCON_CTRL1,
+			   FSL_TCON_CTRL1_TCON_BYPASS, 0);
+}
+
+void fsl_tcon_bypass_enable(struct fsl_tcon *tcon)
+{
+	regmap_update_bits(tcon->regs, FSL_TCON_CTRL1,
+			   FSL_TCON_CTRL1_TCON_BYPASS,
+			   FSL_TCON_CTRL1_TCON_BYPASS);
+}
+
+static struct regmap_config fsl_tcon_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+
+	.name = "tcon",
+};
+
+static int fsl_tcon_init_regmap(struct device *dev,
+				struct fsl_tcon *tcon,
+				struct device_node *np)
+{
+	struct resource res;
+	void __iomem *regs;
+
+	if (of_address_to_resource(np, 0, &res))
+		return -EINVAL;
+
+	regs = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	tcon->regs = devm_regmap_init_mmio(dev, regs,
+					   &fsl_tcon_regmap_config);
+	if (IS_ERR(tcon->regs))
+		return PTR_ERR(tcon->regs);
+
+	return 0;
+}
+
+struct fsl_tcon *fsl_tcon_init(struct device *dev)
+{
+	struct fsl_tcon *tcon;
+	struct device_node *np;
+	int ret;
+
+	tcon = devm_kzalloc(dev, sizeof(*tcon), GFP_KERNEL);
+	if (!tcon)
+		return NULL;
+
+	np = of_parse_phandle(dev->of_node, "fsl,tcon", 0);
+	if (!np) {
+		dev_warn(dev, "Couldn't find the tcon node\n");
+		return NULL;
+	}
+
+	ret = fsl_tcon_init_regmap(dev, tcon, np);
+	if (ret) {
+		dev_err(dev, "Couldn't create the TCON regmap\n");
+		goto err_node_put;
+	}
+
+	tcon->ipg_clk = of_clk_get_by_name(np, "ipg");
+	if (IS_ERR(tcon->ipg_clk)) {
+		dev_err(dev, "Couldn't get the TCON bus clock\n");
+		goto err_node_put;
+	}
+
+	clk_prepare_enable(tcon->ipg_clk);
+
+	return tcon;
+
+err_node_put:
+	of_node_put(np);
+	return NULL;
+}
+
+void fsl_tcon_free(struct fsl_tcon *tcon)
+{
+	clk_disable_unprepare(tcon->ipg_clk);
+	clk_put(tcon->ipg_clk);
+}
+
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_tcon.h b/drivers/gpu/drm/fsl-dcu/fsl_tcon.h
new file mode 100644
index 0000000..80a7617
--- /dev/null
+++ b/drivers/gpu/drm/fsl-dcu/fsl_tcon.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2015 Toradex AG
+ *
+ * Stefan Agner <stefan@agner.ch>
+ *
+ * Freescale TCON device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __FSL_TCON_H__
+#define __FSL_TCON_H__
+
+#include <linux/bitops.h>
+
+#define FSL_TCON_CTRL1			0x0
+#define FSL_TCON_CTRL1_TCON_BYPASS	BIT(29)
+
+struct fsl_tcon {
+	struct regmap		*regs;
+	struct clk		*ipg_clk;
+};
+
+struct fsl_tcon *fsl_tcon_init(struct device *dev);
+void fsl_tcon_free(struct fsl_tcon *tcon);
+
+void fsl_tcon_bypass_disable(struct fsl_tcon *tcon);
+void fsl_tcon_bypass_enable(struct fsl_tcon *tcon);
+
+#endif /* __FSL_TCON_H__ */
-- 
2.7.4
