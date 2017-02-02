From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 19:51:53 +0100
Subject: [PATCH 03/23] IRQ backup
In-Reply-To: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
References: <20170202185213.21698-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202185213.21698-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/irqchip/irq-atmel-aic5.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 2a624d87a035..e4eb594bf4ef 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -31,6 +31,7 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
+#include <linux/platform_data/atmel.h>
 #include "irq-atmel-aic-common.h"
 
 /* Number of irq lines managed by AIC */
@@ -150,6 +151,8 @@ static int aic5_set_type(struct irq_data *d, unsigned type)
 }
 
 #ifdef CONFIG_PM
+u32 smr_cache[128];
+
 static void aic5_suspend(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
@@ -159,13 +162,18 @@ static void aic5_suspend(struct irq_data *d)
 	int i;
 	u32 mask;
 
+	for (i = 0; i < domain->revmap_size; i++) {
+		irq_reg_writel(bgc, i, AT91_AIC5_SSR);
+		smr_cache[i] = irq_reg_readl(bgc, AT91_AIC5_SMR);
+	}
+
 	irq_gc_lock(bgc);
 	for (i = 0; i < dgc->irqs_per_chip; i++) {
 		mask = 1 << i;
 		if ((mask & gc->mask_cache) == (mask & gc->wake_active))
 			continue;
 
-		irq_reg_writel(bgc, i + gc->irq_base, AT91_AIC5_SSR);
+		irq_reg_writel(gc, i + gc->irq_base, AT91_AIC5_SSR);
 		if (mask & gc->wake_active)
 			irq_reg_writel(bgc, 1, AT91_AIC5_IECR);
 		else
@@ -184,10 +192,21 @@ static void aic5_resume(struct irq_data *d)
 	u32 mask;
 
 	irq_gc_lock(bgc);
+
+	irq_reg_writel(bgc, 0xffffffff, AT91_AIC5_SPU);
+	for (i = 0; i < domain->revmap_size; i++) {
+		irq_reg_writel(bgc, i, AT91_AIC5_SSR);
+		irq_reg_writel(bgc, i, AT91_AIC5_SVR);
+		irq_reg_writel(bgc, smr_cache[i], AT91_AIC5_SMR);
+	}
+
+
 	for (i = 0; i < dgc->irqs_per_chip; i++) {
 		mask = 1 << i;
+#if 0
 		if ((mask & gc->mask_cache) == (mask & gc->wake_active))
 			continue;
+#endif
 
 		irq_reg_writel(bgc, i + gc->irq_base, AT91_AIC5_SSR);
 		if (mask & gc->mask_cache)
@@ -195,6 +214,7 @@ static void aic5_resume(struct irq_data *d)
 		else
 			irq_reg_writel(bgc, 1, AT91_AIC5_IDCR);
 	}
+
 	irq_gc_unlock(bgc);
 }
 
-- 
2.11.0
