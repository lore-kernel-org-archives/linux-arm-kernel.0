From: dianders@chromium.org (Doug Anderson)
Date: Mon, 22 Dec 2014 10:47:29 -0800
Subject: [PATCH] pinctrl: rockchip: Avoid losing interrupts when supporting
 both edges
Message-ID: <1419274049-5069-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was seeing cases where I was losing interrupts when inserting and
removing SD cards.  Sometimes the card would get "stuck" in the
inserted state.

I believe that the problem was related to the code to handle the case
where we needed both rising and falling edges.  This code would
disable the interrupt as the polarity was switched.  If an interrupt
came at the wrong time it could be lost.

We'll match what the gpio-dwapb.c driver does upstream and change the
interrupt polarity without disabling things.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/pinctrl/pinctrl-rockchip.c | 45 +++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 3c22dbe..43eacc9 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1398,10 +1398,7 @@ static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
 	struct rockchip_pin_bank *bank = irq_get_handler_data(irq);
-	u32 polarity = 0, data = 0;
 	u32 pend;
-	bool edge_changed = false;
-	unsigned long flags;
 
 	dev_dbg(bank->drvdata->dev, "got irq for bank %s\n", bank->name);
 
@@ -1409,12 +1406,6 @@ static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
 
 	pend = readl_relaxed(bank->reg_base + GPIO_INT_STATUS);
 
-	if (bank->toggle_edge_mode) {
-		polarity = readl_relaxed(bank->reg_base +
-					 GPIO_INT_POLARITY);
-		data = readl_relaxed(bank->reg_base + GPIO_EXT_PORT);
-	}
-
 	while (pend) {
 		unsigned int virq;
 
@@ -1434,27 +1425,31 @@ static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
 		 * needs manual intervention.
 		 */
 		if (bank->toggle_edge_mode & BIT(irq)) {
-			if (data & BIT(irq))
-				polarity &= ~BIT(irq);
-			else
-				polarity |= BIT(irq);
+			u32 data, data_old, polarity;
+			unsigned long flags;
 
-			edge_changed = true;
-		}
+			data = readl_relaxed(bank->reg_base + GPIO_EXT_PORT);
+			do {
+				spin_lock_irqsave(&bank->slock, flags);
 
-		generic_handle_irq(virq);
-	}
+				polarity = readl_relaxed(bank->reg_base +
+							 GPIO_INT_POLARITY);
+				if (data & BIT(irq))
+					polarity &= ~BIT(irq);
+				else
+					polarity |= BIT(irq);
+				writel(polarity,
+				       bank->reg_base + GPIO_INT_POLARITY);
 
-	if (bank->toggle_edge_mode && edge_changed) {
-		/* Interrupt params should only be set with ints disabled */
-		spin_lock_irqsave(&bank->slock, flags);
+				spin_unlock_irqrestore(&bank->slock, flags);
 
-		data = readl_relaxed(bank->reg_base + GPIO_INTEN);
-		writel_relaxed(0, bank->reg_base + GPIO_INTEN);
-		writel(polarity, bank->reg_base + GPIO_INT_POLARITY);
-		writel(data, bank->reg_base + GPIO_INTEN);
+				data_old = data;
+				data = readl_relaxed(bank->reg_base +
+						     GPIO_EXT_PORT);
+			} while ((data & BIT(irq)) != (data_old & BIT(irq)));
+		}
 
-		spin_unlock_irqrestore(&bank->slock, flags);
+		generic_handle_irq(virq);
 	}
 
 	chained_irq_exit(chip, desc);
-- 
2.2.0.rc0.207.ga3a616c
