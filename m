From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 21 Jun 2010 15:03:13 -0700
Subject: [RFC PATCH] msm: initial MSM8X60 early kernel boot support
In-Reply-To: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
References: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1277157793-9712-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

Current MSM8X60 platforms boot all available cores into the kernel
entrypoint in parallel.

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
---
Additional stuff needed to get the last smp patch working,
"smp: parallel smp boot option".

 arch/arm/mach-msm/Makefile  |    2 +
 arch/arm/mach-msm/headsmp.S |   57 ++++++++++++++++++++++
 arch/arm/mach-msm/platsmp.c |  112 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/headsmp.S
 create mode 100644 arch/arm/mach-msm/platsmp.c

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 31719cd..df0b9ad 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -24,6 +24,8 @@ ifdef CONFIG_ARCH_QSD8X50
 	obj-$(CONFIG_MSM_SOC_REV_A) += acpuclock-8x50a.o
 endif
 
+obj-$(CONFIG_SMP) += headsmp.o platsmp.o
+
 obj-$(CONFIG_MSM_CPU_AVS) += avs.o avs_hw.o
 obj-$(CONFIG_CPU_V6) += idle-v6.o
 obj-$(CONFIG_CPU_V7) += idle-v7.o
diff --git a/arch/arm/mach-msm/headsmp.S b/arch/arm/mach-msm/headsmp.S
new file mode 100644
index 0000000..351783c
--- /dev/null
+++ b/arch/arm/mach-msm/headsmp.S
@@ -0,0 +1,57 @@
+/*
+ *  Copyright (c) 2003 ARM Limited
+ *  All Rights Reserved
+ *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+
+/* Called very early during init. Only allowed to continue if we are the
+ * primary CPU, otherwise go to the secondary startup waiting to be brought
+ * out of reset.
+ */
+ENTRY(__smp_secondary_spin)
+	mrc	p15, 0, r0, c0, c0, 5	@ MPIDR
+	ands	r0, r0, #15		@ What CPU am I
+	moveq	pc,lr			@ if 0 (aka primary), return
+	/* Fall through  */
+
+/*
+ * MSM specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ *
+ * This is executing in physical space with cache's off.
+ */
+ENTRY(msm_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5 	@ MPIDR
+	and	r0, r0, #15		@ What CPU am I
+	adr	r4, 1f			@ address of
+	ldmia	r4, {r5, r6}		@ load curr addr and pen_rel addr
+	sub	r4, r4, r5		@ determine virtual/phys offsets
+	add	r6, r6, r4		@ apply
+pen:
+	wfe
+	dsb				@ ensure subsequent access is
+					@ after event
+
+	ldr	r7, [r6]		@ pen_rel has cpu to remove from reset
+	cmp	r7, r0			@ are we lucky?
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	mvn	r7, #0			@ -1 to registers
+	str r7,[r6]			@ back to the pen for ack
+	b	secondary_startup
+
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
new file mode 100644
index 0000000..9dfd092
--- /dev/null
+++ b/arch/arm/mach-msm/platsmp.c
@@ -0,0 +1,112 @@
+/*
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+
+#include <asm/hardware/gic.h>
+#include <asm/cacheflush.h>
+
+#include <mach/smp.h>
+#include <mach/hardware.h>
+#include <mach/msm_iomap.h>
+
+#define SECONDARY_CPU_WAIT_MS 10
+
+int pen_release = -1;
+
+int get_core_count(void)
+{
+#ifdef CONFIG_NR_CPUS
+	return CONFIG_NR_CPUS;
+#else
+	return 1;
+#endif
+}
+
+/* Initialize the present map (cpu_set(i, cpu_present_map)). */
+void smp_prepare_cpus(unsigned int max_cpus)
+{
+	int i;
+
+	for (i = 0; i < max_cpus; i++)
+		cpu_set(i, cpu_present_map);
+}
+
+void smp_init_cpus(void)
+{
+	unsigned int i, ncores = get_core_count();
+
+	for (i = 0; i < ncores; i++)
+		cpu_set(i, cpu_possible_map);
+}
+
+/* Executed by primary CPU, brings other CPUs out of reset. Called@boot
+   as well as when a CPU is coming out of shutdown induced by echo 0 >
+   /sys/devices/.../cpuX.
+*/
+int boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	int cnt = 0;
+	printk(KERN_DEBUG "Starting secondary CPU %d\n", cpu);
+
+	/* Tell other CPUs to come out or reset.  Note that secondary CPUs
+	 * are probably running with caches off, so we'll need to clean to
+	 * memory. Normal cache ops will only clean to L2.
+	 */
+	pen_release = cpu;
+	dmac_clean_range((void *)&pen_release,
+			 (void *)(&pen_release + sizeof(pen_release)));
+	dmac_clean_range((void *)&secondary_data,
+			 (void *)(&secondary_data + sizeof(secondary_data)));
+	sev();
+	dsb();
+
+	/* Wait for done signal. The cpu receiving the signal does not
+	 * have the MMU or caching turned on, so all of its reads and
+	 * writes are to/from memory.  Need to ensure that when
+	 * reading the value we invalidate the cache line so we see the
+	 * fresh data from memory as the normal routines may only
+	 * invalidate to POU or L1.
+	 */
+	while (pen_release != 0xFFFFFFFF) {
+		dmac_inv_range((void *)&pen_release,
+			       (void *)(&pen_release+sizeof(pen_release)));
+		msleep_interruptible(1);
+		if (cnt++ >= SECONDARY_CPU_WAIT_MS)
+			break;
+	}
+
+	if (pen_release == 0xFFFFFFFF)
+		printk(KERN_DEBUG "Secondary CPU start acked %d\n", cpu);
+	else
+		printk(KERN_ERR "Secondary CPU failed to start..." \
+		       "continuing\n");
+
+	return 0;
+}
+
+/* Initialization routine for secondary CPUs after they are brought out of
+ * reset.
+*/
+void platform_secondary_init(unsigned int cpu)
+{
+	printk(KERN_DEBUG "%s: cpu:%d\n", __func__, cpu);
+
+	trace_hardirqs_off();
+
+	/*
+	 * setup GIC (GIC number NOT CPU number and the base address of the
+	 * GIC CPU interface
+	 */
+	gic_cpu_init(0, MSM_QGIC_CPU_BASE);
+}
-- 
1.7.1
