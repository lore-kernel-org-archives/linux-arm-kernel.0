From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:38 +0000
Subject: [PATCH v2 08/15] ARM: local timers: switch shmobile to standalone
 smp_twd
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the SMP shmobile platforms to the standalone version
of smp_twd.c. As shmobile is already using the late_time_init
hook, a private hook is added to initialise the TWD driver
once the platform timer is up and running.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Kconfig               |    1 +
 arch/arm/mach-shmobile/Makefile              |    1 -
 arch/arm/mach-shmobile/include/mach/common.h |    3 ++
 arch/arm/mach-shmobile/localtimer.c          |   26 ---------------------
 arch/arm/mach-shmobile/smp-sh73a0.c          |   32 +++++++++++++++++++++++--
 arch/arm/mach-shmobile/timer.c               |   10 ++++++++
 6 files changed, 43 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0828fab..a46db89 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -23,6 +23,7 @@ config ARCH_SH7372
 config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
 	select CPU_V7
+	select ARM_SMP_TWD
 	select SH_CLK_CPG
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 5ca1f9d..85c5166 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
 
 # Pinmux setup
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 4bf82c1..658c6ec 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -52,4 +52,7 @@ extern void sh73a0_secondary_init(unsigned int cpu);
 extern int sh73a0_boot_secondary(unsigned int cpu);
 extern void sh73a0_smp_prepare_cpus(void);
 
+struct resource;
+extern void shmobile_local_timer_register(void (*)(void));
+
 #endif /* __ARCH_MACH_COMMON_H */
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
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index be1ade7..cb5f011 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -22,6 +22,7 @@
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
+#include <linux/ioport.h>
 #include <mach/common.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
@@ -41,6 +42,31 @@ static void __iomem *scu_base_addr(void)
 static DEFINE_SPINLOCK(scu_lock);
 static unsigned long tmp;
 
+#ifdef CONFIG_ARM_SMP_TWD
+static struct resource sh73a0_twd_resources[] __initdata = {
+	{
+		.start	= 0xf0000600,
+		.end	= 0xf0000600 + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= 29,
+		.end	= 29,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static void __init sh73a0_twd_init(void)
+{
+	int err = twd_timer_register(sh73a0_twd_resources,
+				     ARRAY_SIZE(sh73a0_twd_resources));
+	if (err)
+		pr_err("twd_timer_register failed %d\n", err);
+}
+#else
+#define sh73a0_twd_init	NULL
+#endif
+
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 {
 	void __iomem *scu_base = scu_base_addr();
@@ -59,9 +85,9 @@ unsigned int __init sh73a0_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
-#ifdef CONFIG_HAVE_ARM_TWD
-	/* twd_base needs to be initialized before percpu_timer_setup() */
-	twd_base = (void __iomem *)0xf0000600;
+
+#ifdef CONFIG_ARM_SMP_TWD
+	shmobile_local_timer_register(sh73a0_twd_init);
 #endif
 
 	return scu_get_core_count(scu_base);
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 895794b..fad385d 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -19,8 +19,11 @@
  *
  */
 #include <linux/platform_device.h>
+#include <mach/common.h>
 #include <asm/mach/time.h>
 
+static void (*local_timer_hook)(void) __initdata;
+
 static void __init shmobile_late_time_init(void)
 {
 	/*
@@ -34,6 +37,8 @@ static void __init shmobile_late_time_init(void)
 	 */
 	early_platform_driver_register_all("earlytimer");
 	early_platform_driver_probe("earlytimer", 2, 0);
+	if (local_timer_hook)
+		local_timer_hook();
 }
 
 static void __init shmobile_timer_init(void)
@@ -41,6 +46,11 @@ static void __init shmobile_timer_init(void)
 	late_time_init = shmobile_late_time_init;
 }
 
+void __init shmobile_local_timer_register(void (*hook)(void))
+{
+	local_timer_hook = hook;
+}
+
 struct sys_timer shmobile_timer = {
 	.init		= shmobile_timer_init,
 };
-- 
1.7.7.1
