From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Sep 2011 17:12:59 +0900
Subject: [PATCH 3/5] ARM: EXYNOS4: Add functions for gic interrupt handling
Message-ID: <009601cc7e7f$9a1add60$ce509820$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds two functions for gic interrupt handling.
1. Add interrupt handling of 4 cores.
2. Dynamically set gic bank offset according to the type of soc.
   Gic bank offset of EXYNOS4412 is 0x4000 while the offset of
   EXYNOS4210 and EXYNOS4212 is 0x8000.

This patch is necessary because EXYNOS4 socs cannot support
GIC register banking as described in commit aab74d3e75364.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/cpu.c                      |    8 +++++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S |   23 +++++++++++++++++----
 arch/arm/mach-exynos4/include/mach/map.h         |    1 -
 arch/arm/mach-exynos4/platsmp.c                  |    5 ++-
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 74d50d1..5b1765b 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -33,6 +33,8 @@
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
 
+unsigned int gic_bank_offset __read_mostly;
+
 extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
 			 unsigned int irq_start);
 extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq);
@@ -205,16 +207,18 @@ static void exynos4_gic_irq_fix_base(struct irq_data *d)
 	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
 
 	gic_data->cpu_base = S5P_VA_GIC_CPU +
-			    (EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
+			    (gic_bank_offset * smp_processor_id());
 
 	gic_data->dist_base = S5P_VA_GIC_DIST +
-			    (EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
+			    (gic_bank_offset * smp_processor_id());
 }
 
 void __init exynos4_init_irq(void)
 {
 	int irq;
 
+	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
+
 	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
 	gic_arch_extn.irq_eoi = exynos4_gic_irq_fix_base;
 	gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index 61393dc..4c9adbd 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -17,12 +17,25 @@
 		.endm
 
 		.macro  get_irqnr_preamble, base, tmp
-		ldr	\base, =gic_cpu_base_addr
+		mov	\tmp, #0
+
+		mrc	p15, 0, \base, c0, c0, 5
+		and	\base, \base, #3
+		cmp	\base, #0
+		beq	1f
+
+		ldr	\tmp, =gic_bank_offset
+		ldr	\tmp, [\tmp]
+		cmp	\base, #1
+		beq	1f
+
+		cmp	\base, #2
+		addeq	\tmp, \tmp, \tmp
+		addne	\tmp, \tmp, \tmp, LSL #1
+
+1:		ldr	\base, =gic_cpu_base_addr
 		ldr	\base, [\base]
-		mrc     p15, 0, \tmp, c0, c0, 5
-		and     \tmp, \tmp, #3
-		cmp     \tmp, #1
-		addeq   \base, \base, #EXYNOS4_GIC_BANK_OFFSET
+		add	\base, \base, \tmp
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 1bea7d1..918a979 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -62,7 +62,6 @@
 
 #define EXYNOS4_PA_GIC_CPU		0x10480000
 #define EXYNOS4_PA_GIC_DIST		0x10490000
-#define EXYNOS4_GIC_BANK_OFFSET		0x8000
 
 #define EXYNOS4_PA_COREPERI		0x10500000
 #define EXYNOS4_PA_TWD			0x10500600
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index a3346e3..d5f0f29 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -32,6 +32,7 @@
 
 #include <plat/cpu.h>
 
+extern unsigned int gic_bank_offset;
 extern void exynos4_secondary_startup(void);
 
 #define CPU1_BOOT_REG		(samsung_rev() == EXYNOS4210_REV_1_1 ? \
@@ -67,9 +68,9 @@ static DEFINE_SPINLOCK(boot_lock);
 static void __cpuinit exynos4_gic_secondary_init(void)
 {
 	void __iomem *dist_base = S5P_VA_GIC_DIST +
-				 (EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
+				(gic_bank_offset * smp_processor_id());
 	void __iomem *cpu_base = S5P_VA_GIC_CPU +
-				(EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
+				(gic_bank_offset * smp_processor_id());
 	int i;
 
 	/*
-- 
1.7.1
