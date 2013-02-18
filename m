From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 18 Feb 2013 22:48:03 +0900
Subject: [PATCH 08/08] ARM: shmobile: Remove unused hotplug.c
In-Reply-To: <20130218134648.17303.97576.sendpatchset@w520>
References: <20130218134648.17303.97576.sendpatchset@w520>
Message-ID: <20130218134803.17303.58317.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Each CPU Hotplug implementation for mach-shmobile
is now self-contained, so this change removes unused
helper code in hotplug.c. The two CPU Hotplug capable
SoCs sh73a0 and r8a7779 remain unchanged.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile              |    1 
 arch/arm/mach-shmobile/hotplug.c             |   64 --------------------------
 arch/arm/mach-shmobile/include/mach/common.h |   10 ----
 3 files changed, 75 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-02-18 16:39:05.000000000 +0900
@@ -14,7 +14,6 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.
 
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
-smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
--- 0001/arch/arm/mach-shmobile/hotplug.c
+++ /dev/null	2013-01-21 13:48:16.387453344 +0900
@@ -1,64 +0,0 @@
-/*
- * SMP support for R-Mobile / SH-Mobile
- *
- * Copyright (C) 2010  Magnus Damm
- *
- * Based on realview, Copyright (C) 2002 ARM Ltd, All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-#include <linux/cpumask.h>
-#include <linux/delay.h>
-#include <mach/common.h>
-#include <asm/cacheflush.h>
-
-static cpumask_t dead_cpus;
-
-void shmobile_cpu_die(unsigned int cpu)
-{
-	/* hardware shutdown code running on the CPU that is being offlined */
-	flush_cache_all();
-	dsb();
-
-	/* notify platform_cpu_kill() that hardware shutdown is finished */
-	cpumask_set_cpu(cpu, &dead_cpus);
-
-	/* wait for SoC code in platform_cpu_kill() to shut off CPU core
-	 * power. CPU bring up starts from the reset vector.
-	 */
-	while (1) {
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
-	}
-}
-
-int shmobile_cpu_disable(unsigned int cpu)
-{
-	cpumask_clear_cpu(cpu, &dead_cpus);
-	/*
-	 * we don't allow CPU 0 to be shutdown (it is still too special
-	 * e.g. clock tick interrupts)
-	 */
-	return cpu == 0 ? -EPERM : 0;
-}
-
-int shmobile_cpu_disable_any(unsigned int cpu)
-{
-	cpumask_clear_cpu(cpu, &dead_cpus);
-	return 0;
-}
-
-int shmobile_cpu_is_dead(unsigned int cpu)
-{
-	return cpumask_test_cpu(cpu, &dead_cpus);
-}
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-02-18 16:38:33.000000000 +0900
@@ -85,16 +85,6 @@ int shmobile_cpuidle_init(void);
 static inline int shmobile_cpuidle_init(void) { return 0; }
 #endif
 
-extern void shmobile_cpu_die(unsigned int cpu);
-extern int shmobile_cpu_disable(unsigned int cpu);
-extern int shmobile_cpu_disable_any(unsigned int cpu);
-
-#ifdef CONFIG_HOTPLUG_CPU
-extern int shmobile_cpu_is_dead(unsigned int cpu);
-#else
-static inline int shmobile_cpu_is_dead(unsigned int cpu) { return 1; }
-#endif
-
 extern void __iomem *shmobile_scu_base;
 extern void shmobile_smp_init_cpus(unsigned int ncores);
 
