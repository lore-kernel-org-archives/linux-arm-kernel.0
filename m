From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 11 Jun 2014 08:27:07 +0900
Subject: [RESEND PATCH] ARM: EXYNOS: Fix the sequence of secondary CPU boot for
 Exynos3250
Message-ID: <1402442827-2321-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set AUTOWAKEUP_EN bit to ARM_CORE_CONFIGURATION register
because Exynos3250 removes WFE in secure mode so that turn on automatically
after setting CORE_LOCAL_PWR_EN. Also, This patch use dbs_sev() macro
to guarantee the data synchronization of command instead of IPI_WAKEUP
because Exynos3250 don't have WFE mode in secue mode.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c  | 9 ++++++++-
 arch/arm/mach-exynos/pm.c       | 8 ++++++--
 arch/arm/mach-exynos/regs-pmu.h | 4 ++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index ec02422..882fb84 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -149,6 +149,10 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 			return -ETIMEDOUT;
 		}
 	}
+
+	if (soc_is_exynos3250())
+		__raw_writel(EXYNOS3_COREPORESET(phys_cpu), EXYNOS_SWRESET);
+
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * the boot monitor to read the system wide flags register,
@@ -182,7 +186,10 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		call_firmware_op(cpu_boot, phys_cpu);
 
-		arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+		if (soc_is_exynos3250())
+			dsb_sev();
+		else
+			arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
 		if (pen_release == -1)
 			break;
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 87c0d34..4681f64 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -121,8 +121,12 @@ void exynos_cpu_power_down(int cpu)
  */
 void exynos_cpu_power_up(int cpu)
 {
-	__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-		     EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+	u32 core_conf = 0;
+
+	core_conf |= S5P_CORE_LOCAL_PWR_EN;
+	if (soc_is_exynos3250())
+		core_conf |= S5P_CORE_AUTOWAKEUP_EN;
+	__raw_writel(core_conf, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
 }
 
 /**
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 1d13b08..674dfc2 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -128,6 +128,7 @@
 
 #define S5P_CORE_LOCAL_PWR_EN			0x3
 #define S5P_INT_LOCAL_PWR_EN			0x7
+#define S5P_CORE_AUTOWAKEUP_EN			(1 << 31)
 
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	S5P_PMUREG(0x1154)
@@ -186,6 +187,9 @@
 #define S5P_DIS_IRQ_CORE3			S5P_PMUREG(0x1034)
 #define S5P_DIS_IRQ_CENTRAL3			S5P_PMUREG(0x1038)
 
+/* For EXYNOS3 */
+#define EXYNOS3_COREPORESET(cpu)		((1 << 4) << cpu)
+
 /* For EXYNOS5 */
 
 #define EXYNOS5_SYS_I2C_CFG					S5P_SYSREG(0x0234)
-- 
1.8.0
