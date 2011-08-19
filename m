From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 19 Aug 2011 19:46:14 +0900
Subject: [PATCH] arm: exynos4: Add restart hook for proper reboot
Message-ID: <20110819104614.GA32582@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Add restart hook for proper reboot

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 2d8a40c..1860327 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -28,8 +28,10 @@
 #include <plat/fb-core.h>
 #include <plat/fimc-core.h>
 #include <plat/iic-core.h>
+#include <plat/reset.h>
 
 #include <mach/regs-irq.h>
+#include <mach/regs-pmu.h>
 
 extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
 			 unsigned int irq_start);
@@ -128,6 +130,11 @@ static void exynos4_idle(void)
 	local_irq_enable();
 }
 
+static void exynos4_sw_reset(void)
+{
+	__raw_writel(0x1, S5P_SWRESET);
+}
+
 /*
  * exynos4_map_io
  *
@@ -241,5 +248,8 @@ int __init exynos4_init(void)
 	/* set idle function */
 	pm_idle = exynos4_idle;
 
+	/* set sw_reset function */
+	s5p_reset_hook = exynos4_sw_reset;
+
 	return sysdev_register(&exynos4_sysdev);
 }
diff --git a/arch/arm/mach-exynos4/include/mach/regs-pmu.h b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
index fa49bbb..cdf9b47 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
@@ -29,6 +29,8 @@
 #define S5P_USE_STANDBY_WFE1			(1 << 25)
 #define S5P_USE_MASK				((0x3 << 16) | (0x3 << 24))
 
+#define S5P_SWRESET				S5P_PMUREG(0x0400)
+
 #define S5P_WAKEUP_STAT				S5P_PMUREG(0x0600)
 #define S5P_EINT_WAKEUP_MASK			S5P_PMUREG(0x0604)
 #define S5P_WAKEUP_MASK				S5P_PMUREG(0x0608)
