From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 17 Oct 2009 00:02:01 +0200
Subject: [PATCH v3 1/2] n2100: reduce power button timer to 1 Hz
Message-ID: <19160.60761.315446.356742@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power button on the n2100 apparently does not generate
an interrupt when pressed, so the board support code sets
up a periodic timer to sample it.

This timer operates at 10 Hz, which makes it the third worst
cause of timeouts in my kernel when idle.

10 Hz seems excessive, so this patch reduces the polling
frequency to 1 Hz. round_jiffies() is used to allow this
timer to group with any other whole-Hz timer, avoiding
unecessary timer wakeups.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Changes v1 -> v3:
* dropped config option, made the change unconditional
* use round_jiffies() to make the timer group with any
  other active whole-Hz timer; this change reduced my
  idle tick rate from 3.1 Hz to about 2.5 Hz
* moved duplicated power button timer update code to a
  new subroutine
* reorder patch series so this patch applies before the
  XINT1 UART patch
* rebased on 2.6.32-rc5

 arch/arm/mach-iop32x/n2100.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff -rupN linux-2.6.32-rc5/arch/arm/mach-iop32x/n2100.c linux-2.6.32-rc5.arm-n2100-1-pbpt-hz1-v3/arch/arm/mach-iop32x/n2100.c
--- linux-2.6.32-rc5/arch/arm/mach-iop32x/n2100.c	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.32-rc5.arm-n2100-1-pbpt-hz1-v3/arch/arm/mach-iop32x/n2100.c	2009-10-16 22:00:53.000000000 +0200
@@ -296,6 +296,12 @@ static void n2100_power_off(void)
 
 static struct timer_list power_button_poll_timer;
 
+static void power_button_poll_timer_rearm(void)
+{
+	power_button_poll_timer.expires = round_jiffies(jiffies + HZ);
+	add_timer(&power_button_poll_timer);
+}
+
 static void power_button_poll(unsigned long dummy)
 {
 	if (gpio_line_get(N2100_POWER_BUTTON) == 0) {
@@ -303,8 +309,7 @@ static void power_button_poll(unsigned l
 		return;
 	}
 
-	power_button_poll_timer.expires = jiffies + (HZ / 10);
-	add_timer(&power_button_poll_timer);
+	power_button_poll_timer_rearm();
 }
 
 
@@ -323,8 +328,7 @@ static void __init n2100_init_machine(vo
 
 	init_timer(&power_button_poll_timer);
 	power_button_poll_timer.function = power_button_poll;
-	power_button_poll_timer.expires = jiffies + (HZ / 10);
-	add_timer(&power_button_poll_timer);
+	power_button_poll_timer_rearm();
 }
 
 MACHINE_START(N2100, "Thecus N2100")
