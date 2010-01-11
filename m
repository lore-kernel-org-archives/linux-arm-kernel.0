From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:24 +0800
Subject: [PATCH 16/16] [ARM] pxa/corgi: cleanup GPIO configurations and low
	power mode settings
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-17-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/corgi.c    |   52 +++++++++++++++++++++++++----------------
 arch/arm/mach-pxa/corgi_pm.c |   39 -------------------------------
 2 files changed, 32 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index ae496b6..adb8ce0 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -106,18 +106,18 @@ static unsigned long corgi_pin_config[] __initdata = {
 	GPIO8_MMC_CS0,
 
 	/* GPIO Matrix Keypad */
-	GPIO66_GPIO,	/* column 0 */
-	GPIO67_GPIO,	/* column 1 */
-	GPIO68_GPIO,	/* column 2 */
-	GPIO69_GPIO,	/* column 3 */
-	GPIO70_GPIO,	/* column 4 */
-	GPIO71_GPIO,	/* column 5 */
-	GPIO72_GPIO,	/* column 6 */
-	GPIO73_GPIO,	/* column 7 */
-	GPIO74_GPIO,	/* column 8 */
-	GPIO75_GPIO,	/* column 9 */
-	GPIO76_GPIO,	/* column 10 */
-	GPIO77_GPIO,	/* column 11 */
+	GPIO66_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 0 */
+	GPIO67_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 1 */
+	GPIO68_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 2 */
+	GPIO69_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 3 */
+	GPIO70_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 4 */
+	GPIO71_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 5 */
+	GPIO72_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 6 */
+	GPIO73_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 7 */
+	GPIO74_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 8 */
+	GPIO75_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 9 */
+	GPIO76_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 10 */
+	GPIO77_GPIO | MFP_LPM_DRIVE_HIGH,	/* column 11 */
 	GPIO58_GPIO,	/* row 0 */
 	GPIO59_GPIO,	/* row 1 */
 	GPIO60_GPIO,	/* row 2 */
@@ -128,17 +128,20 @@ static unsigned long corgi_pin_config[] __initdata = {
 	GPIO65_GPIO,	/* row 7 */
 
 	/* GPIO */
-	GPIO9_GPIO,	/* CORGI_GPIO_nSD_DETECT */
-	GPIO7_GPIO,	/* CORGI_GPIO_nSD_WP */
-	GPIO21_GPIO,	/* CORGI_GPIO_ADC_TEMP */
-	GPIO22_GPIO,	/* CORGI_GPIO_IR_ON */
-	GPIO33_GPIO,	/* CORGI_GPIO_SD_PWR */
-	GPIO38_GPIO,	/* CORGI_GPIO_CHRG_ON */
-	GPIO43_GPIO,	/* CORGI_GPIO_CHRG_UKN */
-	GPIO44_GPIO,	/* CORGI_GPIO_HSYNC */
+	GPIO9_GPIO,				/* CORGI_GPIO_nSD_DETECT */
+	GPIO7_GPIO,				/* CORGI_GPIO_nSD_WP */
+	GPIO11_GPIO | WAKEUP_ON_EDGE_BOTH,	/* CORGI_GPIO_MAIN_BAT_{LOW,COVER} */
+	GPIO13_GPIO | MFP_LPM_KEEP_OUTPUT,	/* CORGI_GPIO_LED_ORANGE */
+	GPIO21_GPIO,				/* CORGI_GPIO_ADC_TEMP */
+	GPIO22_GPIO,				/* CORGI_GPIO_IR_ON */
+	GPIO33_GPIO,				/* CORGI_GPIO_SD_PWR */
+	GPIO38_GPIO | MFP_LPM_KEEP_OUTPUT,	/* CORGI_GPIO_CHRG_ON */
+	GPIO43_GPIO | MFP_LPM_KEEP_OUTPUT,	/* CORGI_GPIO_CHRG_UKN */
+	GPIO44_GPIO,				/* CORGI_GPIO_HSYNC */
 
 	GPIO0_GPIO | WAKEUP_ON_EDGE_BOTH,	/* CORGI_GPIO_KEY_INT */
 	GPIO1_GPIO | WAKEUP_ON_EDGE_RISE,	/* CORGI_GPIO_AC_IN */
+	GPIO3_GPIO | WAKEUP_ON_EDGE_BOTH,	/* CORGI_GPIO_WAKEUP */
 };
 
 /*
@@ -675,6 +678,15 @@ static void __init corgi_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(corgi_pin_config));
 
+	/* allow wakeup from various GPIOs */
+	gpio_set_wake(CORGI_GPIO_KEY_INT, 1);
+	gpio_set_wake(CORGI_GPIO_WAKEUP, 1);
+	gpio_set_wake(CORGI_GPIO_AC_IN, 1);
+	gpio_set_wake(CORGI_GPIO_CHRG_FULL, 1);
+
+	if (!machine_is_corgi())
+		gpio_set_wake(CORGI_GPIO_MAIN_BAT_LOW, 1);
+
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index bb68347..3f1dc74 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -77,45 +77,6 @@ static void corgi_discharge(int on)
 
 static void corgi_presuspend(void)
 {
-	int i;
-	unsigned long wakeup_mask;
-
-	/* charging , so CHARGE_ON bit is HIGH during OFF. */
-	if (READ_GPIO_BIT(CORGI_GPIO_CHRG_ON))
-		PGSR1 |= GPIO_bit(CORGI_GPIO_CHRG_ON);
-	else
-		PGSR1 &= ~GPIO_bit(CORGI_GPIO_CHRG_ON);
-
-	if (READ_GPIO_BIT(CORGI_GPIO_LED_ORANGE))
-		PGSR0 |= GPIO_bit(CORGI_GPIO_LED_ORANGE);
-	else
-		PGSR0 &= ~GPIO_bit(CORGI_GPIO_LED_ORANGE);
-
-	if (READ_GPIO_BIT(CORGI_GPIO_CHRG_UKN))
-		PGSR1 |= GPIO_bit(CORGI_GPIO_CHRG_UKN);
-	else
-		PGSR1 &= ~GPIO_bit(CORGI_GPIO_CHRG_UKN);
-
-	/* Resume on keyboard power key */
-	PGSR2 = (PGSR2 & ~CORGI_GPIO_ALL_STROBE_BIT) | CORGI_GPIO_STROBE_BIT(0);
-
-	wakeup_mask = GPIO_bit(CORGI_GPIO_KEY_INT) | GPIO_bit(CORGI_GPIO_WAKEUP) | GPIO_bit(CORGI_GPIO_AC_IN) | GPIO_bit(CORGI_GPIO_CHRG_FULL);
-
-	if (!machine_is_corgi())
-		wakeup_mask |= GPIO_bit(CORGI_GPIO_MAIN_BAT_LOW);
-
-	PWER = wakeup_mask | PWER_RTC;
-	PRER = wakeup_mask;
-	PFER = wakeup_mask;
-
-	for (i = 0; i <=15; i++) {
-		if (PRER & PFER & GPIO_bit(i)) {
-			if (GPLR0 & GPIO_bit(i) )
-				PRER &= ~GPIO_bit(i);
-			else
-				PFER &= ~GPIO_bit(i);
-		}
-	}
 }
 
 static void corgi_postsuspend(void)
-- 
1.6.3.3
