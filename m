From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 00:11:10 -0400
Subject: [PATCH 2/3] ARM: TC2: test the MCPM loopback during boot
In-Reply-To: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
References: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1403583071-5650-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not strictly needed on TC2 but still a good thing to exercise
that code.

Signed-off-by: nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/tc2_pm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index b743a0ae02..54a9fff77c 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -323,6 +323,21 @@ static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
 "	b	cci_enable_port_for_self ");
 }
 
+static void __init tc2_cache_off(void)
+{
+	pr_info("TC2: disabling cache during MCPM loopback test\n");
+	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A15) {
+		/* disable L2 prefetching on the Cortex-A15 */
+		asm volatile(
+		"mcr	p15, 1, %0, c15, c0, 3 \n\t"
+		"isb	\n\t"
+		"dsb	"
+		: : "r" (0x400) );
+	}
+	v7_exit_coherency_flush(all);
+	cci_disable_port_by_cpu(read_cpuid_mpidr());
+}
+
 static int __init tc2_pm_init(void)
 {
 	int ret, irq;
@@ -370,6 +385,8 @@ static int __init tc2_pm_init(void)
 	ret = mcpm_platform_register(&tc2_pm_power_ops);
 	if (!ret) {
 		mcpm_sync_init(tc2_pm_power_up_setup);
+		/* test if we can (re)enable the CCI on our own */
+		BUG_ON(mcpm_loopback(tc2_cache_off) != 0);
 		pr_info("TC2 power management initialized\n");
 	}
 	return ret;
-- 
1.8.4.108.g55ea5f6
