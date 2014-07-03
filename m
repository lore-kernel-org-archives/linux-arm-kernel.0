From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Thu, 03 Jul 2014 10:32:17 +0530
Subject: [RFC PATCH v4] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <1404313142-1278-1-git-send-email-a.kesavan@samsung.com>
References: <1404313142-1278-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1404363737-26222-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the MCPM layer to handle core suspend/resume on Exynos5420.
Also, restore the entry address setup code post-resume.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
Changes in v2:
	- Made use of the MCPM suspend/powered_up call-backs
Changes in v3:
	- Used the residency value to indicate the entered state
Changes in v4:
	- Checked if MCPM has been enabled to prevent build error

This has been tested both on an SMDK5420 and Peach Pit Chromebook on
3.16-rc3/next-20140702.

Here are the dependencies (some of these patches did not apply cleanly):
1) Cleanup patches for mach-exynos
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/33772

2) PMU cleanup and refactoring for using DT
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg671625.html

3) Exynos5420 PMU/S2R Series
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/33898

4) MCPM boot CPU CCI enablement patches
www.spinics.net/lists/linux-samsung-soc/msg32923.html

5) Exynos5420 CPUIdle Series which populates MCPM suspend/powered_up
call-backs.
www.gossamer-threads.com/lists/linux/kernel/1945347
https://patchwork.kernel.org/patch/4357461/

6) Exynos5420 MCPM cluster power down support
http://www.spinics.net/lists/arm-kernel/msg339988.html

7) TPM reset mask patch
http://www.spinics.net/lists/arm-kernel/msg341884.html

 arch/arm/include/asm/mcpm.h          |    6 ++++
 arch/arm/mach-exynos/mcpm-exynos.c   |   50 ++++++++++++++++++++++++----------
 arch/arm/mach-exynos/pm.c            |   38 ++++++++++++++++++++++++--
 arch/arm/mach-exynos/regs-pmu.h      |    1 +
 drivers/cpuidle/cpuidle-big_little.c |    2 +-
 5 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index ff73aff..051fbf1 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -272,4 +272,10 @@ void __init mcpm_smp_set_ops(void);
 #define MCPM_SYNC_CLUSTER_SIZE \
 	(MCPM_SYNC_CLUSTER_INBOUND + __CACHE_WRITEBACK_GRANULE)
 
+/* Definitions for various MCPM scenarios that might need special handling */
+#define MCPM_CPU_IDLE		0x0
+#define MCPM_CPU_SUSPEND	0x1
+#define MCPM_CPU_SWITCH		0x2
+#define MCPM_CPU_HOTPLUG	0x3
+
 #endif
diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index 0315601..9a381f6 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/cputype.h>
 #include <asm/cp15.h>
@@ -30,6 +31,8 @@
 #define EXYNOS5420_USE_ARM_CORE_DOWN_STATE	BIT(29)
 #define EXYNOS5420_USE_L2_COMMON_UP_STATE	BIT(30)
 
+static void __iomem *ns_sram_base_addr;
+
 /*
  * The common v7_exit_coherency_flush API could not be used because of the
  * Erratum 799270 workaround. This macro is the same as the common one (in
@@ -129,7 +132,7 @@ static int exynos_power_up(unsigned int cpu, unsigned int cluster)
  * and can only be executed on processors like A15 and A7 that hit the cache
  * with the C bit clear in the SCTLR register.
  */
-static void exynos_power_down(void)
+static void exynos_mcpm_power_down(u64 residency)
 {
 	unsigned int mpidr, cpu, cluster;
 	bool last_man = false, skip_wfi = false;
@@ -150,7 +153,12 @@ static void exynos_power_down(void)
 	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
 	cpu_use_count[cpu][cluster]--;
 	if (cpu_use_count[cpu][cluster] == 0) {
-		exynos_cpu_power_down(cpunr);
+		/*
+		 * Bypass power down for CPU0 during suspend. This is being
+		 * taken care by the SYS_PWR_CFG bit in CORE0_SYS_PWR_REG.
+		 */
+		if ((cpunr != 0) || (residency != MCPM_CPU_SUSPEND))
+			exynos_cpu_power_down(cpunr);
 
 		if (exynos_cluster_unused(cluster)) {
 			exynos_cluster_power_down(cluster);
@@ -209,6 +217,11 @@ static void exynos_power_down(void)
 	/* Not dead at this point?  Let our caller cope. */
 }
 
+static void exynos_power_down(void)
+{
+	exynos_mcpm_power_down(MCPM_CPU_SWITCH | MCPM_CPU_HOTPLUG);
+}
+
 static int exynos_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
 {
 	unsigned int tries = 100;
@@ -250,11 +263,11 @@ static void exynos_suspend(u64 residency)
 {
 	unsigned int mpidr, cpunr;
 
-	exynos_power_down();
+	exynos_mcpm_power_down(residency);
 
 	/*
 	 * Execution reaches here only if cpu did not power down.
-	 * Hence roll back the changes done in exynos_power_down function.
+	 * Hence roll back the changes done in exynos_mcpm_power_down function.
 	 *
 	 * CAUTION: "This function requires the stack data to be visible through
 	 * power down and can only be executed on processors like A15 and A7
@@ -319,10 +332,26 @@ static const struct of_device_id exynos_dt_mcpm_match[] = {
 	{},
 };
 
+static void exynos_mcpm_setup_entry_point(void)
+{
+	/*
+	 * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
+	 * as part of secondary_cpu_start().  Let's redirect it to the
+	 * mcpm_entry_point(). This is done during both secondary boot-up as
+	 * well as system resume.
+	 */
+	__raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
+	__raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
+	__raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
+}
+
+static struct syscore_ops exynos_mcpm_syscore_ops = {
+	.resume	= exynos_mcpm_setup_entry_point,
+};
+
 static int __init exynos_mcpm_init(void)
 {
 	struct device_node *node;
-	void __iomem *ns_sram_base_addr;
 	unsigned int value, i;
 	int ret;
 
@@ -389,16 +418,9 @@ static int __init exynos_mcpm_init(void)
 		__raw_writel(value, pmu_base_addr + EXYNOS_COMMON_OPTION(i));
 	}
 
-	/*
-	 * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
-	 * as part of secondary_cpu_start().  Let's redirect it to the
-	 * mcpm_entry_point().
-	 */
-	__raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
-	__raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
-	__raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
+	exynos_mcpm_setup_entry_point();
 
-	iounmap(ns_sram_base_addr);
+	register_syscore_ops(&exynos_mcpm_syscore_ops);
 
 	return ret;
 }
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index bf8564a..8b425df 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -24,6 +24,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/mcpm.h>
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
@@ -191,7 +192,6 @@ int exynos_cluster_power_state(int cluster)
 			pmu_base_addr + S5P_INFORM1))
 
 #define S5P_CHECK_AFTR  0xFCBA0D10
-#define S5P_CHECK_SLEEP 0x00000BAD
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
 static void exynos_set_wakeupmask(long mask)
@@ -318,7 +318,10 @@ static void exynos_pm_prepare(void)
 
 	/* ensure at least INFORM0 has the resume address */
 
-	pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
+	if (soc_is_exynos5420() && IS_ENABLED(CONFIG_MCPM))
+		pmu_raw_writel(virt_to_phys(mcpm_entry_point), S5P_INFORM0);
+	else
+		pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
 
 	if (soc_is_exynos5420()) {
 		tmp = __raw_readl(pmu_base_addr + EXYNOS5_ARM_L2_OPTION);
@@ -490,6 +493,28 @@ static struct syscore_ops exynos_pm_syscore_ops = {
 	.resume		= exynos_pm_resume,
 };
 
+static int notrace exynos_mcpm_cpu_suspend(unsigned long arg)
+{
+	/* MCPM works with HW CPU identifiers */
+	unsigned int mpidr = read_cpuid_mpidr();
+	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+
+	__raw_writel(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
+
+	mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
+
+	/*
+	 * Residency value passed to mcpm_cpu_suspend back-end
+	 * has to be given clear semantics. Set to 0 as a
+	 * temporary value.
+	 */
+	mcpm_cpu_suspend(MCPM_CPU_SUSPEND);
+
+	/* return value != 0 means failure */
+	return 1;
+}
+
 /*
  * Suspend Ops
  */
@@ -517,10 +542,17 @@ static int exynos_suspend_enter(suspend_state_t state)
 	flush_cache_all();
 	s3c_pm_check_store();
 
-	ret = cpu_suspend(0, exynos_cpu_suspend);
+	/* Use the MCPM layer to suspend 5420 which is a multi-cluster SoC */
+	if (soc_is_exynos5420() && IS_ENABLED(CONFIG_MCPM))
+		ret = cpu_suspend(0, exynos_mcpm_cpu_suspend);
+	else
+		ret = cpu_suspend(0, exynos_cpu_suspend);
 	if (ret)
 		return ret;
 
+	if (soc_is_exynos5420() && IS_ENABLED(CONFIG_MCPM))
+		mcpm_cpu_powered_up();
+
 	s3c_pm_restore_uarts();
 
 	S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 3cf0454..e8c75db 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -152,6 +152,7 @@
 #define S5P_PAD_RET_EBIB_OPTION			0x31A8
 
 #define S5P_CORE_LOCAL_PWR_EN			0x3
+#define S5P_CHECK_SLEEP				0x00000BAD
 
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	0x1154
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index b45fc62..15f077e 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -108,7 +108,7 @@ static int notrace bl_powerdown_finisher(unsigned long arg)
 	 * has to be given clear semantics. Set to 0 as a
 	 * temporary value.
 	 */
-	mcpm_cpu_suspend(0);
+	mcpm_cpu_suspend(MCPM_CPU_IDLE);
 
 	/* return value != 0 means failure */
 	return 1;
-- 
1.7.9.5
