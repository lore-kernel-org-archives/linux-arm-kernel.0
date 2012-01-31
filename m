From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 31 Jan 2012 13:44:07 +0000 (GMT)
Subject: [PATCH v3 2/2] pxa/hx4700: Add PCMCIA/CF support
Message-ID: <1328017447.95186.YahooMailClassic@web29002.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCMCIA/CF support for the HP iPAQ hx4700. Underlying support is provided by
the pcmcia/pxa2xx_hx4700 platform_device implementation which hooks into the
existing pxa2xx-pcmcia driver.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V3:
Split into two patches: one for kernel drivers, one for hx4700 platform glue.
Rebased to linux-3.3-rc1.

diff -uprN clean-3.3-rc1/arch/arm/mach-pxa/hx4700.c linux-3.3-rc1/arch/arm/mach-pxa/hx4700.c
--- clean-3.3-rc1/arch/arm/mach-pxa/hx4700.c	2012-01-19 23:04:48.000000000 +0000
+++ linux-3.3-rc1/arch/arm/mach-pxa/hx4700.c	2012-01-31 13:21:31.124122619 +0000
@@ -225,7 +225,6 @@ static u16 asic3_gpio_config[] = {
 	ASIC3_GPIOC0_LED0,		/* red */
 	ASIC3_GPIOC1_LED1,		/* green */
 	ASIC3_GPIOC2_LED2,		/* blue */
-	ASIC3_GPIOC4_CF_nCD,
 	ASIC3_GPIOC5_nCIOW,
 	ASIC3_GPIOC6_nCIOR,
 	ASIC3_GPIOC7_nPCE_1,
@@ -239,6 +238,7 @@ static u16 asic3_gpio_config[] = {
 	ASIC3_GPIOC15_nPIOR,
 
 	/* GPIOD: input GPIOs, CF */
+	ASIC3_GPIOD4_CF_nCD,
 	ASIC3_GPIOD11_nCIOIS16,
 	ASIC3_GPIOD12_nCWAIT,
 	ASIC3_GPIOD15_nPIOW,
@@ -765,17 +765,6 @@ static struct i2c_board_info __initdata
 };
 
 /*
- * PCMCIA
- */
-
-static struct platform_device pcmcia = {
-	.name = "hx4700-pcmcia",
-	.dev  = {
-		.parent = &asic3.dev,
-	},
-};
-
-/*
  * Platform devices
  */
 
@@ -790,7 +779,6 @@ static struct platform_device *devices[]
 	&gpio_vbus,
 	&power_supply,
 	&strataflash,
-	&pcmcia,
 };
 
 static struct gpio global_gpios[] = {
diff -uprN clean-3.3-rc1/include/linux/mfd/asic3.h linux-3.3-rc1/include/linux/mfd/asic3.h
--- clean-3.3-rc1/include/linux/mfd/asic3.h	2012-01-19 23:04:48.000000000 +0000
+++ linux-3.3-rc1/include/linux/mfd/asic3.h	2012-01-31 13:21:31.124122619 +0000
@@ -138,6 +138,7 @@ struct asic3_platform_data {
 #define ASIC3_GPIOC13_nPWAIT		ASIC3_CONFIG_GPIO(45, 1, 1, 0)
 #define ASIC3_GPIOC14_nPIOIS16		ASIC3_CONFIG_GPIO(46, 1, 1, 0)
 #define ASIC3_GPIOC15_nPIOR		ASIC3_CONFIG_GPIO(47, 1, 0, 0)
+#define ASIC3_GPIOD4_CF_nCD		ASIC3_CONFIG_GPIO(52, 1, 0, 0)
 #define ASIC3_GPIOD11_nCIOIS16		ASIC3_CONFIG_GPIO(59, 1, 0, 0)
 #define ASIC3_GPIOD12_nCWAIT		ASIC3_CONFIG_GPIO(60, 1, 0, 0)
 #define ASIC3_GPIOD15_nPIOW		ASIC3_CONFIG_GPIO(63, 1, 0, 0)
