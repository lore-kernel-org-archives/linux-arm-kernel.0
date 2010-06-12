From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 12 Jun 2010 15:46:03 +0300
Subject: [PATCH] h1940: implement mmc_power function
Message-ID: <1276346763-29309-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/include/mach/h1940-latch.h |    7 +++----
 arch/arm/mach-s3c2410/mach-h1940.c               |   17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
index d8a8327..a29bc1c 100644
--- a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
+++ b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
@@ -39,8 +39,8 @@
 #define H1940_LATCH_UDA_POWER		(1<<24)
 #define H1940_LATCH_AUDIO_POWER		(1<<25)
 #define H1940_LATCH_SM803_ENABLE	(1<<26)
-#define H1940_LATCH_LCD_P4		(1<<27)
-#define H1940_LATCH_CPUQ5		(1<<28)		/* untraced */
+#define H1940_LATCH_LCD_P4			(1<<27)
+#define H1940_LATCH_SD_POWER		(1<<28)
 #define H1940_LATCH_BLUETOOTH_POWER	(1<<29)		/* active high */
 #define H1940_LATCH_LED_GREEN		(1<<30)
 #define H1940_LATCH_LED_FLASH		(1<<31)
@@ -54,8 +54,7 @@
 	H1940_LATCH_LCD_P1		| \
 	H1940_LATCH_LCD_P2		| \
 	H1940_LATCH_LCD_P3		| \
-	H1940_LATCH_MAX1698_nSHUTDOWN   | \
-	H1940_LATCH_CPUQ5
+	H1940_LATCH_MAX1698_nSHUTDOWN
 
 /* control functions */
 
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 779b45b..ddeedad 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -198,10 +198,25 @@ static struct platform_device h1940_device_bluetooth = {
 	.id               = -1,
 };
 
+static void h1940_set_mmc_power(unsigned char power_mode, unsigned short vdd)
+{
+	switch (power_mode) {
+	case MMC_POWER_OFF:
+		h1940_latch_control(H1940_LATCH_SD_POWER, 0);
+		break;
+	case MMC_POWER_UP:
+	case MMC_POWER_ON:
+		h1940_latch_control(0, H1940_LATCH_SD_POWER);
+		break;
+	default:
+		break;
+	}
+}
+
 static struct s3c24xx_mci_pdata h1940_mmc_cfg __initdata = {
 	.gpio_detect   = S3C2410_GPF(5),
 	.gpio_wprotect = S3C2410_GPH(8),
-	.set_power     = NULL,
+	.set_power     = h1940_set_mmc_power,
 	.ocr_avail     = MMC_VDD_32_33,
 };
 
-- 
1.7.1
