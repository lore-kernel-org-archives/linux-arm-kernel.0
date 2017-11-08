From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  8 Nov 2017 18:01:40 +0000
Subject: [RFC PATCH] phy: don't disable and re-enable interrupts in oneshot
 threaded handler
Message-ID: <20171108180140.3817-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY interrupt handling code registers its interrupt as a oneshot
threaded interrupt, which guarantees that the interrupt will be masked
throughout both the primary and secondary handling stages.

However, the handling code still disables the interrupt by calling
disable_irq(), and re-enables it by calling enable_irq() after having
acked the interrupt in the PHY hardware.

This causes problems with hierarchical irqchip implementations built
on top of the GIC, because the core threaded interrupt code will only
EOI the interrupt if it is still masked after the secondary handler
completes. If this is not the case, the EOI is not emitted, and the
interrupt remains active, blocking further interrupts from the same
source. Disabling and enabling the interrupt will result in the secondary
handler completing with the interrupt unmasked, resulting in the above
behavior.

So remove the disable_irq/enable_irq, and rely on the fact that the
interrupt remains masked already.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/net/phy/phy.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d0626bf5c540..ce8bba0c1072 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -774,8 +774,8 @@ static void phy_error(struct phy_device *phydev)
  * @irq: interrupt line
  * @phy_dat: phy_device pointer
  *
- * Description: When a PHY interrupt occurs, the handler disables
- * interrupts, and uses phy_change to handle the interrupt.
+ * Description: When a PHY interrupt occurs, the handler invokes
+ *              phy_change to handle the interrupt.
  */
 static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 {
@@ -784,9 +784,6 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	if (PHY_HALTED == phydev->state)
 		return IRQ_NONE;		/* It can't be ours.  */
 
-	disable_irq_nosync(irq);
-	atomic_inc(&phydev->irq_disable);
-
 	phy_change(phydev);
 
 	return IRQ_HANDLED;
@@ -891,10 +888,10 @@ void phy_change(struct phy_device *phydev)
 	if (phy_interrupt_is_valid(phydev)) {
 		if (phydev->drv->did_interrupt &&
 		    !phydev->drv->did_interrupt(phydev))
-			goto ignore;
+			return;
 
 		if (phy_disable_interrupts(phydev))
-			goto phy_err;
+			goto irq_enable_err;
 	}
 
 	mutex_lock(&phydev->lock);
@@ -903,9 +900,6 @@ void phy_change(struct phy_device *phydev)
 	mutex_unlock(&phydev->lock);
 
 	if (phy_interrupt_is_valid(phydev)) {
-		atomic_dec(&phydev->irq_disable);
-		enable_irq(phydev->irq);
-
 		/* Reenable interrupts */
 		if (PHY_HALTED != phydev->state &&
 		    phy_config_interrupt(phydev, PHY_INTERRUPT_ENABLED))
@@ -916,15 +910,9 @@ void phy_change(struct phy_device *phydev)
 	phy_trigger_machine(phydev, true);
 	return;
 
-ignore:
-	atomic_dec(&phydev->irq_disable);
-	enable_irq(phydev->irq);
-	return;
-
 irq_enable_err:
 	disable_irq(phydev->irq);
 	atomic_inc(&phydev->irq_disable);
-phy_err:
 	phy_error(phydev);
 }
 
-- 
2.11.0
