From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 12 May 2013 16:05:14 +0200
Subject: [PATCH] irq-sun4i: Fix trivial build errors
In-Reply-To: <20130506142539.523110430@linutronix.de>
References: <20130506142539.523110430@linutronix.de>
Message-ID: <1368367514-21782-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/irqchip/irq-sun4i.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 0191f2c..cab36b1 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -46,7 +46,8 @@ static int __init sun4i_init_domain_chips(void)
 	struct irq_chip_generic *gc;
 	int i, ret, base = 0;
 
-	ret = irq_alloc_domain_generic_chips(d, SUN4I_IRQS_PER_CHIP, 1,
+	ret = irq_alloc_domain_generic_chips(sun4i_irq_domain,
+					     SUN4I_IRQS_PER_CHIP, 1,
 					     "sun4i_irq", handle_level_irq,
 					     clr, 0, IRQ_GC_INIT_MASK_CACHE);
 	if (ret)
@@ -57,9 +58,9 @@ static int __init sun4i_init_domain_chips(void)
 		gc->reg_base = sun4i_irq_base;
 		gc->chip_types[0].regs.mask = SUN4I_IRQ_ENABLE_REG(i);
 		gc->chip_types[0].regs.ack = SUN4I_IRQ_PENDING_REG(i);
-		gc->chip_types[0].chip.mask = irq_gc_mask_clr_bit;
-		gc->chip_types[0].chip.ack = irq_gc_ack_set_bit;
-		gc->chip_types[0].chip.unmask = irq_gc_mask_set_bit;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
+		gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
+		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
 
 		/* Disable, mask and clear all pending interrupts */
 		writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(i));
-- 
1.8.1.2
