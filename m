From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Oct 2016 15:11:37 +0200
Subject: [PATCH 1/2] gpio: mxs: use enable/disable regs to (un)mask irqs
In-Reply-To: <20161021131138.10467-1-s.hauer@pengutronix.de>
References: <20161021131138.10467-1-s.hauer@pengutronix.de>
Message-ID: <20161021131138.10467-2-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs gpio controller does not only have a mask register to mask
interrupts, but also enable/disable registers. Use the enable/disable
registers rather than the mask register. This does not have any
advantage for now, but makes the next patch simpler.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/gpio/gpio-mxs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index b9daa0b..1cf579f 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -211,12 +211,13 @@ static int __init mxs_gpio_init_gc(struct mxs_gpio_port *port, int irq_base)
 
 	ct = gc->chip_types;
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
-	ct->chip.irq_mask = irq_gc_mask_clr_bit;
-	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	ct->chip.irq_mask = irq_gc_mask_disable_reg;
+	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
 	ct->chip.irq_set_type = mxs_gpio_set_irq_type;
 	ct->chip.irq_set_wake = mxs_gpio_set_wake_irq;
 	ct->regs.ack = PINCTRL_IRQSTAT(port) + MXS_CLR;
-	ct->regs.mask = PINCTRL_IRQEN(port);
+	ct->regs.enable = PINCTRL_IRQEN(port) + MXS_SET;
+	ct->regs.disable = PINCTRL_IRQEN(port) + MXS_CLR;
 
 	irq_setup_generic_chip(gc, IRQ_MSK(32), IRQ_GC_INIT_NESTED_LOCK,
 			       IRQ_NOREQUEST, 0);
-- 
2.9.3
