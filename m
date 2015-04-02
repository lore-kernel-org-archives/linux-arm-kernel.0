From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  2 Apr 2015 17:11:11 +0200
Subject: [PATCH] gpio: mvebu: Fix mask/unmask managment per irq chip type
Message-ID: <1427987471-20419-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Level IRQ handlers and edge IRQ handler are managed by tow different
sets of registers. But currently the driver uses the same mask for the
both registers. It lead to issues with the following scenario:

First, an IRQ is requested on a GPIO to be triggered on front. After,
this an other IRQ is requested for a GPIO of the same bank but
triggered on level. Then the first one will be also setup to be
triggered on level. It leads to an interrupt storm.

The different kind of handler are already associated with two
different irq chip type. With this patch the driver uses a private
mask for each one which solves this issue.

It has been tested on an Armada XP based board and on an Armada 375
board. For the both boards, with this patch is applied, there is no
such interrupt storm when running the previous scenario.

This bug was already fixed but in a different way in the legacy
version of this driver by Evgeniy Dushistov:
9ece8839b1277fb9128ff6833411614ab6c88d68 "ARM: orion: Fix for certain
sequence of request_irq can cause irq storm". The fact the new version
of the gpio drive could be affected had been discussed there:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/344670/focus=364012

Reported-by: Evgeniy A. Dushistov <dushistov@mail.ru>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.7 +
---
 drivers/gpio/gpio-mvebu.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index d0bc123c7975..1a54205860f5 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -320,11 +320,13 @@ static void mvebu_gpio_edge_irq_mask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache &= ~mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_edge_mask(mvchip));
+	ct->mask_cache_priv &= ~mask;
+
+	writel_relaxed(ct->mask_cache_priv, mvebu_gpioreg_edge_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
@@ -332,11 +334,13 @@ static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache |= mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_edge_mask(mvchip));
+	ct->mask_cache_priv |= mask;
+	writel_relaxed(ct->mask_cache_priv, mvebu_gpioreg_edge_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
@@ -344,11 +348,13 @@ static void mvebu_gpio_level_irq_mask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache &= ~mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_level_mask(mvchip));
+	ct->mask_cache_priv &= ~mask;
+	writel_relaxed(ct->mask_cache_priv, mvebu_gpioreg_level_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
@@ -356,11 +362,13 @@ static void mvebu_gpio_level_irq_unmask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache |= mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_level_mask(mvchip));
+	ct->mask_cache_priv |= mask;
+	writel_relaxed(ct->mask_cache_priv, mvebu_gpioreg_level_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
-- 
2.1.0
