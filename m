From: chunkeey@googlemail.com (Christian Lamparter)
Date: Thu, 28 Apr 2016 11:05:17 +0200
Subject: [RFC v4 7/8] gpio: ts4800: integrate TS4800 into gpio-mmio
In-Reply-To: <cover.1461806071.git.chunkeey@googlemail.com>
References: <cover.1461806071.git.chunkeey@googlemail.com>
Message-ID: <ca05c30be30ff885833344d022984c83b4d2adcb.1461806071.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch integrates the TS4800 FPGA GPIO driver into
the gpio-mmio framework.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/gpio/Kconfig            | 17 ++++-----
 drivers/gpio/Makefile           |  2 +-
 drivers/gpio/gpio-mmio-compat.h | 11 ++++++
 drivers/gpio/gpio-mmio.c        |  1 +
 drivers/gpio/gpio-ts4800.c      | 76 ++++++++++++++---------------------------
 5 files changed, 47 insertions(+), 60 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 487297f..7d88527 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -220,6 +220,15 @@ config GPIO_MOXART
 	help
 	  Select this option to enable GPIO driver for
 	  MOXA ART SoC devices.
+
+config GPIO_TS4800
+	bool "TS-4800 DIO blocks and compatibles"
+	depends on OF_GPIO
+	depends on SOC_IMX51 || COMPILE_TEST
+	select GPIO_GENERIC
+	help
+	  This driver support TS-4800 FPGA GPIO controllers.
+
 endif
 
 config GPIO_GRGPIO
@@ -407,14 +416,6 @@ config GPIO_TEGRA
 	default y
 	depends on ARCH_TEGRA || COMPILE_TEST
 
-config GPIO_TS4800
-	tristate "TS-4800 DIO blocks and compatibles"
-	depends on OF_GPIO
-	depends on SOC_IMX51 || COMPILE_TEST
-	select GPIO_GENERIC
-	help
-	  This driver support TS-4800 FPGA GPIO controllers.
-
 config GPIO_TZ1090
 	bool "Toumaz Xenif TZ1090 GPIO support"
 	depends on SOC_TZ1090
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 32ad5fe..f9e5036 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -17,6 +17,7 @@ gpio-generic-$(CONFIG_GPIO_GENERIC)	+= gpio-mmio.o
 gpio-generic-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 gpio-generic-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 gpio-generic-$(CONFIG_GPIO_MOXART)	+= gpio-moxart.o
+gpio-generic-$(CONFIG_GPIO_TS4800)	+= gpio-ts4800.o
 
 obj-$(CONFIG_GPIO_104_DIO_48E)	+= gpio-104-dio-48e.o
 obj-$(CONFIG_GPIO_104_IDIO_16)	+= gpio-104-idio-16.o
@@ -107,7 +108,6 @@ obj-$(CONFIG_GPIO_TPS65218)	+= gpio-tps65218.o
 obj-$(CONFIG_GPIO_TPS6586X)	+= gpio-tps6586x.o
 obj-$(CONFIG_GPIO_TPS65910)	+= gpio-tps65910.o
 obj-$(CONFIG_GPIO_TPS65912)	+= gpio-tps65912.o
-obj-$(CONFIG_GPIO_TS4800)	+= gpio-ts4800.o
 obj-$(CONFIG_GPIO_TS5500)	+= gpio-ts5500.o
 obj-$(CONFIG_GPIO_TWL4030)	+= gpio-twl4030.o
 obj-$(CONFIG_GPIO_TWL6040)	+= gpio-twl6040.o
diff --git a/drivers/gpio/gpio-mmio-compat.h b/drivers/gpio/gpio-mmio-compat.h
index 702a384..a85835b 100644
--- a/drivers/gpio/gpio-mmio-compat.h
+++ b/drivers/gpio/gpio-mmio-compat.h
@@ -42,6 +42,17 @@ int moxart_parse_dt(struct platform_device *pdev,
 #define GPIO_MOXART_COMPATIBLE
 #endif /* CONFIG_GPIO_MOXART */
 
+#if IS_ENABLED(CONFIG_GPIO_TS4800)
+int technologic_ts4800_parse_dt(struct platform_device *pdev,
+				struct bgpio_pdata *pdata,
+				unsigned long *flags);
+
+#define GPIO_TS4800_COMPATIBLE				\
+	ADD("technologic,ts4800-gpio", technologic_ts4800_parse_dt),
+#else
+#define GPIO_TS4800_COMPATIBLE
+#endif /* CONFIG_GPIO_TS4800 */
+
 #undef ADD
 
 static inline void set_resource_address(struct resource *res,
diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index fdaf701..9f2cb2c 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -611,6 +611,7 @@ static const struct of_device_id bgpio_of_match[] = {
 	GPIO_CLPS711X_COMPATIBLE
 	GPIO_GE_FPGA_COMPATIBLE
 	GPIO_MOXART_COMPATIBLE
+	GPIO_TS4800_COMPATIBLE
 
 	{ }
 };
diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index 0c144a7..5003655 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -8,74 +8,48 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
 #include <linux/gpio/driver.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include "gpio-mmio-compat.h"
 
 #define DEFAULT_PIN_NUMBER      16
 #define INPUT_REG_OFFSET        0x00
 #define OUTPUT_REG_OFFSET       0x02
 #define DIRECTION_REG_OFFSET    0x04
 
-static int ts4800_gpio_probe(struct platform_device *pdev)
+int technologic_ts4800_parse_dt(struct platform_device *pdev,
+				struct bgpio_pdata *pdata,
+				unsigned long *flags)
 {
-	struct device_node *node;
-	struct gpio_chip *chip;
+	int err;
 	struct resource *res;
-	void __iomem *base_addr;
-	int retval;
-	u32 ngpios;
-
-	chip = devm_kzalloc(&pdev->dev, sizeof(struct gpio_chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
+	struct resource nres[] = {
+		DEFINE_RES_MEM_NAMED(0, 1, "dat"),
+		DEFINE_RES_MEM_NAMED(0, 1, "set"),
+		DEFINE_RES_MEM_NAMED(0, 1, "dirout"),
+	};
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base_addr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base_addr))
-		return PTR_ERR(base_addr);
-
-	node = pdev->dev.of_node;
-	if (!node)
+	if (!res || resource_size(res) != 6)
 		return -EINVAL;
 
-	retval = of_property_read_u32(node, "ngpios", &ngpios);
-	if (retval == -EINVAL)
-		ngpios = DEFAULT_PIN_NUMBER;
-	else if (retval)
-		return retval;
-
-	retval = bgpio_init(chip, &pdev->dev, 2, base_addr + INPUT_REG_OFFSET,
-			    base_addr + OUTPUT_REG_OFFSET, NULL,
-			    base_addr + DIRECTION_REG_OFFSET, NULL, 0);
-	if (retval) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
-		return retval;
-	}
-
-	chip->ngpio = ngpios;
+	set_resource_address(&nres[0], res->start + INPUT_REG_OFFSET, 0x2);
+	set_resource_address(&nres[1], res->start + OUTPUT_REG_OFFSET, 0x2);
+	set_resource_address(&nres[2], res->start + DIRECTION_REG_OFFSET, 0x2);
 
-	platform_set_drvdata(pdev, chip);
+	err = of_property_read_u32(pdev->dev.of_node, "ngpios", &pdata->ngpio);
+	if (err == -EINVAL)
+		pdata->ngpio = DEFAULT_PIN_NUMBER;
+	else if (err)
+		return err;
 
-	return devm_gpiochip_add_data(&pdev->dev, chip, NULL);
+	return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
 }
 
-static const struct of_device_id ts4800_gpio_of_match[] = {
-	{ .compatible = "technologic,ts4800-gpio", },
-	{},
-};
-
-static struct platform_driver ts4800_gpio_driver = {
-	.driver = {
-		   .name = "ts4800-gpio",
-		   .of_match_table = ts4800_gpio_of_match,
-		   },
-	.probe = ts4800_gpio_probe,
-};
-
-module_platform_driver_probe(ts4800_gpio_driver, ts4800_gpio_probe);
-
 MODULE_AUTHOR("Julien Grossholtz <julien.grossholtz@savoirfairelinux.com>");
 MODULE_DESCRIPTION("TS4800 FPGA GPIO driver");
-MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("gpio-ts4800");
-- 
2.8.1
