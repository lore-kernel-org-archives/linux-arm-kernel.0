From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 09 Jan 2013 19:20:50 -0500
Subject: [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1357777251-13541-16-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

Add the required code to properly handle race free platform coherency exit
to the DCSCB power down method.

The power_up_setup callback is used to enable the CCI interface for
the cluster being brought up.  This must be done in assembly before
the kernel environment is entered.

Thanks to Achin Gupta and Nicolas Pitre for their help and
contributions.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/Kconfig       |  1 +
 arch/arm/mach-vexpress/Makefile      |  2 +-
 arch/arm/mach-vexpress/dcscb.c       | 90 +++++++++++++++++++++++++++---------
 arch/arm/mach-vexpress/dcscb_setup.S | 77 ++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/mach-vexpress/dcscb_setup.S

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index e55c02562f..180633dda6 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -56,6 +56,7 @@ config ARCH_VEXPRESS_CA9X4
 config ARCH_VEXPRESS_DCSCB
 	bool "Dual Cluster System Control Block (DCSCB) support"
 	depends on BIG_LITTLE
+	select ARM_CCI
 	help
 	  Support for the Dual Cluster System Configuration Block (DCSCB).
 	  This is needed to provide CPU and cluster power management
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 2253644054..f6e90f3272 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -6,6 +6,6 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 obj-y					:= v2m.o reset.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
-obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o
+obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 59b690376f..95a2d0df20 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/vexpress.h>
+#include <linux/arm-cci.h>
 
 #include <asm/bL_entry.h>
 #include <asm/proc-fns.h>
@@ -104,6 +105,8 @@ static void dcscb_power_down(void)
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	BUG_ON(cpu >= 4 || cluster >= 2);
 
+	__bL_cpu_going_down(cpu, cluster);
+
 	arch_spin_lock(&dcscb_lock);
 	dcscb_use_count[cpu][cluster]--;
 	if (dcscb_use_count[cpu][cluster] == 0) {
@@ -111,6 +114,7 @@ static void dcscb_power_down(void)
 		rst_hold |= cpumask;
 		if (((rst_hold | (rst_hold >> 4)) & cluster_mask) == cluster_mask) {
 			rst_hold |= (1 << 8);
+			BUG_ON(__bL_cluster_state(cluster) != CLUSTER_UP);
 			last_man = true;
 		}
 		writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
@@ -124,35 +128,71 @@ static void dcscb_power_down(void)
 		skip_wfi = true;
 	} else
 		BUG();
-	arch_spin_unlock(&dcscb_lock);
 
-	/*
-	 * Now let's clean our L1 cache and shut ourself down.
-	 * If we're the last CPU in this cluster then clean L2 too.
-	 */
-
-	/*
-	 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
-	 * a preliminary flush here for those CPUs.  At least, that's
-	 * the theory -- without the extra flush, Linux explodes on
-	 * RTSM (maybe not needed anymore, to be investigated)..
-	 */
-	flush_cache_louis();
-	cpu_proc_fin();
+	if (last_man && __bL_outbound_enter_critical(cpu, cluster)) {
+		arch_spin_unlock(&dcscb_lock);
 
-	if (!last_man) {
-		flush_cache_louis();
-	} else {
+		/*
+		 * Flush all cache levels for this cluster.
+		 *
+		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
+		 * a preliminary flush here for those CPUs.  At least, that's
+		 * the theory -- without the extra flush, Linux explodes on
+		 * RTSM (maybe not needed anymore, to be investigated).
+		 */
 		flush_cache_all();
+		cpu_proc_fin(); /* disable allocation into internal caches*/
+		flush_cache_all();
+
+		/*
+		 * This is a harmless no-op.  On platforms with a real
+		 * outer cache this might either be needed or not,
+		 * depending on where the outer cache sits.
+		 */
 		outer_flush_all();
+
+		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
+		asm volatile (
+			"mrc	p15, 0, ip, c1, c0, 1 \n\t"
+			"bic	ip, ip, #(1 << 6) @ clear SMP bit \n\t"
+			"mcr	p15, 0, ip, c1, c0, 1 \n\t"
+			"isb \n\t"
+			"dsb"
+			: : : "ip" );
+
+		/*
+		 * Disable cluster-level coherency by masking
+		 * incoming snoops and DVM messages:
+		 */
+		disable_cci(cluster);
+
+		__bL_outbound_leave_critical(cluster, CLUSTER_DOWN);
+	} else {
+		arch_spin_unlock(&dcscb_lock);
+
+		/*
+		 * Flush the local CPU cache.
+		 *
+		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
+		 * a preliminary flush here for those CPUs.  At least, that's
+		 * the theory -- without the extra flush, Linux explodes on
+		 * RTSM (maybe not needed anymore, to be investigated).
+		 */
+		flush_cache_louis();
+		cpu_proc_fin(); /* disable allocation into internal caches*/
+		flush_cache_louis();
+
+		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
+		asm volatile (
+			"mrc	p15, 0, ip, c1, c0, 1 \n\t"
+			"bic	ip, ip, #(1 << 6) @ clear SMP bit \n\t"
+			"mcr	p15, 0, ip, c1, c0, 1 \n\t"
+			"isb \n\t"
+			"dsb"
+			: : : "ip" );
 	}
 
-	/* Disable local coherency by clearing the ACTLR "SMP" bit: */
-	asm volatile (
-		"mrc	p15, 0, ip, c1, c0, 1 \n\t"
-		"bic	ip, ip, #(1 << 6) @ clear SMP bit \n\t"
-		"mcr	p15, 0, ip, c1, c0, 1"
-		: : : "ip" );
+	__bL_cpu_down(cpu, cluster);
 
 	/* Now we are prepared for power-down, do it: */
 	if (!skip_wfi)
@@ -179,6 +219,8 @@ static void __init dcscb_usage_count_init(void)
 	dcscb_use_count[cpu][cluster] = 1;
 }
 
+extern void dcscb_power_up_setup(void);
+
 static int __init dcscb_init(void)
 {
 	unsigned int cfg;
@@ -193,6 +235,8 @@ static int __init dcscb_init(void)
 	dcscb_usage_count_init();
 
 	ret = bL_platform_power_register(&dcscb_power_ops);
+	if (!ret)
+		ret = bL_cluster_sync_init(dcscb_power_up_setup);
 	if (ret) {
 		iounmap(dcscb_base);
 		return ret;
diff --git a/arch/arm/mach-vexpress/dcscb_setup.S b/arch/arm/mach-vexpress/dcscb_setup.S
new file mode 100644
index 0000000000..c75ee8c4db
--- /dev/null
+++ b/arch/arm/mach-vexpress/dcscb_setup.S
@@ -0,0 +1,77 @@
+/*
+ * arch/arm/include/asm/dcscb_setup.S
+ *
+ * Created by:  Dave Martin, 2012-06-22
+ * Copyright:   (C) 2012  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/linkage.h>
+#include <asm/bL_entry.h>
+
+
+#define SLAVE_SNOOPCTL_OFFSET	0
+#define SNOOPCTL_SNOOP_ENABLE	(1 << 0)
+#define SNOOPCTL_DVM_ENABLE	(1 << 1)
+
+#define CCI_STATUS_OFFSET	0xc
+#define STATUS_CHANGE_PENDING	(1 << 0)
+
+#define CCI_SLAVE_OFFSET(n)	(0x1000 + 0x1000 * (n))
+
+#define RTSM_CCI_PHYS_BASE	0x2c090000
+#define RTSM_CCI_SLAVE_A15	3
+#define RTSM_CCI_SLAVE_A7	4
+
+#define RTSM_CCI_A15_OFFSET	CCI_SLAVE_OFFSET(RTSM_CCI_SLAVE_A15)
+#define RTSM_CCI_A7_OFFSET	CCI_SLAVE_OFFSET(RTSM_CCI_SLAVE_A7)
+
+
+ENTRY(dcscb_power_up_setup)
+
+	cmp	r0, #0			@ check affinity level
+	beq	2f
+
+/*
+ * Enable cluster-level coherency, in preparation for turning on the MMU.
+ * The ACTLR SMP bit does not need to be set here, because cpu_resume()
+ * already restores that.
+ */
+
+	mrc	p15, 0, r0, c0, c0, 5	@ MPIDR
+	ubfx	r0, r0, #8, #4		@ cluster
+
+	@ A15/A7 may not require explicit L2 invalidation on reset, dependent
+	@ on hardware integration desicions.
+	@ For now, this code assumes that L2 is either already invalidated, or
+	@ invalidation is not required.
+
+	ldr	r3, =RTSM_CCI_PHYS_BASE + RTSM_CCI_A15_OFFSET
+	cmp	r0, #0		@ A15 cluster?
+	addne	r3, r3, #RTSM_CCI_A7_OFFSET - RTSM_CCI_A15_OFFSET
+
+	@ r3 now points to the correct CCI slave register block
+
+	ldr	r0, [r3, #SLAVE_SNOOPCTL_OFFSET]
+	orr	r0, r0, #SNOOPCTL_SNOOP_ENABLE | SNOOPCTL_DVM_ENABLE
+	str	r0, [r3, #SLAVE_SNOOPCTL_OFFSET]	@ enable CCI snoops
+
+	@ Wait for snoop control change to complete:
+
+	ldr	r3, =RTSM_CCI_PHYS_BASE
+
+	b	1f
+0:	dsb
+1:	ldr	r0, [r3, #CCI_STATUS_OFFSET]
+	tst	r0, #STATUS_CHANGE_PENDING
+	bne	0b
+
+2:	@ Implementation-specific local CPU setup operations should go here,
+	@ if any.  In this case, there is nothing to do.
+
+	bx	lr
+ENDPROC(dcscb_power_up_setup)
-- 
1.8.0
