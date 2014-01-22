From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Jan 2014 19:12:38 -0300
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <20140122205213.GW18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <52E02AB6.7040104@gmail.com>
 <20140122205213.GW18269@obsidianresearch.com>
Message-ID: <20140122221237.GA30763@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 01:52:13PM -0700, Jason Gunthorpe wrote:
> > Clearing BRIDGE_CAUSE will only clear all currently pending upstream
> > IRQs, of course. If WDT IRQ will be re-raised right after that in
> > BRIDGE_CAUSE depends on the actual HW implementation, i.e. we do no
> > clear the causing IRQ itself but just what it raised in BRIDGE_CAUSE.
> 
> Which is why it makes no sense to clear it one time at kernel start.
> 

So, it seems we need to handle irq_startup(), as you suggested.
I've just tested the attached patch, and it's working fine: the driver's
probe() fully stops the watchdog, and then request_irq() acks and
pending interrupts, through the added irq_startup().

How does it look?

diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index e51d400..91a3955 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -108,6 +108,16 @@ IRQCHIP_DECLARE(orion_intc, "marvell,orion-intc", orion_irq_init);
 #define ORION_BRIDGE_IRQ_CAUSE	0x00
 #define ORION_BRIDGE_IRQ_MASK	0x04
 
+static unsigned int orion_bridge_irq_startup(struct irq_data *data)
+{
+	/* Ack pending interrupts */
+	data->chip->irq_ack(data);
+
+	/* Unmask the interrupt */
+	data->chip->irq_unmask(data);
+	return 0;
+}
+
 static void orion_bridge_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_domain *d = irq_get_handler_data(irq);
@@ -176,6 +186,7 @@ static int __init orion_bridge_irq_init(struct device_node *np,
 
 	gc->chip_types[0].regs.ack = ORION_BRIDGE_IRQ_CAUSE;
 	gc->chip_types[0].regs.mask = ORION_BRIDGE_IRQ_MASK;
+	gc->chip_types[0].chip.irq_startup = orion_bridge_irq_startup;
 	gc->chip_types[0].chip.irq_ack = irq_gc_ack_clr_bit;
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
 	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;


-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
