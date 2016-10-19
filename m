From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 19 Oct 2016 15:03:41 -0600
Subject: [PATCH] Revert "gpio/mvebu: convert to use
 irq_domain_add_simple()"
In-Reply-To: <871szcerxl.fsf@free-electrons.com>
References: <1476831396-24359-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <871szcerxl.fsf@free-electrons.com>
Message-ID: <20161019210341.GA3746@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 09:09:10AM +0200, Gregory CLEMENT wrote:
>  On mer., oct. 19 2016, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> 
> > This reverts commit ce931f571b6dcf8534e8740e8cd16565cf362536.
> >
> > The only difference betwen _simple and _legacy is that _simple
> > calls irq_alloc_descs, however mvebu_gpio_probe already called
> > irq_alloc_descs a few lines above.
> 
> And what about removing the irq_alloc_descs ?

I didn't think I had a test system for that complex work, but it turns
out I do..

> Going back to use the _legacy version seems wrong for me.

Both _legacy and _simple are described as deprecated, and using
_simple is clearly the wrong choice for this driver, so I can't see
how it is 'wrong' to go back.

But it is legit to ask if the driver can be converted to use the
modern style for setting up irq domains, so here is a patch that does
that instead.

I was only able to test LEVEL interrupts, but I think both kinds
should be OK.

>From 7566f05ac445b652ba7607cc1899fed10fea1c76 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Wed, 19 Oct 2016 14:57:45 -0600
Subject: [PATCH] gpio/mvebu: Use irq_domain_add_linear

This fixes the irq allocation in this driver to not print:
 irq: Cannot allocate irq_descs @ IRQ34, assuming pre-allocated
 irq: Cannot allocate irq_descs @ IRQ66, assuming pre-allocated

Which happens because the driver already called irq_alloc_descs()
and so the change to use irq_domain_add_simple resulted in calling
irq_alloc_descs() twice.

Modernize the irq allocation in this driver to use the
irq_domain_add_linear flow directly and eliminate the use of
irq_domain_add_simple/legacy

Fixes: ce931f571b6d ("gpio/mvebu: convert to use irq_domain_add_simple()")
Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/gpio/gpio-mvebu.c | 92 ++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index cd5dc27320a2..1ed6132b993c 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -293,10 +293,10 @@ static void mvebu_gpio_irq_ack(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
-	u32 mask = ~(1 << (d->irq - gc->irq_base));
+	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
-	writel_relaxed(mask, mvebu_gpioreg_edge_cause(mvchip));
+	writel_relaxed(~mask, mvebu_gpioreg_edge_cause(mvchip));
 	irq_gc_unlock(gc);
 }
 
@@ -305,7 +305,7 @@ static void mvebu_gpio_edge_irq_mask(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
-	u32 mask = 1 << (d->irq - gc->irq_base);
+	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
 	ct->mask_cache_priv &= ~mask;
@@ -319,8 +319,7 @@ static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
-
-	u32 mask = 1 << (d->irq - gc->irq_base);
+	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
 	ct->mask_cache_priv |= mask;
@@ -333,8 +332,7 @@ static void mvebu_gpio_level_irq_mask(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
-
-	u32 mask = 1 << (d->irq - gc->irq_base);
+	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
 	ct->mask_cache_priv &= ~mask;
@@ -347,8 +345,7 @@ static void mvebu_gpio_level_irq_unmask(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
-
-	u32 mask = 1 << (d->irq - gc->irq_base);
+	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
 	ct->mask_cache_priv |= mask;
@@ -462,7 +459,7 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
 	for (i = 0; i < mvchip->chip.ngpio; i++) {
 		int irq;
 
-		irq = mvchip->irqbase + i;
+		irq = irq_find_mapping(mvchip->domain, i);
 
 		if (!(cause & (1 << i)))
 			continue;
@@ -655,6 +652,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	struct irq_chip_type *ct;
 	struct clk *clk;
 	unsigned int ngpios;
+	bool have_irqs;
 	int soc_variant;
 	int i, cpu, id;
 	int err;
@@ -665,6 +663,9 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	else
 		soc_variant = MVEBU_GPIO_SOC_VARIANT_ORION;
 
+	/* Some gpio controllers do not provide irq support */
+	have_irqs = of_irq_count(np) != 0;
+
 	mvchip = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_gpio_chip),
 			      GFP_KERNEL);
 	if (!mvchip)
@@ -697,7 +698,8 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.get = mvebu_gpio_get;
 	mvchip->chip.direction_output = mvebu_gpio_direction_output;
 	mvchip->chip.set = mvebu_gpio_set;
-	mvchip->chip.to_irq = mvebu_gpio_to_irq;
+	if (have_irqs)
+		mvchip->chip.to_irq = mvebu_gpio_to_irq;
 	mvchip->chip.base = id * MVEBU_MAX_GPIO_PER_BANK;
 	mvchip->chip.ngpio = ngpios;
 	mvchip->chip.can_sleep = false;
@@ -758,34 +760,30 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
 
 	/* Some gpio controllers do not provide irq support */
-	if (!of_irq_count(np))
+	if (!have_irqs)
 		return 0;
 
-	/* Setup the interrupt handlers. Each chip can have up to 4
-	 * interrupt handlers, with each handler dealing with 8 GPIO
-	 * pins. */
-	for (i = 0; i < 4; i++) {
-		int irq = platform_get_irq(pdev, i);
-
-		if (irq < 0)
-			continue;
-		irq_set_chained_handler_and_data(irq, mvebu_gpio_irq_handler,
-						 mvchip);
-	}
-
-	mvchip->irqbase = irq_alloc_descs(-1, 0, ngpios, -1);
-	if (mvchip->irqbase < 0) {
-		dev_err(&pdev->dev, "no irqs\n");
-		return mvchip->irqbase;
+	mvchip->domain =
+	    irq_domain_add_linear(np, ngpios, &irq_generic_chip_ops, NULL);
+	if (!mvchip->domain) {
+		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
+			mvchip->chip.label);
+		return -ENODEV;
 	}
 
-	gc = irq_alloc_generic_chip("mvebu_gpio_irq", 2, mvchip->irqbase,
-				    mvchip->membase, handle_level_irq);
-	if (!gc) {
-		dev_err(&pdev->dev, "Cannot allocate generic irq_chip\n");
-		return -ENOMEM;
+	err = irq_alloc_domain_generic_chips(
+	    mvchip->domain, ngpios, 2, np->name, handle_level_irq,
+	    IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_LEVEL, 0, 0);
+	if (err) {
+		dev_err(&pdev->dev, "couldn't allocate irq chips %s (DT).\n",
+			mvchip->chip.label);
+		goto err_domain;
 	}
 
+	/* NOTE: The common accessors cannot be used because of the percpu
+	 * access to the mask registers
+	 */
+	gc = irq_get_domain_generic_chip(mvchip->domain, 0);
 	gc->private = mvchip;
 	ct = &gc->chip_types[0];
 	ct->type = IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW;
@@ -803,27 +801,23 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	ct->handler = handle_edge_irq;
 	ct->chip.name = mvchip->chip.label;
 
-	irq_setup_generic_chip(gc, IRQ_MSK(ngpios), 0,
-			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
+	/* Setup the interrupt handlers. Each chip can have up to 4
+	 * interrupt handlers, with each handler dealing with 8 GPIO
+	 * pins.
+	 */
+	for (i = 0; i < 4; i++) {
+		int irq = platform_get_irq(pdev, i);
 
-	/* Setup irq domain on top of the generic chip. */
-	mvchip->domain = irq_domain_add_simple(np, mvchip->chip.ngpio,
-					       mvchip->irqbase,
-					       &irq_domain_simple_ops,
-					       mvchip);
-	if (!mvchip->domain) {
-		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
-			mvchip->chip.label);
-		err = -ENODEV;
-		goto err_generic_chip;
+		if (irq < 0)
+			continue;
+		irq_set_chained_handler_and_data(irq, mvebu_gpio_irq_handler,
+						 mvchip);
 	}
 
 	return 0;
 
-err_generic_chip:
-	irq_remove_generic_chip(gc, IRQ_MSK(ngpios), IRQ_NOREQUEST,
-				IRQ_LEVEL | IRQ_NOPROBE);
-	kfree(gc);
+err_domain:
+	irq_domain_remove(mvchip->domain);
 
 	return err;
 }
-- 
2.1.4
