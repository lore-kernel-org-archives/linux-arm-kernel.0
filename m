From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 26 Sep 2009 21:53:55 +0200
Subject: [PATCH 2/2] n2100: reduce power button timer to 1 Hz
Message-ID: <19134.29011.460366.960746@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power button on the n2100 apparently does not generate
an interrupt when pressed, so the board support code sets
up a periodic timer to sample it.

This timer operates at 10 Hz, which makes it the third worst
cause of timeouts in my kernel when idle.

10 Hz seems excessive, so this patch adds a compile-time option
to reduce the polling frequency to 1 Hz.

(This change could possibly be handled via a kernel boot option,
or even be made unconditional, but I opted for a compile-time
option for now.)

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 arch/arm/mach-iop32x/Kconfig |   12 ++++++++++++
 arch/arm/mach-iop32x/n2100.c |   10 ++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff -rupN linux-2.6.31.arm-n2100-1-xint1-uart/arch/arm/mach-iop32x/Kconfig linux-2.6.31.arm-n2100-2-pbpt-hz1/arch/arm/mach-iop32x/Kconfig
--- linux-2.6.31.arm-n2100-1-xint1-uart/arch/arm/mach-iop32x/Kconfig	2009-09-26 13:39:20.000000000 +0200
+++ linux-2.6.31.arm-n2100-2-pbpt-hz1/arch/arm/mach-iop32x/Kconfig	2009-09-26 13:56:05.000000000 +0200
@@ -64,4 +64,16 @@ config N2100_XINT1_UART
 
 	  Say Y if tickless operation is important for you.
 
+config N2100_PBPT_HZ1
+	bool "Set Thecus n2100 power button poll timer frequency to 1 Hz"
+	depends on MACH_N2100 && NO_HZ
+	help
+	  The Thecus n2100 power button does not generate an interrupt,
+	  so it is polled by a timer, by default at 10 Hz.
+
+	  This option reduces the polling frequency to 1 Hz, which helps
+	  tickless systems keep the timer interrupt rate low.
+
+	  Say Y if tickless operation is important for you.
+
 endif
diff -rupN linux-2.6.31.arm-n2100-1-xint1-uart/arch/arm/mach-iop32x/n2100.c linux-2.6.31.arm-n2100-2-pbpt-hz1/arch/arm/mach-iop32x/n2100.c
--- linux-2.6.31.arm-n2100-1-xint1-uart/arch/arm/mach-iop32x/n2100.c	2009-09-26 13:49:18.000000000 +0200
+++ linux-2.6.31.arm-n2100-2-pbpt-hz1/arch/arm/mach-iop32x/n2100.c	2009-09-26 13:56:43.000000000 +0200
@@ -307,6 +307,12 @@ static void n2100_power_off(void)
 
 static struct timer_list power_button_poll_timer;
 
+#ifdef CONFIG_N2100_PBPT_HZ1
+#define N2100_PBPT_DELTA	(HZ)
+#else
+#define N2100_PBPT_DELTA	(HZ / 10)
+#endif
+
 static void power_button_poll(unsigned long dummy)
 {
 	if (gpio_line_get(N2100_POWER_BUTTON) == 0) {
@@ -314,7 +320,7 @@ static void power_button_poll(unsigned l
 		return;
 	}
 
-	power_button_poll_timer.expires = jiffies + (HZ / 10);
+	power_button_poll_timer.expires = jiffies + N2100_PBPT_DELTA;
 	add_timer(&power_button_poll_timer);
 }
 
@@ -334,7 +340,7 @@ static void __init n2100_init_machine(vo
 
 	init_timer(&power_button_poll_timer);
 	power_button_poll_timer.function = power_button_poll;
-	power_button_poll_timer.expires = jiffies + (HZ / 10);
+	power_button_poll_timer.expires = jiffies + N2100_PBPT_DELTA;
 	add_timer(&power_button_poll_timer);
 }
 
