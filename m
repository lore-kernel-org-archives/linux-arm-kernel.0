From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Sep 2016 15:53:28 +0200
Subject: [PATCH 2/4] ARM: common/locomo: remove NO_IRQ check
In-Reply-To: <20160906135637.2622666-1-arnd@arndb.de>
References: <20160906135637.2622666-1-arnd@arndb.de>
Message-ID: <20160906135637.2622666-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 489447380a29 ("[PATCH] handle errors returned by
platform_get_irq*()") ten years ago, the locomo driver refuses to
work without an interrupt line passed in its resources, so the
check for NO_IRQ is unnecessary.

We still check the irq_base argument for NO_IRQ, but as both
platforms that use locomo (poodle and collie) provide both
'irq' and 'irq_base', this can be done more consistently
by just checking that both are valid in the probe function
and otherwise returning an error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/common/locomo.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 0e97b4b871f9..81abb04e5254 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -253,8 +253,7 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 		dev->mapbase = 0;
 	dev->length = info->length;
 
-	dev->irq[0] = (lchip->irq_base == NO_IRQ) ?
-			NO_IRQ : lchip->irq_base + info->irq[0];
+	dev->irq[0] = lchip->irq_base + info->irq[0];
 
 	ret = device_register(&dev->dev);
 	if (ret) {
@@ -376,6 +375,9 @@ __locomo_probe(struct device *me, struct resource *mem, int irq)
 	unsigned long r;
 	int i, ret = -ENODEV;
 
+	if (!pdata->irq_base)
+		return ret;
+
 	lchip = kzalloc(sizeof(struct locomo), GFP_KERNEL);
 	if (!lchip)
 		return -ENOMEM;
@@ -387,7 +389,7 @@ __locomo_probe(struct device *me, struct resource *mem, int irq)
 
 	lchip->phys = mem->start;
 	lchip->irq = irq;
-	lchip->irq_base = (pdata) ? pdata->irq_base : NO_IRQ;
+	lchip->irq_base = pdata->irq_base;
 
 	/*
 	 * Map the whole region.  This also maps the
@@ -454,8 +456,7 @@ __locomo_probe(struct device *me, struct resource *mem, int irq)
 	 * The interrupt controller must be initialised before any
 	 * other device to ensure that the interrupts are available.
 	 */
-	if (lchip->irq != NO_IRQ && lchip->irq_base != NO_IRQ)
-		locomo_setup_irq(lchip);
+	locomo_setup_irq(lchip);
 
 	for (i = 0; i < ARRAY_SIZE(locomo_devices); i++)
 		locomo_init_one_child(lchip, &locomo_devices[i]);
@@ -476,9 +477,7 @@ static void __locomo_remove(struct locomo *lchip)
 {
 	device_for_each_child(lchip->dev, NULL, locomo_remove_child);
 
-	if (lchip->irq != NO_IRQ) {
-		irq_set_chained_handler_and_data(lchip->irq, NULL, NULL);
-	}
+	irq_set_chained_handler_and_data(lchip->irq, NULL, NULL);
 
 	iounmap(lchip->base);
 	kfree(lchip);
-- 
2.9.0
