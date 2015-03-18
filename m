From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Mar 2015 14:04:53 -0400
Subject: [PATCH RFC/RFT 6/6] ARM: hisi/hip04: remove the MCPM overhead
In-Reply-To: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
References: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1426701893-25589-7-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform is currently relying on the MCPM infrastructure for no
apparent reason.  The MCPM concurrency handling brings no benefits here
as there is no asynchronous CPU wake-ups to be concerned about (this is
used for CPU hotplug and secondary boot only, not for CPU idle).

This platform is also different from the other MCPM users because a given
CPU can't shut itself down completely without the assistance of another
CPU. This is at odds with the on-going MCPM backend refactoring.

To simplify things, this is converted to hook directly into the
smp_operations callbacks, bypassing the MCPM infrastructure.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-hisi/platmcpm.c | 127 ++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index 280f3f14f7..880cbfa9c3 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -6,6 +6,8 @@
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
  */
+#include <linux/init.h>
+#include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
@@ -13,7 +15,9 @@
 
 #include <asm/cputype.h>
 #include <asm/cp15.h>
-#include <asm/mcpm.h>
+#include <asm/cacheflush.h>
+#include <asm/smp.h>
+#include <asm/smp_plat.h>
 
 #include "core.h"
 
@@ -94,11 +98,16 @@ static void hip04_set_snoop_filter(unsigned int cluster, unsigned int on)
 	} while (data != readl_relaxed(fabric + FAB_SF_MODE));
 }
 
-static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
+static int hip04_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
 {
+	unsigned int mpidr, cpu, cluster;
 	unsigned long data;
 	void __iomem *sys_dreq, *sys_status;
 
+	mpidr = cpu_logical_map(l_cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
 	if (!sysctrl)
 		return -ENODEV;
 	if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
@@ -118,6 +127,7 @@ static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
 			cpu_relax();
 			data = readl_relaxed(sys_status);
 		} while (data & CLUSTER_DEBUG_RESET_STATUS);
+		hip04_set_snoop_filter(cluster, 1);
 	}
 
 	data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
@@ -126,11 +136,15 @@ static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
 	do {
 		cpu_relax();
 	} while (data == readl_relaxed(sys_status));
+
 	/*
 	 * We may fail to power up core again without this delay.
 	 * It's not mentioned in document. It's found by test.
 	 */
 	udelay(20);
+
+	arch_send_wakeup_ipi_mask(cpumask_of(l_cpu));
+
 out:
 	hip04_cpu_table[cluster][cpu]++;
 	spin_unlock_irq(&boot_lock);
@@ -138,31 +152,29 @@ out:
 	return 0;
 }
 
-static void hip04_mcpm_power_down(void)
+static void hip04_cpu_die(unsigned int l_cpu)
 {
 	unsigned int mpidr, cpu, cluster;
-	bool skip_wfi = false, last_man = false;
+	bool last_man;
 
-	mpidr = read_cpuid_mpidr();
+	mpidr = cpu_logical_map(l_cpu);
 	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 
-	__mcpm_cpu_going_down(cpu, cluster);
-
 	spin_lock(&boot_lock);
-	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
 	hip04_cpu_table[cluster][cpu]--;
 	if (hip04_cpu_table[cluster][cpu] == 1) {
 		/* A power_up request went ahead of us. */
-		skip_wfi = true;
+		spin_unlock(&boot_lock);
+		return;
 	} else if (hip04_cpu_table[cluster][cpu] > 1) {
 		pr_err("Cluster %d CPU%d boots multiple times\n", cluster, cpu);
 		BUG();
 	}
 
 	last_man = hip04_cluster_is_down(cluster);
-	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
-		spin_unlock(&boot_lock);
+	spin_unlock(&boot_lock);
+	if (last_man) {
 		/* Since it's Cortex A15, disable L2 prefetching. */
 		asm volatile(
 		"mcr	p15, 1, %0, c15, c0, 3 \n\t"
@@ -170,34 +182,30 @@ static void hip04_mcpm_power_down(void)
 		"dsb	"
 		: : "r" (0x400) );
 		v7_exit_coherency_flush(all);
-		hip04_set_snoop_filter(cluster, 0);
-		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
 	} else {
-		spin_unlock(&boot_lock);
 		v7_exit_coherency_flush(louis);
 	}
 
-	__mcpm_cpu_down(cpu, cluster);
-
-	if (!skip_wfi)
+	for (;;)
 		wfi();
 }
 
-static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
+static int hip04_cpu_kill(unsigned int l_cpu)
 {
+	unsigned int mpidr, cpu, cluster;
 	unsigned int data, tries, count;
-	int ret = -ETIMEDOUT;
 
+	mpidr = cpu_logical_map(l_cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	BUG_ON(cluster >= HIP04_MAX_CLUSTERS ||
 	       cpu >= HIP04_MAX_CPUS_PER_CLUSTER);
 
 	count = TIMEOUT_MSEC / POLL_MSEC;
 	spin_lock_irq(&boot_lock);
 	for (tries = 0; tries < count; tries++) {
-		if (hip04_cpu_table[cluster][cpu]) {
-			ret = -EBUSY;
+		if (hip04_cpu_table[cluster][cpu])
 			goto err;
-		}
 		cpu_relax();
 		data = readl_relaxed(sysctrl + SC_CPU_RESET_STATUS(cluster));
 		if (data & CORE_WFI_STATUS(cpu))
@@ -220,64 +228,19 @@ static int hip04_mcpm_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
 	}
 	if (tries >= count)
 		goto err;
+	if (hip04_cluster_is_down(cluster))
+		hip04_set_snoop_filter(cluster, 0);
 	spin_unlock_irq(&boot_lock);
-	return 0;
+	return 1;
 err:
 	spin_unlock_irq(&boot_lock);
-	return ret;
-}
-
-static void hip04_mcpm_powered_up(void)
-{
-	unsigned int mpidr, cpu, cluster;
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-
-	spin_lock(&boot_lock);
-	if (!hip04_cpu_table[cluster][cpu])
-		hip04_cpu_table[cluster][cpu] = 1;
-	spin_unlock(&boot_lock);
-}
-
-static void __naked hip04_mcpm_power_up_setup(unsigned int affinity_level)
-{
-	asm volatile ("			\n"
-"	cmp	r0, #0			\n"
-"	bxeq	lr			\n"
-	/* calculate fabric phys address */
-"	adr	r2, 2f			\n"
-"	ldmia	r2, {r1, r3}		\n"
-"	sub	r0, r2, r1		\n"
-"	ldr	r2, [r0, r3]		\n"
-	/* get cluster id from MPIDR */
-"	mrc	p15, 0, r0, c0, c0, 5	\n"
-"	ubfx	r1, r0, #8, #8		\n"
-	/* 1 << cluster id */
-"	mov	r0, #1			\n"
-"	mov	r3, r0, lsl r1		\n"
-"	ldr	r0, [r2, #"__stringify(FAB_SF_MODE)"]	\n"
-"	tst	r0, r3			\n"
-"	bxne	lr			\n"
-"	orr	r1, r0, r3		\n"
-"	str	r1, [r2, #"__stringify(FAB_SF_MODE)"]	\n"
-"1:	ldr	r0, [r2, #"__stringify(FAB_SF_MODE)"]	\n"
-"	tst	r0, r3			\n"
-"	beq	1b			\n"
-"	bx	lr			\n"
-
-"	.align	2			\n"
-"2:	.word	.			\n"
-"	.word	fabric_phys_addr	\n"
-	);
+	return 0;
 }
 
-static const struct mcpm_platform_ops hip04_mcpm_ops = {
-	.power_up		= hip04_mcpm_power_up,
-	.power_down		= hip04_mcpm_power_down,
-	.wait_for_powerdown	= hip04_mcpm_wait_for_powerdown,
-	.powered_up		= hip04_mcpm_powered_up,
+static struct smp_operations __initdata hip04_smp_ops = {
+	.smp_boot_secondary	= hip04_boot_secondary,
+	.cpu_die		= hip04_cpu_die,
+	.cpu_kill		= hip04_cpu_kill,
 };
 
 static bool __init hip04_cpu_table_init(void)
@@ -298,7 +261,7 @@ static bool __init hip04_cpu_table_init(void)
 	return true;
 }
 
-static int __init hip04_mcpm_init(void)
+static int __init hip04_smp_init(void)
 {
 	struct device_node *np, *np_sctl, *np_fab;
 	struct resource fab_res;
@@ -353,10 +316,6 @@ static int __init hip04_mcpm_init(void)
 		ret = -EINVAL;
 		goto err_table;
 	}
-	ret = mcpm_platform_register(&hip04_mcpm_ops);
-	if (ret) {
-		goto err_table;
-	}
 
 	/*
 	 * Fill the instruction address that is used after secondary core
@@ -364,13 +323,11 @@ static int __init hip04_mcpm_init(void)
 	 */
 	writel_relaxed(hip04_boot_method[0], relocation);
 	writel_relaxed(0xa5a5a5a5, relocation + 4);	/* magic number */
-	writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
+	writel_relaxed(virt_to_phys(secondary_startup), relocation + 8);
 	writel_relaxed(0, relocation + 12);
 	iounmap(relocation);
 
-	mcpm_sync_init(hip04_mcpm_power_up_setup);
-	mcpm_smp_set_ops();
-	pr_info("HiP04 MCPM initialized\n");
+	smp_set_ops(&hip04_smp_ops);
 	return ret;
 err_table:
 	iounmap(fabric);
@@ -383,4 +340,4 @@ err_reloc:
 err:
 	return ret;
 }
-early_initcall(hip04_mcpm_init);
+early_initcall(hip04_smp_init);
-- 
2.1.0
