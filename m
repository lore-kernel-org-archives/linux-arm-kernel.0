From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 17 Oct 2017 15:03:06 +0200
Subject: [PATCH v4 5/5] reset: zx2967: use the reset-simple driver
In-Reply-To: <20171017130306.881-1-p.zabel@pengutronix.de>
References: <20171017130306.881-1-p.zabel@pengutronix.de>
Message-ID: <20171017130306.881-6-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset-simple driver can be used without changes.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Alexandru Gagniuc <alex.g@adaptrum.com>
---
 MAINTAINERS                  |  1 -
 drivers/reset/Kconfig        | 10 +----
 drivers/reset/Makefile       |  1 -
 drivers/reset/reset-simple.c |  2 +
 drivers/reset/reset-zx2967.c | 99 --------------------------------------------
 5 files changed, 4 insertions(+), 109 deletions(-)
 delete mode 100644 drivers/reset/reset-zx2967.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b9887b3644ef..d48d8a238fae1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2124,7 +2124,6 @@ F:	drivers/gpio/gpio-zx.c
 F:	drivers/i2c/busses/i2c-zx2967.c
 F:	drivers/mmc/host/dw_mmc-zx.*
 F:	drivers/pinctrl/zte/
-F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
 F:	drivers/thermal/zx2967_thermal.c
 F:	drivers/watchdog/zx2967_wdt.c
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 9bdb4fe1b03e6..de0090c911cd6 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -77,14 +77,14 @@ config RESET_PISTACHIO
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI
+	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
 	  exclusive register space.
 
 	  Currently this driver supports Altera SoCFPGAs, the RCC reset
-	  controller in STM32 MCUs, and Allwinner SoCs.
+	  controller in STM32 MCUs, Allwinner SoCs, and ZTE's zx2967 family.
 
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
@@ -121,12 +121,6 @@ config RESET_UNIPHIER
 	  Say Y if you want to control reset signals provided by System Control
 	  block, Media I/O block, Peripheral Block.
 
-config RESET_ZX2967
-	bool "ZTE ZX2967 Reset Driver"
-	depends on ARCH_ZX || COMPILE_TEST
-	help
-	  This enables the reset controller driver for ZTE's zx2967 family.
-
 config RESET_ZYNQ
 	bool "ZYNQ Reset Driver" if COMPILE_TEST
 	default ARCH_ZYNQ
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 98dd1eccc820c..48b64d63b75aa 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -17,6 +17,5 @@ obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
-obj-$(CONFIG_RESET_ZX2967) += reset-zx2967.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
 
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 273039ef02e64..a63f96d92035e 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -123,6 +123,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "st,stm32-rcc", },
 	{ .compatible = "allwinner,sun6i-a31-clock-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "zte,zx296718-reset",
+		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/reset/reset-zx2967.c b/drivers/reset/reset-zx2967.c
deleted file mode 100644
index 4f319f7753d4d..0000000000000
--- a/drivers/reset/reset-zx2967.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * ZTE's zx2967 family reset controller driver
- *
- * Copyright (C) 2017 ZTE Ltd.
- *
- * Author: Baoyou Xie <baoyou.xie@linaro.org>
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/reset-controller.h>
-
-struct zx2967_reset {
-	void __iomem			*reg_base;
-	spinlock_t			lock;
-	struct reset_controller_dev	rcdev;
-};
-
-static int zx2967_reset_act(struct reset_controller_dev *rcdev,
-			    unsigned long id, bool assert)
-{
-	struct zx2967_reset *reset = NULL;
-	int bank = id / 32;
-	int offset = id % 32;
-	u32 reg;
-	unsigned long flags;
-
-	reset = container_of(rcdev, struct zx2967_reset, rcdev);
-
-	spin_lock_irqsave(&reset->lock, flags);
-
-	reg = readl_relaxed(reset->reg_base + (bank * 4));
-	if (assert)
-		reg &= ~BIT(offset);
-	else
-		reg |= BIT(offset);
-	writel_relaxed(reg, reset->reg_base + (bank * 4));
-
-	spin_unlock_irqrestore(&reset->lock, flags);
-
-	return 0;
-}
-
-static int zx2967_reset_assert(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	return zx2967_reset_act(rcdev, id, true);
-}
-
-static int zx2967_reset_deassert(struct reset_controller_dev *rcdev,
-				 unsigned long id)
-{
-	return zx2967_reset_act(rcdev, id, false);
-}
-
-static const struct reset_control_ops zx2967_reset_ops = {
-	.assert		= zx2967_reset_assert,
-	.deassert	= zx2967_reset_deassert,
-};
-
-static int zx2967_reset_probe(struct platform_device *pdev)
-{
-	struct zx2967_reset *reset;
-	struct resource *res;
-
-	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
-	if (!reset)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reset->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(reset->reg_base))
-		return PTR_ERR(reset->reg_base);
-
-	spin_lock_init(&reset->lock);
-
-	reset->rcdev.owner = THIS_MODULE;
-	reset->rcdev.nr_resets = resource_size(res) * 8;
-	reset->rcdev.ops = &zx2967_reset_ops;
-	reset->rcdev.of_node = pdev->dev.of_node;
-
-	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
-}
-
-static const struct of_device_id zx2967_reset_dt_ids[] = {
-	 { .compatible = "zte,zx296718-reset", },
-	 {},
-};
-
-static struct platform_driver zx2967_reset_driver = {
-	.probe	= zx2967_reset_probe,
-	.driver = {
-		.name		= "zx2967-reset",
-		.of_match_table	= zx2967_reset_dt_ids,
-	},
-};
-builtin_platform_driver(zx2967_reset_driver);
-- 
2.11.0
