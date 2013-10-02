From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed,  2 Oct 2013 14:34:19 +0200
Subject: [PATCH 1/1] gpio: mvebu: enable and use IRQ_GC_MASK_CACHE_PER_TYPE
In-Reply-To: <1380717118-10860-1-git-send-email-gerlando.falauto@keymile.com>
References: <1380717118-10860-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1380717259-11060-1-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have now introduced mask_cache within irq_chip_type to also
handle per-chip-type mask registers, convert gpio-mvebu driver to use
this new pointer.

Also enable IRQ_GC_MASK_CACHE_PER_TYPE to actually handle separate mask
registers for all three SoC variants handled by this driver.

This wll fix a bug where requesting (and triggering) both EDGE- and
LEVEL- based IRQs causes the kernel to hang.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: Simon Guinot <sguinot@lacie.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/gpio/gpio-mvebu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 3a4816a..ce425b3 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -303,48 +303,52 @@ static void mvebu_gpio_irq_ack(struct irq_data *d)
 static void mvebu_gpio_edge_irq_mask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache &= ~mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_edge_mask(mvchip));
+	*ct->mask_cache &= ~mask;
+	writel_relaxed(*ct->mask_cache, mvebu_gpioreg_edge_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache |= mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_edge_mask(mvchip));
+	*ct->mask_cache |= mask;
+	writel_relaxed(*ct->mask_cache, mvebu_gpioreg_edge_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_level_irq_mask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache &= ~mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_level_mask(mvchip));
+	*ct->mask_cache &= ~mask;
+	writel_relaxed(*ct->mask_cache, mvebu_gpioreg_level_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_level_irq_unmask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache |= mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_level_mask(mvchip));
+	*ct->mask_cache |= mask;
+	writel_relaxed(*ct->mask_cache, mvebu_gpioreg_level_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
@@ -708,7 +712,8 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	ct->handler = handle_edge_irq;
 	ct->chip.name = mvchip->chip.label;
 
-	irq_setup_generic_chip(gc, IRQ_MSK(ngpios), 0,
+	irq_setup_generic_chip(gc, IRQ_MSK(ngpios),
+			       IRQ_GC_MASK_CACHE_PER_TYPE,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 
 	/* Setup irq domain on top of the generic chip. */
-- 
1.8.0.1
