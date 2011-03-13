From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 13 Mar 2011 17:19:19 +0200
Subject: [PATCH v2 3/6] ARM: PXA: Z2: Fix libertas init/tear down sequences
In-Reply-To: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
References: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1300029562-8400-4-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO15 seems to be not related to WiFi, so don't touch it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/include/mach/z2.h |    3 +--
 arch/arm/mach-pxa/z2.c              |   31 ++++++++-----------------------
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/z2.h b/arch/arm/mach-pxa/include/mach/z2.h
index 8835c16..7b0f71e 100644
--- a/arch/arm/mach-pxa/include/mach/z2.h
+++ b/arch/arm/mach-pxa/include/mach/z2.h
@@ -25,8 +25,7 @@
 #define	GPIO98_ZIPITZ2_LID_BUTTON	98
 
 /* Libertas GSPI8686 WiFi */
-#define	GPIO14_ZIPITZ2_WIFI_RESET	14
-#define	GPIO15_ZIPITZ2_WIFI_POWER	15
+#define	GPIO14_ZIPITZ2_WIFI_POWER	14
 #define	GPIO24_ZIPITZ2_WIFI_CS		24
 #define	GPIO36_ZIPITZ2_WIFI_IRQ		36
 
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index b58274e..2c5a5cc 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -138,8 +138,7 @@ static unsigned long z2_pin_config[] = {
 	GPIO1_GPIO,		/* Power button */
 	GPIO37_GPIO,		/* Headphone detect */
 	GPIO98_GPIO,		/* Lid switch */
-	GPIO14_GPIO,		/* WiFi Reset */
-	GPIO15_GPIO,		/* WiFi Power */
+	GPIO14_GPIO,		/* WiFi Power */
 	GPIO24_GPIO,		/* WiFi CS */
 	GPIO36_GPIO,		/* WiFi IRQ */
 	GPIO88_GPIO,		/* LCD CS */
@@ -511,26 +510,16 @@ static int z2_lbs_spi_setup(struct spi_device *spi)
 {
 	int ret = 0;
 
-	ret = gpio_request(GPIO15_ZIPITZ2_WIFI_POWER, "WiFi Power");
+	ret = gpio_request(GPIO14_ZIPITZ2_WIFI_POWER, "WiFi Power");
 	if (ret)
 		goto err;
 
-	ret = gpio_direction_output(GPIO15_ZIPITZ2_WIFI_POWER, 1);
+	ret = gpio_direction_output(GPIO14_ZIPITZ2_WIFI_POWER, 1);
 	if (ret)
 		goto err2;
 
-	ret = gpio_request(GPIO14_ZIPITZ2_WIFI_RESET, "WiFi Reset");
-	if (ret)
-		goto err2;
-
-	ret = gpio_direction_output(GPIO14_ZIPITZ2_WIFI_RESET, 0);
-	if (ret)
-		goto err3;
-
-	/* Reset the card */
+	/* Wait until card is powered on */
 	mdelay(180);
-	gpio_set_value(GPIO14_ZIPITZ2_WIFI_RESET, 1);
-	mdelay(20);
 
 	spi->bits_per_word = 16;
 	spi->mode = SPI_MODE_2,
@@ -539,22 +528,18 @@ static int z2_lbs_spi_setup(struct spi_device *spi)
 
 	return 0;
 
-err3:
-	gpio_free(GPIO14_ZIPITZ2_WIFI_RESET);
 err2:
-	gpio_free(GPIO15_ZIPITZ2_WIFI_POWER);
+	gpio_free(GPIO14_ZIPITZ2_WIFI_POWER);
 err:
 	return ret;
 };
 
 static int z2_lbs_spi_teardown(struct spi_device *spi)
 {
-	gpio_set_value(GPIO14_ZIPITZ2_WIFI_RESET, 0);
-	gpio_set_value(GPIO15_ZIPITZ2_WIFI_POWER, 0);
-	gpio_free(GPIO14_ZIPITZ2_WIFI_RESET);
-	gpio_free(GPIO15_ZIPITZ2_WIFI_POWER);
-	return 0;
+	gpio_set_value(GPIO14_ZIPITZ2_WIFI_POWER, 0);
+	gpio_free(GPIO14_ZIPITZ2_WIFI_POWER);
 
+	return 0;
 };
 
 static struct pxa2xx_spi_chip z2_lbs_chip_info = {
-- 
1.7.4.1
