From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 Apr 2011 21:08:10 -0500
Subject: [PATCH 03/10] ARM: msm: use common secondary pen code
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
Message-ID: <1304129297-6614-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig            |    1 +
 arch/arm/mach-msm/Makefile  |    2 +-
 arch/arm/mach-msm/headsmp.S |   40 -----------------------
 arch/arm/mach-msm/platsmp.c |   73 ++-----------------------------------------
 4 files changed, 5 insertions(+), 111 deletions(-)
 delete mode 100644 arch/arm/mach-msm/headsmp.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 84e2127..959b27f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -647,6 +647,7 @@ config ARCH_MSM
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select SMP_COMMON_PEN if SMP
 	help
 	  Support for Qualcomm MSM/QSD based systems.  This runs on the
 	  apps processor of the MSM/QSD and depends on a shared memory
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 9519fd2..8460f98 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 obj-$(CONFIG_MSM_SCM) += scm.o scm-boot.o
 
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
-obj-$(CONFIG_SMP) += headsmp.o platsmp.o
+obj-$(CONFIG_SMP) += platsmp.o
 
 obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o devices-msm7x00.o
 obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o board-trout-panel.o devices-msm7x00.o
diff --git a/arch/arm/mach-msm/headsmp.S b/arch/arm/mach-msm/headsmp.S
deleted file mode 100644
index 0c631a9..0000000
--- a/arch/arm/mach-msm/headsmp.S
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- *  linux/arch/arm/mach-realview/headsmp.S
- *
- *  Copyright (c) 2003 ARM Limited
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-	__CPUINIT
-
-/*
- * MSM specific entry point for secondary CPUs.  This provides
- * a "holding pen" into which all secondary cores are held until we're
- * ready for them to initialise.
- */
-ENTRY(msm_secondary_startup)
-	mrc	p15, 0, r0, c0, c0, 5
-	and	r0, r0, #15
-	adr	r4, 1f
-	ldmia	r4, {r5, r6}
-	sub	r4, r4, r5
-	add	r6, r6, r4
-pen:	ldr	r7, [r6]
-	cmp	r7, r0
-	bne	pen
-
-	/*
-	 * we've been released from the holding pen: secondary_stack
-	 * should now contain the SVC stack for this core
-	 */
-	b	secondary_startup
-
-	.align
-1:	.long	.
-	.long	pen_release
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 0f427bc..4315bb5 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -31,45 +31,18 @@
 /* Mask for edge trigger PPIs except AVS_SVICINT and AVS_SVICINTSWDONE */
 #define GIC_PPI_EDGE_MASK 0xFFFFD7FF
 
-extern void msm_secondary_startup(void);
-/*
- * control for which core is the next to come out of the secondary
- * boot "holding pen".
- */
-volatile int pen_release = -1;
-
-static DEFINE_SPINLOCK(boot_lock);
-
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	/* Configure edge-triggered PPIs */
 	writel(GIC_PPI_EDGE_MASK, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
 
-	/*
-	 * if any interrupts are already enabled for the primary
-	 * core (e.g. timer irq), then they will not have been enabled
-	 * for us: do so
-	 */
-	gic_secondary_init(0);
-
-	/*
-	 * let the primary processor know we're out of the
-	 * pen, then head off into the C entry point
-	 */
-	pen_release = -1;
-	smp_wmb();
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	pen_secondary_init(cpu);
 }
 
 static __cpuinit void prepare_cold_cpu(unsigned int cpu)
 {
 	int ret;
-	ret = scm_set_boot_addr(virt_to_phys(msm_secondary_startup),
+	ret = scm_set_boot_addr(virt_to_phys(pen_secondary_startup),
 				SCM_FLAG_COLDBOOT_CPU1);
 	if (ret == 0) {
 		void *sc1_base_ptr;
@@ -96,47 +69,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 		cold_boot_done = true;
 	}
 
-	/*
-	 * set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
-	 * The secondary processor is waiting to be released from
-	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
-	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
-	 * "cpu" is Linux's internal ID.
-	 */
-	pen_release = cpu;
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
-
-	/*
-	 * Send the secondary CPU a soft interrupt, thereby causing
-	 * the boot monitor to read the system wide flags register,
-	 * and branch to the address found there.
-	 */
-	smp_cross_call(cpumask_of(cpu), 1);
-
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		smp_rmb();
-		if (pen_release == -1)
-			break;
-
-		udelay(10);
-	}
-
-	/*
-	 * now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-
-	return pen_release != -1 ? -ENOSYS : 0;
+	return pen_boot_secondary(cpu, idle);
 }
 
 /*
-- 
1.7.1
