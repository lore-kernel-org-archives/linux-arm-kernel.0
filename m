From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:03 +0100
Subject: [PATCH 32/54] ARM: netx: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134103.GG15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-netx/generic.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
index 43da8bb..29ffa75 100644
--- a/arch/arm/mach-netx/generic.c
+++ b/arch/arm/mach-netx/generic.c
@@ -88,13 +88,13 @@ netx_hif_demux_handler(unsigned int irq_unused, struct irq_desc *desc)
 }
 
 static int
-netx_hif_irq_type(unsigned int _irq, unsigned int type)
+netx_hif_irq_type(struct irq_data *d, unsigned int type)
 {
 	unsigned int val, irq;
 
 	val = readl(NETX_DPMAS_IF_CONF1);
 
-	irq = _irq - NETX_IRQ_HIF_CHAINED(0);
+	irq = d->irq - NETX_IRQ_HIF_CHAINED(0);
 
 	if (type & IRQ_TYPE_EDGE_RISING) {
 		DEBUG_IRQ("rising edges\n");
@@ -119,49 +119,49 @@ netx_hif_irq_type(unsigned int _irq, unsigned int type)
 }
 
 static void
-netx_hif_ack_irq(unsigned int _irq)
+netx_hif_ack_irq(struct irq_data *d)
 {
 	unsigned int val, irq;
 
-	irq = _irq - NETX_IRQ_HIF_CHAINED(0);
+	irq = d->irq - NETX_IRQ_HIF_CHAINED(0);
 	writel((1 << 24) << irq, NETX_DPMAS_INT_STAT);
 
 	val = readl(NETX_DPMAS_INT_EN);
 	val &= ~((1 << 24) << irq);
 	writel(val, NETX_DPMAS_INT_EN);
 
-	DEBUG_IRQ("%s: irq %d\n", __func__, _irq);
+	DEBUG_IRQ("%s: irq %d\n", __func__, d->irq);
 }
 
 static void
-netx_hif_mask_irq(unsigned int _irq)
+netx_hif_mask_irq(struct irq_data *d)
 {
 	unsigned int val, irq;
 
-	irq = _irq - NETX_IRQ_HIF_CHAINED(0);
+	irq = d->irq - NETX_IRQ_HIF_CHAINED(0);
 	val = readl(NETX_DPMAS_INT_EN);
 	val &= ~((1 << 24) << irq);
 	writel(val, NETX_DPMAS_INT_EN);
-	DEBUG_IRQ("%s: irq %d\n", __func__, _irq);
+	DEBUG_IRQ("%s: irq %d\n", __func__, d->irq);
 }
 
 static void
-netx_hif_unmask_irq(unsigned int _irq)
+netx_hif_unmask_irq(struct irq_data *d)
 {
 	unsigned int val, irq;
 
-	irq = _irq - NETX_IRQ_HIF_CHAINED(0);
+	irq = d->irq - NETX_IRQ_HIF_CHAINED(0);
 	val = readl(NETX_DPMAS_INT_EN);
 	val |= (1 << 24) << irq;
 	writel(val, NETX_DPMAS_INT_EN);
-	DEBUG_IRQ("%s: irq %d\n", __func__, _irq);
+	DEBUG_IRQ("%s: irq %d\n", __func__, d->irq);
 }
 
 static struct irq_chip netx_hif_chip = {
-	.ack = netx_hif_ack_irq,
-	.mask = netx_hif_mask_irq,
-	.unmask = netx_hif_unmask_irq,
-	.set_type = netx_hif_irq_type,
+	.irq_ack = netx_hif_ack_irq,
+	.irq_mask = netx_hif_mask_irq,
+	.irq_unmask = netx_hif_unmask_irq,
+	.irq_set_type = netx_hif_irq_type,
 };
 
 void __init netx_init_irq(void)
-- 
1.7.1
