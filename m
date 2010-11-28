From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Sun, 28 Nov 2010 20:30:22 +0200
Subject: [PATCH 04/10] ARM: S3C2416: Add support of SD/MMC card detect on
	SMDK2416
In-Reply-To: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
Message-ID: <1290969027-10178-4-git-send-email-jekhor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable card detect by GPIO pin on hsmmc1 device (SD0 on SMDK2416
board) and enable card polling on hsmmc0 (SD1).

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 arch/arm/mach-s3c2416/mach-smdk2416.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index 7fc3664..ad2497c 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -46,6 +46,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/nand.h>
+#include <plat/sdhci.h>
 
 #include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
@@ -159,6 +160,18 @@ static struct s3c_fb_platdata smdk2416_fb_platdata = {
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 };
 
+static struct s3c_sdhci_platdata smdk2416_hsmmc0_pdata __initdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S3C2410_GPF(1),
+	.ext_cd_gpio_invert	= 1,
+};
+
+static struct s3c_sdhci_platdata smdk2416_hsmmc1_pdata __initdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_NONE,
+};
+
 static struct platform_device *smdk2416_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_wdt,
@@ -180,6 +193,9 @@ static void __init smdk2416_machine_init(void)
 	s3c_i2c0_set_platdata(NULL);
 	s3c_fb_set_platdata(&smdk2416_fb_platdata);
 
+	s3c_sdhci0_set_platdata(&smdk2416_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdk2416_hsmmc1_pdata);
+
 	gpio_request(S3C2410_GPB(4), "USBHost Power");
 	gpio_direction_output(S3C2410_GPB(4), 1);
 
-- 
1.7.2.3
