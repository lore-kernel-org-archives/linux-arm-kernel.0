From: augulis.darius@gmail.com (Darius Augulis)
Date: Wed, 29 Sep 2010 22:36:42 +0300
Subject: [PATCH 8/9] ARM: S3C64XX: add backlight control for mach-mini6410
In-Reply-To: <20100929192354.25307.40197.stgit@darius-desktop>
References: <20100929192354.25307.40197.stgit@darius-desktop>
Message-ID: <20100929193609.25307.32546.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for platform-lcd device for mach-mini6410

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-mini6410.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 331f7e0..90f1976 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -40,6 +40,7 @@
 #include <plat/fb.h>
 #include <plat/nand.h>
 #include <plat/regs-serial.h>
+#include <video/platform_lcd.h>
 
 #define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
@@ -182,6 +183,25 @@ static struct s3c_fb_platdata mini6410_lcd_pdata __initdata = {
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 };
 
+static void mini6410_lcd_power_set(struct plat_lcd_data *pd,
+				   unsigned int power)
+{
+	if (power)
+		gpio_direction_output(S3C64XX_GPE(0), 1);
+	else
+		gpio_direction_output(S3C64XX_GPE(0), 0);
+}
+
+static struct plat_lcd_data mini6410_lcd_power_data = {
+	.set_power	= mini6410_lcd_power_set,
+};
+
+static struct platform_device mini6410_lcd_powerdev = {
+	.name			= "platform-lcd",
+	.dev.parent		= &s3c_device_fb.dev,
+	.dev.platform_data	= &mini6410_lcd_power_data,
+};
+
 static struct platform_device *mini6410_devices[] __initdata = {
 	&mini6410_device_eth,
 	&s3c_device_hsmmc0,
@@ -189,6 +209,7 @@ static struct platform_device *mini6410_devices[] __initdata = {
 	&s3c_device_ohci,
 	&s3c_device_nand,
 	&s3c_device_fb,
+	&mini6410_lcd_powerdev,
 };
 
 static void __init mini6410_map_io(void)
