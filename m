From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2012 13:52:35 +0000
Subject: [PATCH v3 10/15] ARM: highbank: convert to twd_local_timer_register()
 interface
In-Reply-To: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
References: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326721960-2224-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new smp_twd runtime registration interface
to the highbank platforms, and remove the old compile-time support.

The highbank DTS file is updated to match the TWD DT documentation
and fixes the timer trigger (rising edge).

Acked-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/highbank.dts      |    8 +++---
 arch/arm/mach-highbank/Makefile     |    1 -
 arch/arm/mach-highbank/highbank.c   |    3 ++
 arch/arm/mach-highbank/localtimer.c |   40 -----------------------------------
 4 files changed, 7 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/localtimer.c

diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index 305635b..37c0ff9 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -72,15 +72,15 @@
 		ranges;
 
 		timer at fff10600 {
-			compatible = "arm,smp-twd";
+			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xfff10600 0x20>;
-			interrupts = <1 13 0xf04>;
+			interrupts = <1 13 0xf01>;
 		};
 
 		watchdog at fff10620 {
-			compatible = "arm,cortex-a9-wdt";
+			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0xfff10620 0x20>;
-			interrupts = <1 14 0xf04>;
+			interrupts = <1 14 0xf01>;
 		};
 
 		intc: interrupt-controller at fff11000 {
diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
index 986958a..f8437dd 100644
--- a/arch/arm/mach-highbank/Makefile
+++ b/arch/arm/mach-highbank/Makefile
@@ -1,6 +1,5 @@
 obj-y					:= clock.o highbank.o system.o
 obj-$(CONFIG_DEBUG_HIGHBANK_UART)	+= lluart.o
 obj-$(CONFIG_SMP)			+= platsmp.o
-obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
 obj-$(CONFIG_PM_SLEEP)			+= pm.o
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 804c4a5..4f4f9c0 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -27,6 +27,7 @@
 #include <asm/cacheflush.h>
 #include <asm/unified.h>
 #include <asm/smp_scu.h>
+#include <asm/smp_twd.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/timer-sp.h>
 #include <asm/hardware/gic.h>
@@ -113,6 +114,8 @@ static void __init highbank_timer_init(void)
 
 	sp804_clocksource_init(timer_base + 0x20, "timer1");
 	sp804_clockevents_init(timer_base, irq, "timer0");
+
+	twd_local_timer_of_register();
 }
 
 static struct sys_timer highbank_timer = {
diff --git a/arch/arm/mach-highbank/localtimer.c b/arch/arm/mach-highbank/localtimer.c
deleted file mode 100644
index 5a00e79..0000000
--- a/arch/arm/mach-highbank/localtimer.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright 2010-2011 Calxeda, Inc.
- * Based on localtimer.c, Copyright (C) 2002 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#include <linux/init.h>
-#include <linux/clockchips.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-
-#include <asm/smp_twd.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
-	if (!twd_base) {
-		twd_base = of_iomap(np, 0);
-		WARN_ON(!twd_base);
-	}
-	evt->irq = irq_of_parse_and_map(np, 0);
-	twd_timer_setup(evt);
-	return 0;
-}
-- 
1.7.7.1
