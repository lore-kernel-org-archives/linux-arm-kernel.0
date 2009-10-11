From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 11 Oct 2009 11:04:23 +0200
Subject: zaurus suspend saga: 2.6.32-rc3
Message-ID: <20091011090423.GB1414@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm using patch similar to this for debugging:

...and good news is that it blinks after pressing of power button.

...core > pm_test also works.

I also verified that end of pxa_pm_enter() is reached (with similar
blinking patch). End of corgi_pxa_pm_enter() seems to be reached, too.

Any ideas what to try next?
								Pavel

--- arm.ofic//mach-pxa/pm.c	2009-09-10 00:13:59.000000000 +0200
+++ arm/mach-pxa/pm.c	2009-10-07 14:21:21.000000000 +0200
@@ -14,7 +14,10 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/errno.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
 
+#include <mach/spitz.h>
 #include <mach/pm.h>
 
 struct pxa_cpu_pm_fns *pxa_cpu_pm_fns;
@@ -41,6 +44,24 @@
 
 	/* *** go zzz *** */
 	pxa_cpu_pm_fns->enter(state);
+
+	gpio_set_value(SPITZ_GPIO_LED_GREEN, 0);
+	mdelay(100);
+	gpio_set_value(SPITZ_GPIO_LED_GREEN, 1);
+	mdelay(100);
+	gpio_set_value(SPITZ_GPIO_LED_GREEN, 0);
+	mdelay(100);
+	gpio_set_value(SPITZ_GPIO_LED_GREEN, 1);
+	mdelay(100);
+	gpio_set_value(SPITZ_GPIO_LED_GREEN, 0);
+	mdelay(100);
+	gpio_set_value(SPITZ_GPIO_LED_GREEN, 1);
+	mdelay(100);
+	gpio_set_value(SPITZ_GPIO_LED_GREEN, 0);
+	mdelay(100);
+	gpio_set_value(SPITZ_GPIO_LED_GREEN, 1);
+	mdelay(100);
+
 	cpu_init();
 
 	if (state != PM_SUSPEND_STANDBY) {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
