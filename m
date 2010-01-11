From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:21 +0800
Subject: [PATCH 13/16] [ARM] pxa/spitz: use generic GPIO API and remove
	pxa_gpio_mode()
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-14-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

REVISIT: change to GPIO18 is ugly, need to make sure whether that's
really necessary - GPIO18_RDY as an VLIO input signal - we don't
normally need to do such kind of trick during low power mode.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/spitz.c    |    4 +++-
 arch/arm/mach-pxa/spitz_pm.c |   28 +++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 6d9c472..70b17b6 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -86,6 +86,7 @@ static unsigned long spitz_pin_config[] __initdata = {
 
 	/* GPIOs */
 	GPIO9_GPIO,	/* SPITZ_GPIO_nSD_DETECT */
+	GPIO16_GPIO,	/* SPITZ_GPIO_SYNC */
 	GPIO81_GPIO,	/* SPITZ_GPIO_nSD_WP */
 	GPIO41_GPIO,	/* SPITZ_GPIO_USB_CONNECT */
 	GPIO37_GPIO,	/* SPITZ_GPIO_USB_HOST */
@@ -119,7 +120,8 @@ static unsigned long spitz_pin_config[] __initdata = {
 	GPIO117_I2C_SCL,
 	GPIO118_I2C_SDA,
 
-	GPIO1_GPIO | WAKEUP_ON_EDGE_RISE,
+	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,	/* SPITZ_GPIO_KEY_INT */
+	GPIO1_GPIO | WAKEUP_ON_EDGE_FALL,	/* SPITZ_GPIO_RESET */
 };
 
 /*
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index fc5a70c..4209ddf 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -24,9 +24,10 @@
 
 #include <mach/sharpsl.h>
 #include <mach/spitz.h>
-#include <mach/pxa2xx-regs.h>
-#include <mach/pxa2xx-gpio.h>
+#include <mach/pxa27x.h>
+
 #include "sharpsl.h"
+#include "generic.h"
 
 #define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
 #define SHARPSL_CHARGE_ON_TEMP         0xe0  /* 2.9V */
@@ -37,10 +38,17 @@
 
 static int spitz_last_ac_status;
 
+static struct gpio spitz_charger_gpios[] = {
+	{ SPITZ_GPIO_KEY_INT,	GPIOF_IN, "Keyboard Interrupt" },
+	{ SPITZ_GPIO_SYNC,	GPIOF_IN, "Sync" },
+	{ SPITZ_GPIO_ADC_TEMP_ON, GPIOF_OUT_INIT_LOW, "ADC Temp On" },
+	{ SPITZ_GPIO_JK_B,	  GPIOF_OUT_INIT_LOW, "JK B" },
+	{ SPITZ_GPIO_CHRG_ON,	  GPIOF_OUT_INIT_LOW, "Charger On" },
+};
+
 static void spitz_charger_init(void)
 {
-	pxa_gpio_mode(SPITZ_GPIO_KEY_INT | GPIO_IN);
-	pxa_gpio_mode(SPITZ_GPIO_SYNC | GPIO_IN);
+	gpio_request_array(ARRAY_AND_SIZE(spitz_charger_gpios));
 }
 
 static void spitz_measure_temp(int on)
@@ -76,6 +84,11 @@ static void spitz_discharge1(int on)
 	gpio_set_value(SPITZ_GPIO_LED_GREEN, on);
 }
 
+static unsigned long gpio18_config[] = {
+	GPIO18_RDY,
+	GPIO18_GPIO,
+};
+
 static void spitz_presuspend(void)
 {
 	spitz_last_ac_status = sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN);
@@ -97,7 +110,9 @@ static void spitz_presuspend(void)
 	PGSR3 &= ~SPITZ_GPIO_G3_STROBE_BIT;
 	PGSR2 |= GPIO_bit(SPITZ_GPIO_KEY_STROBE0);
 
-	pxa_gpio_mode(GPIO18_RDY|GPIO_OUT | GPIO_DFLT_HIGH);
+	pxa2xx_mfp_config(&gpio18_config[0], 1);
+	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, "Unknown");
+	gpio_free(18);
 
 	PRER = GPIO_bit(SPITZ_GPIO_KEY_INT);
 	PFER = GPIO_bit(SPITZ_GPIO_KEY_INT) | GPIO_bit(SPITZ_GPIO_RESET);
@@ -114,8 +129,7 @@ static void spitz_presuspend(void)
 
 static void spitz_postsuspend(void)
 {
-	pxa_gpio_mode(GPIO18_RDY_MD);
-	pxa_gpio_mode(10 | GPIO_IN);
+	pxa2xx_mfp_config(&gpio18_config[1], 1);
 }
 
 static int spitz_should_wakeup(unsigned int resume_on_alarm)
-- 
1.6.3.3
