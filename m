From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 17 Oct 2017 15:03:05 +0200
Subject: [PATCH v4 4/5] reset: stm32: use the reset-simple driver
In-Reply-To: <20171017130306.881-1-p.zabel@pengutronix.de>
References: <20171017130306.881-1-p.zabel@pengutronix.de>
Message-ID: <20171017130306.881-5-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset-simple driver can be used without changes.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/reset/Kconfig        |  11 ++---
 drivers/reset/Makefile       |   1 -
 drivers/reset/reset-simple.c |   1 +
 drivers/reset/reset-stm32.c  | 108 -------------------------------------------
 4 files changed, 4 insertions(+), 117 deletions(-)
 delete mode 100644 drivers/reset/reset-stm32.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2d6770b210ed7..9bdb4fe1b03e6 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -77,19 +77,14 @@ config RESET_PISTACHIO
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_SOCFPGA || ARCH_STRATIX10 || ARCH_SUNXI
+	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
 	  exclusive register space.
 
-	  Currently this driver supports Altera SoCFPGAs and Allwinner SoCs.
-
-config RESET_STM32
-	bool "STM32 Reset Driver" if COMPILE_TEST
-	default ARCH_STM32
-	help
-	  This enables the RCC reset controller driver for STM32 MCUs.
+	  Currently this driver supports Altera SoCFPGAs, the RCC reset
+	  controller in STM32 MCUs, and Allwinner SoCs.
 
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 3bf3b4e6a9fd2..98dd1eccc820c 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
-obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 98ff0f924948e..273039ef02e64 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -120,6 +120,7 @@ static const struct reset_simple_devdata reset_simple_active_low = {
 
 static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "altr,rst-mgr", .data = &reset_simple_socfpga },
+	{ .compatible = "st,stm32-rcc", },
 	{ .compatible = "allwinner,sun6i-a31-clock-reset",
 		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
diff --git a/drivers/reset/reset-stm32.c b/drivers/reset/reset-stm32.c
deleted file mode 100644
index 3a7c8527e66af..0000000000000
--- a/drivers/reset/reset-stm32.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- * Copyright (C) Maxime Coquelin 2015
- * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
- * License terms:  GNU General Public License (GPL), version 2
- *
- * Heavily based on sunxi driver from Maxime Ripard.
- */
-
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/reset-controller.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-struct stm32_reset_data {
-	spinlock_t			lock;
-	void __iomem			*membase;
-	struct reset_controller_dev	rcdev;
-};
-
-static int stm32_reset_assert(struct reset_controller_dev *rcdev,
-			      unsigned long id)
-{
-	struct stm32_reset_data *data = container_of(rcdev,
-						     struct stm32_reset_data,
-						     rcdev);
-	int bank = id / BITS_PER_LONG;
-	int offset = id % BITS_PER_LONG;
-	unsigned long flags;
-	u32 reg;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	reg = readl(data->membase + (bank * 4));
-	writel(reg | BIT(offset), data->membase + (bank * 4));
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
-}
-
-static int stm32_reset_deassert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	struct stm32_reset_data *data = container_of(rcdev,
-						     struct stm32_reset_data,
-						     rcdev);
-	int bank = id / BITS_PER_LONG;
-	int offset = id % BITS_PER_LONG;
-	unsigned long flags;
-	u32 reg;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	reg = readl(data->membase + (bank * 4));
-	writel(reg & ~BIT(offset), data->membase + (bank * 4));
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
-}
-
-static const struct reset_control_ops stm32_reset_ops = {
-	.assert		= stm32_reset_assert,
-	.deassert	= stm32_reset_deassert,
-};
-
-static const struct of_device_id stm32_reset_dt_ids[] = {
-	 { .compatible = "st,stm32-rcc", },
-	 { /* sentinel */ },
-};
-
-static int stm32_reset_probe(struct platform_device *pdev)
-{
-	struct stm32_reset_data *data;
-	struct resource *res;
-
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->membase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(data->membase))
-		return PTR_ERR(data->membase);
-
-	spin_lock_init(&data->lock);
-
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = resource_size(res) * 8;
-	data->rcdev.ops = &stm32_reset_ops;
-	data->rcdev.of_node = pdev->dev.of_node;
-
-	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
-}
-
-static struct platform_driver stm32_reset_driver = {
-	.probe	= stm32_reset_probe,
-	.driver = {
-		.name		= "stm32-rcc-reset",
-		.of_match_table	= stm32_reset_dt_ids,
-	},
-};
-builtin_platform_driver(stm32_reset_driver);
-- 
2.11.0
