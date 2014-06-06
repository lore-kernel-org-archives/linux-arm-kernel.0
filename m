From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 Jun 2014 10:16:30 +0200
Subject: [PATCH v2] ARM: EXYNOS: SWRESET is needed to boot secondary CPU on
 Exynos3250
Message-ID: <1402042590-8056-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without software reset the secondary CPU does not power up and
exynos_boot_secondary() ends with pen_release equal to 1. This can be
observed in dmesg:
	CPU1: failed to come online
	Brought up 1 CPUs
	SMP: Total of 1 processors activated.
	CPU: All CPU(s) started in SVC mode.

When booting the secondary CPU on Exynos3250 execute also software
reset for core 1.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
Changes since v1:
1. Removed inline keyword and change if statement to early return as
   Tomasz suggested.
2. Added reviewed-by Tomasz Figa.
---
 arch/arm/mach-exynos/platsmp.c  | 23 +++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 7071e49197c3..4031b0ed8057 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -76,6 +76,26 @@ static inline void __iomem *cpu_boot_reg(int cpu)
 }
 
 /*
+ * Set wake up by local power mode and execute software reset for given core.
+ *
+ * Currently this is needed only when booting secondary CPU on Exynos3250.
+ */
+static void exynos_core_restart(u32 core_id)
+{
+	u32 val;
+
+	if (!of_machine_is_compatible("samsung,exynos3250"))
+		return;
+
+	val = __raw_readl(EXYNOS_ARM_CORE_STATUS(core_id));
+	val |= S5P_CORE_WAKEUP_FROM_LOCAL_CFG;
+	__raw_writel(val, EXYNOS_ARM_CORE_STATUS(core_id));
+
+	pr_info("CPU%u: Software reset\n", core_id);
+	__raw_writel(EXYNOS_CORE_PO_RESET(core_id), EXYNOS_SWRESET);
+}
+
+/*
  * Write pen_release in a way that is guaranteed to be visible to all
  * observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
@@ -150,6 +170,9 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 			return -ETIMEDOUT;
 		}
 	}
+
+	exynos_core_restart(core_id);
+
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * the boot monitor to read the system wide flags register,
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 4179f6a6d595..4f578ddd4d8b 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -26,6 +26,8 @@
 #define S5P_USE_STANDBY_WFI0			(1 << 16)
 #define S5P_USE_STANDBY_WFE0			(1 << 24)
 
+#define EXYNOS_CORE_PO_RESET(n)			((1 << 4) << n)
+
 #define EXYNOS_SWRESET				S5P_PMUREG(0x0400)
 #define EXYNOS5440_SWRESET			S5P_PMUREG(0x00C4)
 
@@ -127,6 +129,7 @@
 #define S5P_PAD_RET_EBIB_OPTION			S5P_PMUREG(0x31A8)
 
 #define S5P_CORE_LOCAL_PWR_EN			0x3
+#define S5P_CORE_WAKEUP_FROM_LOCAL_CFG		(0x3 << 8)
 #define S5P_INT_LOCAL_PWR_EN			0x7
 
 #define S5P_CHECK_SLEEP				0x00000BAD
-- 
1.9.1
