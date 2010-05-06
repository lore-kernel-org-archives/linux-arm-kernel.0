From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Thu, 6 May 2010 15:23:24 +0200
Subject: [PATCH 7/8] Add support for power on/off on Acer n30 / Acer n35 MMC
	card reader
In-Reply-To: <4BE2C294.7030300@vscht.cz>
References: <4BE1EBFE.9080601@vscht.cz> <4BE1ED3E.1050201@vscht.cz>
	<4BE1ED86.3010506@vscht.cz> <4BE1EE5F.5090402@vscht.cz>
	<4BE1EE8C.8040900@vscht.cz>
	<20100506012258.GZ6684@trinity.fluff.org>
	<4BE2C18E.6080207@vscht.cz> <4BE2C1D7.4030408@vscht.cz>
	<4BE2C224.7080907@vscht.cz> <4BE2C24C.9050008@vscht.cz>
	<4BE2C26E.2080508@vscht.cz> <4BE2C294.7030300@vscht.cz>
Message-ID: <4BE2C2CC.2010003@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 81973aa..f25275e 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -352,10 +352,25 @@ static struct s3c2410fb_mach_info n30_fb_info __initdata = {
 	.lpcsel		= 0x06,
 };

+static void n30_sdi_set_power(unsigned char power_mode, unsigned short vdd)
+{
+	switch (power_mode) {
+	case MMC_POWER_ON:
+	case MMC_POWER_UP:
+		s3c2410_gpio_setpin(S3C2410_GPG(4), 1);
+		break;
+	case MMC_POWER_OFF:
+	default:
+		s3c2410_gpio_setpin(S3C2410_GPG(4), 0);
+		break;
+	}
+}
+
 static struct s3c24xx_mci_pdata n30_mci_cfg __initdata = {
 	.gpio_detect	= S3C2410_GPF(1),
 	.gpio_wprotect  = S3C2410_GPG(10),
 	.ocr_avail	= MMC_VDD_32_33,
+	.set_power	= n30_sdi_set_power,
 };

 static struct platform_device *n30_devices[] __initdata = {
-- 
1.7.1
