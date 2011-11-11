From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Fri, 11 Nov 2011 11:59:35 +0530
Subject: [PATCH V2 3/5] ARM: exynos4: add L2 early resume code
In-Reply-To: <1320992977-11589-1-git-send-email-amit.kachhap@linaro.org>
References: <1320992977-11589-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1320992977-11589-4-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds code to save L2 register configuration at boot, and to
resume L2 before MMU is enabled in suspend and cpuidle resume paths.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/mach-exynos/cpu.c |   42 +++++++++++++++++++++++++++++++-----------
 arch/arm/plat-s5p/sleep.S  |   28 ++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 11 deletions(-)

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
 
diff --git a/arch/arm/plat-s5p/sleep.S b/arch/arm/plat-s5p/sleep.S
index c371ba2..40bd9bf 100644
--- a/arch/arm/plat-s5p/sleep.S
+++ b/arch/arm/plat-s5p/sleep.S
@@ -23,6 +23,8 @@
 */
 
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/hardware/cache-l2x0.h>
 
 	.text
 
@@ -47,5 +49,31 @@
 	.data
 
 ENTRY(s3c_cpu_resume)
+#ifdef CONFIG_CACHE_L2X0
+	adr	r0, l2x0_regs_phys
+	ldr	r0, [r0]
+	ldr	r1, [r0, #L2X0_R_PHY_BASE]
+	ldr	r2, [r1, #L2X0_CTRL]
+	tst	r2, #0x1
+	bne	resume_l2on
+	ldr	r2, [r0, #L2X0_R_AUX_CTRL]
+	str	r2, [r1, #L2X0_AUX_CTRL]
+	ldr	r2, [r0, #L2X0_R_TAG_LATENCY]
+	str	r2, [r1, #L2X0_TAG_LATENCY_CTRL]
+	ldr	r2, [r0, #L2X0_R_DATA_LATENCY]
+	str	r2, [r1, #L2X0_DATA_LATENCY_CTRL]
+	ldr	r2, [r0, #L2X0_R_PREFETCH_CTRL]
+	str	r2, [r1, #L2X0_PREFETCH_CTRL]
+	ldr	r2, [r0, #L2X0_R_PWR_CTRL]
+	str	r2, [r1, #L2X0_POWER_CTRL]
+	mov	r2, #1
+	str	r2, [r1, #L2X0_CTRL]
+resume_l2on:
+#endif
 	b	cpu_resume
 ENDPROC(s3c_cpu_resume)
+#ifdef CONFIG_CACHE_L2X0
+	.globl l2x0_regs_phys
+l2x0_regs_phys:
+	.long	0
+#endif
-- 
1.7.1
