From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 21 Mar 2013 17:05:36 +0100 (CET)
Subject: [PATCH 1/3] ARM: shmobile: irqpin: fix handling of spurious interrupts
 in DT case
In-Reply-To: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
References: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
Message-ID: <Pine.LNX.4.64.1303211703490.32438@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To disable spurious interrupts, that get triggered on certain hardware, the
irqpin driver masks them on the parent interrupt controller. To specify
such broken devices a .control_parent parameter can be provided in the
platform data. In the DT case we need a property, to do the same. However,
this is not enough to correctly handle spurious interrupts in the DT case.
In the non-DT case all interrupts get mapped statically during probing,
therefore, if a spurious interrupt arrives, it can easily be mapped back
to hardware registers and bits and handled. In the DT case interrupts are
mapped only when a device, using that interrupt is instantiated from DT.
So, spurious interrupts occur unmapped and thus cannot be handled properly.
This patch fixes this by mapping such interrupts as they occur.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 .../interrupt-controller/renesas,intc-irqpin.txt   |   13 +++++++++++++
 drivers/irqchip/irq-renesas-intc-irqpin.c          |   13 +++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
new file mode 100644
index 0000000..e55d183
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
@@ -0,0 +1,13 @@
+DT bindings for the R-/SH-Mobile irqpin controller
+
+Required properties:
+
+- compatible: has to be "renesas,intc-irqpin"
+- #interrupt-cells: has to be <2>
+
+Optional properties:
+
+- any properties, listed in interrupts.txt in this directory, and any standard
+  resource allocation properties
+- control-parent: disable and enable interrupts on the parent interrupt
+  controller, needed for some broken implementations
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index fd5dabc..82bbe8f 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
@@ -70,6 +71,7 @@ struct intc_irqpin_priv {
 	struct intc_irqpin_iomem iomem[INTC_IRQPIN_REG_NR];
 	struct intc_irqpin_irq irq[INTC_IRQPIN_MAX];
 	struct renesas_intc_irqpin_config config;
+	unsigned int min_irq;
 	unsigned int number_of_irqs;
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
@@ -249,6 +251,10 @@ static irqreturn_t intc_irqpin_irq_handler(int irq, void *dev_id)
 	struct intc_irqpin_priv *p = i->p;
 	unsigned long bit;
 
+	if (!i->domain_irq)
+		/* unmapped: spurious IRQ, map it now */
+		irq_create_mapping(p->irq_domain, irq - p->min_irq);
+
 	intc_irqpin_dbg(i, "demux1");
 	bit = intc_irqpin_hwirq_mask(p, INTC_IRQPIN_REG_SOURCE, i->hw_irq);
 
@@ -321,6 +327,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		}
 	}
 
+	p->min_irq = INT_MAX;
 	/* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
 	for (k = 0; k < INTC_IRQPIN_MAX; k++) {
 		irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
@@ -329,6 +336,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 
 		p->irq[k].p = p;
 		p->irq[k].requested_irq = irq->start;
+		if (p->min_irq > irq->start)
+			p->min_irq = irq->start;
 	}
 
 	p->number_of_irqs = k;
@@ -372,6 +381,10 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	for (k = 0; k < p->number_of_irqs; k++)
 		intc_irqpin_mask_unmask_prio(p, k, 1);
 
+	if (!pdata)
+		p->config.control_parent = of_property_read_bool(pdev->dev.of_node,
+								 "control-parent");
+
 	/* use more severe masking method if requested */
 	if (p->config.control_parent) {
 		enable_fn = intc_irqpin_irq_enable_force;
-- 
1.7.2.5
