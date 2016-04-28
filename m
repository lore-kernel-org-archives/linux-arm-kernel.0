From: chunkeey@googlemail.com (Christian Lamparter)
Date: Thu, 28 Apr 2016 11:05:15 +0200
Subject: [RFC v4 5/8] gpio: ge: integrate GE's FPGA GPIO into gpio-mmio
In-Reply-To: <cover.1461806071.git.chunkeey@googlemail.com>
References: <cover.1461806071.git.chunkeey@googlemail.com>
Message-ID: <dff18619d8d69b8321a3023defe185cd71fa75e7.1461806071.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch integrates the gpio-ge driver into the
gpio-mmio framework.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/gpio/Kconfig            |  24 +++++-----
 drivers/gpio/Makefile           |   2 +-
 drivers/gpio/gpio-ge.c          | 101 ++++++++++++----------------------------
 drivers/gpio/gpio-mmio-compat.h |  14 ++++++
 drivers/gpio/gpio-mmio.c        |   1 +
 5 files changed, 57 insertions(+), 85 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ff9ac65..a0e140d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -187,18 +187,6 @@ config GPIO_ETRAXFS
 	help
 	  Say yes here to support the GPIO controller on Axis ETRAX FS SoCs.
 
-config GPIO_GE_FPGA
-	bool "GE FPGA based GPIO"
-	depends on GE_FPGA
-	select GPIO_GENERIC
-	help
-	  Support for common GPIO functionality provided on some GE Single Board
-	  Computers.
-
-	  This driver provides basic support (configure as input or output, read
-	  and write pin state) for GPIO implemented in a number of GE single
-	  board computers.
-
 config GPIO_GENERIC_PLATFORM
 	tristate "Generic memory-mapped GPIO controller support (MMIO platform device)"
 	select GPIO_GENERIC
@@ -213,6 +201,18 @@ config GPIO_CLPS711X
 	help
 	  Say yes here to support GPIO on CLPS711X SoCs.
 
+config GPIO_GE_FPGA
+	bool "GE FPGA based GPIO"
+	depends on GE_FPGA || COMPILE_TEST
+	select GPIO_GENERIC
+	help
+	  Support for common GPIO functionality provided on some GE Single Board
+	  Computers.
+
+	  This driver provides basic support (configure as input or output, read
+	  and write pin state) for GPIO implemented in a number of GE single
+	  board computers.
+
 endif
 
 config GPIO_GRGPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a1ae48f..a76b13d 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_GPIO_GENERIC)	+= gpio-generic.o
 # directly supported by gpio-generic
 gpio-generic-$(CONFIG_GPIO_GENERIC)	+= gpio-mmio.o
 gpio-generic-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
+gpio-generic-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 
 obj-$(CONFIG_GPIO_104_DIO_48E)	+= gpio-104-dio-48e.o
 obj-$(CONFIG_GPIO_104_IDIO_16)	+= gpio-104-idio-16.o
@@ -43,7 +44,6 @@ obj-$(CONFIG_GPIO_EM)		+= gpio-em.o
 obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_ETRAXFS)	+= gpio-etraxfs.o
 obj-$(CONFIG_GPIO_F7188X)	+= gpio-f7188x.o
-obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
 obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 8650b29..63cea89 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -18,13 +18,12 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/of_device.h>
-#include <linux/of_gpio.h>
-#include <linux/of_address.h>
 #include <linux/module.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
 #include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
+#include "gpio-mmio-compat.h"
 
 #define GEF_GPIO_DIRECT		0x00
 #define GEF_GPIO_IN		0x04
@@ -36,79 +35,37 @@
 #define GEF_GPIO_OVERRUN	0x1C
 #define GEF_GPIO_MODE		0x20
 
-static const struct of_device_id gef_gpio_ids[] = {
-	{
-		.compatible	= "gef,sbc610-gpio",
-		.data		= (void *)19,
-	}, {
-		.compatible	= "gef,sbc310-gpio",
-		.data		= (void *)6,
-	}, {
-		.compatible	= "ge,imp3a-gpio",
-		.data		= (void *)16,
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, gef_gpio_ids);
-
-static int __init gef_gpio_probe(struct platform_device *pdev)
+int ge_parse_dt(struct platform_device *pdev,
+	       struct bgpio_pdata *pdata,
+	       unsigned long *flags)
 {
-	const struct of_device_id *of_id =
-		of_match_device(gef_gpio_ids, &pdev->dev);
-	struct gpio_chip *gc;
-	void __iomem *regs;
-	int ret;
-
-	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
-		return -ENOMEM;
-
-	regs = of_iomap(pdev->dev.of_node, 0);
-	if (!regs)
-		return -ENOMEM;
-
-	ret = bgpio_init(gc, &pdev->dev, 4, regs + GEF_GPIO_IN,
-			 regs + GEF_GPIO_OUT, NULL, NULL,
-			 regs + GEF_GPIO_DIRECT, BGPIOF_BIG_ENDIAN_BYTE_ORDER);
-	if (ret) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
-		goto err0;
-	}
+	struct device_node *np = pdev->dev.of_node;
 
-	/* Setup pointers to chip functions */
-	gc->label = devm_kstrdup(&pdev->dev, pdev->dev.of_node->full_name,
-				     GFP_KERNEL);
-	if (!gc->label) {
-		ret = -ENOMEM;
-		goto err0;
-	}
+	struct resource *res;
+	struct resource nres[] = {
+		DEFINE_RES_MEM_NAMED(0, 1, "dat"),
+		DEFINE_RES_MEM_NAMED(0, 1, "set"),
+		DEFINE_RES_MEM_NAMED(0, 1, "dirin"),
+	};
 
-	gc->base = -1;
-	gc->ngpio = (u16)(uintptr_t)of_id->data;
-	gc->of_gpio_n_cells = 2;
-	gc->of_node = pdev->dev.of_node;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res || resource_size(res) != 0x24)
+		return -EINVAL;
 
-	/* This function adds a memory mapped GPIO chip */
-	ret = devm_gpiochip_add_data(&pdev->dev, gc, NULL);
-	if (ret)
-		goto err0;
+	set_resource_address(&nres[0], res->start + GEF_GPIO_IN, 0x4);
+	set_resource_address(&nres[1], res->start + GEF_GPIO_OUT, 0x4);
+	set_resource_address(&nres[2], res->start + GEF_GPIO_DIRECT, 0x4);
+	*flags |= BGPIOF_BIG_ENDIAN_BYTE_ORDER;
 
-	return 0;
-err0:
-	iounmap(regs);
-	pr_err("%s: GPIO chip registration failed\n",
-			pdev->dev.of_node->full_name);
-	return ret;
-};
+	if (of_device_is_compatible(np, "ge,imp3a-gpio"))
+		pdata->ngpio = 16;
+	else if (of_device_is_compatible(np, "gef,sbc310-gpio"))
+		pdata->ngpio = 6;
+	else if (of_device_is_compatible(np, "gef,sbc610-gpio"))
+		pdata->ngpio = 19;
 
-static struct platform_driver gef_gpio_driver = {
-	.driver = {
-		.name		= "gef-gpio",
-		.of_match_table	= gef_gpio_ids,
-	},
-};
-module_platform_driver_probe(gef_gpio_driver, gef_gpio_probe);
+	return platform_device_add_resources(pdev, nres, ARRAY_SIZE(nres));
+}
 
 MODULE_DESCRIPTION("GE I/O FPGA GPIO driver");
 MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-mmio-compat.h b/drivers/gpio/gpio-mmio-compat.h
index 32b5510..63863da 100644
--- a/drivers/gpio/gpio-mmio-compat.h
+++ b/drivers/gpio/gpio-mmio-compat.h
@@ -16,6 +16,20 @@ int cirrus_clps711x_parse_dt(struct platform_device *pdev,
 #define GPIO_CLPS711X_COMPATIBLE
 #endif /* CONFIG_GPIO_CLPS711X */
 
+#if IS_ENABLED(CONFIG_GPIO_GE_FPGA)
+int ge_parse_dt(struct platform_device *pdev,
+		struct bgpio_pdata *pdata,
+		unsigned long *flags);
+
+#define GPIO_GE_FPGA_COMPATIBLE				\
+	ADD("ge,imp3a-gpio", ge_parse_dt),		\
+	ADD("gef,sbc310-gpio", ge_parse_dt),		\
+	ADD("gef,sbc610-gpio", ge_parse_dt),
+
+#else
+#define GPIO_GE_FPGA_COMPATIBLE
+#endif /* CONFIG_CONFIG_GPIO_GE_FPGA */
+
 #undef ADD
 
 static inline void set_resource_address(struct resource *res,
diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 1be8cb7..81af498 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -609,6 +609,7 @@ static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
 static const struct of_device_id bgpio_of_match[] = {
 	ADD("linux,gpio-mmio", bgpio_basic_mmio_parse_dt),
 	GPIO_CLPS711X_COMPATIBLE
+	GPIO_GE_FPGA_COMPATIBLE
 
 	{ }
 };
-- 
2.8.1
