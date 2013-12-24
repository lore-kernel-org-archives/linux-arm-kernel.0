From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:06:02 +0900
Subject: [PATCH 3/3] irq-renesas-irqc: simplify irq_set_type() method
In-Reply-To: <cover.1387855444.git.horms+renesas@verge.net.au>
References: <cover.1387855444.git.horms+renesas@verge.net.au>
Message-ID: <ce70af18801fd8dac6e9f85308294948916e84d6.1387855444.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Value 0 of the sense  selection field of CONFIG_n register means "disable event
detection" and serves in irqc_sense[] for marking the invalid values of the IRQ
type (by just omitting initializers). There is no need for INTC_IRQ_SENSE_VALID
and hence INTC_IRQ_SENSE() as all field values matching to the  valid IRQ types
are non-zero anyway.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-irqc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 082d95c..8777065 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -81,15 +81,12 @@ static void irqc_irq_disable(struct irq_data *d)
 	iowrite32(BIT(hw_irq), p->cpu_int_base + IRQC_EN_STS);
 }
 
-#define INTC_IRQ_SENSE_VALID 0x10
-#define INTC_IRQ_SENSE(x) (x + INTC_IRQ_SENSE_VALID)
-
 static unsigned char irqc_sense[IRQ_TYPE_SENSE_MASK + 1] = {
-	[IRQ_TYPE_LEVEL_LOW] = INTC_IRQ_SENSE(0x01),
-	[IRQ_TYPE_LEVEL_HIGH] = INTC_IRQ_SENSE(0x02),
-	[IRQ_TYPE_EDGE_FALLING] = INTC_IRQ_SENSE(0x04), /* Synchronous */
-	[IRQ_TYPE_EDGE_RISING] = INTC_IRQ_SENSE(0x08), /* Synchronous */
-	[IRQ_TYPE_EDGE_BOTH] = INTC_IRQ_SENSE(0x0c),  /* Synchronous */
+	[IRQ_TYPE_LEVEL_LOW]	= 0x01,
+	[IRQ_TYPE_LEVEL_HIGH]	= 0x02,
+	[IRQ_TYPE_EDGE_FALLING]	= 0x04,	/* Synchronous */
+	[IRQ_TYPE_EDGE_RISING]	= 0x08,	/* Synchronous */
+	[IRQ_TYPE_EDGE_BOTH]	= 0x0c,	/* Synchronous */
 };
 
 static int irqc_irq_set_type(struct irq_data *d, unsigned int type)
@@ -101,12 +98,12 @@ static int irqc_irq_set_type(struct irq_data *d, unsigned int type)
 
 	irqc_dbg(&p->irq[hw_irq], "sense");
 
-	if (!(value & INTC_IRQ_SENSE_VALID))
+	if (!value)
 		return -EINVAL;
 
 	tmp = ioread32(p->iomem + IRQC_CONFIG(hw_irq));
 	tmp &= ~0x3f;
-	tmp |= value ^ INTC_IRQ_SENSE_VALID;
+	tmp |= value;
 	iowrite32(tmp, p->iomem + IRQC_CONFIG(hw_irq));
 	return 0;
 }
-- 
1.8.4
