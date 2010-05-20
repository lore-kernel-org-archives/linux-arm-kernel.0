From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 11:39:52 +0900
Subject: [PATCH v4 1/3] ARM: S3C64XX: Adds Touchscreen support for S3C64XX
In-Reply-To: <1274323194-16059-1-git-send-email-kgene.kim@samsung.com>
References: <1274323194-16059-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1274323194-16059-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch adds touchscreen support for S3C64XX.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig         |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 69e9fbf..1f2f412 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -90,6 +90,7 @@ config MACH_SMDK6410
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_I2C1
 	select S3C_DEV_FB
+	select SAMSUNG_DEV_TS
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
 	select S3C64XX_SETUP_SDHCI
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 9d51455..d0c6e9b 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -64,6 +64,8 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/adc.h>
+#include <plat/ts.h>
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
@@ -262,6 +264,8 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&smdk6410_lcd_powerdev,
 
 	&smdk6410_smsc911x,
+	&s3c_device_adc,
+	&s3c_device_ts,
 };
 
 #ifdef CONFIG_REGULATOR
@@ -596,6 +600,12 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
 	{ I2C_BOARD_INFO("24c128", 0x57), },	/* Samsung S524AD0XD1 */
 };
 
+static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
+	.delay			= 10000,
+	.presc			= 49,
+	.oversampling_shift	= 2,
+};
+
 static void __init smdk6410_map_io(void)
 {
 	u32 tmp;
@@ -625,6 +635,8 @@ static void __init smdk6410_machine_init(void)
 	s3c_i2c1_set_platdata(NULL);
 	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
 
+	s3c24xx_ts_set_platdata(&s3c_ts_platform);
+
 	/* configure nCS1 width to 16 bits */
 
 	cs1 = __raw_readl(S3C64XX_SROM_BW) &
-- 
