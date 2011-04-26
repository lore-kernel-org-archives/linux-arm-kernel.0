From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 26 Apr 2011 13:57:52 -0700
Subject: [RFC] ep93xx: switch gpio to early platform device
Message-ID: <201104261357.53245.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the ep93xx gpio support into an early platform device. 

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8207954..e2d9e3e 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -241,6 +241,27 @@ unsigned int ep93xx_chip_revision(void)
 }
 
 /*************************************************************************
+ * EP93xx gpio
+ *************************************************************************/
+static struct platform_device ep93xx_gpio_device = {
+	.name		= "ep93xx-gpio",
+	.id		= -1,
+};
+
+static struct platform_device *ep93xx_early_gpio_device[] __initdata = {
+	&ep93xx_gpio_device,
+};
+
+static void __init ep93xx_init_early_gpio(void)
+{
+	int num = ARRAY_SIZE(ep93xx_early_gpio_device);
+
+	early_platform_add_devices(ep93xx_early_gpio_device, num);
+	early_platform_driver_register_all("early_ep93xx_gpio");
+	early_platform_driver_probe("early_ep93xx_gpio", num, 0);
+}
+
+/*************************************************************************
  * EP93xx peripheral handling
  *************************************************************************/
 #define EP93XX_UART_MCR_OFFSET		(0x0100)
@@ -866,14 +887,12 @@ void __init ep93xx_register_ac97(void)
 	platform_device_register(&ep93xx_pcm_device);
 }
 
-extern void ep93xx_gpio_init(void);
-
 void __init ep93xx_init_devices(void)
 {
 	/* Disallow access to MaverickCrunch initially */
 	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_CPENA);
 
-	ep93xx_gpio_init();
+	ep93xx_init_early_gpio();
 
 	amba_device_register(&uart1_device, &iomem_resource);
 	amba_device_register(&uart2_device, &iomem_resource);
diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
index a5a9ff7..e820316 100644
--- a/arch/arm/mach-ep93xx/gpio.c
+++ b/arch/arm/mach-ep93xx/gpio.c
@@ -4,6 +4,7 @@
  * Generic EP93xx GPIO handling
  *
  * Copyright (c) 2008 Ryan Mallon <ryan@bluewatersys.com>
+ * Copyright (c) 2011 H Hartley Sweeten <hsweeten@visionengravers.com>
  *
  * Based on code originally from:
  *  linux/arch/arm/mach-ep93xx/core.c
@@ -13,10 +14,9 @@
  *  published by the Free Software Foundation.
  */
 
-#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/init.h>
-#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
@@ -406,10 +406,15 @@ static struct ep93xx_gpio_chip ep93xx_gpio_banks[] = {
 	EP93XX_GPIO_BANK("H", 0x40, 0x44, 56),
 };
 
-void __init ep93xx_gpio_init(void)
+static int __devinit ep93xx_gpio_probe(struct platform_device *pdev)
 {
 	int i;
 
+	if (!is_early_platform_device(pdev)) {
+		pr_info("called via non early platform\n");
+		return 0;
+	}
+
 	/* Set Ports C, D, E, G, and H for GPIO use */
 	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
 				 EP93XX_SYSCON_DEVCFG_GONK |
@@ -431,4 +436,22 @@ void __init ep93xx_gpio_init(void)
 
 		gpiochip_add(chip);
 	}
+
+	pr_info("subsystem initialized\n");
+	return 0;
+}
+
+static int __devexit ep93xx_gpio_remove(struct platform_device *pdev)
+{
+	return -EBUSY;
 }
+
+static struct platform_driver ep93xx_gpio_driver = {
+	.driver		= {
+		.name	= "ep93xx-gpio",
+	},
+	.probe		= ep93xx_gpio_probe,
+	.remove		= __devexit_p(ep93xx_gpio_remove),
+};
+
+early_platform_init("early_ep93xx_gpio", &ep93xx_gpio_driver);
