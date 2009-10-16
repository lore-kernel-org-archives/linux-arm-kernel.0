From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:21 -0700
Subject: [PATCH 17/46] davinci: Add support for Sharp LCD035Q3DG01 graphical
	LCD
In-Reply-To: <1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark A. Greer <mgreer@mvista.com>

Add support for the Sharp LCD035Q3DG01 graphical LCD.  This
requires a minor interface change to da8xx_register_lcdc()
so that the board code can pass in the platform_data which
describes the lcd controller that's to be used.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c    |    2 +-
 arch/arm/mach-davinci/devices-da8xx.c      |   25 ++++++++++++++-----------
 arch/arm/mach-davinci/include/mach/da8xx.h |    6 +++++-
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index fbc7aae..da1a6fb 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -377,7 +377,7 @@ static __init void da850_evm_init(void)
 		pr_warning("da850_evm_init: lcd initialization failed: %d\n",
 				ret);
 
-	ret = da8xx_register_lcdc();
+	ret = da8xx_register_lcdc(&sharp_lk043t1dg01_pdata);
 	if (ret)
 		pr_warning("da850_evm_init: lcdc registration failed: %d\n",
 				ret);
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 0102e0a..5595613 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -21,7 +21,6 @@
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
-#include <video/da8xx-fb.h>
 
 #include "clock.h"
 
@@ -381,10 +380,16 @@ static struct lcd_ctrl_config lcd_cfg = {
 	.raster_order		= 0,
 };
 
-static struct da8xx_lcdc_platform_data da850_evm_lcdc_pdata = {
-	.manu_name = "sharp",
-	.controller_data = &lcd_cfg,
-	.type = "Sharp_LK043T1DG01",
+struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata = {
+	.manu_name		= "sharp",
+	.controller_data	= &lcd_cfg,
+	.type			= "Sharp_LCD035Q3DG01",
+};
+
+struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata = {
+	.manu_name		= "sharp",
+	.controller_data	= &lcd_cfg,
+	.type			= "Sharp_LK043T1DG01",
 };
 
 static struct resource da8xx_lcdc_resources[] = {
@@ -400,19 +405,17 @@ static struct resource da8xx_lcdc_resources[] = {
 	},
 };
 
-static struct platform_device da850_lcdc_device = {
+static struct platform_device da8xx_lcdc_device = {
 	.name		= "da8xx_lcdc",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(da8xx_lcdc_resources),
 	.resource	= da8xx_lcdc_resources,
-	.dev = {
-		.platform_data = &da850_evm_lcdc_pdata,
-	}
 };
 
-int __init da8xx_register_lcdc(void)
+int __init da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata)
 {
-	return platform_device_register(&da850_lcdc_device);
+	da8xx_lcdc_device.dev.platform_data = pdata;
+	return platform_device_register(&da8xx_lcdc_device);
 }
 
 static struct resource da8xx_mmcsd0_resources[] = {
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index ec2821b..375a3f7 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -11,6 +11,8 @@
 #ifndef __ASM_ARCH_DAVINCI_DA8XX_H
 #define __ASM_ARCH_DAVINCI_DA8XX_H
 
+#include <video/da8xx-fb.h>
+
 #include <mach/serial.h>
 #include <mach/edma.h>
 #include <mach/i2c.h>
@@ -76,12 +78,14 @@ int da8xx_register_edma(void);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
 int da8xx_register_watchdog(void);
 int da8xx_register_emac(void);
-int da8xx_register_lcdc(void);
+int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
 int da8xx_register_mmcsd0(struct davinci_mmc_config *config);
 void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata);
 
 extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
+extern struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata;
+extern struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata;
 
 extern const short da830_emif25_pins[];
 extern const short da830_spi0_pins[];
-- 
1.6.4.3
