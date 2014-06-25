From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 25 Jun 2014 18:18:34 +0200
Subject: [PATCH 2/2] ARM: EXYNOS: Add support for firmware-assisted
 suspend/resume
In-Reply-To: <1403713114-18923-1-git-send-email-t.figa@samsung.com>
References: <1403713114-18923-1-git-send-email-t.figa@samsung.com>
Message-ID: <1403713114-18923-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a numer of Exynos-based boards Linux kernel is running in non-secure
mode under a secure firmware. This means that certain operations need to
be handled in special way, with firmware assistance. System-wide
suspend/resume is an example of such operations.

This patch adds support for firmware-assisted suspend/resume by
leveraging recently introduced suspend and resume firmware operations
and modifying existing suspend/resume paths to account for presence of
secure firmware.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/firmware.c | 47 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/pm.c       | 16 +++++++++-----
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index def7bb4..cd554a1 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -14,15 +14,21 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/suspend.h>
 
 #include <mach/map.h>
 
 #include "common.h"
 #include "smc.h"
 
+#define EXYNOS_SLEEP_MAGIC	0x00000bad
+#define EXYNOS_BOOT_ADDR	0x8
+#define EXYNOS_BOOT_FLAG	0xc
+
 static int exynos_do_idle(void)
 {
 	exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
@@ -66,10 +72,51 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	return 0;
 }
 
+/* For Cortex-A9 Diagnostic and Power control register */
+static unsigned int cp15_power;
+static unsigned int cp15_diag;
+
+static int exynos_cpu_suspend(unsigned long arg)
+{
+	flush_cache_all();
+	outer_flush_all();
+
+	exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
+
+	pr_info("Failed to suspend the system\n");
+	writel(0, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
+	return 1;
+}
+
+static int exynos_suspend(void)
+{
+	/* Save Power control and Diagnostic registers */
+	asm ("mrc p15, 0, %0, c15, c0, 0\n"
+		"mrc p15, 0, %1, c15, c0, 1\n"
+		: "=r" (cp15_power), "=r" (cp15_diag) : : "cc");
+
+	writel(EXYNOS_SLEEP_MAGIC, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
+	writel(virt_to_phys(cpu_resume),
+		sysram_ns_base_addr + EXYNOS_BOOT_ADDR);
+
+	return cpu_suspend(0, exynos_cpu_suspend);
+}
+
+static int exynos_resume(void)
+{
+	exynos_smc(SMC_CMD_C15RESUME, cp15_power, cp15_diag, 0);
+	writel(0, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
+	outer_resume();
+
+	return 0;
+}
+
 static const struct firmware_ops exynos_firmware_ops = {
 	.do_idle		= exynos_do_idle,
 	.set_cpu_boot_addr	= exynos_set_cpu_boot_addr,
 	.cpu_boot		= exynos_cpu_boot,
+	.suspend		= exynos_suspend,
+	.resume			= exynos_resume,
 };
 
 static void exynos_l2_write_sec(unsigned long val, void __iomem *base,
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index f23cc77..ed20318 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 
 #include <asm/cacheflush.h>
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
@@ -331,12 +332,11 @@ static int exynos_pm_central_resume(void)
 
 static void exynos_pm_resume(void)
 {
+	u32 cpuid = read_cpuid_part_number();
+
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
-		exynos_cpu_restore_register();
-
 	/* For release retention */
 
 	__raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
@@ -353,9 +353,13 @@ static void exynos_pm_resume(void)
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
+	if (cpuid == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(S5P_VA_SCU);
 
+	if (call_firmware_op(resume) == -ENOSYS
+	    && cpuid == ARM_CPU_PART_CORTEX_A9)
+		exynos_cpu_restore_register();
+
 early_wakeup:
 
 	/* Clear SLEEP mode set in INFORM1 */
@@ -391,7 +395,9 @@ static int exynos_suspend_enter(suspend_state_t state)
 	flush_cache_all();
 	s3c_pm_check_store();
 
-	ret = cpu_suspend(0, exynos_cpu_suspend);
+	ret = call_firmware_op(suspend);
+	if (ret == -ENOSYS)
+		ret = cpu_suspend(0, exynos_cpu_suspend);
 	if (ret)
 		return ret;
 
-- 
1.9.3
