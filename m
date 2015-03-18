From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 18 Mar 2015 13:51:52 +0100
Subject: [PATCH v3 3/4] ARM: EXYNOS: cpuidle: add AFTR mode support for
 Exynos3250
In-Reply-To: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
References: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1426683113-31209-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/firmware.c |  8 +++++++-
 arch/arm/mach-exynos/pm.c       | 12 +++++++++++-
 arch/arm/mach-exynos/regs-pmu.h |  1 +
 arch/arm/mach-exynos/smc.h      |  9 +++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 4791a3c..f236877 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -48,7 +48,13 @@ static int exynos_do_idle(unsigned long mode)
 		__raw_writel(virt_to_phys(exynos_cpu_resume_ns),
 			     sysram_ns_base_addr + 0x24);
 		__raw_writel(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
-		exynos_smc(SMC_CMD_CPU0AFTR, 0, 0, 0);
+		if (soc_is_exynos3250()) {
+			exynos_smc(SMC_CMD_SAVE, OP_TYPE_CORE,
+				   SMC_POWERSTATE_IDLE, 0);
+			exynos_smc(SMC_CMD_SHUTDOWN, OP_TYPE_CLUSTER,
+				   SMC_POWERSTATE_IDLE, 0);
+		} else
+			exynos_smc(SMC_CMD_CPU0AFTR, 0, 0, 0);
 		break;
 	case FW_DO_IDLE_SLEEP:
 		exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 5685250..cc75ab4 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -127,6 +127,8 @@ int exynos_pm_central_resume(void)
 static void exynos_set_wakeupmask(long mask)
 {
 	pmu_raw_writel(mask, S5P_WAKEUP_MASK);
+	if (soc_is_exynos3250())
+		pmu_raw_writel(0x0, S5P_WAKEUP_MASK2);
 }
 
 static void exynos_cpu_set_boot_vector(long flags)
@@ -140,7 +142,7 @@ static int exynos_aftr_finisher(unsigned long flags)
 {
 	int ret;
 
-	exynos_set_wakeupmask(0x0000ff3e);
+	exynos_set_wakeupmask(soc_is_exynos3250() ? 0x40003ffe : 0x0000ff3e);
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
 
@@ -157,8 +159,13 @@ static int exynos_aftr_finisher(unsigned long flags)
 
 void exynos_enter_aftr(void)
 {
+	unsigned int cpuid = smp_processor_id();
+
 	cpu_pm_enter();
 
+	if (soc_is_exynos3250())
+		exynos_set_boot_flag(cpuid, C2_STATE);
+
 	exynos_pm_central_suspend();
 
 	if (of_machine_is_compatible("samsung,exynos4212") ||
@@ -178,6 +185,9 @@ void exynos_enter_aftr(void)
 
 	exynos_pm_central_resume();
 
+	if (soc_is_exynos3250())
+		exynos_clear_boot_flag(cpuid, C2_STATE);
+
 	cpu_pm_exit();
 }
 
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 84ddce1..b761433 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -43,6 +43,7 @@
 #define S5P_WAKEUP_STAT				0x0600
 #define S5P_EINT_WAKEUP_MASK			0x0604
 #define S5P_WAKEUP_MASK				0x0608
+#define S5P_WAKEUP_MASK2				0x0614
 
 #define S5P_INFORM0				0x0800
 #define S5P_INFORM1				0x0804
diff --git a/arch/arm/mach-exynos/smc.h b/arch/arm/mach-exynos/smc.h
index f7b82f9..27a976d 100644
--- a/arch/arm/mach-exynos/smc.h
+++ b/arch/arm/mach-exynos/smc.h
@@ -17,6 +17,8 @@
 #define SMC_CMD_SLEEP		(-3)
 #define SMC_CMD_CPU1BOOT	(-4)
 #define SMC_CMD_CPU0AFTR	(-5)
+#define SMC_CMD_SAVE           	(-6)
+#define SMC_CMD_SHUTDOWN       	(-7)
 /* For CP15 Access */
 #define SMC_CMD_C15RESUME	(-11)
 /* For L2 Cache Access */
@@ -32,4 +34,11 @@ extern void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3);
 
 #endif /* __ASSEMBLY__ */
 
+/* op type for SMC_CMD_SAVE and SMC_CMD_SHUTDOWN */
+#define OP_TYPE_CORE            0x0
+#define OP_TYPE_CLUSTER         0x1
+
+/* Power State required for SMC_CMD_SAVE and SMC_CMD_SHUTDOWN */
+#define SMC_POWERSTATE_IDLE     0x1
+
 #endif
-- 
1.8.2.3
