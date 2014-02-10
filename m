From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 11 Feb 2014 00:22:37 +0800
Subject: [PATCH] pinctrl: sunxi: use chained_irq_{enter,
 exit} for GIC compatibility
Message-ID: <1392049357-13225-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On tha Allwinner A20 SoC, the external interrupts on the pin controller
device are connected to the GIC. Without chained_irq_{enter, exit},
external GPIO interrupts, such as used by mmc core card detect, cause
the system to hang.

Cc: stable at vger.kernel.org
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This issue was first encountered during my attempt to get out-of-band
interrupts for WiFi on the Cubietruck working. With David's new series
of sunci-mci using mmc slot-gpio for (GPIO interrupt based) card
detection, removing the SD card also causes my Cubietruck to hang. This
problem should extend to all Allwinner A20 based boards.

With this fix, the system no longer hangs when I remove or insert the
SD card. /proc/interrupts show that the interrupt has correctly fired.
However the system still does not detect card removal/insertion. I
believe this is another unrelated issue.

 drivers/pinctrl/pinctrl-sunxi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 9ccf681..787f352 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -665,6 +666,7 @@ static struct irq_chip sunxi_pinctrl_irq_chip = {
 
 static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = irq_get_chip(irq);
 	struct sunxi_pinctrl *pctl = irq_get_handler_data(irq);
 	const unsigned long reg = readl(pctl->membase + IRQ_STATUS_REG);
 
@@ -674,10 +676,12 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 	if (reg) {
 		int irqoffset;
 
+		chained_irq_enter(chip, desc);
 		for_each_set_bit(irqoffset, &reg, SUNXI_IRQ_NUMBER) {
 			int pin_irq = irq_find_mapping(pctl->domain, irqoffset);
 			generic_handle_irq(pin_irq);
 		}
+		chained_irq_exit(chip, desc);
 	}
 }
 
-- 
1.9.rc1
