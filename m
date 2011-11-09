From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  9 Nov 2011 10:47:28 +0800
Subject: [PATCH v7 08/11] ARM: pxa: use generic gpio operation instead of gpio
 register
In-Reply-To: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1320806851-13928-9-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the code of accessing gpio register. Use the generic read
operation instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/corgi_pm.c |   20 +++++++++++++++++---
 arch/arm/mach-pxa/spitz_pm.c |   10 ++++++++--
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 2903477..eca862f 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -40,7 +40,9 @@ static struct gpio charger_gpios[] = {
 	{ CORGI_GPIO_ADC_TEMP_ON, GPIOF_OUT_INIT_LOW, "ADC Temp On" },
 	{ CORGI_GPIO_CHRG_ON,	  GPIOF_OUT_INIT_LOW, "Charger On" },
 	{ CORGI_GPIO_CHRG_UKN,	  GPIOF_OUT_INIT_LOW, "Charger Unknown" },
+	{ CORGI_GPIO_AC_IN,	  GPIOF_IN, "Charger Detection" },
 	{ CORGI_GPIO_KEY_INT,	  GPIOF_IN, "Key Interrupt" },
+	{ CORGI_GPIO_WAKEUP,	  GPIOF_IN, "System wakeup notification" },
 };
 
 static void corgi_charger_init(void)
@@ -90,7 +92,12 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 {
 	int is_resume = 0;
 
-	dev_dbg(sharpsl_pm.dev, "GPLR0 = %x,%x\n", GPLR0, PEDR);
+	dev_dbg(sharpsl_pm.dev, "PEDR = %x, GPIO_AC_IN = %d, "
+		"GPIO_CHRG_FULL = %d, GPIO_KEY_INT = %d, GPIO_WAKEUP = %d\n",
+		PEDR, gpio_get_value(CORGI_GPIO_AC_IN),
+		gpio_get_value(CORGI_GPIO_CHRG_FULL),
+		gpio_get_value(CORGI_GPIO_KEY_INT),
+		gpio_get_value(CORGI_GPIO_WAKEUP));
 
 	if ((PEDR & GPIO_bit(CORGI_GPIO_AC_IN))) {
 		if (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN)) {
@@ -124,14 +131,21 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 
 static unsigned long corgi_charger_wakeup(void)
 {
-	return ~GPLR0 & ( GPIO_bit(CORGI_GPIO_AC_IN) | GPIO_bit(CORGI_GPIO_KEY_INT) | GPIO_bit(CORGI_GPIO_WAKEUP) );
+	unsigned long ret;
+
+	ret = (!gpio_get_value(CORGI_GPIO_AC_IN) << GPIO_bit(CORGI_GPIO_AC_IN))
+		| (!gpio_get_value(CORGI_GPIO_KEY_INT)
+		<< GPIO_bit(CORGI_GPIO_KEY_INT))
+		| (!gpio_get_value(CORGI_GPIO_WAKEUP)
+		<< GPIO_bit(CORGI_GPIO_WAKEUP));
+	return ret;
 }
 
 unsigned long corgipm_read_devdata(int type)
 {
 	switch(type) {
 	case SHARPSL_STATUS_ACIN:
-		return ((GPLR(CORGI_GPIO_AC_IN) & GPIO_bit(CORGI_GPIO_AC_IN)) != 0);
+		return !gpio_get_value(CORGI_GPIO_AC_IN);
 	case SHARPSL_STATUS_LOCK:
 		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index 094279a..5cc05d1 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -41,6 +41,7 @@ static int spitz_last_ac_status;
 static struct gpio spitz_charger_gpios[] = {
 	{ SPITZ_GPIO_KEY_INT,	GPIOF_IN, "Keyboard Interrupt" },
 	{ SPITZ_GPIO_SYNC,	GPIOF_IN, "Sync" },
+	{ SPITZ_GPIO_AC_IN,     GPIOF_IN, "Charger Detection" },
 	{ SPITZ_GPIO_ADC_TEMP_ON, GPIOF_OUT_INIT_LOW, "ADC Temp On" },
 	{ SPITZ_GPIO_JK_B,	  GPIOF_OUT_INIT_LOW, "JK B" },
 	{ SPITZ_GPIO_CHRG_ON,	  GPIOF_OUT_INIT_LOW, "Charger On" },
@@ -169,14 +170,19 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
 
 static unsigned long spitz_charger_wakeup(void)
 {
-	return (~GPLR0 & GPIO_bit(SPITZ_GPIO_KEY_INT)) | (GPLR0 & GPIO_bit(SPITZ_GPIO_SYNC));
+	unsigned long ret;
+	ret = (!gpio_get_value(SPITZ_GPIO_KEY_INT)
+		<< GPIO_bit(SPITZ_GPIO_KEY_INT))
+		| (!gpio_get_value(SPITZ_GPIO_SYNC)
+		<< GPIO_bit(SPITZ_GPIO_SYNC));
+	return ret;
 }
 
 unsigned long spitzpm_read_devdata(int type)
 {
 	switch (type) {
 	case SHARPSL_STATUS_ACIN:
-		return (((~GPLR(SPITZ_GPIO_AC_IN)) & GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);
+		return !gpio_get_value(SPITZ_GPIO_AC_IN);
 	case SHARPSL_STATUS_LOCK:
 		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
-- 
1.7.4.1
