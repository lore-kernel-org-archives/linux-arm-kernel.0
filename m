From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Sep 2011 16:24:38 +0900
Subject: [PATCH 1/2] ARM: EXYNOS4: Add support PPI in external GIC
Message-ID: <008f01cc7e78$d8d08020$8a718060$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

To support PPI in external GIC of EXYNOS4 SoCs,
gic_arch_extn.irq_eoi, irq_unmask and irq_mask are
fixed. This patch is necessary because external GIC of EXYNOS4
cannot support register banking.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/cpu.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 2aa3df0..9d5a171 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -200,20 +200,25 @@ void __init exynos4_init_clocks(int xtal)
 	exynos4_setup_clocks();
 }
 
-static void exynos4_gic_irq_eoi(struct irq_data *d)
+static void exynos4_gic_irq_fix_base(struct irq_data *d)
 {
 	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
 
 	gic_data->cpu_base = S5P_VA_GIC_CPU +
 			    (EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
+
+	gic_data->dist_base = S5P_VA_GIC_DIST +
+			    (EXYNOS4_GIC_BANK_OFFSET * smp_processor_id());
 }
 
 void __init exynos4_init_irq(void)
 {
 	int irq;
 
-	gic_init(0, IRQ_SPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
-	gic_arch_extn.irq_eoi = exynos4_gic_irq_eoi;
+	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
+	gic_arch_extn.irq_eoi = exynos4_gic_irq_fix_base;
+	gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
+	gic_arch_extn.irq_mask = exynos4_gic_irq_fix_base;
 
 	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
 
-- 
1.7.1
