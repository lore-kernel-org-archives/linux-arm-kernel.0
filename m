From: Dave.Martin@arm.com (Dave Martin)
Date: Tue,  1 Oct 2013 10:55:02 +0100
Subject: [PATCH v2 3/3] ARM: vexpress/TC2: Implement MCPM power_down_finish()
In-Reply-To: <1380621302-5655-1-git-send-email-Dave.Martin@arm.com>
References: <1380621302-5655-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1380621302-5655-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the power_down_finish() method for TC2, to
enable the kernel to confirm when CPUs are safely powered down.

The information required for determining when a CPU is parked
cannot be obtained from any single place, so a few sources of
information must be combined:

  * mcpm_cpu_power_down() must be pending for the CPU, so that we
    don't get confused by false STANDBYWFI positives arising from
    CPUidle.  This is detected by waiting for the tc2_pm use count
    for the target CPU to reach 0.

  * Either the SPC must report that the CPU has asserted
    STANDBYWFI, or the TC2 tile's reset control logic must be
    holding the CPU in reset.

    Just checking for STANDBYWFI is not sufficient, because this
    signal is not latched when the the cluster is clamped off and
    powered down: the relevant status bits just drop to zero.  This
    means that STANDBYWFI status cannot be used for reliable
    detection of the last CPU in a cluster reaching WFI.

This patch is required in order for kexec to work with MCPM on TC2.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/mach-vexpress/spc.c    |   39 ++++++++++++++++++++++
 arch/arm/mach-vexpress/spc.h    |    1 +
 arch/arm/mach-vexpress/tc2_pm.c |   69 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index eefb029..6f6ac56 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -35,6 +35,10 @@
 /* SPC per-CPU mailboxes */
 #define A15_BX_ADDR0		0x68
 #define A7_BX_ADDR0		0x78
+/* SPC CPU/cluster reset statue */
+#define STANDBYWFI_STAT		0x3c
+#define STANDBYWFI_STAT_A15_CPU_MASK(cpu)	(1 << (cpu))
+#define STANDBYWFI_STAT_A7_CPU_MASK(cpu)	(1 << (3 + (cpu)))
 
 /* wake-up interrupt masks */
 #define GBL_WAKEUP_INT_MSK	(0x3 << 10)
@@ -157,6 +161,41 @@ void ve_spc_powerdown(u32 cluster, bool enable)
 	writel_relaxed(enable, info->baseaddr + pwdrn_reg);
 }
 
+static u32 standbywfi_cpu_mask(u32 cpu, u32 cluster)
+{
+	return cluster_is_a15(cluster) ?
+		  STANDBYWFI_STAT_A15_CPU_MASK(cpu)
+		: STANDBYWFI_STAT_A7_CPU_MASK(cpu);
+}
+
+/**
+ * ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
+ *
+ * @cpu: mpidr[7:0] bitfield describing CPU affinity level within cluster
+ * @cluster: mpidr[15:8] bitfield describing cluster affinity level
+ *
+ * @return: non-zero if and only if the specified CPU is in WFI
+ *
+ * Take care when interpreting the result of this function: a CPU might
+ * be in WFI temporarily due to idle, and is not necessarily safely
+ * parked.
+ */
+int ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
+{
+	int ret;
+	u32 mask = standbywfi_cpu_mask(cpu, cluster);
+
+	if (cluster >= MAX_CLUSTERS)
+		return 1;
+
+	ret = readl_relaxed(info->baseaddr + STANDBYWFI_STAT);
+
+	pr_debug("%s: PCFGREG[0x%X] = 0x%08X, mask = 0x%X\n",
+		 __func__, STANDBYWFI_STAT, ret, mask);
+
+	return ret & mask;
+}
+
 int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid)
 {
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
diff --git a/arch/arm/mach-vexpress/spc.h b/arch/arm/mach-vexpress/spc.h
index 5f7e4a4..edb1b06 100644
--- a/arch/arm/mach-vexpress/spc.h
+++ b/arch/arm/mach-vexpress/spc.h
@@ -20,5 +20,6 @@ void ve_spc_global_wakeup_irq(bool set);
 void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set);
 void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr);
 void ve_spc_powerdown(u32 cluster, bool enable);
+int ve_spc_cpu_in_wfi(u32 cpu, u32 cluster);
 
 #endif
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index e6eb481..ede245c 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -31,11 +32,17 @@
 #include "spc.h"
 
 /* SCC conf registers */
+#define RESET_CTRL		0x018
+#define RESET_A15_NCORERESET(cpu)	(1 << (2 + (cpu)))
+#define RESET_A7_NCORERESET(cpu)	(1 << (19 + (cpu)))
+
 #define A15_CONF		0x400
 #define A7_CONF			0x500
 #define SYS_INFO		0x700
 #define SPC_BASE		0xb00
 
+static void __iomem *scc;
+
 /*
  * We can't use regular spinlocks. In the switcher case, it is possible
  * for an outbound CPU to call power_down() after its inbound counterpart
@@ -233,6 +240,58 @@ static void tc2_pm_power_down(void)
 	tc2_pm_down(0);
 }
 
+static int tc2_core_in_reset(unsigned int cpu, unsigned int cluster)
+{
+	u32 mask = cluster ?
+		  RESET_A7_NCORERESET(cpu)
+		: RESET_A15_NCORERESET(cpu);
+
+	return !(readl_relaxed(scc + RESET_CTRL) & mask);
+}
+
+#define POLL_MSEC 10
+#define TIMEOUT_MSEC 1000
+
+static int tc2_pm_power_down_finish(unsigned int cpu, unsigned int cluster)
+{
+	unsigned tries;
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	BUG_ON(cluster >= TC2_CLUSTERS || cpu >= TC2_MAX_CPUS_PER_CLUSTER);
+
+	for (tries = 0; tries < TIMEOUT_MSEC / POLL_MSEC; ++tries) {
+		/*
+		 * In case this CPU raced too far ahead of the target CPU,
+		 * wait until tc2_pm_down() has really been entered:
+		 */
+		if (ACCESS_ONCE(tc2_pm_use_count[cpu][cluster]) != 0)
+			goto poll;
+
+		pr_debug("%s(cpu=%u, cluster=%u): RESET_CTRL = 0x%08X\n",
+			 __func__, cpu, cluster,
+			 readl_relaxed(scc + RESET_CTRL));
+
+		/*
+		 * We need the CPU to reach WFI, but the power
+		 * controller may immediately put the CPU in reset and
+		 * power the cluster off as soon as that happens, if
+		 * there are no other CPUs live on the cluster.  That
+		 * can cause the CPU's STANDBYWFI signal to disappear
+		 * before we see it.
+		 *
+		 * So we need to check for both conditions:
+		 */
+		if (tc2_core_in_reset(cpu, cluster) ||
+		    ve_spc_cpu_in_wfi(cpu, cluster))
+			return 0; /* success: the CPU is halted */
+
+	poll:
+		msleep(POLL_MSEC);
+	}
+
+	return -ETIMEDOUT; /* timeout */
+}
+
 static void tc2_pm_suspend(u64 residency)
 {
 	unsigned int mpidr, cpu, cluster;
@@ -275,10 +334,11 @@ static void tc2_pm_powered_up(void)
 }
 
 static const struct mcpm_platform_ops tc2_pm_power_ops = {
-	.power_up	= tc2_pm_power_up,
-	.power_down	= tc2_pm_power_down,
-	.suspend	= tc2_pm_suspend,
-	.powered_up	= tc2_pm_powered_up,
+	.power_up		= tc2_pm_power_up,
+	.power_down		= tc2_pm_power_down,
+	.power_down_finish	= tc2_pm_power_down_finish,
+	.suspend		= tc2_pm_suspend,
+	.powered_up		= tc2_pm_powered_up,
 };
 
 static bool __init tc2_pm_usage_count_init(void)
@@ -312,7 +372,6 @@ static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
 static int __init tc2_pm_init(void)
 {
 	int ret;
-	void __iomem *scc;
 	u32 a15_cluster_id, a7_cluster_id, sys_info;
 	struct device_node *np;
 
-- 
1.7.9.5
