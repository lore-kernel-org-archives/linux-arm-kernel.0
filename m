From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 3 Jun 2014 13:13:02 +0530
Subject: [PATCH 10/14] irqchip: crossbar: Add kerneldoc for
 crossbar_domain_unmap callback
In-Reply-To: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
References: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1401781386-4982-11-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The crossbar_domain_map/unmap callbacks need not be called same number
of times for a particular irq. But still use counting is not needed
here, because unmap(irq) gets called when irq_desc(irq) is disposed.
After this the irq is anyways unusable and have to mapped again.

Adding the above kerneldoc for unmap callback clarity.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-crossbar.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 5f3e75a..2a73a66 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -101,6 +101,16 @@ static int crossbar_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+/**
+ * crossbar_domain_unmap - unmap a crossbar<->irq connection
+ * @d: domain of irq to unmap
+ * @irq: virq number
+ *
+ * The map/unmap callbacks need not be called same number of times for
+ * a particular irq. But still use counting is not needed here, because
+ * unmap(irq) gets called when irq_desc(irq) is disposed. After this the
+ * irq is anyways unusuable and have to be mapped again.
+ */
 static void crossbar_domain_unmap(struct irq_domain *d, unsigned int irq)
 {
 	irq_hw_number_t hw = irq_get_irq_data(irq)->hwirq;
-- 
1.7.9.5
