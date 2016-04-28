From: chunkeey@googlemail.com (Christian Lamparter)
Date: Thu, 28 Apr 2016 11:05:16 +0200
Subject: [RFC v4 6/8] gpio: moxart: integrate MOXA ART GPIO driver into
 gpio-mmio
In-Reply-To: <cover.1461806071.git.chunkeey@googlemail.com>
References: <cover.1461806071.git.chunkeey@googlemail.com>
Message-ID: <47faa5ebc21fc12688a2b2a009967150f5ecf2ce.1461806071.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch integrates the GPIO driver for the MOXA ART SoC into
the gpio-mmio framework.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/gpio/Kconfig            | 15 ++++----
 drivers/gpio/Makefile           |  2 +-
 drivers/gpio/gpio-mmio-compat.h | 12 ++++++
 drivers/gpio/gpio-mmio.c        |  1 +
 drivers/gpio/gpio-moxart.c      | 81 +++++++++++------------------------------
 5 files changed, 42 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a0e140d..487297f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -213,6 +213,13 @@ config GPIO_GE_FPGA
 	  and write pin state) for GPIO implemented in a number of GE single
 	  board computers.
 
+config GPIO_MOXART
+	bool "MOXART GPIO support"
+	depends on ARCH_MOXART || COMPILE_TEST
+	select GPIO_GENERIC
+	help
+	  Select this option to enable GPIO driver for
+	  MOXA ART SoC devices.
 endif
 
 config GPIO_GRGPIO
@@ -289,14 +296,6 @@ config GPIO_MM_LANTIQ
 	  (EBU) found on Lantiq SoCs. The gpios are output only as they are
 	  created by attaching a 16bit latch to the bus.
 
-config GPIO_MOXART
-	bool "MOXART GPIO support"
-	depends on ARCH_MOXART || COMPILE_TEST
-	select GPIO_GENERIC
-	help
-	  Select this option to enable GPIO driver for
-	  MOXA ART SoC devices.
-
 config GPIO_MPC5200
 	def_bool y
 	depends on PPC_MPC52xx
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a76b13d..32ad5fe 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_GPIO_GENERIC)	+= gpio-generic.o
 gpio-generic-$(CONFIG_GPIO_GENERIC)	+= gpio-mmio.o
 gpio-generic-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 gpio-generic-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
+gpio-generic-$(CONFIG_GPIO_MOXART)	+= gpio-moxart.o
 
 obj-$(CONFIG_GPIO_104_DIO_48E)	+= gpio-104-dio-48e.o
 obj-$(CONFIG_GPIO_104_IDIO_16)	+= gpio-104-idio-16.o
@@ -68,7 +69,6 @@ obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= gpio-mcp23s08.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
-obj-$(CONFIG_GPIO_MOXART)	+= gpio-moxart.o
 obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
 obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
diff --git a/drivers/gpio/gpio-mmio-compat.h b/drivers/gpio/gpio-mmio-compat.h
index 63863da..702a384 100644
--- a/drivers/gpio/gpio-mmio-compat.h
+++ b/drivers/gpio/gpio-mmio-compat.h
@@ -30,6 +30,18 @@ int ge_parse_dt(struct platform_device *pdev,
 #define GPIO_GE_FPGA_COMPATIBLE
 #endif /* CONFIG_CONFIG_GPIO_GE_FPGA */
 
+#if IS_ENABLED(CONFIG_GPIO_MOXART)
+int moxart_parse_dt(struct platform_device *pdev,
+		    struct bgpio_pdata *pdata,
+		    unsigned long *flags);
+
+#define GPIO_MOXART_COMPATIBLE				\
+	ADD("moxa,moxart-gpio", moxart_parse_dt),
+
+#else
+#define GPIO_MOXART_COMPATIBLE
+#endif /* CONFIG_GPIO_MOXART */
+
 #undef ADD
 
 static inline void set_resource_address(struct resource *res,
diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 81af498..fdaf701 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -610,6 +610,7 @@ static const struct of_device_id bgpio_of_match[] = {
 	ADD("linux,gpio-mmio", bgpio_basic_mmio_parse_dt),
 	GPIO_CLPS711X_COMPATIBLE
 	GPIO_GE_FPGA_COMPATIBLE
+	GPIO_MOXART_COMPATIBLE
 
 	{ }
 };
diff --git a/drivers/gpio/gpio-moxart.c b/drivers/gpio/gpio-moxart.c
index d58d389..812b86a 100644
--- a/drivers/gpio/gpio-moxart.c
+++ b/drivers/gpio/gpio-moxart.c
@@ -10,75 +10,36 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/err.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/of_address.h>
-#include <linux/of_gpio.h>
-#include <linux/pinctrl/consumer.h>
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/bitops.h>
+#include <linux/ioport.h>
 #include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
+#include "gpio-mmio-compat.h"
 
 #define GPIO_DATA_OUT		0x00
 #define GPIO_DATA_IN		0x04
 #define GPIO_PIN_DIRECTION	0x08
 
-static int moxart_gpio_probe(struct platform_device *pdev)
+int moxart_parse_dt(struct platform_device *pdev,
+		    struct bgpio_pdata *pdata,
+		    unsigned long *flags)
 {
-	struct device *dev = &pdev->dev;
 	struct resource *res;
-	struct gpio_chip *gc;
-	void __iomem *base;
-	int ret;
-
-	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
-		return -ENOMEM;
+	struct resource nres[] = {
+		DEFINE_RES_MEM_NAMED(0, 1, "dat"),
+		DEFINE_RES_MEM_NAMED(0, 1, "set"),
+		DEFINE_RES_MEM_NAMED(0, 1, "dirout"),
+	};
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	ret = bgpio_init(gc, dev, 4, base + GPIO_DATA_IN,
-			 base + GPIO_DATA_OUT, NULL,
-			 base + GPIO_PIN_DIRECTION, NULL,
-			 BGPIOF_READ_OUTPUT_REG_SET);
-	if (ret) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
-		return ret;
-	}
-
-	gc->label = "moxart-gpio";
-	gc->request = gpiochip_generic_request;
-	gc->free = gpiochip_generic_free;
-	gc->base = 0;
-	gc->owner = THIS_MODULE;
-
-	ret = devm_gpiochip_add_data(dev, gc, NULL);
-	if (ret) {
-		dev_err(dev, "%s: gpiochip_add failed\n",
-			dev->of_node->full_name);
-		return ret;
-	}
-
-	return ret;
+	if (!res || resource_size(res) != 12)
+		return -EINVAL;
+
+	*flags |= BGPIOF_READ_OUTPUT_REG_SET;
+	set_resource_address(&nres[0], res->start + GPIO_DATA_IN, 0x4);
+	set_resource_address(&nres[1], res->start + GPIO_DATA_OUT, 0x4);
+	set_resource_address(&nres[2], res->start + GPIO_PIN_DIRECTION, 0x4);
+	return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
 }
-
-static const struct of_device_id moxart_gpio_match[] = {
-	{ .compatible = "moxa,moxart-gpio" },
-	{ }
-};
-
-static struct platform_driver moxart_gpio_driver = {
-	.driver	= {
-		.name		= "moxart-gpio",
-		.of_match_table	= moxart_gpio_match,
-	},
-	.probe	= moxart_gpio_probe,
-};
-builtin_platform_driver(moxart_gpio_driver);
-- 
2.8.1
