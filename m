From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 15:00:49 +0100
Subject: [PATCH v3 3/9] gpio: mvebu: convert to usage of *pmask_cache within
 irq_chip_type
In-Reply-To: <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1363615255-18200-4-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have now introduced pmask_cache within irq_chip_type to also
handle per-chip-type mask registers, convert gpio-mvebu driver to use
this new pointer.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 drivers/gpio/gpio-mvebu.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 456663c..81384f4 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -302,48 +302,52 @@ static void mvebu_gpio_irq_ack(struct irq_data *d)
 static void mvebu_gpio_edge_irq_mask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache &= ~mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_edge_mask(mvchip));
+	*ct->pmask_cache &= ~mask;
+	writel_relaxed(*ct->pmask_cache, mvebu_gpioreg_edge_mask(mvchip));
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
+	*ct->pmask_cache |= mask;
+	writel_relaxed(*ct->pmask_cache, mvebu_gpioreg_edge_mask(mvchip));
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
+	*ct->pmask_cache &= ~mask;
+	writel_relaxed(*ct->pmask_cache, mvebu_gpioreg_level_mask(mvchip));
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
+	*ct->pmask_cache |= mask;
+	writel_relaxed(*ct->pmask_cache, mvebu_gpioreg_level_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
-- 
1.7.10.1
