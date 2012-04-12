From: lost.distance@yahoo.com (Paul Parsons)
Date: Thu, 12 Apr 2012 15:06:46 +0100 (BST)
Subject: [PATCH] gpio: pxa: Set PXA GPIO irq_chip IRQCHIP_SKIP_SET_WAKE flag
Message-ID: <1334239606.46697.YahooMailClassic@web29016.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA GPIO irq_chip structure (pxa_muxed_gpio_chip) sets neither:
1. The irq_set_wake() handler.
2. The IRQCHIP_SKIP_SET_WAKE flag.

Consequently any attempt to configure the PXA GPIOs as wakeup sources
results in Unbalanced IRQ warnings when the system is woken from sleep
mode:

WARNING: at kernel/irq/manage.c:520 irq_set_irq_wake+0xc4/0xf8()
Unbalanced IRQ 96 wake disable
...
WARNING: at kernel/irq/manage.c:520 irq_set_irq_wake+0xc4/0xf8()
Unbalanced IRQ 190 wake disable
...
WARNING: at kernel/irq/manage.c:520 irq_set_irq_wake+0xc4/0xf8()
Unbalanced IRQ 195 wake disable
...

This patch sets the pxa_muxed_gpio_chip IRQCHIP_SKIP_SET_WAKE flag,
thereby eliminating the Unbalanced IRQ warnings.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
 drivers/gpio/gpio-pxa.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 5689ce6..93ce960 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -427,6 +427,7 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_mask	= pxa_mask_muxed_gpio,
 	.irq_unmask	= pxa_unmask_muxed_gpio,
 	.irq_set_type	= pxa_gpio_irq_type,
+	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int pxa_gpio_nums(void)
-- 
1.7.3.4
