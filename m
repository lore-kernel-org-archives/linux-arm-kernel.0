From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:35:12 +0000
Subject: [PATCH 12/17] ARM: sa11x0: neponset: get parent IRQ from neponset
 device resource
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOue-0001CK-6m@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Obtain the parent IRQ from the neponset device resource rather than
hard-coding it into the code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 4768196..f4d5871 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -207,7 +207,11 @@ static int __devinit neponset_probe(struct platform_device *dev)
 		.res = smc91x_resources,
 		.num_res = ARRAY_SIZE(smc91x_resources),
 	};
-	int ret;
+	int ret, irq;
+
+	irq = ret = platform_get_irq(dev, 0);
+	if (ret < 0)
+		goto err_alloc;
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d) {
@@ -234,16 +238,16 @@ static int __devinit neponset_probe(struct platform_device *dev)
 	set_irq_flags(d->irq_base + NEP_IRQ_USAR, IRQF_VALID | IRQF_PROBE);
 	irq_set_chip(d->irq_base + NEP_IRQ_SA1111, &nochip);
 
-	irq_set_irq_type(IRQ_GPIO25, IRQ_TYPE_EDGE_RISING);
-	irq_set_handler_data(IRQ_GPIO25, d);
-	irq_set_chained_handler(IRQ_GPIO25, neponset_irq_handler);
+	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
+	irq_set_handler_data(irq, d);
+	irq_set_chained_handler(irq, neponset_irq_handler);
 
 	/*
 	 * We would set IRQ_GPIO25 to be a wake-up IRQ, but unfortunately
 	 * something on the Neponset activates this IRQ on sleep (eth?)
 	 */
 #if 0
-	enable_irq_wake(IRQ_GPIO25);
+	enable_irq_wake(irq);
 #endif
 
 	dev_info(&dev->dev, "Neponset daughter board, providing IRQ%u-%u\n",
@@ -275,12 +279,13 @@ static int __devinit neponset_probe(struct platform_device *dev)
 static int __devexit neponset_remove(struct platform_device *dev)
 {
 	struct neponset_drvdata *d = platform_get_drvdata(dev);
+	int irq = platform_get_irq(dev, 0);
 
 	if (!IS_ERR(d->sa1111))
 		platform_device_unregister(d->sa1111);
 	if (!IS_ERR(d->smc91x))
 		platform_device_unregister(d->smc91x);
-	irq_set_chained_handler(IRQ_GPIO25, NULL);
+	irq_set_chained_handler(irq, NULL);
 	irq_free_descs(d->irq_base, NEP_IRQ_NR);
 	kfree(d);
 
@@ -325,7 +330,8 @@ static struct platform_driver neponset_device_driver = {
 };
 
 static struct resource neponset_resources[] = {
-	[0] = DEFINE_RES_MEM(0x10000000, 0x08000000),
+	DEFINE_RES_MEM(0x10000000, 0x08000000),
+	DEFINE_RES_IRQ(IRQ_GPIO25),
 };
 
 static struct platform_device neponset_device = {
-- 
1.7.4.4
