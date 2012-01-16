From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2012 13:52:33 +0000
Subject: [PATCH v3 08/15] ARM: shmobile: convert to twd_local_timer_register()
 interface
In-Reply-To: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
References: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326721960-2224-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new smp_twd runtime registration interface
to the shmobile platforms, and remove the old compile-time support.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Makefile              |    1 -
 arch/arm/mach-shmobile/include/mach/common.h |    2 ++
 arch/arm/mach-shmobile/localtimer.c          |   26 --------------------------
 arch/arm/mach-shmobile/platsmp.c             |    1 -
 arch/arm/mach-shmobile/smp-r8a7779.c         |    8 +++-----
 arch/arm/mach-shmobile/smp-sh73a0.c          |    8 +++-----
 arch/arm/mach-shmobile/timer.c               |   10 ++++++++++
 7 files changed, 18 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 7ad6954..e7c2590 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o clock-r8a7779.o intc-r8a7779.o
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o
 
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index e4b945e..9fde3eb 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -2,6 +2,8 @@
 #define __ARCH_MACH_COMMON_H
 
 extern struct sys_timer shmobile_timer;
+struct twd_local_timer;
+void shmobile_twd_init(struct twd_local_timer *twd_local_timer);
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
 extern int shmobile_platform_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-shmobile/localtimer.c b/arch/arm/mach-shmobile/localtimer.c
deleted file mode 100644
index ad9ccc9..0000000
--- a/arch/arm/mach-shmobile/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
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
-	twd_timer_setup(evt);
-	return 0;
-}
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 9933812..45fa392 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -17,7 +17,6 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <asm/hardware/gic.h>
-#include <asm/localtimer.h>
 #include <asm/mach-types.h>
 #include <mach/common.h>
 
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index cc97ef8..7e056d3 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -63,6 +63,8 @@ static void __iomem *scu_base_addr(void)
 static DEFINE_SPINLOCK(scu_lock);
 static unsigned long tmp;
 
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
+
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 {
 	void __iomem *scu_base = scu_base_addr();
@@ -81,11 +83,7 @@ unsigned int __init r8a7779_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
-#ifdef CONFIG_HAVE_ARM_TWD
-	/* twd_base needs to be initialized before percpu_timer_setup() */
-	twd_base = (void __iomem *)0xf0000600;
-#endif
-
+	shmobile_twd_init(&twd_local_timer);
 	return scu_get_core_count(scu_base);
 }
 
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index be1ade7..8e0906f 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -41,6 +41,8 @@ static void __iomem *scu_base_addr(void)
 static DEFINE_SPINLOCK(scu_lock);
 static unsigned long tmp;
 
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
+
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 {
 	void __iomem *scu_base = scu_base_addr();
@@ -59,11 +61,7 @@ unsigned int __init sh73a0_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
-#ifdef CONFIG_HAVE_ARM_TWD
-	/* twd_base needs to be initialized before percpu_timer_setup() */
-	twd_base = (void __iomem *)0xf0000600;
-#endif
-
+	shmobile_twd_init(&twd_local_timer);
 	return scu_get_core_count(scu_base);
 }
 
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 895794b..be16231 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -20,6 +20,7 @@
  */
 #include <linux/platform_device.h>
 #include <asm/mach/time.h>
+#include <asm/smp_twd.h>
 
 static void __init shmobile_late_time_init(void)
 {
@@ -41,6 +42,15 @@ static void __init shmobile_timer_init(void)
 	late_time_init = shmobile_late_time_init;
 }
 
+void __init shmobile_twd_init(struct twd_local_timer *twd_local_timer)
+{
+#ifdef CONFIG_HAVE_ARM_TWD
+	int err = twd_local_timer_register(twd_local_timer);
+	if (err)
+		pr_err("twd_local_timer_register failed %d\n", err);
+#endif
+}
+
 struct sys_timer shmobile_timer = {
 	.init		= shmobile_timer_init,
 };
-- 
1.7.7.1
