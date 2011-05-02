From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon,  2 May 2011 22:42:20 +0200
Subject: [RFC PATCH] arm: move timer init to late_timer_init
Message-ID: <1304368940-19340-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

and add global early device init
this will init earlytimer and will try to probe 1 or 2 timers for clockevents
and clocksource

This will also allow to share timer cross arch such as sh-mobile and sh

all arm timers will be update to early device step by step

tested on at91sam9263-ek, at91rm9200-ek and qemu versatilepb

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/kernel/time.c                  |   23 ++++++++++++++-
 arch/arm/mach-shmobile/Makefile         |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c   |   13 +--------
 arch/arm/mach-shmobile/board-ap4evb.c   |   18 +++---------
 arch/arm/mach-shmobile/board-g3evm.c    |   12 +-------
 arch/arm/mach-shmobile/board-g4evm.c    |   12 +-------
 arch/arm/mach-shmobile/board-mackerel.c |   18 +++---------
 arch/arm/mach-shmobile/timer.c          |   46 -------------------------------
 8 files changed, 33 insertions(+), 111 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/timer.c

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 1ff46ca..7cc21ca 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -13,6 +13,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/init.h>
@@ -158,12 +159,30 @@ static int __init timer_init_sysfs(void)
 
 device_initcall(timer_init_sysfs);
 
-void __init time_init(void)
+static void arm_late_time_init(void)
 {
 	system_timer = machine_desc->timer;
-	system_timer->init();
+	if (system_timer->init)
+		system_timer->init();
+
+	/*
+	 * Make sure all compiled-in early timers register themselves.
+	 *
+	 * Run probe() for two "earlytimer" devices, these will be the
+	 * clockevents and clocksource devices respectively. In the event
+	 * that only a clockevents device is available, we -ENODEV on the
+	 * clocksource and the jiffies clocksource is used transparently
+	 * instead. No error handling is necessary here.
+	 */
+	early_platform_driver_register_all("earlytimer");
+	early_platform_driver_probe("earlytimer", 2, 0);
+
 #ifdef CONFIG_HAVE_SCHED_CLOCK
 	sched_clock_postinit();
 #endif
 }
 
+void __init time_init(void)
+{
+	late_time_init = arm_late_time_init;
+}
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 260e09d..6a1cc9e 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= map_io.o timer.o console.o clock.o pm_runtime.o
+obj-y				:= map_io.o console.o clock.o pm_runtime.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index b30b11d..cd9ba29 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -339,6 +339,7 @@ static void __init ag5evm_init_early(void)
 	/* setup early devices and console here as well */
 	sh73a0_add_early_devices();
 	shmobile_setup_console();
+	sh73a0_clock_init();
 }
 
 #define PINTC_ADDR	0xe6900000
@@ -447,22 +448,10 @@ static void __init ag5evm_init(void)
 	platform_add_devices(ag5evm_devices, ARRAY_SIZE(ag5evm_devices));
 }
 
-static void __init ag5evm_timer_init(void)
-{
-	sh73a0_clock_init();
-	shmobile_timer.init();
-	return;
-}
-
-struct sys_timer ag5evm_timer = {
-	.init	= ag5evm_timer_init,
-};
-
 MACHINE_START(AG5EVM, "ag5evm")
 	.map_io		= shmobile_map_io,
 	.init_irq	= ag5evm_init_irq,
 	.handle_irq	= shmobile_handle_irq_gic,
 	.init_early	= ag5evm_init_early,
 	.init_machine	= ag5evm_init,
-	.timer		= &ag5evm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index ed55c01..f800cae 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1096,6 +1096,10 @@ static void __init ap4evb_init_early(void)
 	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
 	shmobile_setup_console();
+	sh7372_clock_init();
+
+	/* External clock source */
+	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 }
 
 #define GPIO_PORT9CR	0xE6051009
@@ -1330,24 +1334,10 @@ static void __init ap4evb_init(void)
 	fsi_init_pm_clock();
 }
 
-static void __init ap4evb_timer_init(void)
-{
-	sh7372_clock_init();
-	shmobile_timer.init();
-
-	/* External clock source */
-	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
-}
-
-static struct sys_timer ap4evb_timer = {
-	.init		= ap4evb_timer_init,
-};
-
 MACHINE_START(AP4EVB, "ap4evb")
 	.map_io		= shmobile_map_io,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_early	= ap4evb_init_early,
 	.init_machine	= ap4evb_init,
-	.timer		= &ap4evb_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
index 20eeacf..63a6c35 100644
--- a/arch/arm/mach-shmobile/board-g3evm.c
+++ b/arch/arm/mach-shmobile/board-g3evm.c
@@ -249,6 +249,7 @@ static void __init g3evm_init_early(void)
 	/* setup early devices and console here as well */
 	sh7367_add_early_devices();
 	shmobile_setup_console();
+	sh7367_clock_init();
 }
 
 static void __init g3evm_init(void)
@@ -338,21 +339,10 @@ static void __init g3evm_init(void)
 	platform_add_devices(g3evm_devices, ARRAY_SIZE(g3evm_devices));
 }
 
-static void __init g3evm_timer_init(void)
-{
-	sh7367_clock_init();
-	shmobile_timer.init();
-}
-
-static struct sys_timer g3evm_timer = {
-	.init		= g3evm_timer_init,
-};
-
 MACHINE_START(G3EVM, "g3evm")
 	.map_io		= shmobile_map_io,
 	.init_irq	= sh7367_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_early	= g3evm_init_early,
 	.init_machine	= g3evm_init,
-	.timer		= &g3evm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index 079dd35..46e1b0c 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -263,6 +263,7 @@ static void __init g4evm_init_early(void)
 	/* setup early devices and console here as well */
 	sh7377_add_early_devices();
 	shmobile_setup_console();
+	sh7377_clock_init();
 }
 
 #define GPIO_SDHID0_D0	0xe60520fc
@@ -381,21 +382,10 @@ static void __init g4evm_init(void)
 	platform_add_devices(g4evm_devices, ARRAY_SIZE(g4evm_devices));
 }
 
-static void __init g4evm_timer_init(void)
-{
-	sh7377_clock_init();
-	shmobile_timer.init();
-}
-
-static struct sys_timer g4evm_timer = {
-	.init		= g4evm_timer_init,
-};
-
 MACHINE_START(G4EVM, "g4evm")
 	.map_io		= shmobile_map_io,
 	.init_irq	= sh7377_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_early	= g4evm_init_early,
 	.init_machine	= g4evm_init,
-	.timer		= &g4evm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f05a673..d52f323 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1011,6 +1011,10 @@ static void __init mackerel_init_early(void)
 	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
 	shmobile_setup_console();
+	sh7372_clock_init();
+
+	/* External clock source */
+	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 }
 
 #define GPIO_PORT9CR	0xE6051009
@@ -1203,24 +1207,10 @@ static void __init mackerel_init(void)
 	hdmi_init_pm_clock();
 }
 
-static void __init mackerel_timer_init(void)
-{
-	sh7372_clock_init();
-	shmobile_timer.init();
-
-	/* External clock source */
-	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
-}
-
-static struct sys_timer mackerel_timer = {
-	.init		= mackerel_timer_init,
-};
-
 MACHINE_START(MACKEREL, "mackerel")
 	.map_io		= shmobile_map_io,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_early	= mackerel_init_early,
 	.init_machine	= mackerel_init,
-	.timer		= &mackerel_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
deleted file mode 100644
index 895794b..0000000
--- a/arch/arm/mach-shmobile/timer.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * SH-Mobile Timer
- *
- * Copyright (C) 2010  Magnus Damm
- * Copyright (C) 2002 - 2009  Paul Mundt
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-#include <linux/platform_device.h>
-#include <asm/mach/time.h>
-
-static void __init shmobile_late_time_init(void)
-{
-	/*
-	 * Make sure all compiled-in early timers register themselves.
-	 *
-	 * Run probe() for two "earlytimer" devices, these will be the
-	 * clockevents and clocksource devices respectively. In the event
-	 * that only a clockevents device is available, we -ENODEV on the
-	 * clocksource and the jiffies clocksource is used transparently
-	 * instead. No error handling is necessary here.
-	 */
-	early_platform_driver_register_all("earlytimer");
-	early_platform_driver_probe("earlytimer", 2, 0);
-}
-
-static void __init shmobile_timer_init(void)
-{
-	late_time_init = shmobile_late_time_init;
-}
-
-struct sys_timer shmobile_timer = {
-	.init		= shmobile_timer_init,
-};
-- 
1.7.4.1
