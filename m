From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 31 Jul 2016 14:17:15 +0200
Subject: [PATCH v3] ARM: pxa: fix GPIO double shifts
Message-ID: <1469967435-23436-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 9bf448c66d4b ("ARM: pxa: use generic gpio operation instead of
gpio register") from Oct 17, 2011, leads to the following static checker
warning:
  arch/arm/mach-pxa/spitz_pm.c:172 spitz_charger_wakeup()
  warn: double left shift '!gpio_get_value(SPITZ_GPIO_KEY_INT)
        << (1 << ((SPITZ_GPIO_KEY_INT) & 31))'

As Dan reported, the value is shifted three times :
 - once by gpio_get_value(), which returns either 0 or BIT(gpio)
 - once by the shift operation '<<'
 - a last time by GPIO_bit(gpio) which is BIT(gpio)

Therefore the calculation lead to a chained or operator of :
 - (1 << gpio) << (1 << gpio) = (2^gpio)^gpio = 2 ^ (gpio * gpio)

It is be sheer luck the former statement works, only because each gpio
used is strictly smaller than 6, and therefore 2^(gpio^2) never
overflows a 32 bits value, and because it is used as a boolean value to
check a gpio activation.

As the xxx_charger_wakeup() functions are used as a true/false detection
mechanism, take that opportunity to change their prototypes from integer
return value to boolean one.

Fixes: 9bf448c66d4b ("ARM: pxa: use generic gpio operation instead of
gpio register")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: replaced binary ORs with logical ORs after assembly comparison
Since v2: changed charger_wakeup prototype to bool foo()
---
 arch/arm/mach-pxa/corgi_pm.c   | 12 +++++-------
 arch/arm/mach-pxa/sharpsl_pm.c |  2 +-
 arch/arm/mach-pxa/sharpsl_pm.h |  2 +-
 arch/arm/mach-pxa/spitz_pm.c   | 10 +++++-----
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index d9206811be9b..d935de02b582 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -131,15 +131,13 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 	return is_resume;
 }
 
-static unsigned long corgi_charger_wakeup(void)
+static bool corgi_charger_wakeup(void)
 {
-	unsigned long ret;
+	bool ret;
 
-	ret = (!gpio_get_value(CORGI_GPIO_AC_IN) << GPIO_bit(CORGI_GPIO_AC_IN))
-		| (!gpio_get_value(CORGI_GPIO_KEY_INT)
-		<< GPIO_bit(CORGI_GPIO_KEY_INT))
-		| (!gpio_get_value(CORGI_GPIO_WAKEUP)
-		<< GPIO_bit(CORGI_GPIO_WAKEUP));
+	ret = !gpio_get_value(CORGI_GPIO_AC_IN)
+		|| !gpio_get_value(CORGI_GPIO_KEY_INT)
+		|| !gpio_get_value(CORGI_GPIO_WAKEUP);
 	return ret;
 }
 
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index b80eab9993c5..249b7bd5fbc4 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -744,7 +744,7 @@ static int sharpsl_off_charge_battery(void)
 		time = RCNR;
 		while (1) {
 			/* Check if any wakeup event had occurred */
-			if (sharpsl_pm.machinfo->charger_wakeup() != 0)
+			if (sharpsl_pm.machinfo->charger_wakeup())
 				return 0;
 			/* Check for timeout */
 			if ((RCNR - time) > SHARPSL_WAIT_CO_TIME)
diff --git a/arch/arm/mach-pxa/sharpsl_pm.h b/arch/arm/mach-pxa/sharpsl_pm.h
index 905be6755f04..fa75b6df8134 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.h
+++ b/arch/arm/mach-pxa/sharpsl_pm.h
@@ -34,7 +34,7 @@ struct sharpsl_charger_machinfo {
 #define SHARPSL_STATUS_LOCK     5
 #define SHARPSL_STATUS_CHRGFULL 6
 #define SHARPSL_STATUS_FATAL    7
-	unsigned long (*charger_wakeup)(void);
+	bool (*charger_wakeup)(void);
 	int (*should_wakeup)(unsigned int resume_on_alarm);
 	void (*backlight_limit)(int);
 	int (*backlight_get_status) (void);
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index ea9f9034cb54..9e2902f32fc2 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -165,12 +165,12 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
 	return is_resume;
 }
 
-static unsigned long spitz_charger_wakeup(void)
+static bool spitz_charger_wakeup(void)
 {
-	unsigned long ret;
-	ret = ((!gpio_get_value(SPITZ_GPIO_KEY_INT)
-		<< GPIO_bit(SPITZ_GPIO_KEY_INT))
-		| gpio_get_value(SPITZ_GPIO_SYNC));
+	bool ret;
+
+	ret = !gpio_get_value(SPITZ_GPIO_KEY_INT)
+		|| gpio_get_value(SPITZ_GPIO_SYNC);
 	return ret;
 }
 
-- 
2.1.4
