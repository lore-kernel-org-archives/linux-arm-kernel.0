From: davidm@egauge.net (David Mosberger-Tang)
Date: Mon, 16 May 2016 14:17:10 -0600
Subject: [PATCH] drivers: nvmem: atmel-secumod: New driver for Atmel Secumod
 nvram
In-Reply-To: <alpine.LNX.2.00.1605121505320.21379@nippy.intranet>
References: <alpine.LNX.2.00.1605121505320.21379@nippy.intranet>
Message-ID: <1463429830-20539-1-git-send-email-davidm@egauge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Mosberger <davidm@egauge.net>
---
 .../devicetree/bindings/nvmem/atmel-secumod.txt    |  46 ++++++++
 drivers/nvmem/atmel-secumod.c                      | 125 +++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
 create mode 100644 drivers/nvmem/atmel-secumod.c

diff --git a/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt b/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
new file mode 100644
index 0000000..85db709
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
+		nvmem-cell-names = "RAM";
+	};
diff --git a/drivers/nvmem/atmel-secumod.c b/drivers/nvmem/atmel-secumod.c
new file mode 100644
index 0000000..fda83c9
--- /dev/null
+++ b/drivers/nvmem/atmel-secumod.c
@@ -0,0 +1,125 @@
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
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
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
