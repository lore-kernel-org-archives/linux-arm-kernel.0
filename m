From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 11:20:29 +0100
Subject: [[PATCH v2] 08/11] irqchip: exynos: fix usage of __raw IO
In-Reply-To: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466504432-24187-9-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the use of __raw IO accesors when the readl/writel_relaxed
are better. This should fix issues if the kernel is running as
big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Marc Zyngier <marc.zyngier@arm.com>w
---
 drivers/irqchip/exynos-combiner.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index ead15be..b78a169 100644
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
@@ -235,9 +235,9 @@ static void combiner_resume(void)
 	int i;
 
 	for (i = 0; i < max_nr; i++) {
-		__raw_writel(combiner_data[i].irq_mask,
+		writel_relaxed(combiner_data[i].irq_mask,
 			     combiner_data[i].base + COMBINER_ENABLE_CLEAR);
-		__raw_writel(combiner_data[i].pm_save,
+		writel_relaxed(combiner_data[i].pm_save,
 			     combiner_data[i].base + COMBINER_ENABLE_SET);
 	}
 }
-- 
2.8.1
