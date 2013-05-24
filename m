From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 May 2013 01:45:10 -0400
Subject: [PATCH 7/8] ARM: vexpress/dcscb: handle platform coherency exit/setup
 and CCI
In-Reply-To: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
References: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1369374311-21260-8-git-send-email-nicolas.pitre@linaro.org>
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
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/Kconfig       |  1 +
 arch/arm/mach-vexpress/Makefile      |  2 +-
 arch/arm/mach-vexpress/dcscb.c       | 79 +++++++++++++++++++++++++++---------
 arch/arm/mach-vexpress/dcscb_setup.S | 38 +++++++++++++++++
 4 files changed, 100 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/mach-vexpress/dcscb_setup.S

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 2f46385c28..b8bbabec63 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -60,6 +60,7 @@ config ARCH_VEXPRESS_CA9X4
 config ARCH_VEXPRESS_DCSCB
 	bool "Dual Cluster System Control Block (DCSCB) support"
 	depends on MCPM
+	select ARM_CCI
 	help
 	  Support for the Dual Cluster System Configuration Block (DCSCB).
 	  This is needed to provide CPU and cluster power management
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 518519f57a..48ba89a814 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -6,6 +6,6 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
-obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o
+obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index b928b1f5eb..1acc975360 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/of_address.h>
 #include <linux/vexpress.h>
+#include <linux/arm-cci.h>
 
 #include <asm/mcpm.h>
 #include <asm/proc-fns.h>
@@ -105,7 +106,10 @@ static void dcscb_power_down(void)
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	BUG_ON(cpu >= 4 || cluster >= 2);
 
+	__mcpm_cpu_going_down(cpu, cluster);
+
 	arch_spin_lock(&dcscb_lock);
+	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
 	dcscb_use_count[cpu][cluster]--;
 	if (dcscb_use_count[cpu][cluster] == 0) {
 		rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
@@ -125,31 +129,59 @@ static void dcscb_power_down(void)
 		skip_wfi = true;
 	} else
 		BUG();
-	arch_spin_unlock(&dcscb_lock);
-
-	/*
-	 * Now let's clean our L1 cache and shut ourself down.
-	 * If we're the last CPU in this cluster then clean L2 too.
-	 */
 
-	/*
-	 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
-	 * a preliminary flush here for those CPUs.  At least, that's
-	 * the theory -- without the extra flush, Linux explodes on
-	 * RTSM (to be investigated)..
-	 */
-	flush_cache_louis();
-	set_cr(get_cr() & ~CR_C);
+	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
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
+		 * RTSM (to be investigated).
+		 */
+		flush_cache_all();
+		set_cr(get_cr() & ~CR_C);
 		flush_cache_all();
+
+		/*
+		 * This is a harmless no-op.  On platforms with a real
+		 * outer cache this might either be needed or not,
+		 * depending on where the outer cache sits.
+		 */
 		outer_flush_all();
+
+		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
+		set_auxcr(get_auxcr() & ~(1 << 6));
+
+		/*
+		 * Disable cluster-level coherency by masking
+		 * incoming snoops and DVM messages:
+		 */
+		cci_disable_port_by_cpu(mpidr);
+
+		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
+	} else {
+		arch_spin_unlock(&dcscb_lock);
+
+		/*
+		 * Flush the local CPU cache.
+		 *
+		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
+		 * a preliminary flush here for those CPUs.  At least, that's
+		 * the theory -- without the extra flush, Linux explodes on
+		 * RTSM (to be investigated).
+		 */
+		flush_cache_louis();
+		set_cr(get_cr() & ~CR_C);
+		flush_cache_louis();
+
+		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
+		set_auxcr(get_auxcr() & ~(1 << 6));
 	}
 
-	/* Disable local coherency by clearing the ACTLR "SMP" bit: */
-	set_auxcr(get_auxcr() & ~(1 << 6));
+	__mcpm_cpu_down(cpu, cluster);
 
 	/* Now we are prepared for power-down, do it: */
 	dsb();
@@ -177,12 +209,17 @@ static void __init dcscb_usage_count_init(void)
 	dcscb_use_count[cpu][cluster] = 1;
 }
 
+extern void dcscb_power_up_setup(unsigned int affinity_level);
+
 static int __init dcscb_init(void)
 {
 	struct device_node *node;
 	unsigned int cfg;
 	int ret;
 
+	if (!cci_probed())
+		return -ENODEV;
+
 	node = of_find_compatible_node(NULL, NULL, "arm,rtsm,dcscb");
 	if (!node)
 		return -ENODEV;
@@ -195,11 +232,15 @@ static int __init dcscb_init(void)
 	dcscb_usage_count_init();
 
 	ret = mcpm_platform_register(&dcscb_power_ops);
+	if (!ret)
+		ret = mcpm_sync_init(dcscb_power_up_setup);
 	if (ret) {
 		iounmap(dcscb_base);
 		return ret;
 	}
 
+	pr_info("VExpress DCSCB support installed\n");
+
 	/*
 	 * Future entries into the kernel can now go
 	 * through the cluster entry vectors.
diff --git a/arch/arm/mach-vexpress/dcscb_setup.S b/arch/arm/mach-vexpress/dcscb_setup.S
new file mode 100644
index 0000000000..4bb7fbe0f6
--- /dev/null
+++ b/arch/arm/mach-vexpress/dcscb_setup.S
@@ -0,0 +1,38 @@
+/*
+ * arch/arm/include/asm/dcscb_setup.S
+ *
+ * Created by:  Dave Martin, 2012-06-22
+ * Copyright:   (C) 2012-2013  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
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
+ *
+ * A15/A7 may not require explicit L2 invalidation on reset, dependent
+ * on hardware integration decisions.
+ * For now, this code assumes that L2 is either already invalidated,
+ * or invalidation is not required.
+ */
+
+	b	cci_enable_port_for_self
+
+2:	@ Implementation-specific local CPU setup operations should go here,
+	@ if any.  In this case, there is nothing to do.
+
+	bx	lr
+
+ENDPROC(dcscb_power_up_setup)
-- 
1.8.1.2
