From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 16:03:24 +0200
Subject: [PATCH 6/7] irqchip: exynos: localize irq lookup for ATAGS
In-Reply-To: <1365775405-115297-1-git-send-email-arnd@arndb.de>
References: <1365775405-115297-1-git-send-email-arnd@arndb.de>
Message-ID: <1365775405-115297-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ_SPI() macro is not available in the driver when building with sparse
IRQs or multiplatform, so let's move all users of this into one function
that we can leave out when building DT-only.

Signed-off-by: Arnd Bergmann <arnd@arnd.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/exynos-combiner.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 7fcdeee..acb9c74 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -18,7 +18,9 @@
 #include <linux/of_irq.h>
 #include <asm/mach/irq.h>
 
+#ifdef CONFIG_EXYNOS_ATAGS
 #include <plat/cpu.h>
+#endif
 
 #include "irqchip.h"
 
@@ -182,8 +184,12 @@ static struct irq_domain_ops combiner_irq_domain_ops = {
 	.map	= combiner_irq_domain_map,
 };
 
-static unsigned int exynos4x12_combiner_extra_irq(int group)
+static unsigned int combiner_lookup_irq(int group)
 {
+#ifdef CONFIG_EXYNOS_ATAGS
+	if (group < EXYNOS4210_MAX_COMBINER_NR || soc_is_exynos5250())
+		return IRQ_SPI(group);
+
 	switch (group) {
 	case 16:
 		return IRQ_SPI(107);
@@ -193,9 +199,9 @@ static unsigned int exynos4x12_combiner_extra_irq(int group)
 		return IRQ_SPI(48);
 	case 19:
 		return IRQ_SPI(42);
-	default:
-		return 0;
 	}
+#endif
+	return 0;
 }
 
 void __init combiner_init(void __iomem *combiner_base,
@@ -228,14 +234,13 @@ void __init combiner_init(void __iomem *combiner_base,
 	}
 
 	for (i = 0; i < max_nr; i++) {
-		if (i < EXYNOS4210_MAX_COMBINER_NR || soc_is_exynos5250())
-			irq = IRQ_SPI(i);
-		else
-			irq = exynos4x12_combiner_extra_irq(i);
 #ifdef CONFIG_OF
 		if (np)
 			irq = irq_of_parse_and_map(np, i);
+		else
 #endif
+			irq = combiner_lookup_irq(i);
+
 		combiner_init_one(&combiner_data[i], i,
 				  combiner_base + (i >> 2) * 0x10, irq);
 		combiner_cascade_irq(&combiner_data[i], irq);
-- 
1.8.1.2
