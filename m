From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:40 +0000
Subject: [PATCH v2 10/15] ARM: local timers: switch highbank to standalone
 smp_twd
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the highbank platform to the standalone version of smp_twd.c.
Since the timer calibration code requires another timer to be up
and running, the actual initialisation is left to the late_timer_init
hook.

Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-highbank/Makefile     |    1 -
 arch/arm/mach-highbank/highbank.c   |   13 +++++++++++
 arch/arm/mach-highbank/localtimer.c |   40 -----------------------------------
 3 files changed, 13 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/localtimer.c

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
index 804c4a5..6a60919 100644
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
@@ -93,6 +94,16 @@ static void __init highbank_init_irq(void)
 	l2x0_of_init(0, ~0UL);
 }
 
+const static struct of_device_id twd_match[] __initconst = {
+	{ .compatible = "arm,smp-twd", },
+	{}
+};
+
+static void __init highbank_twd_init(void)
+{
+	twd_timer_of_init(twd_match);
+}
+
 static void __init highbank_timer_init(void)
 {
 	int irq;
@@ -113,6 +124,8 @@ static void __init highbank_timer_init(void)
 
 	sp804_clocksource_init(timer_base + 0x20, "timer1");
 	sp804_clockevents_init(timer_base, irq, "timer0");
+
+	late_time_init = highbank_twd_init;
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
