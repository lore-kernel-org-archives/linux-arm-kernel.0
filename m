From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jan 2012 13:08:47 +0000
Subject: [PATCH 08/15] ARM: shmobile: convert to twd_local_timer_register()
 interface
In-Reply-To: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326287334-1905-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new smp_twd runtime registration interface
to the shmobile platforms, and remove the old compile-time support.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Makefile              |    1 -
 arch/arm/mach-shmobile/include/mach/common.h |    2 +
 arch/arm/mach-shmobile/localtimer.c          |   26 ---------------------
 arch/arm/mach-shmobile/platsmp.c             |    1 -
 arch/arm/mach-shmobile/smp-sh73a0.c          |   32 +++++++++++++++++++++----
 arch/arm/mach-shmobile/timer.c               |   10 ++++++++
 6 files changed, 39 insertions(+), 33 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c

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
index be78a2c..3dab2ec 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -52,4 +52,6 @@ extern void sh73a0_secondary_init(unsigned int cpu);
 extern int sh73a0_boot_secondary(unsigned int cpu);
 extern void sh73a0_smp_prepare_cpus(void);
 
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
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index c49a833..928dd59 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -17,7 +17,6 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <asm/hardware/gic.h>
-#include <asm/localtimer.h>
 #include <asm/mach-types.h>
 #include <mach/common.h>
 
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index be1ade7..54903b9 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -41,6 +41,32 @@ static void __iomem *scu_base_addr(void)
 static DEFINE_SPINLOCK(scu_lock);
 static unsigned long tmp;
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static struct twd_local_timer twd_local_timer __initdata = {
+	.res =	{
+		{
+			.start	= 0xf0000600,
+			.end	= 0xf0000600 + 0x10,
+			.flags	= IORESOURCE_MEM,
+		},
+		{
+			.start	= 29,
+			.end	= 29,
+			.flags	= IORESOURCE_IRQ,
+		},
+	},
+};
+
+static void __init sh73a0_twd_init(void)
+{
+	int err = twd_local_timer_register(&twd_local_timer);
+	if (err)
+		pr_err("twd_local_timer_register failed %d\n", err);
+}
+#else
+#define sh73a0_twd_init	NULL
+#endif
+
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 {
 	void __iomem *scu_base = scu_base_addr();
@@ -59,11 +85,7 @@ unsigned int __init sh73a0_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
-#ifdef CONFIG_HAVE_ARM_TWD
-	/* twd_base needs to be initialized before percpu_timer_setup() */
-	twd_base = (void __iomem *)0xf0000600;
-#endif
-
+	shmobile_local_timer_register(sh73a0_twd_init);
 	return scu_get_core_count(scu_base);
 }
 
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
