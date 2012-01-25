From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:31:05 +0000
Subject: [PATCH 03/33] MFD: mcp-core: fix complaints from the genirq layer
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3sP-0000Xj-Ql@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The genirq layer complains if an interrupt handler returns with
interrupts enabled.  The UCB1x00 handler does just this, because
ucb1x00_enable() calls mcp_enable(), which uses spin_lock_irq()
rather than spin_lock_irqsave().  Convert this, and the divisor
setting functions to use spin_lock_irqsave().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/mcp-core.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 84815f9..86cc3f7 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -93,9 +93,11 @@ static struct bus_type mcp_bus_type = {
  */
 void mcp_set_telecom_divisor(struct mcp *mcp, unsigned int div)
 {
-	spin_lock_irq(&mcp->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcp->lock, flags);
 	mcp->ops->set_telecom_divisor(mcp, div);
-	spin_unlock_irq(&mcp->lock);
+	spin_unlock_irqrestore(&mcp->lock, flags);
 }
 EXPORT_SYMBOL(mcp_set_telecom_divisor);
 
@@ -108,9 +110,11 @@ EXPORT_SYMBOL(mcp_set_telecom_divisor);
  */
 void mcp_set_audio_divisor(struct mcp *mcp, unsigned int div)
 {
-	spin_lock_irq(&mcp->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcp->lock, flags);
 	mcp->ops->set_audio_divisor(mcp, div);
-	spin_unlock_irq(&mcp->lock);
+	spin_unlock_irqrestore(&mcp->lock, flags);
 }
 EXPORT_SYMBOL(mcp_set_audio_divisor);
 
@@ -163,10 +167,11 @@ EXPORT_SYMBOL(mcp_reg_read);
  */
 void mcp_enable(struct mcp *mcp)
 {
-	spin_lock_irq(&mcp->lock);
+	unsigned long flags;
+	spin_lock_irqsave(&mcp->lock, flags);
 	if (mcp->use_count++ == 0)
 		mcp->ops->enable(mcp);
-	spin_unlock_irq(&mcp->lock);
+	spin_unlock_irqrestore(&mcp->lock, flags);
 }
 EXPORT_SYMBOL(mcp_enable);
 
-- 
1.7.4.4
