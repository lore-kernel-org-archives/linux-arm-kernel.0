From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 25 Nov 2013 16:16:25 +0000
Subject: [PATCH v4 REPOST] ARM: vexpress/TC2: Implement MCPM
 power_down_finish()
Message-ID: <1385396185-15291-1-git-send-email-Dave.Martin@arm.com>
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
Acked-by: Pawel Moll <pawel.moll@arm.com>
---

Since v3.13-rc1, mcpm backends must implement an additional method which
the vexpress TC2 implementation doesn't have upstream, resulting in an
ugly WARN_ON() during hotplug and kexec operations.

This patch has received review, but the audience for it is small, so
feedback has been limited.  Pawel has agreed that it is OK for merge,
though, as documented by the following thread:

http://archive.arm.linux.org.uk/lurker/message/20131002.144555.de22a6f8.en.html


Since there is now an interface break, it would be good if this patch
can be merged as a fix in the 3.13 cycle.  This code is specific to
vexpress TC2 and won't affect any other platform.


 arch/arm/mach-vexpress/spc.c    |   40 ++++++++++++++++++++++++
 arch/arm/mach-vexpress/spc.h    |    1 +
 arch/arm/mach-vexpress/tc2_pm.c |   66 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 033d34d..c26ef5b 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -53,6 +53,11 @@
 #define A15_BX_ADDR0		0x68
 #define A7_BX_ADDR0		0x78
 
+/* SPC CPU/cluster reset statue */
+#define STANDBYWFI_STAT		0x3c
+#define STANDBYWFI_STAT_A15_CPU_MASK(cpu)	(1 << (cpu))
+#define STANDBYWFI_STAT_A7_CPU_MASK(cpu)	(1 << (3 + (cpu)))
+
 /* SPC system config interface registers */
 #define SYSCFG_WDATA		0x70
 #define SYSCFG_RDATA		0x74
@@ -213,6 +218,41 @@ void ve_spc_powerdown(u32 cluster, bool enable)
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
 static int ve_spc_get_performance(int cluster, u32 *freq)
 {
 	struct ve_spc_opp *opps = info->opps[cluster];
diff --git a/arch/arm/mach-vexpress/spc.h b/arch/arm/mach-vexpress/spc.h
index dbd44c3..793d065 100644
--- a/arch/arm/mach-vexpress/spc.h
+++ b/arch/arm/mach-vexpress/spc.h
@@ -20,5 +20,6 @@ void ve_spc_global_wakeup_irq(bool set);
 void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set);
 void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr);
 void ve_spc_powerdown(u32 cluster, bool enable);
+int ve_spc_cpu_in_wfi(u32 cpu, u32 cluster);
 
 #endif
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index 05a364c..29e7785 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -32,11 +33,17 @@
 #include "spc.h"
 
 /* SCC conf registers */
+#define RESET_CTRL		0x018
+#define RESET_A15_NCORERESET(cpu)	(1 << (2 + (cpu)))
+#define RESET_A7_NCORERESET(cpu)	(1 << (16 + (cpu)))
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
@@ -190,6 +197,55 @@ static void tc2_pm_power_down(void)
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
+		 * Only examine the hardware state if the target CPU has
+		 * caught up@least as far as tc2_pm_down():
+		 */
+		if (ACCESS_ONCE(tc2_pm_use_count[cpu][cluster]) == 0) {
+			pr_debug("%s(cpu=%u, cluster=%u): RESET_CTRL = 0x%08X\n",
+				 __func__, cpu, cluster,
+				 readl_relaxed(scc + RESET_CTRL));
+
+			/*
+			 * We need the CPU to reach WFI, but the power
+			 * controller may put the cluster in reset and
+			 * power it off as soon as that happens, before
+			 * we have a chance to see STANDBYWFI.
+			 *
+			 * So we need to check for both conditions:
+			 */
+			if (tc2_core_in_reset(cpu, cluster) ||
+			    ve_spc_cpu_in_wfi(cpu, cluster))
+				return 0; /* success: the CPU is halted */
+		}
+
+		/* Otherwise, wait and retry: */
+		msleep(POLL_MSEC);
+	}
+
+	return -ETIMEDOUT; /* timeout */
+}
+
 static void tc2_pm_suspend(u64 residency)
 {
 	unsigned int mpidr, cpu, cluster;
@@ -232,10 +288,11 @@ static void tc2_pm_powered_up(void)
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
@@ -269,7 +326,6 @@ static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
 static int __init tc2_pm_init(void)
 {
 	int ret, irq;
-	void __iomem *scc;
 	u32 a15_cluster_id, a7_cluster_id, sys_info;
 	struct device_node *np;
 
-- 
1.7.9.5
