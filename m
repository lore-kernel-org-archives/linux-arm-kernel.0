From: chunkeey@googlemail.com (Christian Lamparter)
Date: Thu, 28 Apr 2016 11:05:14 +0200
Subject: [RFC v4 4/8] gpio: clps711x: integrate cirrus clps711x into gpio-mmio
In-Reply-To: <cover.1461806071.git.chunkeey@googlemail.com>
References: <cover.1461806071.git.chunkeey@googlemail.com>
Message-ID: <79a6a3bb50a02320cc90690df9ad2b1e91c5c5c3.1461806071.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch integrates the Cirrus' clps711x driver into the
gpio-mmio framework.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/gpio/Kconfig            | 14 +++----
 drivers/gpio/Makefile           |  2 +-
 drivers/gpio/gpio-clps711x.c    | 84 ++++++++++++++---------------------------
 drivers/gpio/gpio-mmio-compat.h | 11 ++++++
 drivers/gpio/gpio-mmio.c        |  1 +
 5 files changed, 48 insertions(+), 64 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d1f124e..ff9ac65 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -152,13 +152,6 @@ config GPIO_BRCMSTB
 	help
 	  Say yes here to enable GPIO support for Broadcom STB (BCM7XXX) SoCs.
 
-config GPIO_CLPS711X
-	tristate "CLPS711X GPIO support"
-	depends on ARCH_CLPS711X || COMPILE_TEST
-	select GPIO_GENERIC
-	help
-	  Say yes here to support GPIO on CLPS711X SoCs.
-
 config GPIO_DAVINCI
 	bool "TI Davinci/Keystone GPIO support"
 	default y if ARCH_DAVINCI
@@ -213,6 +206,13 @@ config GPIO_GENERIC_PLATFORM
 	  Say yes here to support basic platform_device memory-mapped GPIO controllers.
 
 if GPIO_GENERIC_PLATFORM
+config GPIO_CLPS711X
+	bool "CLPS711X GPIO support"
+	depends on ARCH_CLPS711X || COMPILE_TEST
+	select GPIO_GENERIC
+	help
+	  Say yes here to support GPIO on CLPS711X SoCs.
+
 endif
 
 config GPIO_GRGPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 991598e..a1ae48f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_GPIO_GENERIC)	+= gpio-generic.o
 
 # directly supported by gpio-generic
 gpio-generic-$(CONFIG_GPIO_GENERIC)	+= gpio-mmio.o
+gpio-generic-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 
 obj-$(CONFIG_GPIO_104_DIO_48E)	+= gpio-104-dio-48e.o
 obj-$(CONFIG_GPIO_104_IDIO_16)	+= gpio-104-idio-16.o
@@ -31,7 +32,6 @@ obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
-obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_CRYSTAL_COVE)	+= gpio-crystalcove.o
 obj-$(CONFIG_GPIO_DA9052)	+= gpio-da9052.o
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index 5a69025..2072d0f 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -9,83 +9,55 @@
  * (at your option) any later version.
  */
 
-#include <linux/err.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
+#include "gpio-mmio-compat.h"
 
-static int clps711x_gpio_probe(struct platform_device *pdev)
+int cirrus_clps711x_parse_dt(struct platform_device *pdev,
+			     struct bgpio_pdata *pdata,
+			     unsigned long *flags)
 {
 	struct device_node *np = pdev->dev.of_node;
-	void __iomem *dat, *dir;
-	struct gpio_chip *gc;
+	int id = np ? of_alias_get_id(np, "gpio") : pdev->id;
 	struct resource *res;
-	int err, id = np ? of_alias_get_id(np, "gpio") : pdev->id;
+	struct resource nres[] = {
+		DEFINE_RES_MEM_NAMED(0, 1, "dat"),
+		DEFINE_RES_MEM_NAMED(0, 1, "dirout"),
+	};
 
 	if ((id < 0) || (id > 4))
 		return -ENODEV;
 
-	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
-		return -ENOMEM;
+	if (id == 4) {
+		/* PORTE is 3 lines only */
+		pdata->ngpio = 3;
+	}
+
+	pdata->base = id * 8;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dat = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dat))
-		return PTR_ERR(dat);
+	if (!res || resource_size(res) != 0x1)
+		return -EINVAL;
+	set_resource_address(&nres[0], res->start, 0x1);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	dir = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dir))
-		return PTR_ERR(dir);
+	if (!res || resource_size(res) != 0x1)
+		return -EINVAL;
+	set_resource_address(&nres[1], res->start, 0x1);
 
-	switch (id) {
-	case 3:
+	if (id == 3) {
 		/* PORTD is inverted logic for direction register */
-		err = bgpio_init(gc, &pdev->dev, 1, dat, NULL, NULL,
-				 NULL, dir, 0);
-		break;
-	default:
-		err = bgpio_init(gc, &pdev->dev, 1, dat, NULL, NULL,
-				 dir, NULL, 0);
-		break;
-	}
-
-	if (err)
-		return err;
-
-	switch (id) {
-	case 4:
-		/* PORTE is 3 lines only */
-		gc->ngpio = 3;
-		break;
-	default:
-		break;
+		nres[1].name = "dirin";
 	}
 
-	gc->base = id * 8;
-	gc->owner = THIS_MODULE;
-	platform_set_drvdata(pdev, gc);
-
-	return devm_gpiochip_add_data(&pdev->dev, gc, NULL);
+	return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
 }
 
-static const struct of_device_id __maybe_unused clps711x_gpio_ids[] = {
-	{ .compatible = "cirrus,clps711x-gpio" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, clps711x_gpio_ids);
-
-static struct platform_driver clps711x_gpio_driver = {
-	.driver	= {
-		.name		= "clps711x-gpio",
-		.of_match_table	= of_match_ptr(clps711x_gpio_ids),
-	},
-	.probe	= clps711x_gpio_probe,
-};
-module_platform_driver(clps711x_gpio_driver);
-
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
 MODULE_DESCRIPTION("CLPS711X GPIO driver");
 MODULE_ALIAS("platform:clps711x-gpio");
+MODULE_ALIAS("clps711x-gpio");
diff --git a/drivers/gpio/gpio-mmio-compat.h b/drivers/gpio/gpio-mmio-compat.h
index 73c48bc..32b5510 100644
--- a/drivers/gpio/gpio-mmio-compat.h
+++ b/drivers/gpio/gpio-mmio-compat.h
@@ -5,6 +5,17 @@
 
 #define ADD(_name, _func) { .compatible = _name, .data = _func }
 
+#if IS_ENABLED(CONFIG_GPIO_CLPS711X)
+int cirrus_clps711x_parse_dt(struct platform_device *pdev,
+			     struct bgpio_pdata *pdata,
+			     unsigned long *flags);
+
+#define GPIO_CLPS711X_COMPATIBLE			\
+	ADD("cirrus,clps711x-gpio", cirrus_clps711x_parse_dt),
+#else
+#define GPIO_CLPS711X_COMPATIBLE
+#endif /* CONFIG_GPIO_CLPS711X */
+
 #undef ADD
 
 static inline void set_resource_address(struct resource *res,
diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 4de9846..1be8cb7 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -608,6 +608,7 @@ static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
 
 static const struct of_device_id bgpio_of_match[] = {
 	ADD("linux,gpio-mmio", bgpio_basic_mmio_parse_dt),
+	GPIO_CLPS711X_COMPATIBLE
 
 	{ }
 };
-- 
2.8.1
