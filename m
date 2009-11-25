From: john.ogness@linutronix.de (John Ogness)
Date: Wed, 25 Nov 2009 19:19:58 +0100
Subject: [PATCH] MXC: set GPIO IRQ handler
Message-ID: <807htelb5d.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq chip function gpio_set_irq_type() correctly sets the i.MX
registers but does not set the irq handler. This means that all
gpio-based irq's are handled with handle_edge_irq().

This patch corrects this by also setting the appropriate handler.

This patch is against 2.6.32-rc8.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/arm/plat-mxc/gpio.c |    5 +++++
 1 file changed, 5 insertions(+)
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -126,6 +126,11 @@ static int gpio_set_irq_type(u32 irq, u3
 	__raw_writel(val | (edge << (bit << 1)), reg);
 	_clear_gpio_irqstatus(port, gpio & 0x1f);
 
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
+		__set_irq_handler_unlocked(irq, handle_level_irq);
+	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
+		__set_irq_handler_unlocked(irq, handle_edge_irq);
+
 	return 0;
 }
 
