From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 17 Feb 2014 22:19:42 +0100
Subject: [PATCH 2/4] pinctrl-sunxi: Fix hang on gpio irq
In-Reply-To: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
References: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1392671984-29872-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our irq handler was missing chained_irq_enter / exit calls, causing a
hard hang as soon as a gpio irq happened.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 74635cc..cc9bd1b 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -665,9 +666,12 @@ static struct irq_chip sunxi_pinctrl_irq_chip = {
 
 static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = irq_get_chip(irq);
 	struct sunxi_pinctrl *pctl = irq_get_handler_data(irq);
 	const unsigned long reg = readl(pctl->membase + IRQ_STATUS_REG);
 
+	chained_irq_enter(chip, desc);
+
 	/* Clear all interrupts */
 	writel(reg, pctl->membase + IRQ_STATUS_REG);
 
@@ -679,6 +683,7 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 			generic_handle_irq(pin_irq);
 		}
 	}
+	chained_irq_exit(chip, desc);
 }
 
 static struct of_device_id sunxi_pinctrl_match[] = {
-- 
1.8.5.3
