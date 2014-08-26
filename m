From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 26 Aug 2014 16:10:25 +0200
Subject: [PATCH v3 2/5] ARM: EXYNOS: Add support for firmware-assisted
 suspend/resume
In-Reply-To: <1409062228-14690-1-git-send-email-t.figa@samsung.com>
References: <1409062228-14690-1-git-send-email-t.figa@samsung.com>
Message-ID: <1409062228-14690-3-git-send-email-t.figa@samsung.com>
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
 arch/arm/mach-exynos/Makefile   |  1 +
 arch/arm/mach-exynos/common.h   |  4 ++++
 arch/arm/mach-exynos/firmware.c | 45 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/pm.c       | 16 ++++++++++-----
 arch/arm/mach-exynos/sleep.S    | 28 +++++++++++++++++++++++++
 arch/arm/mach-exynos/smc.h      |  4 ++++
 6 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 788f26d..e7d1774 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -26,6 +26,7 @@ CFLAGS_hotplug.o		+= -march=armv7-a
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 obj-$(CONFIG_EXYNOS5420_MCPM)	+= mcpm-exynos.o
 CFLAGS_mcpm-exynos.o		+= -march=armv7-a
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 47b904b..c218200 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -111,6 +111,9 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
 #define soc_is_exynos5() (soc_is_exynos5250() || soc_is_exynos5410() || \
 			  soc_is_exynos5420() || soc_is_exynos5800())
 
+extern u32 cp15_save_diag;
+extern u32 cp15_save_power;
+
 extern void __iomem *sysram_ns_base_addr;
 extern void __iomem *sysram_base_addr;
 extern void __iomem *pmu_base_addr;
@@ -127,6 +130,7 @@ static inline void exynos_pm_init(void) {}
 #endif
 
 extern void exynos_cpu_resume(void);
+extern void exynos_cpu_resume_ns(void);
 
 extern struct smp_operations exynos_smp_ops;
 
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index e8797bb..f5e626d 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -14,13 +14,20 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
 #include <asm/firmware.h>
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
@@ -69,10 +76,48 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	return 0;
 }
 
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
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
+		/* Save Power control and Diagnostic registers */
+		asm ("mrc p15, 0, %0, c15, c0, 0\n"
+			"mrc p15, 0, %1, c15, c0, 1\n"
+			: "=r" (cp15_save_power), "=r" (cp15_save_diag)
+			: : "cc");
+	}
+
+	writel(EXYNOS_SLEEP_MAGIC, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
+	writel(virt_to_phys(exynos_cpu_resume_ns),
+		sysram_ns_base_addr + EXYNOS_BOOT_ADDR);
+
+	return cpu_suspend(0, exynos_cpu_suspend);
+}
+
+static int exynos_resume(void)
+{
+	writel(0, sysram_ns_base_addr + EXYNOS_BOOT_FLAG);
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
 
 void __init exynos_firmware_init(void)
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index abefacb..454c1cc 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 
 #include <asm/cacheflush.h>
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
@@ -292,12 +293,11 @@ static int exynos_pm_suspend(void)
 
 static void exynos_pm_resume(void)
 {
+	u32 cpuid = read_cpuid_part();
+
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
-		exynos_cpu_restore_register();
-
 	/* For release retention */
 
 	pmu_raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
@@ -314,9 +314,13 @@ static void exynos_pm_resume(void)
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
+	if (cpuid == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(S5P_VA_SCU);
 
+	if (call_firmware_op(resume) == -ENOSYS
+	    && cpuid == ARM_CPU_PART_CORTEX_A9)
+		exynos_cpu_restore_register();
+
 early_wakeup:
 
 	/* Clear SLEEP mode set in INFORM1 */
@@ -357,7 +361,9 @@ static int exynos_suspend_enter(suspend_state_t state)
 	flush_cache_all();
 	s3c_pm_check_store();
 
-	ret = cpu_suspend(0, exynos_cpu_suspend);
+	ret = call_firmware_op(suspend);
+	if (ret == -ENOSYS)
+		ret = cpu_suspend(0, exynos_cpu_suspend);
 	if (ret)
 		return ret;
 
diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
index 108a45f..e3c3730 100644
--- a/arch/arm/mach-exynos/sleep.S
+++ b/arch/arm/mach-exynos/sleep.S
@@ -16,6 +16,7 @@
  */
 
 #include <linux/linkage.h>
+#include "smc.h"
 
 #define CPU_MASK	0xff0ffff0
 #define CPU_CORTEX_A9	0x410fc090
@@ -55,3 +56,30 @@ ENTRY(exynos_cpu_resume)
 #endif
 	b	cpu_resume
 ENDPROC(exynos_cpu_resume)
+
+	.align
+
+ENTRY(exynos_cpu_resume_ns)
+	mrc	p15, 0, r0, c0, c0, 0
+	ldr	r1, =CPU_MASK
+	and	r0, r0, r1
+	ldr	r1, =CPU_CORTEX_A9
+	cmp	r0, r1
+	bne	skip_cp15
+
+	adr	r0, cp15_save_power
+	ldr	r1, [r0]
+	adr	r0, cp15_save_diag
+	ldr	r2, [r0]
+	mov	r0, #SMC_CMD_C15RESUME
+	dsb
+	smc	#0
+skip_cp15:
+	b	cpu_resume
+ENDPROC(exynos_cpu_resume_ns)
+	.globl cp15_save_diag
+cp15_save_diag:
+	.long	0	@ cp15 diagnostic
+	.globl cp15_save_power
+cp15_save_power:
+	.long	0	@ cp15 power control
diff --git a/arch/arm/mach-exynos/smc.h b/arch/arm/mach-exynos/smc.h
index 13a1dc8..f7b82f9 100644
--- a/arch/arm/mach-exynos/smc.h
+++ b/arch/arm/mach-exynos/smc.h
@@ -26,6 +26,10 @@
 #define SMC_CMD_L2X0INVALL	(-24)
 #define SMC_CMD_L2X0DEBUG	(-25)
 
+#ifndef __ASSEMBLY__
+
 extern void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3);
 
+#endif /* __ASSEMBLY__ */
+
 #endif
-- 
2.0.4
