From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 17 Oct 2011 21:35:14 +0800
Subject: [PATCH v5 08/11] ARM: pxa: use generic gpio operation instead of gpio
	register
In-Reply-To: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
References: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1318858517-22494-9-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the code of accessing gpio register. Use the generic read
operation instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/corgi_pm.c |   12 +++++++++---
 arch/arm/mach-pxa/spitz_pm.c |    9 +++++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 2903477..6c3a0a2 100644
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
@@ -90,7 +92,7 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 {
 	int is_resume = 0;
 
-	dev_dbg(sharpsl_pm.dev, "GPLR0 = %x,%x\n", GPLR0, PEDR);
+	dev_dbg(sharpsl_pm.dev, "GPLR0 = %x,%x\n", charger_gpios[4].gpio, PEDR);
 
 	if ((PEDR & GPIO_bit(CORGI_GPIO_AC_IN))) {
 		if (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN)) {
@@ -124,14 +126,18 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 
 static unsigned long corgi_charger_wakeup(void)
 {
-	return ~GPLR0 & ( GPIO_bit(CORGI_GPIO_AC_IN) | GPIO_bit(CORGI_GPIO_KEY_INT) | GPIO_bit(CORGI_GPIO_WAKEUP) );
+	unsigned long gplr0;
+	gplr0 = gpio_get_value(charger_gpios[3].gpio);
+	return ~gplr0 & ( GPIO_bit(CORGI_GPIO_AC_IN) | GPIO_bit(CORGI_GPIO_KEY_INT) | GPIO_bit(CORGI_GPIO_WAKEUP) );
 }
 
 unsigned long corgipm_read_devdata(int type)
 {
+	unsigned long gplr0 = 0;
 	switch(type) {
 	case SHARPSL_STATUS_ACIN:
-		return ((GPLR(CORGI_GPIO_AC_IN) & GPIO_bit(CORGI_GPIO_AC_IN)) != 0);
+		gplr0 = gpio_get_value(charger_gpios[3].gpio);
+		return ((gplr0 & GPIO_bit(CORGI_GPIO_AC_IN)) != 0);
 	case SHARPSL_STATUS_LOCK:
 		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index 094279a..adf87ed 100644
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
@@ -169,14 +170,18 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
 
 static unsigned long spitz_charger_wakeup(void)
 {
-	return (~GPLR0 & GPIO_bit(SPITZ_GPIO_KEY_INT)) | (GPLR0 & GPIO_bit(SPITZ_GPIO_SYNC));
+	unsigned long gplr0;
+	gplr0 = gpio_get_value(spitz_charger_gpios[0].gpio);
+	return (~gplr0 & GPIO_bit(SPITZ_GPIO_KEY_INT)) | (gplr0 & GPIO_bit(SPITZ_GPIO_SYNC));
 }
 
 unsigned long spitzpm_read_devdata(int type)
 {
+	unsigned long gplr = 0;
 	switch (type) {
 	case SHARPSL_STATUS_ACIN:
-		return (((~GPLR(SPITZ_GPIO_AC_IN)) & GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);
+		gplr = gpio_get_value(spitz_charger_gpios[2].gpio);
+		return ((~gplr & GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);
 	case SHARPSL_STATUS_LOCK:
 		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
-- 
1.7.2.5
