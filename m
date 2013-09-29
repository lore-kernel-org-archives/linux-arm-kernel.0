From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 29 Sep 2013 18:12:01 +0200
Subject: [PATCH] ARM: s3c64xx: mini6410: Correct card detect type for HSMMC1
Message-ID: <1380471121-9478-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to board schematics, for HSMMC1 a GPIO line is used to detect
card presence, while currently it is being configured for internal card
detect line, which is multiplexed with card detect line of HSMMC0 and
thus breaking it.

This patch adds proper sdhci platform data setting card detect type to
external GPIO and fixing operation of HSMMC0.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-mini6410.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 58d46a3..97ae470 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -36,7 +36,9 @@
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
+#include <linux/platform_data/mmc-sdhci-s3c.h>
 #include <plat/regs-serial.h>
+#include <plat/sdhci.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 
 #include <video/platform_lcd.h>
@@ -214,6 +216,13 @@ static struct platform_device mini6410_lcd_powerdev = {
 	.dev.platform_data	= &mini6410_lcd_power_data,
 };
 
+static struct s3c_sdhci_platdata mini6410_hsmmc1_pdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S3C64XX_GPN(10),
+	.ext_cd_gpio_invert	= true,
+};
+
 static struct platform_device *mini6410_devices[] __initdata = {
 	&mini6410_device_eth,
 	&s3c_device_hsmmc0,
@@ -321,6 +330,7 @@ static void __init mini6410_machine_init(void)
 
 	s3c_nand_set_platdata(&mini6410_nand_info);
 	s3c_fb_set_platdata(&mini6410_lcd_pdata[features.lcd_index]);
+	s3c_sdhci1_set_platdata(&mini6410_hsmmc1_pdata);
 	s3c24xx_ts_set_platdata(NULL);
 
 	/* configure nCS1 width to 16 bits */
-- 
1.8.3.2
