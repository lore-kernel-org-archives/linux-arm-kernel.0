From: balbi@ti.com (Felipe Balbi)
Date: Mon, 2 Dec 2013 21:42:57 -0600
Subject: [PATCH v2 04/15] mfd: menelaus: Remove unnecessary loop
In-Reply-To: <1386042188-12246-1-git-send-email-balbi@ti.com>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
Message-ID: <1386042188-12246-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we can let irqs refire and give the scheduler
a chance to choose when we should be scheduled.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/menelaus.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 11d7d81..11dc4d3 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -795,30 +795,25 @@ static irqreturn_t menelaus_irq(int irq, void *_menelaus)
 {
 	struct menelaus_chip *menelaus = _menelaus;
 	void (*handler)(struct menelaus_chip *menelaus);
-
-	while (1) {
-		unsigned isr;
-
-		isr = (menelaus_read_reg(MENELAUS_INT_STATUS2)
-				& ~menelaus->mask2) << 8;
-		isr |= menelaus_read_reg(MENELAUS_INT_STATUS1)
-				& ~menelaus->mask1;
-		if (!isr)
-			break;
-
-		while (isr) {
-			int irq = fls(isr) - 1;
-			isr &= ~(1 << irq);
-
-			mutex_lock(&menelaus->lock);
-			menelaus_disable_irq(irq);
-			menelaus_ack_irq(irq);
-			handler = menelaus->handlers[irq];
-			if (handler)
-				handler(menelaus);
-			menelaus_enable_irq(irq);
-			mutex_unlock(&menelaus->lock);
-		}
+	unsigned isr;
+
+	isr = (menelaus_read_reg(MENELAUS_INT_STATUS2)
+			& ~menelaus->mask2) << 8;
+	isr |= menelaus_read_reg(MENELAUS_INT_STATUS1)
+		& ~menelaus->mask1;
+
+	while (isr) {
+		int irq = fls(isr) - 1;
+		isr &= ~(1 << irq);
+
+		mutex_lock(&menelaus->lock);
+		menelaus_disable_irq(irq);
+		menelaus_ack_irq(irq);
+		handler = menelaus->handlers[irq];
+		if (handler)
+			handler(menelaus);
+		menelaus_enable_irq(irq);
+		mutex_unlock(&menelaus->lock);
 	}
 
 	return IRQ_HANDLED;
-- 
1.8.4.GIT
