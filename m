From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 02:51:05 -0500
Subject: [PATCH v3 10/15] ARM: vexpress/dcscb: add CPU use counts to the power
 up/down API implementation
In-Reply-To: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359445870-18925-11-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible for a CPU to be told to power up before it managed
to power itself down.  Solve this race with a usage count as mandated
by the API definition.

Signed-off-by: nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/dcscb.c | 77 +++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 677ced9efc..f993608944 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -45,6 +45,7 @@
 static arch_spinlock_t dcscb_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 
 static void __iomem *dcscb_base;
+static int dcscb_use_count[4][2];
 
 static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
 {
@@ -61,14 +62,27 @@ static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
 	local_irq_disable();
 	arch_spin_lock(&dcscb_lock);
 
-	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
-	if (rst_hold & (1 << 8)) {
-		/* remove cluster reset and add individual CPU's reset */
-		rst_hold &= ~(1 << 8);
-		rst_hold |= 0xf;
+	dcscb_use_count[cpu][cluster]++;
+	if (dcscb_use_count[cpu][cluster] == 1) {
+		rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
+		if (rst_hold & (1 << 8)) {
+			/* remove cluster reset and add individual CPU's reset */
+			rst_hold &= ~(1 << 8);
+			rst_hold |= 0xf;
+		}
+		rst_hold &= ~(cpumask | (cpumask << 4));
+		writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
+	} else if (dcscb_use_count[cpu][cluster] != 2) {
+		/*
+		 * The only possible values are:
+		 * 0 = CPU down
+		 * 1 = CPU (still) up
+		 * 2 = CPU requested to be up before it had a chance
+		 *     to actually make itself down.
+		 * Any other value is a bug.
+		 */
+		BUG();
 	}
-	rst_hold &= ~(cpumask | (cpumask << 4));
-	writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
 
 	arch_spin_unlock(&dcscb_lock);
 	local_irq_enable();
@@ -78,7 +92,8 @@ static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
 
 static void dcscb_power_down(void)
 {
-	unsigned int mpidr, cpu, cluster, rst_hold, cpumask, last_man;
+	unsigned int mpidr, cpu, cluster, rst_hold, cpumask;
+	bool last_man = false, skip_wfi = false;
 
 	mpidr = read_cpuid_mpidr();
 	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
@@ -89,13 +104,26 @@ static void dcscb_power_down(void)
 	BUG_ON(cpu >= 4 || cluster >= 2);
 
 	arch_spin_lock(&dcscb_lock);
-	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
-	rst_hold |= cpumask;
-	if (((rst_hold | (rst_hold >> 4)) & 0xf) == 0xf)
-		rst_hold |= (1 << 8);
-	writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
+	dcscb_use_count[cpu][cluster]--;
+	if (dcscb_use_count[cpu][cluster] == 0) {
+		rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
+		rst_hold |= cpumask;
+		if (((rst_hold | (rst_hold >> 4)) & 0xf) == 0xf) {
+			rst_hold |= (1 << 8);
+			last_man = true;
+		}
+		writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
+	} else if (dcscb_use_count[cpu][cluster] == 1) {
+		/*
+		 * A power_up request went ahead of us.
+		 * Even if we do not want to shut this CPU down,
+		 * the caller expects a certain state as if the WFI
+		 * was aborted.  So let's continue with cache cleaning.
+		 */
+		skip_wfi = true;
+	} else
+		BUG();
 	arch_spin_unlock(&dcscb_lock);
-	last_man = (rst_hold & (1 << 8));
 
 	/*
 	 * Now let's clean our L1 cache and shut ourself down.
@@ -122,8 +150,10 @@ static void dcscb_power_down(void)
 	set_auxcr(get_auxcr() & ~(1 << 6));
 
 	/* Now we are prepared for power-down, do it: */
-	dsb();
-	wfi();
+	if (!skip_wfi) {
+		dsb();
+		wfi();
+	}
 
 	/* Not dead@this point?  Let our caller cope. */
 }
@@ -133,6 +163,19 @@ static const struct mcpm_platform_ops dcscb_power_ops = {
 	.power_down	= dcscb_power_down,
 };
 
+static void __init dcscb_usage_count_init(void)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+	BUG_ON(cpu >= 4 || cluster >= 2);
+	dcscb_use_count[cpu][cluster] = 1;
+}
+
 static int __init dcscb_init(void)
 {
 	int ret;
@@ -141,6 +184,8 @@ static int __init dcscb_init(void)
 	if (!dcscb_base)
 		return -EADDRNOTAVAIL;
 
+	dcscb_usage_count_init();
+
 	ret = mcpm_platform_register(&dcscb_power_ops);
 	if (ret) {
 		iounmap(dcscb_base);
-- 
1.8.1.2
