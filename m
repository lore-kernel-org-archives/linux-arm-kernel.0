From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 13 Mar 2011 15:53:29 +0200
Subject: [PATCH 2/2] i2c-pxa2xx: Don't clear isr bits too early
In-Reply-To: <1300024409-32587-1-git-send-email-anarsoul@gmail.com>
References: <1300024409-32587-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1300024409-32587-2-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

isr is passed later into i2c_pxa_irq_txempty and
i2c_pxa_irq_rxfull and they may use some other bits
than irq sources.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 312d369..cab529d 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -966,8 +966,7 @@ static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id)
 	struct pxa_i2c *i2c = dev_id;
 	u32 isr = readl(_ISR(i2c));
 
-	isr &= VALID_INT_SOURCE;
-	if (!isr)
+	if (!(isr & VALID_INT_SOURCE))
 		return IRQ_NONE;
 
 	if (i2c_debug > 2 && 0) {
@@ -984,7 +983,7 @@ static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id)
 	/*
 	 * Always clear all pending IRQs.
 	 */
-	writel(isr, _ISR(i2c));
+	writel(isr & VALID_INT_SOURCE, _ISR(i2c));
 
 	if (isr & ISR_SAD)
 		i2c_pxa_slave_start(i2c, isr);
-- 
1.7.4.1
