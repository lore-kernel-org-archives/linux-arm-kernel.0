From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Mon,  5 May 2014 14:57:20 +0530
Subject: [Patch v4 5/5] mcpm: exynos: populate suspend and powered_up callbacks
In-Reply-To: <1399282040-8995-1-git-send-email-chander.kashyap@linaro.org>
References: <1399278444-8312-3-git-send-email-chander.kashyap@linaro.org>
 <1399282040-8995-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1399282040-8995-6-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support cpuidle through mcpm, suspend and powered-up
callbacks are required in mcpm platform code.
Hence populate the same callbacks.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
---
Changes in v4: None
Changes in v3:
	1. Removed coherancy enablement after suspend failure.
	2. Use generic function to poweron cpu.
changes in v2:
	1. Fixed typo: enynos_pmu_cpunr to exynos_pmu_cpunr
 arch/arm/mach-exynos/mcpm-exynos.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index d0f7461..6d4a907 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -256,10 +256,44 @@ static int exynos_power_down_finish(unsigned int cpu, unsigned int cluster)
 	return -ETIMEDOUT; /* timeout */
 }
 
+void exynos_powered_up(void)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	arch_spin_lock(&exynos_mcpm_lock);
+	if (cpu_use_count[cpu][cluster] == 0)
+		cpu_use_count[cpu][cluster] = 1;
+	arch_spin_unlock(&exynos_mcpm_lock);
+}
+
+static void exynos_suspend(u64 residency)
+{
+	unsigned int mpidr, cpunr;
+
+	mpidr = read_cpuid_mpidr();
+	cpunr = exynos_pmu_cpunr(mpidr);
+
+	__raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 0x1c);
+
+	exynos_power_down();
+
+	/*
+	 * Execution reaches here only if cpu did not power down.
+	 * Hence roll back the changes done in exynos_power_down function.
+	*/
+	exynos_cpu_powerup(cpunr);
+}
+
 static const struct mcpm_platform_ops exynos_power_ops = {
 	.power_up		= exynos_power_up,
 	.power_down		= exynos_power_down,
 	.power_down_finish	= exynos_power_down_finish,
+	.suspend		= exynos_suspend,
+	.powered_up		= exynos_powered_up,
 };
 
 static void __init exynos_mcpm_usage_count_init(void)
-- 
1.7.9.5
