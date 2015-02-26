From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Feb 2015 11:13:08 +0100
Subject: [PATCH 3/8] irqchip: armada-370-xp: Introduce a is_percpu_irq()
 helper for readability
In-Reply-To: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1424945593-20320-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This commit introduces a helper function is_percpu_irq(), to be used
when interrupts are mapped to decide which ones are set as per CPU.

This change will allow to extend the list of per cpu interrupts in a less
intrusive fashion; also, it makes the code slightly more readable by keeping
a list of the per CPU interrupts.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ebb5a11f55b9..204c88386b1a 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -77,6 +77,16 @@ static DEFINE_MUTEX(msi_used_lock);
 static phys_addr_t msi_doorbell_addr;
 #endif
 
+static inline bool is_percpu_irq(irq_hw_number_t irq)
+{
+	switch (irq) {
+	case ARMADA_370_XP_TIMER0_PER_CPU_IRQ:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void armada_370_xp_irq_mask(struct irq_data *d)
 {
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
@@ -275,7 +285,7 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 
 	irq_set_status_flags(virq, IRQ_LEVEL);
 
-	if (hw == ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
+	if (is_percpu_irq(hw)) {
 		irq_set_percpu_devid(virq);
 		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
 					handle_percpu_devid_irq);
-- 
2.3.0
