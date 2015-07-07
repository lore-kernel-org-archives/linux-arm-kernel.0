From: eric@anholt.net (Eric Anholt)
Date: Tue,  7 Jul 2015 14:13:34 -0700
Subject: [PATCH 1/4] irqchip: bcm2835: Refactor handle_IRQ() calls out of
 MAKE_HWIRQ.
In-Reply-To: <1436303617-17185-1-git-send-email-eric@anholt.net>
References: <1436303617-17185-1-git-send-email-eric@anholt.net>
Message-ID: <1436303617-17185-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For BCM2836, we want to chain into this IRQ chip from the root
controller, and for chaining we need to do something else instead of
handle_IRQ() once we have decoded the IRQ.

Note that this changes the behavior a little bit: Previously for a
non-shortcut IRQ, we'd loop reading and handling the second level IRQ
status until it was cleared before returning to the loop reading the
top level IRQ status (Note that the top level bit is just an OR of the
low level bits).  For the expected case of just one interrupt to be
handled, this was an extra register read, so we're down from 4 to 3
reads.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/irqchip/irq-bcm2835.c | 57 ++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index e68c3b6..382450a 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -179,44 +179,45 @@ static int __init armctrl_of_init(struct device_node *node,
  * handle_IRQ may briefly re-enable interrupts for soft IRQ handling.
  */
 
-static void armctrl_handle_bank(int bank, struct pt_regs *regs)
+static u32 armctrl_translate_bank(int bank)
 {
-	u32 stat, irq;
+	u32 stat = readl_relaxed(intc.pending[bank]);
 
-	while ((stat = readl_relaxed(intc.pending[bank]))) {
-		irq = MAKE_HWIRQ(bank, ffs(stat) - 1);
-		handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
-	}
+	return MAKE_HWIRQ(bank, ffs(stat) - 1);
+}
+
+static u32 armctrl_translate_shortcut(int bank, u32 stat)
+{
+	return MAKE_HWIRQ(bank, shortcuts[ffs(stat >> SHORTCUT_SHIFT) - 1]);
 }
 
-static void armctrl_handle_shortcut(int bank, struct pt_regs *regs,
-	u32 stat)
+static u32 get_next_armctrl_hwirq(void)
 {
-	u32 irq = MAKE_HWIRQ(bank, shortcuts[ffs(stat >> SHORTCUT_SHIFT) - 1]);
-	handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
+	u32 stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK;
+
+	if (stat == 0)
+		return ~0;
+	else if (stat & BANK0_HWIRQ_MASK)
+		return MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
+	else if (stat & SHORTCUT1_MASK)
+		return armctrl_translate_shortcut(1, stat & SHORTCUT1_MASK);
+	else if (stat & SHORTCUT2_MASK)
+		return armctrl_translate_shortcut(2, stat & SHORTCUT2_MASK);
+	else if (stat & BANK1_HWIRQ)
+		return armctrl_translate_bank(1);
+	else if (stat & BANK2_HWIRQ)
+		return armctrl_translate_bank(2);
+	else
+		BUG();
 }
 
 static void __exception_irq_entry bcm2835_handle_irq(
 	struct pt_regs *regs)
 {
-	u32 stat, irq;
-
-	while ((stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK)) {
-		if (stat & BANK0_HWIRQ_MASK) {
-			irq = MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
-			handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
-		} else if (stat & SHORTCUT1_MASK) {
-			armctrl_handle_shortcut(1, regs, stat & SHORTCUT1_MASK);
-		} else if (stat & SHORTCUT2_MASK) {
-			armctrl_handle_shortcut(2, regs, stat & SHORTCUT2_MASK);
-		} else if (stat & BANK1_HWIRQ) {
-			armctrl_handle_bank(1, regs);
-		} else if (stat & BANK2_HWIRQ) {
-			armctrl_handle_bank(2, regs);
-		} else {
-			BUG();
-		}
-	}
+	u32 hwirq;
+
+	while ((hwirq = get_next_armctrl_hwirq()) != ~0)
+		handle_IRQ(irq_linear_revmap(intc.domain, hwirq), regs);
 }
 
 IRQCHIP_DECLARE(bcm2835_armctrl_ic, "brcm,bcm2835-armctrl-ic", armctrl_of_init);
-- 
2.1.4
