From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue,  1 Nov 2011 06:31:29 +0530
Subject: [PATCH v2 3/3] ARM: Exynos4: Enable conversion of GIC dt irq
	specifier to linux virq
In-Reply-To: <1320109289-2730-1-git-send-email-thomas.abraham@linaro.org>
References: <1320109289-2730-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1320109289-2730-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable conversion of device tree interrupt specifier to linux virq domain
for GIC controller.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/cpu.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 358624d..c06dd03 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -10,6 +10,8 @@
 
 #include <linux/sched.h>
 #include <linux/sysdev.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -229,13 +231,26 @@ static void exynos4_gic_irq_fix_base(struct irq_data *d)
 			    (gic_bank_offset * smp_processor_id());
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id exynos4_dt_irq_match[] = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{},
+};
+#endif
+
 void __init exynos4_init_irq(void)
 {
 	int irq;
 
 	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
 
-	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
+	if (!of_have_populated_dt())
+		gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
+#ifdef CONFIG_OF
+	else	
+		of_irq_init(exynos4_dt_irq_match);
+#endif
+
 	gic_arch_extn.irq_eoi = exynos4_gic_irq_fix_base;
 	gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
 	gic_arch_extn.irq_mask = exynos4_gic_irq_fix_base;
-- 
1.7.4.4
