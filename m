From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 21 Sep 2015 15:46:06 +0200
Subject: [PATCH 3/3] irqchip: atmel-aic5: simplify base chip selection
In-Reply-To: <1442843173-2390-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442843173-2390-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442843173-2390-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_get_domain_generic_chip() to select the base chip.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/irqchip/irq-atmel-aic5.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index abff79e..7264ec7 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -70,8 +70,7 @@ static struct irq_domain *aic5_domain;
 static asmlinkage void __exception_irq_entry
 aic5_handle(struct pt_regs *regs)
 {
-	struct irq_domain_chip_generic *dgc = aic5_domain->gc;
-	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(aic5_domain, 0);
 	u32 irqnr;
 	u32 irqstat;
 
@@ -87,8 +86,7 @@ aic5_handle(struct pt_regs *regs)
 static void aic5_mask(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
-	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(domain, 0);
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
 	/* Disable interrupt on AIC5 */
@@ -102,8 +100,7 @@ static void aic5_mask(struct irq_data *d)
 static void aic5_unmask(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
-	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(domain, 0);
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
 	/* Enable interrupt on AIC5 */
@@ -117,8 +114,7 @@ static void aic5_unmask(struct irq_data *d)
 static int aic5_retrigger(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
-	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(domain, 0);
 
 	/* Enable interrupt on AIC5 */
 	irq_gc_lock(bgc);
@@ -132,8 +128,7 @@ static int aic5_retrigger(struct irq_data *d)
 static int aic5_set_type(struct irq_data *d, unsigned type)
 {
 	struct irq_domain *domain = d->domain;
-	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(domain, 0);
 	unsigned int smr;
 	int ret;
 
@@ -153,7 +148,7 @@ static void aic5_suspend(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
 	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(domain, 0);
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	int i;
 	u32 mask;
@@ -177,7 +172,7 @@ static void aic5_resume(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
 	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(domain, 0);
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	int i;
 	u32 mask;
@@ -201,7 +196,7 @@ static void aic5_pm_shutdown(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
 	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(domain, 0);
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	int i;
 
@@ -256,12 +251,11 @@ static int aic5_irq_domain_xlate(struct irq_domain *d,
 				 irq_hw_number_t *out_hwirq,
 				 unsigned int *out_type)
 {
-	struct irq_domain_chip_generic *dgc = d->gc;
-	struct irq_chip_generic *bgc;
+	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(d, 0);
 	unsigned smr;
 	int ret;
 
-	if (!dgc)
+	if (!bgc)
 		return -EINVAL;
 
 	ret = aic_common_irq_domain_xlate(d, ctrlr, intspec, intsize,
@@ -269,8 +263,6 @@ static int aic5_irq_domain_xlate(struct irq_domain *d,
 	if (ret)
 		return ret;
 
-	bgc = dgc->gc[0];
-
 	irq_gc_lock(bgc);
 	irq_reg_writel(bgc, *out_hwirq, AT91_AIC5_SSR);
 	smr = irq_reg_readl(bgc, AT91_AIC5_SMR);
-- 
2.5.0
