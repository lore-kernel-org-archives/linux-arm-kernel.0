From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 24 May 2013 11:13:07 +0200 (CEST)
Subject: [PATCH 2/2] ARM: shmobile: irqpin: map spurious interrupts in DT case
In-Reply-To: <Pine.LNX.4.64.1305241109530.1090@axis700.grange>
References: <Pine.LNX.4.64.1305241109530.1090@axis700.grange>
Message-ID: <Pine.LNX.4.64.1305241112210.1090@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the non-DT case all interrupts get mapped statically during probing,
therefore, if a spurious interrupt arrives, it can easily be mapped back
to hardware registers and bits and handled. In the DT case interrupts are
mapped only when a device, using that interrupt is instantiated from DT.
So, spurious interrupts occur unmapped and thus cannot be handled properly.
This patch fixes this by mapping such interrupts as they occur.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 82cec63..e62d76d 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -71,6 +71,7 @@ struct intc_irqpin_priv {
 	struct intc_irqpin_iomem iomem[INTC_IRQPIN_REG_NR];
 	struct intc_irqpin_irq irq[INTC_IRQPIN_MAX];
 	struct renesas_intc_irqpin_config config;
+	unsigned int min_irq;
 	unsigned int number_of_irqs;
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
@@ -274,6 +275,10 @@ static irqreturn_t intc_irqpin_irq_handler(int irq, void *dev_id)
 	struct intc_irqpin_priv *p = i->p;
 	unsigned long bit;
 
+	if (!i->domain_irq)
+		/* unmapped: spurious IRQ, map it now */
+		irq_create_mapping(p->irq_domain, irq - p->min_irq);
+
 	intc_irqpin_dbg(i, "demux1");
 	bit = intc_irqpin_hwirq_mask(p, INTC_IRQPIN_REG_SOURCE, i->hw_irq);
 
@@ -372,6 +377,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		}
 	}
 
+	p->min_irq = INT_MAX;
 	/* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
 	for (k = 0; k < INTC_IRQPIN_MAX; k++) {
 		irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
@@ -380,6 +386,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 
 		p->irq[k].p = p;
 		p->irq[k].requested_irq = irq->start;
+		if (p->min_irq > irq->start)
+			p->min_irq = irq->start;
 	}
 
 	p->number_of_irqs = k;
-- 
1.7.2.5
