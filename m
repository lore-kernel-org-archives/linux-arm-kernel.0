From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2011 16:53:22 +0000
Subject: [RFC PATCH 16/20] ARM: shmobile: dynamically register local timer
	setup function
In-Reply-To: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1299084806-16546-17-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Makefile     |    1 -
 arch/arm/mach-shmobile/localtimer.c |   25 -------------------------
 arch/arm/mach-shmobile/timer.c      |   12 ++++++++++++
 3 files changed, 12 insertions(+), 26 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e2507f6..290a232 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
 
 # Pinmux setup
diff --git a/arch/arm/mach-shmobile/localtimer.c b/arch/arm/mach-shmobile/localtimer.c
deleted file mode 100644
index a4c4e8b..0000000
--- a/arch/arm/mach-shmobile/localtimer.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * SMP support for R-Mobile / SH-Mobile - local timer portion
- *
- * Copyright (C) 2010  Magnus Damm
- *
- * Based on vexpress, Copyright (C) 2002 ARM Ltd, All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = 29;
-	return 0;
-}
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 895794b..3256b18 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -19,6 +19,8 @@
  *
  */
 #include <linux/platform_device.h>
+#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 #include <asm/mach/time.h>
 
 static void __init shmobile_late_time_init(void)
@@ -36,8 +38,18 @@ static void __init shmobile_late_time_init(void)
 	early_platform_driver_probe("earlytimer", 2, 0);
 }
 
+#ifdef CONFIG_LOCAL_TIMERS
+static int __cpuinit shmobile_local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = 29;
+}
+#else
+#define shmobile_local_timer_setup	NULL
+#endif
+
 static void __init shmobile_timer_init(void)
 {
+	twd_timer_register_setup(shmobile_local_timer_setup);
 	late_time_init = shmobile_late_time_init;
 }
 
-- 
1.7.0.4
