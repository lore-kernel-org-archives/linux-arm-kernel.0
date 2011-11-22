From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Tue, 22 Nov 2011 15:05:29 +0530
Subject: [PATCH V3 3/6] ARM: exynos: save L2 settings during bootup
In-Reply-To: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
References: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1321954532-18724-4-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds code to save L2 register configuration at boot, and
later used to resume L2 before MMU is enabled in suspend and cpuidle
resume paths.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/mach-exynos/cpu.c |   42 +++++++++++++++++++++++++++++++-----------
 1 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
index 8e09f34..252e346 100644
--- a/arch/arm/mach-exynos/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@ -19,6 +19,7 @@
 #include <asm/proc-fns.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
+#include <asm/cacheflush.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -34,6 +35,7 @@
 
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
+#include <mach/pmu.h>
 
 unsigned int gic_bank_offset __read_mostly;
 
@@ -297,20 +299,38 @@ core_initcall(exynos4_core_init);
 #ifdef CONFIG_CACHE_L2X0
 static int __init exynos4_l2x0_cache_init(void)
 {
-	/* TAG, Data Latency Control: 2cycle */
-	__raw_writel(0x110, S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
+	if (!(__raw_readl(S5P_VA_L2CC + L2X0_CTRL) & 0x1)) {
+		l2x0_saved_regs.phy_base = EXYNOS4_PA_L2CC;
+		/* TAG, Data Latency Control: 2 cycles */
+		l2x0_saved_regs.tag_latency = 0x110;
 
-	if (soc_is_exynos4210())
-		__raw_writel(0x110, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
-	else if (soc_is_exynos4212() || soc_is_exynos4412())
-		__raw_writel(0x120, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
+		if (soc_is_exynos4212() || soc_is_exynos4412())
+			l2x0_saved_regs.data_latency = 0x120;
+		else
+			l2x0_saved_regs.data_latency = 0x110;
+
+		l2x0_saved_regs.prefetch_ctrl = 0x30000007;
+		l2x0_saved_regs.pwr_ctrl =
+			(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN);
+
+		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
 
-	/* L2X0 Prefetch Control */
-	__raw_writel(0x30000007, S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
+		__raw_writel(l2x0_saved_regs.tag_latency,
+				S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
+		__raw_writel(l2x0_saved_regs.data_latency,
+				S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
 
-	/* L2X0 Power Control */
-	__raw_writel(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN,
-		     S5P_VA_L2CC + L2X0_POWER_CTRL);
+		/* L2X0 Prefetch Control */
+		__raw_writel(l2x0_saved_regs.prefetch_ctrl,
+				S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
+
+		/* L2X0 Power Control */
+		__raw_writel(l2x0_saved_regs.pwr_ctrl,
+				S5P_VA_L2CC + L2X0_POWER_CTRL);
+
+		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
+		clean_dcache_area(&l2x0_saved_regs, sizeof(struct l2x0_regs));
+	}
 
 	l2x0_init(S5P_VA_L2CC, 0x7C470001, 0xC200ffff);
 
-- 
1.7.1
