From: chaos.youn@samsung.com (Changhwan Youn)
Date: Mon, 20 Jun 2011 16:34:16 +0900
Subject: [PATCH 5/7] ARM: EXYNOS4: Add support external GIC
In-Reply-To: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <1308555258-4322-6-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For full support of power modes, this patch adds implementation
external GIC on EXYNOS4.

External GIC of Exynos4 cannot support register banking so
several interrupt related code for CPU1 should be different
from that of CPU0.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
---
 arch/arm/mach-exynos4/cpu.c                      |   10 ++++++++
 arch/arm/mach-exynos4/include/mach/entry-macro.S |    5 ++++
 arch/arm/mach-exynos4/include/mach/map.h         |    1 +
 arch/arm/mach-exynos4/platsmp.c                  |   27 +++++++++++++++++++++-
 4 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index fa33294..40a866c 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -16,6 +16,7 @@
 
 #include <asm/proc-fns.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -159,11 +160,20 @@ void __init exynos4_init_clocks(int xtal)
 	exynos4_setup_clocks();
 }
 
+static void exynos4_gic_irq_eoi(struct irq_data *d)
+{
+	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
+
+	gic_data->cpu_base = S5P_VA_GIC_CPU +
+			    (EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
+}
+
 void __init exynos4_init_irq(void)
 {
 	int irq;
 
 	gic_init(0, IRQ_LOCALTIMER, S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
+	gic_arch_extn.irq_eoi = exynos4_gic_irq_eoi;
 
 	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
 
diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index d8f38c2..4fad076 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -10,6 +10,7 @@
 */
 
 #include <mach/hardware.h>
+#include <mach/map.h>
 #include <asm/hardware/gic.h>
 
 		.macro	disable_fiq
@@ -18,6 +19,10 @@
 		.macro  get_irqnr_preamble, base, tmp
 		ldr	\base, =gic_cpu_base_addr
 		ldr	\base, [\base]
+		mrc     p15, 0, \tmp, c0, c0, 5
+		and     \tmp, \tmp, #3
+		cmp     \tmp, #1
+		addeq   \base, \base, #EXYNOS4_GIC_BANK_OFFSET
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 9d5d797..2339a70 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -63,6 +63,7 @@
 
 #define EXYNOS4_PA_GIC_CPU		0x10480000
 #define EXYNOS4_PA_GIC_DIST		0x10490000
+#define EXYNOS4_GIC_BANK_OFFSET		0x8000
 
 #define EXYNOS4_PA_COREPERI		0x10500000
 #define EXYNOS4_PA_TWD			0x10500600
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index c5e65a0..decf528 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -58,6 +58,31 @@ static void __iomem *scu_base_addr(void)
 
 static DEFINE_SPINLOCK(boot_lock);
 
+static void __cpuinit exynos4_gic_secondary_init(void)
+{
+	void __iomem *dist_base = S5P_VA_GIC_DIST +
+				 (EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
+	void __iomem *cpu_base = S5P_VA_GIC_CPU +
+				(EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
+	int i;
+
+	/*
+	 * Deal with the banked PPI and SGI interrupts - disable all
+	 * PPI interrupts, ensure all SGI interrupts are enabled.
+	 */
+	__raw_writel(0xffff0000, dist_base + GIC_DIST_ENABLE_CLEAR);
+	__raw_writel(0x0000ffff, dist_base + GIC_DIST_ENABLE_SET);
+
+	/*
+	 * Set priority on PPI and SGI interrupts
+	 */
+	for (i = 0; i < 32; i += 4)
+		__raw_writel(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
+
+	__raw_writel(0xf0, cpu_base + GIC_CPU_PRIMASK);
+	__raw_writel(1, cpu_base + GIC_CPU_CTRL);
+}
+
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	/*
@@ -65,7 +90,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-	gic_secondary_init(0);
+	exynos4_gic_secondary_init();
 
 	/*
 	 * let the primary processor know we're out of the
-- 
1.7.1
