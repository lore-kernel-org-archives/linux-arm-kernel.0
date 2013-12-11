From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 11 Dec 2013 17:27:08 +0530
Subject: [PATCH 4/5] ARM: EXYNOS5250: Implement pm_power_off
In-Reply-To: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
References: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1386763029-8516-5-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olofj@chromium.org>

Add pm_power_off callback function for exynos5250 to make soft
power off work properly.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Olof Johansson <olofj@chromium.org>
---
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    3 +++
 arch/arm/mach-exynos/pmu.c                   |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index 2cdb63e..da2fab0 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -343,6 +343,7 @@
 #define EXYNOS5_TOP_PWR_OPTION					S5P_PMUREG(0x2C48)
 #define EXYNOS5_TOP_PWR_SYSMEM_OPTION				S5P_PMUREG(0x2CC8)
 #define EXYNOS5_JPEG_MEM_OPTION					S5P_PMUREG(0x2F48)
+#define EXYNOS5_PS_HOLD_CONTROL					S5P_PMUREG(0x330C)
 #define EXYNOS5_GSCL_STATUS					S5P_PMUREG(0x4004)
 #define EXYNOS5_ISP_STATUS					S5P_PMUREG(0x4024)
 #define EXYNOS5_GSCL_OPTION					S5P_PMUREG(0x4008)
@@ -365,4 +366,6 @@
 
 #define EXYNOS5_OPTION_USE_RETENTION				(1 << 4)
 
+#define EXYNOS5_PS_HOLD_CONTROL_DATA				(1 << 8)
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 5f4d26b..9053b6c 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -12,6 +12,8 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
 
 #include <mach/regs-clock.h>
 
@@ -409,6 +411,23 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 	}
 }
 
+static void exynos5_power_off(void)
+{
+	unsigned int tmp;
+
+	pr_info("Power down\n");
+	tmp = __raw_readl(EXYNOS5_PS_HOLD_CONTROL);
+	tmp &= ~EXYNOS5_PS_HOLD_CONTROL_DATA;
+	__raw_writel(tmp, EXYNOS5_PS_HOLD_CONTROL);
+
+	/* Wait a little so we don't give a false warning below */
+	mdelay(100);
+
+	pr_err("Power down failed, please power off system manually.\n");
+	while (1)
+		;
+}
+
 static int __init exynos_pmu_init(void)
 {
 	unsigned int value;
@@ -444,6 +463,7 @@ static int __init exynos_pmu_init(void)
 			__raw_writel(0x0, exynos5_list_disable_pmu_reg[i]);
 
 		exynos_pmu_config = exynos5250_pmu_config;
+		pm_power_off = exynos5_power_off;
 		pr_info("EXYNOS5250 PMU Initialize\n");
 	} else {
 		pr_info("EXYNOS: PMU not supported\n");
-- 
1.7.9.5
