From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue,  7 Sep 2010 18:00:03 +0300
Subject: [PATCH 3/5] h1940: implement mmc_power function
In-Reply-To: <1283871605-32068-1-git-send-email-anarsoul@gmail.com>
References: <1283871605-32068-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1283871605-32068-4-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/include/mach/h1940-latch.h |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c               |   23 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
index 73586f2..ef7d8cf 100644
--- a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
+++ b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
@@ -35,7 +35,7 @@
 #define H1940_LATCH_AUDIO_POWER		H1940_LATCH_GPIO(9)
 #define H1940_LATCH_SM803_ENABLE	H1940_LATCH_GPIO(10)
 #define H1940_LATCH_LCD_P4		H1940_LATCH_GPIO(11)
-#define H1940_LATCH_CPUQ5		H1940_LATCH_GPIO(12)
+#define H1940_LATCH_SD_POWER		H1940_LATCH_GPIO(12)
 #define H1940_LATCH_BLUETOOTH_POWER	H1940_LATCH_GPIO(13)
 #define H1940_LATCH_LED_GREEN		H1940_LATCH_GPIO(14)
 #define H1940_LATCH_LED_FLASH		H1940_LATCH_GPIO(15)
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 2af4afd..1741aa2 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -112,8 +112,7 @@ static unsigned int latch_state = H1940_LATCH_BIT(H1940_LATCH_LCD_P4) |
 	H1940_LATCH_BIT(H1940_LATCH_LCD_P1)			|
 	H1940_LATCH_BIT(H1940_LATCH_LCD_P2)			|
 	H1940_LATCH_BIT(H1940_LATCH_LCD_P3)			|
-	H1940_LATCH_BIT(H1940_LATCH_MAX1698_nSHUTDOWN)   |
-	H1940_LATCH_BIT(H1940_LATCH_CPUQ5);
+	H1940_LATCH_BIT(H1940_LATCH_MAX1698_nSHUTDOWN);
 
 static void h1940_latch_control(unsigned int clear, unsigned int set)
 {
@@ -255,10 +254,25 @@ static struct platform_device h1940_device_bluetooth = {
 	.id               = -1,
 };
 
+static void h1940_set_mmc_power(unsigned char power_mode, unsigned short vdd)
+{
+	switch (power_mode) {
+	case MMC_POWER_OFF:
+		gpio_set_value(H1940_LATCH_SD_POWER, 0);
+		break;
+	case MMC_POWER_UP:
+	case MMC_POWER_ON:
+		gpio_set_value(H1940_LATCH_SD_POWER, 1);
+		break;
+	default:
+		break;
+	};
+}
+
 static struct s3c24xx_mci_pdata h1940_mmc_cfg __initdata = {
 	.gpio_detect   = S3C2410_GPF(5),
 	.gpio_wprotect = S3C2410_GPH(8),
-	.set_power     = NULL,
+	.set_power     = h1940_set_mmc_power,
 	.ocr_avail     = MMC_VDD_32_33,
 };
 
@@ -405,6 +419,9 @@ static void __init h1940_init(void)
 	gpio_request(H1940_LATCH_USB_DP, "USB pullup");
 	gpio_direction_output(H1940_LATCH_USB_DP, 0);
 
+	gpio_request(H1940_LATCH_SD_POWER, "SD power");
+	gpio_direction_output(H1940_LATCH_SD_POWER, 0);
+
 	platform_add_devices(h1940_devices, ARRAY_SIZE(h1940_devices));
 }
 
-- 
1.7.2.2
