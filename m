From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:56:15 +0000
Subject: [PATCH 05/20] ARM: sa1111: finish "allow cascaded IRQs to be used by
 platforms"
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPF1-00043q-6D@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 19851c58e680 (sa1111: allow cascaded IRQs to be used by platforms)
moved the IRQ definitions to the .c file, and added an irq_base member
to the private data structure.

The inerrupt demultiplexer uses irq_base, but the interrupt setup code
does not.  Also, although the commit adds a private data structure to
pass this data, it isn't even referenced, resulting in irq_base being
zero.

We also copied the IRQ numbers from the device info array into the actual
devices, resulting in wrong interrupt numbers passed to the sub-devices.

The net effect of this is that we always overwrite IRQs 0-54, even if
they are allocated elsewhere in the system.

Add the code necessary to setup the private irq_base, and use it in the
IRQ setup code.  Make the SA-1111 probe fail with -EINVAL if there is no
platform data provided.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 957f6e3..d3a8f5e 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -438,7 +438,7 @@ static struct irq_chip sa1111_high_chip = {
 static void sa1111_setup_irq(struct sa1111 *sachip)
 {
 	void __iomem *irqbase = sachip->base + SA1111_INTC;
-	unsigned int irq;
+	unsigned i, irq;
 
 	/*
 	 * We're guaranteed that this region hasn't been taken.
@@ -464,14 +464,16 @@ static void sa1111_setup_irq(struct sa1111 *sachip)
 	sa1111_writel(~0, irqbase + SA1111_INTSTATCLR0);
 	sa1111_writel(~0, irqbase + SA1111_INTSTATCLR1);
 
-	for (irq = IRQ_GPAIN0; irq <= SSPROR; irq++) {
+	for (i = IRQ_GPAIN0; i <= SSPROR; i++) {
+		irq = sachip->irq_base + i;
 		irq_set_chip_and_handler(irq, &sa1111_low_chip,
 					 handle_edge_irq);
 		irq_set_chip_data(irq, sachip);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
 
-	for (irq = AUDXMTDMADONEA; irq <= IRQ_S1_BVD1_STSCHG; irq++) {
+	for (i = AUDXMTDMADONEA; i <= IRQ_S1_BVD1_STSCHG; i++) {
+		irq = sachip->irq_base + i;
 		irq_set_chip_and_handler(irq, &sa1111_high_chip,
 					 handle_edge_irq);
 		irq_set_chip_data(irq, sachip);
@@ -625,6 +627,7 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 		      struct sa1111_dev_info *info)
 {
 	struct sa1111_dev *dev;
+	unsigned i;
 	int ret;
 
 	dev = kzalloc(sizeof(struct sa1111_dev), GFP_KERNEL);
@@ -645,7 +648,9 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 	dev->res.flags   = IORESOURCE_MEM;
 	dev->mapbase     = sachip->base + info->offset;
 	dev->skpcr_mask  = info->skpcr_mask;
-	memmove(dev->irq, info->irq, sizeof(dev->irq));
+
+	for (i = 0; i < ARRAY_SIZE(info->irq); i++)
+		dev->irq[i] = sachip->irq_base + info->irq[i];
 
 	ret = request_resource(parent, &dev->res);
 	if (ret) {
@@ -699,16 +704,21 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
  *	Returns:
  *	%-ENODEV	device not found.
  *	%-EBUSY		physical address already marked in-use.
+ *	%-EINVAL	no platform data passed
  *	%0		successful.
  */
 static int __devinit
 __sa1111_probe(struct device *me, struct resource *mem, int irq)
 {
+	struct sa1111_platform_data *pd = me->platform_data;
 	struct sa1111 *sachip;
 	unsigned long id;
 	unsigned int has_devs;
 	int i, ret = -ENODEV;
 
+	if (!pd)
+		return -EINVAL;
+
 	sachip = kzalloc(sizeof(struct sa1111), GFP_KERNEL);
 	if (!sachip)
 		return -ENOMEM;
@@ -730,6 +740,7 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 
 	sachip->phys = mem->start;
 	sachip->irq = irq;
+	sachip->irq_base = pd->irq_base;
 
 	/*
 	 * Map the whole region.  This also maps the
-- 
1.7.4.4
