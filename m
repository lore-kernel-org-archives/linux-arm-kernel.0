From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 00:11:11 -0400
Subject: [PATCH 3/3] ARM: exynos: activate the CCI on boot CPU/cluster with the
 MCPM loopback
In-Reply-To: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
References: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1403583071-5650-4-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Chromebook firmware doesn't enable the CCI for the boot cpu, and
arguably it shouldn't have to either. Let's have the kernel handle the
CCI on its own for the boot CPU the same way it does it for secondary CPUs
by using the MCPM loopback.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-exynos/mcpm-exynos.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index 0498d0b887..0c839f94ec 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -290,6 +290,19 @@ static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
 	"b	cci_enable_port_for_self");
 }
 
+static void __init exynos_cache_off(void)
+{
+	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A15) {
+		/* disable L2 prefetching on the Cortex-A15 */
+		asm volatile(
+		"mcr	p15, 1, %0, c15, c0, 3\n\t"
+		"isb\n\t"
+		"dsb"
+		: : "r" (0x400));
+	}
+	exynos_v7_exit_coherency_flush(all);
+}
+
 static const struct of_device_id exynos_dt_mcpm_match[] = {
 	{ .compatible = "samsung,exynos5420" },
 	{ .compatible = "samsung,exynos5800" },
@@ -333,6 +346,8 @@ static int __init exynos_mcpm_init(void)
 	ret = mcpm_platform_register(&exynos_power_ops);
 	if (!ret)
 		ret = mcpm_sync_init(exynos_pm_power_up_setup);
+	if (!ret)
+		ret = mcpm_loopback(exynos_cache_off); /* turn on the CCI */
 	if (ret) {
 		iounmap(ns_sram_base_addr);
 		return ret;
-- 
1.8.4.108.g55ea5f6
