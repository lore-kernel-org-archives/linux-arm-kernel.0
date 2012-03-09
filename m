From: lost.distance@yahoo.com (Paul Parsons)
Date: Fri, 9 Mar 2012 14:56:49 +0000 (GMT)
Subject: [PATCH 2/2 v5] pxa/hx4700: Add PCMCIA/CF support
Message-ID: <1331305009.57620.YahooMailClassic@web29018.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCMCIA/CF support for the HP iPAQ hx4700. Underlying support is provided by
the pcmcia/pxa2xx_hx4700 platform_device implementation which hooks into the
existing pxa2xx-pcmcia driver.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V5:
Separated removal of old pcmcia platform_device structure (which is unrelated,
and whose patch hunks fail to apply against linux-3.3-rc6) into a new patch.
Rebased to linux-3.3-rc6.

diff -uprN clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c
--- clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-04 01:08:09.000000000 +0000
+++ linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-09 13:58:39.421923593 +0000
@@ -226,7 +226,6 @@ static u16 asic3_gpio_config[] = {
 	ASIC3_GPIOC0_LED0,		/* red */
 	ASIC3_GPIOC1_LED1,		/* green */
 	ASIC3_GPIOC2_LED2,		/* blue */
-	ASIC3_GPIOC4_CF_nCD,
 	ASIC3_GPIOC5_nCIOW,
 	ASIC3_GPIOC6_nCIOR,
 	ASIC3_GPIOC7_nPCE_1,
@@ -240,6 +239,7 @@ static u16 asic3_gpio_config[] = {
 	ASIC3_GPIOC15_nPIOR,
 
 	/* GPIOD: input GPIOs, CF */
+	ASIC3_GPIOD4_CF_nCD,
 	ASIC3_GPIOD11_nCIOIS16,
 	ASIC3_GPIOD12_nCWAIT,
 	ASIC3_GPIOD15_nPIOW,
diff -uprN clean-3.3-rc6/include/linux/mfd/asic3.h linux-3.3-rc6/include/linux/mfd/asic3.h
--- clean-3.3-rc6/include/linux/mfd/asic3.h	2012-03-04 01:08:09.000000000 +0000
+++ linux-3.3-rc6/include/linux/mfd/asic3.h	2012-03-09 13:58:39.421923593 +0000
@@ -138,6 +138,7 @@ struct asic3_platform_data {
 #define ASIC3_GPIOC13_nPWAIT		ASIC3_CONFIG_GPIO(45, 1, 1, 0)
 #define ASIC3_GPIOC14_nPIOIS16		ASIC3_CONFIG_GPIO(46, 1, 1, 0)
 #define ASIC3_GPIOC15_nPIOR		ASIC3_CONFIG_GPIO(47, 1, 0, 0)
+#define ASIC3_GPIOD4_CF_nCD		ASIC3_CONFIG_GPIO(52, 1, 0, 0)
 #define ASIC3_GPIOD11_nCIOIS16		ASIC3_CONFIG_GPIO(59, 1, 0, 0)
 #define ASIC3_GPIOD12_nCWAIT		ASIC3_CONFIG_GPIO(60, 1, 0, 0)
 #define ASIC3_GPIOD15_nPIOW		ASIC3_CONFIG_GPIO(63, 1, 0, 0)
