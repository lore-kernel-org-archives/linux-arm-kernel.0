From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:20 +0800
Subject: [PATCH 12/16] [ARM] pxa/corgi: use generic GPIO API and remove
	pxa_gpio_mode()
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-13-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/corgi.c    |    8 ++++++--
 arch/arm/mach-pxa/corgi_pm.c |   38 +++++++++++++++++++-------------------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 74446cf..ae496b6 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -130,11 +130,15 @@ static unsigned long corgi_pin_config[] __initdata = {
 	/* GPIO */
 	GPIO9_GPIO,	/* CORGI_GPIO_nSD_DETECT */
 	GPIO7_GPIO,	/* CORGI_GPIO_nSD_WP */
-	GPIO33_GPIO,	/* CORGI_GPIO_SD_PWR */
+	GPIO21_GPIO,	/* CORGI_GPIO_ADC_TEMP */
 	GPIO22_GPIO,	/* CORGI_GPIO_IR_ON */
+	GPIO33_GPIO,	/* CORGI_GPIO_SD_PWR */
+	GPIO38_GPIO,	/* CORGI_GPIO_CHRG_ON */
+	GPIO43_GPIO,	/* CORGI_GPIO_CHRG_UKN */
 	GPIO44_GPIO,	/* CORGI_GPIO_HSYNC */
 
-	GPIO1_GPIO | WAKEUP_ON_EDGE_RISE,
+	GPIO0_GPIO | WAKEUP_ON_EDGE_BOTH,	/* CORGI_GPIO_KEY_INT */
+	GPIO1_GPIO | WAKEUP_ON_EDGE_RISE,	/* CORGI_GPIO_AC_IN */
 };
 
 /*
diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index d4a0733..bb68347 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/apm-emulation.h>
@@ -25,7 +26,8 @@
 #include <mach/sharpsl.h>
 #include <mach/corgi.h>
 #include <mach/pxa2xx-regs.h>
-#include <mach/pxa2xx-gpio.h>
+
+#include "generic.h"
 #include "sharpsl.h"
 
 #define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
@@ -35,44 +37,42 @@
 #define SHARPSL_FATAL_ACIN_VOLT        182   /* 3.45V */
 #define SHARPSL_FATAL_NOACIN_VOLT      170   /* 3.40V */
 
+static struct gpio charger_gpios[] = {
+	{ CORGI_GPIO_ADC_TEMP_ON, GPIOF_OUT_INIT_LOW, "ADC Temp On" },
+	{ CORGI_GPIO_CHRG_ON,	  GPIOF_OUT_INIT_LOW, "Charger On" },
+	{ CORGI_GPIO_CHRG_UKN,	  GPIOF_OUT_INIT_LOW, "Charger Unknown" },
+	{ CORGI_GPIO_KEY_INT,	  GPIOF_IN, "Key Interrupt" },
+};
+
 static void corgi_charger_init(void)
 {
-	pxa_gpio_mode(CORGI_GPIO_ADC_TEMP_ON | GPIO_OUT);
-	pxa_gpio_mode(CORGI_GPIO_CHRG_ON | GPIO_OUT);
-	pxa_gpio_mode(CORGI_GPIO_CHRG_UKN | GPIO_OUT);
-	pxa_gpio_mode(CORGI_GPIO_KEY_INT | GPIO_IN);
+	gpio_request_array(ARRAY_AND_SIZE(charger_gpios));
 }
 
 static void corgi_measure_temp(int on)
 {
-	if (on)
-		GPSR(CORGI_GPIO_ADC_TEMP_ON) = GPIO_bit(CORGI_GPIO_ADC_TEMP_ON);
-	else
-		GPCR(CORGI_GPIO_ADC_TEMP_ON) = GPIO_bit(CORGI_GPIO_ADC_TEMP_ON);
+	gpio_set_value(CORGI_GPIO_ADC_TEMP_ON, on);
 }
 
 static void corgi_charge(int on)
 {
 	if (on) {
 		if (machine_is_corgi() && (sharpsl_pm.flags & SHARPSL_SUSPENDED)) {
-			GPCR(CORGI_GPIO_CHRG_ON) = GPIO_bit(CORGI_GPIO_CHRG_ON);
-			GPSR(CORGI_GPIO_CHRG_UKN) = GPIO_bit(CORGI_GPIO_CHRG_UKN);
+			gpio_set_value(CORGI_GPIO_CHRG_ON, 0);
+			gpio_set_value(CORGI_GPIO_CHRG_UKN, 1);
 		} else {
-			GPSR(CORGI_GPIO_CHRG_ON) = GPIO_bit(CORGI_GPIO_CHRG_ON);
-			GPCR(CORGI_GPIO_CHRG_UKN) = GPIO_bit(CORGI_GPIO_CHRG_UKN);
+			gpio_set_value(CORGI_GPIO_CHRG_ON, 1);
+			gpio_set_value(CORGI_GPIO_CHRG_UKN, 0);
 		}
 	} else {
-		GPCR(CORGI_GPIO_CHRG_ON) = GPIO_bit(CORGI_GPIO_CHRG_ON);
-		GPCR(CORGI_GPIO_CHRG_UKN) = GPIO_bit(CORGI_GPIO_CHRG_UKN);
+		gpio_set_value(CORGI_GPIO_CHRG_ON, 0);
+		gpio_set_value(CORGI_GPIO_CHRG_UKN, 0);
 	}
 }
 
 static void corgi_discharge(int on)
 {
-	if (on)
-		GPSR(CORGI_GPIO_DISCHARGE_ON) = GPIO_bit(CORGI_GPIO_DISCHARGE_ON);
-	else
-		GPCR(CORGI_GPIO_DISCHARGE_ON) = GPIO_bit(CORGI_GPIO_DISCHARGE_ON);
+	gpio_set_value(CORGI_GPIO_DISCHARGE_ON, on);
 }
 
 static void corgi_presuspend(void)
-- 
1.6.3.3
