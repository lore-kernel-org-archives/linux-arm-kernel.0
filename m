From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Thu, 6 May 2010 00:22:04 +0200
Subject: [PATCH 8/9] Add support for power on/off on Acer n30 / Acer n35 MMC
	card reader
In-Reply-To: <4BE1EF47.8030903@vscht.cz>
References: <4BE1EBFE.9080601@vscht.cz> <4BE1ED3E.1050201@vscht.cz>
	<4BE1ED86.3010506@vscht.cz> <4BE1EE5F.5090402@vscht.cz>
	<4BE1EE8C.8040900@vscht.cz> <4BE1EEB1.9060006@vscht.cz>
	<4BE1EF47.8030903@vscht.cz>
Message-ID: <4BE1EF8C.5000702@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 389b9f2..4b2a708 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -352,12 +352,26 @@ static struct s3c2410fb_mach_info n30_fb_info __initdata = {
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
 	.wprotect_invert = 0,
 	.detect_invert  = 0,
 	.gpio_detect	= S3C2410_GPF(1),
 	.gpio_wprotect  = S3C2410_GPG(10),
-	.set_power	= NULL,
+	.set_power	= n30_sdi_set_power,
 	.ocr_avail	= MMC_VDD_32_33,
 };

-- 
1.7.1
