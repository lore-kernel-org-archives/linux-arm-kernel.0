From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Mar 2015 14:04:51 -0400
Subject: [PATCH RFC/RFT 4/6] ARM: vexpress: migrate DCSCB to the new MCPM
 backend abstraction
In-Reply-To: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
References: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1426701893-25589-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/dcscb.c | 195 ++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 129 deletions(-)

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 12c74734cd..5cedcf5721 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/of_address.h>
 #include <linux/vexpress.h>
@@ -36,163 +35,102 @@
 #define KFC_CFG_W	0x2c
 #define DCS_CFG_R	0x30
 
-/*
- * We can't use regular spinlocks. In the switcher case, it is possible
- * for an outbound CPU to call power_down() while its inbound counterpart
- * is already live using the same logical CPU number which trips lockdep
- * debugging.
- */
-static arch_spinlock_t dcscb_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-
 static void __iomem *dcscb_base;
-static int dcscb_use_count[4][2];
 static int dcscb_allcpus_mask[2];
 
-static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
+static int dcscb_cpu_powerup(unsigned int cpu, unsigned int cluster)
 {
 	unsigned int rst_hold, cpumask = (1 << cpu);
-	unsigned int all_mask;
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (cluster >= 2 || !(cpumask & dcscb_allcpus_mask[cluster]))
 		return -EINVAL;
 
-	all_mask = dcscb_allcpus_mask[cluster];
+	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
+	rst_hold &= ~(cpumask | (cpumask << 4));
+	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
+	return 0;
+}
 
-	/*
-	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
-	 * variant exists, we need to disable IRQs manually here.
-	 */
-	local_irq_disable();
-	arch_spin_lock(&dcscb_lock);
-
-	dcscb_use_count[cpu][cluster]++;
-	if (dcscb_use_count[cpu][cluster] == 1) {
-		rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
-		if (rst_hold & (1 << 8)) {
-			/* remove cluster reset and add individual CPU's reset */
-			rst_hold &= ~(1 << 8);
-			rst_hold |= all_mask;
-		}
-		rst_hold &= ~(cpumask | (cpumask << 4));
-		writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
-	} else if (dcscb_use_count[cpu][cluster] != 2) {
-		/*
-		 * The only possible values are:
-		 * 0 = CPU down
-		 * 1 = CPU (still) up
-		 * 2 = CPU requested to be up before it had a chance
-		 *     to actually make itself down.
-		 * Any other value is a bug.
-		 */
-		BUG();
-	}
+static int dcscb_cluster_powerup(unsigned int cluster)
+{
+	unsigned int rst_hold;
 
-	arch_spin_unlock(&dcscb_lock);
-	local_irq_enable();
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	if (cluster >= 2)
+		return -EINVAL;
 
+	/* remove cluster reset and add individual CPU's reset */
+	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
+	rst_hold &= ~(1 << 8);
+	rst_hold |= dcscb_allcpus_mask[cluster];
+	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
 	return 0;
 }
 
-static void dcscb_power_down(void)
+static void dcscb_cpu_powerdown_prepare(unsigned int cpu, unsigned int cluster)
 {
-	unsigned int mpidr, cpu, cluster, rst_hold, cpumask, all_mask;
-	bool last_man = false, skip_wfi = false;
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-	cpumask = (1 << cpu);
+	unsigned int rst_hold;
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-	BUG_ON(cluster >= 2 || !(cpumask & dcscb_allcpus_mask[cluster]));
-
-	all_mask = dcscb_allcpus_mask[cluster];
-
-	__mcpm_cpu_going_down(cpu, cluster);
-
-	arch_spin_lock(&dcscb_lock);
-	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
-	dcscb_use_count[cpu][cluster]--;
-	if (dcscb_use_count[cpu][cluster] == 0) {
-		rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
-		rst_hold |= cpumask;
-		if (((rst_hold | (rst_hold >> 4)) & all_mask) == all_mask) {
-			rst_hold |= (1 << 8);
-			last_man = true;
-		}
-		writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
-	} else if (dcscb_use_count[cpu][cluster] == 1) {
-		/*
-		 * A power_up request went ahead of us.
-		 * Even if we do not want to shut this CPU down,
-		 * the caller expects a certain state as if the WFI
-		 * was aborted.  So let's continue with cache cleaning.
-		 */
-		skip_wfi = true;
-	} else
-		BUG();
-
-	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
-		arch_spin_unlock(&dcscb_lock);
-
-		/* Flush all cache levels for this cluster. */
-		v7_exit_coherency_flush(all);
-
-		/*
-		 * A full outer cache flush could be needed@this point
-		 * on platforms with such a cache, depending on where the
-		 * outer cache sits. In some cases the notion of a "last
-		 * cluster standing" would need to be implemented if the
-		 * outer cache is shared across clusters. In any case, when
-		 * the outer cache needs flushing, there is no concurrent
-		 * access to the cache controller to worry about and no
-		 * special locking besides what is already provided by the
-		 * MCPM state machinery is needed.
-		 */
-
-		/*
-		 * Disable cluster-level coherency by masking
-		 * incoming snoops and DVM messages:
-		 */
-		cci_disable_port_by_cpu(mpidr);
-
-		__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
-	} else {
-		arch_spin_unlock(&dcscb_lock);
-
-		/* Disable and flush the local CPU cache. */
-		v7_exit_coherency_flush(louis);
-	}
+	BUG_ON(cluster >= 2 || !((1 << cpu) & dcscb_allcpus_mask[cluster]));
 
-	__mcpm_cpu_down(cpu, cluster);
+	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
+	rst_hold |= (1 << cpu);
+	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
+}
 
-	/* Now we are prepared for power-down, do it: */
-	dsb();
-	if (!skip_wfi)
-		wfi();
+static void dcscb_cluster_powerdown_prepare(unsigned int cluster)
+{
+	unsigned int rst_hold;
 
-	/* Not dead@this point?  Let our caller cope. */
+	pr_debug("%s: cluster %u\n", __func__, cluster);
+	BUG_ON(cluster >= 2);
+
+	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
+	rst_hold |= (1 << 8);
+	writel_relaxed(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
 }
 
-static const struct mcpm_platform_ops dcscb_power_ops = {
-	.power_up	= dcscb_power_up,
-	.power_down	= dcscb_power_down,
-};
+static void dcscb_cpu_cache_disable(void)
+{
+	/* Disable and flush the local CPU cache. */
+	v7_exit_coherency_flush(louis);
+}
 
-static void __init dcscb_usage_count_init(void)
+static void dcscb_cluster_cache_disable(void)
 {
-	unsigned int mpidr, cpu, cluster;
+	/* Flush all cache levels for this cluster. */
+	v7_exit_coherency_flush(all);
 
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	/*
+	 * A full outer cache flush could be needed@this point
+	 * on platforms with such a cache, depending on where the
+	 * outer cache sits. In some cases the notion of a "last
+	 * cluster standing" would need to be implemented if the
+	 * outer cache is shared across clusters. In any case, when
+	 * the outer cache needs flushing, there is no concurrent
+	 * access to the cache controller to worry about and no
+	 * special locking besides what is already provided by the
+	 * MCPM state machinery is needed.
+	 */
 
-	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-	BUG_ON(cluster >= 2 || !((1 << cpu) & dcscb_allcpus_mask[cluster]));
-	dcscb_use_count[cpu][cluster] = 1;
+	/*
+	 * Disable cluster-level coherency by masking
+	 * incoming snoops and DVM messages:
+	 */
+	cci_disable_port_by_cpu(read_cpuid_mpidr());
 }
 
+static const struct mcpm_platform_ops dcscb_power_ops = {
+	.cpu_powerup		= dcscb_cpu_powerup,
+	.cluster_powerup	= dcscb_cluster_powerup,
+	.cpu_powerdown_prepare	= dcscb_cpu_powerdown_prepare,
+	.cluster_powerdown_prepare = dcscb_cluster_powerdown_prepare,
+	.cpu_cache_disable	= dcscb_cpu_cache_disable,
+	.cluster_cache_disable	= dcscb_cluster_cache_disable,
+};
+
 extern void dcscb_power_up_setup(unsigned int affinity_level);
 
 static int __init dcscb_init(void)
@@ -213,7 +151,6 @@ static int __init dcscb_init(void)
 	cfg = readl_relaxed(dcscb_base + DCS_CFG_R);
 	dcscb_allcpus_mask[0] = (1 << (((cfg >> 16) >> (0 << 2)) & 0xf)) - 1;
 	dcscb_allcpus_mask[1] = (1 << (((cfg >> 16) >> (1 << 2)) & 0xf)) - 1;
-	dcscb_usage_count_init();
 
 	ret = mcpm_platform_register(&dcscb_power_ops);
 	if (!ret)
-- 
2.1.0
