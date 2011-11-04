From: amit.kachhap@linaro.org (amit.kachhap at linaro.org)
Date: Fri,  4 Nov 2011 13:03:47 -0400
Subject: [PATCH 3/4] ARM: exynos4: add L2 early resume code
In-Reply-To: <1320426228-21746-1-git-send-email-amit.kachhap@linaro.org>
References: <1320426228-21746-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1320426228-21746-4-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amit Daniel Kachhap <amit.kachhap@linaro.org>

This patch adds code to save L2 register configuration at boot, and to
resume L2 before MMU is enabled in suspend and cpuidle resume paths.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/mach-exynos4/cpu.c   |   43 ++++++++++++++++++++++++++++++----------
 arch/arm/mach-exynos4/sleep.S |   26 ++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index a348434..53c6cd3 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/sysdev.h>
 
+#include <asm/cacheflush.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
@@ -31,6 +32,7 @@
 
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
+#include <mach/pmu.h>
 
 unsigned int gic_bank_offset __read_mostly;
 
@@ -254,20 +256,39 @@ core_initcall(exynos4_core_init);
 #ifdef CONFIG_CACHE_L2X0
 static int __init exynos4_l2x0_cache_init(void)
 {
-	/* TAG, Data Latency Control: 2cycle */
-	__raw_writel(0x110, S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
+	if (!(__raw_readl(S5P_VA_L2CC + L2X0_CTRL) & 0x1)) {
 
-	if (soc_is_exynos4210())
-		__raw_writel(0x110, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
-	else if (soc_is_exynos4212() || soc_is_exynos4412())
-		__raw_writel(0x120, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
+		l2x0_saved_regs.phy_base = EXYNOS4_PA_L2CC;
+		/* TAG, Data Latency Control: 2 cycles */
+		l2x0_saved_regs.tag_latency = 0x110;
+
+		if (soc_is_exynos4212() || soc_is_exynos4412())
+			l2x0_saved_regs.data_latency = 0x120;
+		else
+			l2x0_saved_regs.data_latency = 0x110;
+
+		l2x0_saved_regs.prefetch_ctrl = 0x30000007;
+		l2x0_saved_regs.pwr_ctrl =
+			(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN);
 
-	/* L2X0 Prefetch Control */
-	__raw_writel(0x30000007, S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
+		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
 
-	/* L2X0 Power Control */
-	__raw_writel(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN,
-		     S5P_VA_L2CC + L2X0_POWER_CTRL);
+		__raw_writel(l2x0_saved_regs.tag_latency,
+				S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
+		__raw_writel(l2x0_saved_regs.data_latency,
+				S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
+
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
 
diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
index c19527b..3284213 100644
--- a/arch/arm/mach-exynos4/sleep.S
+++ b/arch/arm/mach-exynos4/sleep.S
@@ -27,6 +27,8 @@
 */
 
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/hardware/cache-l2x0.h>
 
 	.text
 
@@ -47,7 +49,31 @@
 	 * other way of restoring the stack pointer after sleep, and we
 	 * must not write to the code segment (code is read-only)
 	 */
+	.align
+	.data
 
 ENTRY(s3c_cpu_resume)
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
 	b	cpu_resume
 ENDPROC(s3c_cpu_resume)
+	.globl l2x0_regs_phys
+l2x0_regs_phys:
+	.long	0
-- 
1.7.5.4
