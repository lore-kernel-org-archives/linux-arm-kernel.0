From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 2 Mar 2012 17:50:18 +0100
Subject: [PATCH 06/12] mfd: twl4030-irq: micro-optimization on IRQ handler
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Message-ID: <1330707024-23730-7-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

__ffs() will be far faster than the for loop used.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/twl4030-irq.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index faf3318..e6dc8f9 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -293,7 +293,6 @@ static unsigned twl4030_irq_base;
  */
 static irqreturn_t handle_twl4030_pih(int irq, void *devid)
 {
-	int		module_irq;
 	irqreturn_t	ret;
 	u8		pih_isr;
 
@@ -304,12 +303,13 @@ static irqreturn_t handle_twl4030_pih(int irq, void *devid)
 		return IRQ_NONE;
 	}
 
-	/* these handlers deal with the relevant SIH irq status */
-	for (module_irq = twl4030_irq_base;
-			pih_isr;
-			pih_isr >>= 1, module_irq++) {
-		if (pih_isr & 0x1)
-			handle_nested_irq(module_irq);
+	while (pih_isr) {
+		unsigned long	pending = __ffs(pih_isr);
+		unsigned int	irq;
+
+		pih_isr &= ~BIT(pending);
+		irq = pending + twl4030_irq_base;
+		handle_nested_irq(irq);
 	}
 
 	return IRQ_HANDLED;
-- 
1.7.0.4
