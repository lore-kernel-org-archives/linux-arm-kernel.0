From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:33:53 +0200
Subject: [PATCH v2 08/38] ARM: EXYNOS: common: Remove legacy interrupt
 initialization code
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-9-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes legacy IRQ initialization code that was used to set
up interrupt handling when booting with ATAGS, which is not supported
any more.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 598e4b8..9626ce4 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -41,7 +41,6 @@
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
 #include <mach/regs-gpio.h>
-#include <mach/irqs.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
@@ -486,41 +485,14 @@ void __init exynos_init_time(void)
 	}
 }
 
-static unsigned int max_combiner_nr(void)
-{
-	if (soc_is_exynos5250())
-		return EXYNOS5_MAX_COMBINER_NR;
-	else if (soc_is_exynos4412())
-		return EXYNOS4412_MAX_COMBINER_NR;
-	else if (soc_is_exynos4212())
-		return EXYNOS4212_MAX_COMBINER_NR;
-	else
-		return EXYNOS4210_MAX_COMBINER_NR;
-}
-
-
 void __init exynos4_init_irq(void)
 {
-	unsigned int gic_bank_offset;
-
-	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
-
-	if (!of_have_populated_dt())
-		gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset, NULL);
-	else
-		irqchip_init();
-
-	if (!of_have_populated_dt())
-		combiner_init(S5P_VA_COMBINER_BASE, NULL,
-			      max_combiner_nr(), COMBINER_IRQ(0, 0));
-
-	gic_arch_extn.irq_set_wake = s3c_irq_wake;
+	irqchip_init();
 }
 
 void __init exynos5_init_irq(void)
 {
 	irqchip_init();
-	gic_arch_extn.irq_set_wake = s3c_irq_wake;
 }
 
 struct bus_type exynos_subsys = {
-- 
1.8.2.1
