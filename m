From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Aug 2017 02:38:45 +0200
Subject: [PATCH 3/5] reset: Add Realtek RTD1295 driver
In-Reply-To: <20170816003847.6208-1-afaerber@suse.de>
References: <20170816003847.6208-1-afaerber@suse.de>
Message-ID: <20170816003847.6208-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a per-register reset controller driver. This deals with the fact
that not all registers are adjoined.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 drivers/reset/Kconfig         |   6 +++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-rtd129x.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 drivers/reset/reset-rtd129x.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 52d5251660b9..dbac75e3f82c 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -68,6 +68,12 @@ config RESET_PISTACHIO
 	help
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
+config RESET_RTD129X
+	bool "Realtek RTD129x Reset Driver" if COMPILE_TEST
+	default ARCH_REALTEK if ARM64
+	help
+	  This enables the reset controller driver for Realtek RTD1295 SoC.
+
 config RESET_SOCFPGA
 	bool "SoCFPGA Reset Driver" if COMPILE_TEST
 	default ARCH_SOCFPGA
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index b62783f50fe5..bca900260a57 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
+obj-$(CONFIG_RESET_RTD129X) += reset-rtd129x.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
diff --git a/drivers/reset/reset-rtd129x.c b/drivers/reset/reset-rtd129x.c
new file mode 100644
index 000000000000..d553900096c6
--- /dev/null
+++ b/drivers/reset/reset-rtd129x.c
@@ -0,0 +1,100 @@
+/*
+ * Realtek RTD129x reset controller
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: GPL-2.0+
+ */
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+struct rtd129x_reset_controller {
+	struct reset_controller_dev rcdev;
+	void __iomem *base;
+	spinlock_t lock;
+};
+
+#define to_rtd129x_rcdev(_rcdev) \
+	container_of(_rcdev, struct rtd129x_reset_controller, rcdev)
+
+static int rtd129x_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct rtd129x_reset_controller *data = to_rtd129x_rcdev(rcdev);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl(data->base);
+	writel(reg & ~BIT(id), data->base);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int rtd129x_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct rtd129x_reset_controller *data = to_rtd129x_rcdev(rcdev);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl(data->base);
+	writel(reg | BIT(id), data->base);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static const struct reset_control_ops rtd129x_reset_ops = {
+	.assert		= rtd129x_reset_assert,
+	.deassert	= rtd129x_reset_deassert,
+};
+
+static const struct of_device_id rtd129x_reset_dt_ids[] = {
+	 { .compatible = "realtek,rtd1295-reset" },
+	 { }
+};
+
+static int rtd129x_reset_probe(struct platform_device *pdev)
+{
+	struct rtd129x_reset_controller *data;
+	struct resource *res;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+
+	spin_lock_init(&data->lock);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = 32;
+	data->rcdev.ops = &rtd129x_reset_ops;
+	data->rcdev.of_node = pdev->dev.of_node;
+
+	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
+}
+
+static struct platform_driver rtd129x_reset_driver = {
+	.probe = rtd129x_reset_probe,
+	.driver = {
+		.name = "rtd129x-reset",
+		.of_match_table	= rtd129x_reset_dt_ids,
+	},
+};
+builtin_platform_driver(rtd129x_reset_driver);
-- 
2.12.3
