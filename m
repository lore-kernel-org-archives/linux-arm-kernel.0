From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 21:09:47 +0100
Subject: [PATCH 4/6] i2c/pxa2xx: add support for shared IRQ handler
In-Reply-To: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de>
References: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1291320589-31570-5-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sodaville has three of them on a single IRQ. IRQF_DISABLED is removed
because it is a NOP allready and scheduled for removal.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 32982fb..7c724b2 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -943,11 +943,17 @@ static void i2c_pxa_irq_rxfull(struct pxa_i2c *i2c, u32 isr)
 	writel(icr, _ICR(i2c));
 }
 
+#define VALID_INT_SOURCE	(ISR_SSD | ISR_ALD | ISR_ITE | ISR_IRF | \
+				ISR_SAD | ISR_BED)
 static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id)
 {
 	struct pxa_i2c *i2c = dev_id;
 	u32 isr = readl(_ISR(i2c));
 
+	isr &= VALID_INT_SOURCE;
+	if (!isr)
+		return IRQ_NONE;
+
 	if (i2c_debug > 2 && 0) {
 		dev_dbg(&i2c->adap.dev, "%s: ISR=%08x, ICR=%08x, IBMR=%02x\n",
 			__func__, isr, readl(_ICR(i2c)), readl(_IBMR(i2c)));
@@ -962,7 +968,7 @@ static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id)
 	/*
 	 * Always clear all pending IRQs.
 	 */
-	writel(isr & (ISR_SSD|ISR_ALD|ISR_ITE|ISR_IRF|ISR_SAD|ISR_BED), _ISR(i2c));
+	writel(isr, _ISR(i2c));
 
 	if (isr & ISR_SAD)
 		i2c_pxa_slave_start(i2c, isr);
@@ -1100,7 +1106,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
 	} else {
 		i2c->adap.algo = &i2c_pxa_algorithm;
-		ret = request_irq(irq, i2c_pxa_handler, IRQF_DISABLED,
+		ret = request_irq(irq, i2c_pxa_handler, IRQF_SHARED,
 				  i2c->adap.name, i2c);
 		if (ret)
 			goto ereqirq;
-- 
1.7.3.2
