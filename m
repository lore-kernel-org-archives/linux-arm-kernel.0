From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 2 Oct 2015 15:50:46 +0200
Subject: [PATCH 2/2] pinctrl: at91-pio4: Adapt to new irq flow handler
 prototype
In-Reply-To: <abf74f93ec58e3b321dce23af3fa5af1ffa2e070.1443793711.git.nicolas.ferre@atmel.com>
References: <abf74f93ec58e3b321dce23af3fa5af1ffa2e070.1443793711.git.nicolas.ferre@atmel.com>
Message-ID: <37a4986f2752faa3d82f56d1235c619d09dec97f.1443793711.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adapt atmel_gpio_irq_handler() function as the "irq" argument is now removed
from the irq flow handlers prototype in commit
bd0b9ac405e1794d72533c3d487aa65b6b955a0c (genirq: Remove irq argument from irq
flow handlers).

This allows to remove this warning:
../drivers/pinctrl/pinctrl-at91-pio4.c: In function 'atmel_pinctrl_probe':
../drivers/pinctrl/pinctrl-at91-pio4.c:1000:3: warning: passing argument 2 of
'irq_set_chained_handler' from incompatible pointer type [enabled by default]
   irq_set_chained_handler(res->start, atmel_gpio_irq_handler);
   ^
In file included from ../include/linux/gpio/driver.h:6:0,
                 from ../include/asm-generic/gpio.h:12,
                 from ../arch/arm/include/asm/gpio.h:9,
                 from ../include/linux/gpio.h:48,
                 from ../drivers/pinctrl/pinctrl-at91-pio4.c:18:
../include/linux/irq.h:548:1: note: expected 'irq_flow_handler_t' but argument
is of type 'void (*)(unsigned int,  struct irq_desc *)'
 irq_set_chained_handler(unsigned int irq, irq_flow_handler_t handle)

This change appeared while the driver was being reviewed and was being included
in pinctrl tree.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 1f1a64ef3559..cae0748aca25 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -248,10 +248,11 @@ static struct irq_chip atmel_gpio_irq_chip = {
 	.irq_set_wake	= atmel_gpio_irq_set_wake,
 };
 
-static void atmel_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void atmel_gpio_irq_handler(struct irq_desc *desc)
 {
-	struct atmel_pioctrl *atmel_pioctrl = irq_get_handler_data(irq);
+	struct atmel_pioctrl *atmel_pioctrl = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int irq = irq_desc_get_irq(desc);
 	unsigned long isr;
 	int n, bank = -1;
 
-- 
2.1.3
