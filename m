From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 7 May 2011 22:29:16 +0200
Subject: [PATCH 4/4] ARM: S3C2416: Add support for USB 2.0 High-Speed gadget
	controller
In-Reply-To: <201105072223.44163.heiko@sntech.de>
References: <Pine.LNX.4.44L0.1104141313210.2487-100000@iolanthe.rowland.org>
	<20110416145830.GA8811@kroah.com>
	<201105072223.44163.heiko@sntech.de>
Message-ID: <201105072229.16703.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Add support for USB 2.0 High-Speed gadget controller driver for Samsung's
S3C2416 processor.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s3c2416/mach-smdk2416.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index 3f83177..ac27ebb 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -23,6 +23,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/gpio.h>
 #include <linux/fb.h>
+#include <linux/delay.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -35,6 +36,7 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/regs-s3c2443-clock.h>
 
 #include <mach/idle.h>
 #include <mach/leds-gpio.h>
@@ -47,6 +49,7 @@
 #include <plat/cpu.h>
 #include <plat/nand.h>
 #include <plat/sdhci.h>
+#include <plat/udc.h>
 
 #include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
@@ -121,6 +124,27 @@ static struct s3c2410_uartcfg smdk2416_uartcfgs[] __initdata = {
 	}
 };
 
+void smdk2416_hsudc_gpio_init(void)
+{
+	s3c_gpio_setpull(S3C2410_GPH(14), S3C_GPIO_PULL_UP);
+	s3c_gpio_setpull(S3C2410_GPF(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgpin(S3C2410_GPH(14), S3C_GPIO_SFN(1));
+	s3c2410_modify_misccr(S3C2416_MISCCR_SEL_SUSPND, 0);
+}
+
+void smdk2416_hsudc_gpio_uninit(void)
+{
+	s3c2410_modify_misccr(S3C2416_MISCCR_SEL_SUSPND, 1);
+	s3c_gpio_setpull(S3C2410_GPH(14), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgpin(S3C2410_GPH(14), S3C_GPIO_SFN(0));
+}
+
+struct s3c24xx_hsudc_platdata smdk2416_hsudc_platdata = {
+	.epnum = 9,
+	.gpio_init = smdk2416_hsudc_gpio_init,
+	.gpio_uninit = smdk2416_hsudc_gpio_uninit,
+};
+
 struct s3c_fb_pd_win smdk2416_fb_win[] = {
 	[0] = {
 		/* think this is the same as the smdk6410 */
@@ -186,6 +210,7 @@ static struct platform_device *smdk2416_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
+	&s3c_device_usb_hsudc,
 };
 
 static void __init smdk2416_map_io(void)
@@ -203,6 +228,8 @@ static void __init smdk2416_machine_init(void)
 	s3c_sdhci0_set_platdata(&smdk2416_hsmmc0_pdata);
 	s3c_sdhci1_set_platdata(&smdk2416_hsmmc1_pdata);
 
+	s3c24xx_hsudc_set_platdata(&smdk2416_hsudc_platdata);
+
 	gpio_request(S3C2410_GPB(4), "USBHost Power");
 	gpio_direction_output(S3C2410_GPB(4), 1);
 
-- 
1.7.2.3
