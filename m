From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Jan 2014 13:49:05 -0300
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <20140121233537.GS18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
Message-ID: <20140122164904.GB27273@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 04:35:37PM -0700, Jason Gunthorpe wrote:
> On Tue, Jan 21, 2014 at 06:12:32AM -0300, Ezequiel Garcia wrote:
> > After adding the IRQ request, the BRIDGE_CAUSE bit should be cleared by the
> > bridge interrupt controller. There's no longer a need to do it in the watchdog
> > driver, so we can simply remove it.
> 
> When we talked about this before I pointed out that sequence here is
> important:
> 
> - Disable WDT
> - Clear bridge
> - Enable WDT
> 

Sure, I wrote this series with that in mind and made some tests to
ensure that no spurious trigger was possible.

> Looking at this patch in isolation it looks to me like the clear
> bridge lines should be replaced with a request_irq (as that does the
> clear) - is the request_irq in the wrong spot?
> 

First of all, it seems to me that the first item "Disable WDT" is not
currently true on this driver. orion_wdt_start() seem to reset the
counter, but doesn't clear the WDT_EN bit. Do you think we should
enforce a "true" disable?

As an example, s3c2410wdt calls stop() from start(). Maybe we should
do something like it?

Regarding the sequence. Let me see if I got this problem right. The
concern here is about the bootloader leaving the registers in a
weird-state, right?

In that case, I thought that requesting the IRQ at probe time was enough
to ensure the BRIDGE_CAUSE would be cleared by the time the watchdog is
started. However, after reading through the irqchip code again, I'm no longer
sure this is the case.

It looks like the BRIDGE_CAUSE register is cleared when the interruption
is acked (which happens in the handler if I understood the code right).
So requesting the IRQ is useless...

I'll trace the code to confirm this.

Sebastian: If the above is correct, do you think we can add a cause clear to
the orion irqchip? (supposing it's harmful) Something like this:

diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index e51d400..fef9171 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -180,6 +180,9 @@ static int __init orion_bridge_irq_init(struct device_node *np,
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
 	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
 
+	/* clear pending interrupts */
+	writel(0, gc->reg_base + ORION_BRIDGE_IRQ_CAUSE);
+
 	/* mask all interrupts */
 	writel(0, gc->reg_base + ORION_BRIDGE_IRQ_MASK);
 
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
