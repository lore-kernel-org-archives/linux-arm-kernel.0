From: davidm@egauge.net (David Mosberger-Tang)
Date: Tue, 10 May 2016 13:02:16 -0600
Subject: [PATCH] drivers: nvmem: atmel-secumod: New driver for Atmel Secumod
 nvram.
In-Reply-To: <1453348655-31182-1-git-send-email-davidm@egauge.net>
References: <1453348655-31182-1-git-send-email-davidm@egauge.net>
Message-ID: <1462906936-31353-1-git-send-email-davidm@egauge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Mosberger <davidm@egauge.net>
---
 .../devicetree/bindings/nvmem/atmel-secumod.txt    |  46 ++++++++
 arch/arm/boot/dts/sama5d2.dtsi                     |  20 ++++
 drivers/nvmem/Kconfig                              |   7 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/atmel-secumod.c                      | 122 +++++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
 create mode 100644 drivers/nvmem/atmel-secumod.c

diff --git a/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt b/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
new file mode 100644
index 0000000..0bb7638
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
@@ -0,0 +1,46 @@
+= Atmel Secumod device tree bindings =
+
+This binding is intended to represent Atmel's Secumod which is found
+in SAMA5D2 and perhaps others.
+
+Required properties:
+- compatible: should be "atmel,sama5d2-secumod"
+- reg: Should contain registers location and length of the RAM, followed
+       by register location and length of the Secumod controller.
+
+= Data cells =
+Are child nodes of secumod, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+Example:
+
+    secumod at fc040000 {
+            compatible = "atmel,sama5d2-secumod";
+            reg = <0xf8044000 0x1420
+                   0xfc040000 0x4000>;
+            status = "okay";
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            secram_auto_erasable at 0000 {
+                    reg = <0x0000 0x1000>;
+            };
+            secram at 1000 {
+                    reg = <0x1000 0x400>;
+            };
+            ram at 1400 {
+                    reg = <0x1400 0x20>;
+            };
+    };
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+
+	ram {
+		...
+		nvmem-cells = <&ram>;
+		nvmem-cell-names = "calibration";
+	};
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 78996bd..5856d6a 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1178,6 +1178,26 @@
 				clocks = <&pioA_clk>;
 			};
 
+			secumod at fc040000 {
+				compatible = "atmel,sama5d2-secumod";
+				reg = <0xf8044000 0x1420
+				       0xfc040000 0x4000>;
+				status = "okay";
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				secram_auto_erasable at 0000 {
+					reg = <0x0000 0x1000>;
+				};
+				secram at 1000 {
+					reg = <0x1000 0x400>;
+				};
+				ram at 1400 {
+					reg = <0x1400 0x20>;
+				};
+			};
+
 			tdes at fc044000 {
 				compatible = "atmel,at91sam9g46-tdes";
 				reg = <0xfc044000 0x100>;
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ca52952..3d34fbb 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -102,4 +102,11 @@ config NVMEM_VF610_OCOTP
 	  This driver can also be build as a module. If so, the module will
 	  be called nvmem-vf610-ocotp.
 
+config NVMEM_ATMEL_SECUMOD
+       tristate "Atmel Secure Module driver"
+       depends on ARCH_AT91
+       help
+         Select this to get support for the secure module (SECUMOD) built
+	 into the SAMA5D2 chips.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 45ab1ae..9cbd950 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -22,3 +22,5 @@ obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
 nvmem_sunxi_sid-y		:= sunxi_sid.o
 obj-$(CONFIG_NVMEM_VF610_OCOTP)	+= nvmem-vf610-ocotp.o
 nvmem-vf610-ocotp-y		:= vf610-ocotp.o
+obj-$(CONFIG_NVMEM_ATMEL_SECUMOD)	+= nvmem-atmel-secumod.o
+nvmem-atmel-secumod-y		:= atmel-secumod.o
diff --git a/drivers/nvmem/atmel-secumod.c b/drivers/nvmem/atmel-secumod.c
new file mode 100644
index 0000000..a6b4574
--- /dev/null
+++ b/drivers/nvmem/atmel-secumod.c
@@ -0,0 +1,122 @@
+/*
+ * Driver for SAMA5D2 secure module (SECUMOD).
+ *
+ * Copyright (C) 2016 eGauge Systems LLC
+ *
+ * David Mosberger <davidm@egauge.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+static struct regmap_config secumod_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4
+};
+
+static struct nvmem_config econfig = {
+	.name = "secumod",
+	.owner = THIS_MODULE,
+};
+
+/*
+ * Security-module register definitions:
+ */
+#define SECUMOD_RAMRDY	0x0014
+
+/*
+ * Since the secure module may need to automatically erase some of the
+ * RAM, it may take a while for it to be ready.  As far as I know,
+ * it's not documented how long this might take in the worst-case.
+ */
+static void
+secumod_wait_ready (void *regs)
+{
+	unsigned long start, stop;
+
+	start = jiffies;
+	while (!(readl(regs + SECUMOD_RAMRDY) & 1))
+		msleep_interruptible(1);
+	stop = jiffies;
+	if (stop != start)
+		pr_info("nvmem-atmel-secumod: it took %u msec for SECUMOD "
+			"to become ready...\n", jiffies_to_msecs(stop - start));
+	else
+		pr_info("nvmem-atmel-secumod: ready\n");
+}
+
+static int secumod_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static int secumod_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct nvmem_device *nvmem;
+	struct regmap *regmap;
+	void __iomem *base;
+
+	/*
+	 * Map controller address temporarily so we can ensure that
+	 * the hardware is ready:
+	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	base = devm_ioremap_resource(dev, res);
+	secumod_wait_ready(base);
+	devm_iounmap(dev, base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	secumod_regmap_config.max_register = resource_size(res) - 1;
+
+	regmap = devm_regmap_init_mmio(dev, base, &secumod_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "%s: regmap init failed\n", __func__);
+		return PTR_ERR(regmap);
+	}
+	econfig.dev = dev;
+	nvmem = nvmem_register(&econfig);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	platform_set_drvdata(pdev, nvmem);
+
+	return 0;
+}
+
+static const struct of_device_id secumod_of_match[] = {
+	{ .compatible = "atmel,sama5d2-secumod",},
+	{/* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, secumod_of_match);
+
+static struct platform_driver secumod_driver = {
+	.probe = secumod_probe,
+	.remove = secumod_remove,
+	.driver = {
+		.name = "atmel,sama5d2-secumod",
+		.of_match_table = secumod_of_match,
+	},
+};
+module_platform_driver(secumod_driver);
+MODULE_AUTHOR("David Mosberger <davidm@egauge.net>");
+MODULE_DESCRIPTION("Atmel Secumod driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
