From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 02:51:06 -0500
Subject: [PATCH v3 11/15] ARM: vexpress/dcscb: do not hardcode number of CPUs
 per cluster
In-Reply-To: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359445870-18925-12-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If 4 CPUs are assumed, the A15x1-A7x1 model configuration would never
shut down the initial cluster as the 0xf reset bit mask will never be
observed.  Let's construct this mask based on the provided information
in the DCSCB config register for the number of CPUs per cluster.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/dcscb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index f993608944..8d363357ef 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -46,10 +46,12 @@ static arch_spinlock_t dcscb_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 
 static void __iomem *dcscb_base;
 static int dcscb_use_count[4][2];
+static int dcscb_mcpm_cpu_mask[2];
 
 static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
 {
 	unsigned int rst_hold, cpumask = (1 << cpu);
+	unsigned int mcpm_mask = dcscb_mcpm_cpu_mask[cluster];
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (cpu >= 4 || cluster >= 2)
@@ -68,7 +70,7 @@ static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
 		if (rst_hold & (1 << 8)) {
 			/* remove cluster reset and add individual CPU's reset */
 			rst_hold &= ~(1 << 8);
-			rst_hold |= 0xf;
+			rst_hold |= mcpm_mask;
 		}
 		rst_hold &= ~(cpumask | (cpumask << 4));
 		writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
@@ -92,13 +94,14 @@ static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
 
 static void dcscb_power_down(void)
 {
-	unsigned int mpidr, cpu, cluster, rst_hold, cpumask;
+	unsigned int mpidr, cpu, cluster, rst_hold, cpumask, mcpm_mask;
 	bool last_man = false, skip_wfi = false;
 
 	mpidr = read_cpuid_mpidr();
 	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	cpumask = (1 << cpu);
+	mcpm_mask = dcscb_mcpm_cpu_mask[cluster];
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	BUG_ON(cpu >= 4 || cluster >= 2);
@@ -108,7 +111,7 @@ static void dcscb_power_down(void)
 	if (dcscb_use_count[cpu][cluster] == 0) {
 		rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
 		rst_hold |= cpumask;
-		if (((rst_hold | (rst_hold >> 4)) & 0xf) == 0xf) {
+		if (((rst_hold | (rst_hold >> 4)) & mcpm_mask) == mcpm_mask) {
 			rst_hold |= (1 << 8);
 			last_man = true;
 		}
@@ -178,12 +181,15 @@ static void __init dcscb_usage_count_init(void)
 
 static int __init dcscb_init(void)
 {
+	unsigned int cfg;
 	int ret;
 
 	dcscb_base = ioremap(DCSCB_PHYS_BASE, 0x1000);
 	if (!dcscb_base)
 		return -EADDRNOTAVAIL;
-
+	cfg = readl_relaxed(dcscb_base + DCS_CFG_R);
+	dcscb_mcpm_cpu_mask[0] = (1 << (((cfg >> 16) >> (0 << 2)) & 0xf)) - 1;
+	dcscb_mcpm_cpu_mask[1] = (1 << (((cfg >> 16) >> (1 << 2)) & 0xf)) - 1;
 	dcscb_usage_count_init();
 
 	ret = mcpm_platform_register(&dcscb_power_ops);
-- 
1.8.1.2
