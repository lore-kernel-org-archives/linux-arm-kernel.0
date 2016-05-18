From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 18 May 2016 15:40:26 +0000
Subject: [PATCH-V2 2/6] memory: bcm2835: add bcm2835-memory controller
In-Reply-To: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
References: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463586030-2778-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add a memory-controller driver for the bcm2835 SOC.

This is mostly needed to claim the SDRAM clocks
so that this (and the corresponding parent pll)
never gets disabled.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
 V1->V2: moved to different register sets (that are also
     	  set up by the alternative boot loader to enable sdram)
	 added 2 distinct clocks (for low voltage and internal pll)
	 made the use of "names" for reg and clocks
---
 drivers/memory/Kconfig         |   7 +++
 drivers/memory/Makefile        |   1 +
 drivers/memory/bcm2835-sdram.c | 128 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 drivers/memory/bcm2835-sdram.c

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 51d5cd2..a55cad3 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -25,6 +25,13 @@ config ATMEL_SDRAMC
 	  Starting with the at91sam9g45, this controller supports SDR, DDR and
 	  LP-DDR memories.
 
+config BCM2835_SDRAM
+	bool "Broadcom BCM2835 SDRAM Controller"
+	default y
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	help
+	  This driver is for Broadcom BCM2835 SDRAM Controller.
+
 config TI_AEMIF
 	tristate "Texas Instruments AEMIF driver"
 	depends on (ARCH_DAVINCI || ARCH_KEYSTONE) && OF
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 890bdf4..1287b90 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_OF)		+= of_memory.o
 endif
 obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
 obj-$(CONFIG_ATMEL_SDRAMC)	+= atmel-sdramc.o
+obj-$(CONFIG_BCM2835_SDRAM)	+= bcm2835-sdram.o
 obj-$(CONFIG_TI_AEMIF)		+= ti-aemif.o
 obj-$(CONFIG_TI_EMIF)		+= emif.o
 obj-$(CONFIG_OMAP_GPMC)		+= omap-gpmc.o
diff --git a/drivers/memory/bcm2835-sdram.c b/drivers/memory/bcm2835-sdram.c
new file mode 100644
index 0000000..ce985ee
--- /dev/null
+++ b/drivers/memory/bcm2835-sdram.c
@@ -0,0 +1,128 @@
+/*
+ * Driver for Broadcom BCM2835 soc sdram controller
+ *
+ * Copyright (C) 2016 Martin Sperl
+ *
+ * inspired by: atmel-sdramc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+struct bcm2835_sdram_data {
+	void __iomem	*sdram_regs;
+	void __iomem	*aphy_csr_regs;
+	void __iomem	*dphy_csr_regs;
+
+	struct clk	*clk_lv;
+	struct clk	*clk_pll_parent;
+};
+
+static int bcm2835_sdram_probe_reg(struct platform_device *pdev,
+				   const char *name,
+				   void __iomem **ptr)
+{
+	struct resource *res;
+	int err = 0;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (!res) {
+		dev_err(&pdev->dev,
+			"Could not find register range %s\n",
+			name);
+		return -EINVAL;
+	}
+
+	*ptr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(*ptr)) {
+		err = PTR_ERR(*ptr);
+		dev_err(&pdev->dev,
+			"Could not get register range %s: %d\n",
+			name, err);
+	}
+
+	return err;
+}
+
+static int bcm2835_sdram_probe(struct platform_device *pdev)
+{
+	struct bcm2835_sdram_data *data;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, data);
+
+	/* get registers */
+	ret = bcm2835_sdram_probe_reg(pdev, "sdram",
+				      &data->sdram_regs);
+	if (ret)
+		return ret;
+	ret = bcm2835_sdram_probe_reg(pdev, "aphy_csr",
+				      &data->aphy_csr_regs);
+	if (ret)
+		return ret;
+	ret = bcm2835_sdram_probe_reg(pdev, "dphy_csr",
+				      &data->dphy_csr_regs);
+	if (ret)
+		return ret;
+
+	/* get clocks */
+	data->clk_lv = devm_clk_get(&pdev->dev, "low-voltage");
+	if (IS_ERR(data->clk_lv)) {
+		ret = PTR_ERR(data->clk_lv);
+		dev_err(&pdev->dev, "Could not get clock named %s - %d\n",
+			"low-voltage", ret);
+		return ret;
+	}
+	data->clk_pll_parent = devm_clk_get(&pdev->dev, "pll-parent");
+	if (IS_ERR(data->clk_pll_parent)) {
+		ret = PTR_ERR(data->clk_pll_parent);
+		dev_err(&pdev->dev, "Could not get clock named %s - %d\n",
+			"pll-parent", ret);
+		return ret;
+	}
+
+	/* finally prepare both */
+	clk_prepare_enable(data->clk_lv);
+	clk_prepare_enable(data->clk_pll_parent);
+
+	return 0;
+}
+
+static const struct of_device_id bcm2835_sdram_of_match_table[] = {
+	{ .compatible = "brcm,bcm2835-sdram", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm2835_sdram_of_match_table);
+
+static struct platform_driver bcm2835_sdram_driver = {
+	.probe = bcm2835_sdram_probe,
+	.driver = {
+		.name = "bcm2835_sdram",
+		.of_match_table = bcm2835_sdram_of_match_table,
+	},
+};
+module_platform_driver(bcm2835_sdram_driver);
+
+MODULE_AUTHOR("Martin Sperl");
+MODULE_DESCRIPTION("sdram driver for bcm2835 chip");
+MODULE_LICENSE("GPL");
-- 
2.1.4
