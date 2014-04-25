From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:50:26 +0100
Subject: [PATCH 177/222] ARM: l2c: exynos: convert to common l2c310 early
 resume functionality
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeeA-0007PF-5m@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-exynos/common.h     |  1 -
 arch/arm/mach-exynos/exynos.c     | 12 +-----------
 arch/arm/mach-exynos/sleep.S      | 30 +-----------------------------
 arch/arm/plat-samsung/s5p-sleep.S |  1 -
 4 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 9ef3f83efaff..88c619d1e145 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -55,7 +55,6 @@ enum sys_powerdown {
 	NUM_SYS_POWERDOWN,
 };
 
-extern unsigned long l2x0_regs_phys;
 struct exynos_pmu_conf {
 	void __iomem *reg;
 	unsigned int val[NUM_SYS_POWERDOWN];
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index a51bf25e7523..fbfc29df3299 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -318,17 +318,7 @@ core_initcall(exynos_core_init);
 
 static int __init exynos4_l2x0_cache_init(void)
 {
-	int ret;
-
-	ret = l2x0_of_init(0x3c400001, 0xc20fffff);
-	if (ret)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_S5P_SLEEP)) {
-		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
-		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
-	}
-	return 0;
+	return l2x0_of_init(0x3c400001, 0xc20fffff);
 }
 early_initcall(exynos4_l2x0_cache_init);
 
diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
index 7e0af530511e..108a45f4bb62 100644
--- a/arch/arm/mach-exynos/sleep.S
+++ b/arch/arm/mach-exynos/sleep.S
@@ -16,8 +16,6 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-#include <asm/hardware/cache-l2x0.h>
 
 #define CPU_MASK	0xff0ffff0
 #define CPU_CORTEX_A9	0x410fc090
@@ -53,33 +51,7 @@ ENTRY(exynos_cpu_resume)
 	and	r0, r0, r1
 	ldr	r1, =CPU_CORTEX_A9
 	cmp	r0, r1
-	bne	skip_l2_resume
-	adr	r0, l2x0_regs_phys
-	ldr	r0, [r0]
-	cmp	r0, #0
-	beq	skip_l2_resume
-	ldr	r1, [r0, #L2X0_R_PHY_BASE]
-	ldr	r2, [r1, #L2X0_CTRL]
-	tst	r2, #0x1
-	bne	skip_l2_resume
-	ldr	r2, [r0, #L2X0_R_AUX_CTRL]
-	str	r2, [r1, #L2X0_AUX_CTRL]
-	ldr	r2, [r0, #L2X0_R_TAG_LATENCY]
-	str	r2, [r1, #L310_TAG_LATENCY_CTRL]
-	ldr	r2, [r0, #L2X0_R_DATA_LATENCY]
-	str	r2, [r1, #L310_DATA_LATENCY_CTRL]
-	ldr	r2, [r0, #L2X0_R_PREFETCH_CTRL]
-	str	r2, [r1, #L310_PREFETCH_CTRL]
-	ldr	r2, [r0, #L2X0_R_PWR_CTRL]
-	str	r2, [r1, #L310_POWER_CTRL]
-	mov	r2, #1
-	str	r2, [r1, #L2X0_CTRL]
-skip_l2_resume:
+	bleq	l2c310_early_resume
 #endif
 	b	cpu_resume
 ENDPROC(exynos_cpu_resume)
-#ifdef CONFIG_CACHE_L2X0
-	.globl l2x0_regs_phys
-l2x0_regs_phys:
-	.long	0
-#endif
diff --git a/arch/arm/plat-samsung/s5p-sleep.S b/arch/arm/plat-samsung/s5p-sleep.S
index c5001659bdf8..25c68ceb9e2b 100644
--- a/arch/arm/plat-samsung/s5p-sleep.S
+++ b/arch/arm/plat-samsung/s5p-sleep.S
@@ -22,7 +22,6 @@
 */
 
 #include <linux/linkage.h>
-#include <asm/asm-offsets.h>
 
 	.data
 	.align
-- 
1.8.3.1
