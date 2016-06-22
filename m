From: matthew@mattleach.net (Matthew Leach)
Date: Wed, 22 Jun 2016 17:57:01 +0100
Subject: [PATCH v2 1/3] irqchip: exynos_combiner: fixup reg access on be
In-Reply-To: <20160622165703.7775-1-matthew@mattleach.net>
References: <20160622165703.7775-1-matthew@mattleach.net>
Message-ID: <20160622165703.7775-2-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the byte-order aware big endian accessors, allowing for kernels
running under big-endian.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Marc Zyngier <marc.zyngier@arm.com>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
CC: linux-samsung-soc at vger.kernel.org
---
 drivers/irqchip/exynos-combiner.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index ead15be..97ae34c 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -55,14 +55,14 @@ static void combiner_mask_irq(struct irq_data *data)
 {
 	u32 mask = 1 << (data->hwirq % 32);
 
-	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_CLEAR);
+	writel_relaxed(mask, combiner_base(data) + COMBINER_ENABLE_CLEAR);
 }
 
 static void combiner_unmask_irq(struct irq_data *data)
 {
 	u32 mask = 1 << (data->hwirq % 32);
 
-	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_SET);
+	writel_relaxed(mask, combiner_base(data) + COMBINER_ENABLE_SET);
 }
 
 static void combiner_handle_cascade_irq(struct irq_desc *desc)
@@ -75,7 +75,7 @@ static void combiner_handle_cascade_irq(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	spin_lock(&irq_controller_lock);
-	status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
+	status = readl_relaxed(chip_data->base + COMBINER_INT_STATUS);
 	spin_unlock(&irq_controller_lock);
 	status &= chip_data->irq_mask;
 
@@ -135,7 +135,7 @@ static void __init combiner_init_one(struct combiner_chip_data *combiner_data,
 	combiner_data->parent_irq = irq;
 
 	/* Disable all interrupts */
-	__raw_writel(combiner_data->irq_mask, base + COMBINER_ENABLE_CLEAR);
+	writel_relaxed(combiner_data->irq_mask, base + COMBINER_ENABLE_CLEAR);
 }
 
 static int combiner_irq_domain_xlate(struct irq_domain *d,
@@ -218,7 +218,7 @@ static int combiner_suspend(void)
 
 	for (i = 0; i < max_nr; i++)
 		combiner_data[i].pm_save =
-			__raw_readl(combiner_data[i].base + COMBINER_ENABLE_SET);
+			readl_relaxed(combiner_data[i].base + COMBINER_ENABLE_SET);
 
 	return 0;
 }
@@ -235,10 +235,10 @@ static void combiner_resume(void)
 	int i;
 
 	for (i = 0; i < max_nr; i++) {
-		__raw_writel(combiner_data[i].irq_mask,
-			     combiner_data[i].base + COMBINER_ENABLE_CLEAR);
-		__raw_writel(combiner_data[i].pm_save,
-			     combiner_data[i].base + COMBINER_ENABLE_SET);
+		writel_relaxed(combiner_data[i].irq_mask,
+			       combiner_data[i].base + COMBINER_ENABLE_CLEAR);
+		writel_relaxed(combiner_data[i].pm_save,
+			       combiner_data[i].base + COMBINER_ENABLE_SET);
 	}
 }
 
-- 
2.8.3
