From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jun 2014 16:51:26 +0200
Subject: [PATCH] drm: imx: use GENERIC_IRQ_CHIP
In-Reply-To: <20140612142354.GI23430@n2100.arm.linux.org.uk>
References: <7367559.qEUUbIia3C@wuerfel>
 <20140612142354.GI23430@n2100.arm.linux.org.uk>
Message-ID: <18338077.DHE9A0xGC1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 June 2014 15:23:54 Russell King - ARM Linux wrote:
> On Thu, Jun 12, 2014 at 04:05:32PM +0200, Arnd Bergmann wrote:
> > This driver defines its own irqchip using the generic chip
> > infrastructure, and hence needs the GENERIC_IRQ_CHIP Kconfig
> > symbol enabled, or get this build error:
> > 
> > drivers/built-in.o: In function `ipu_probe':
> > :(.text+0x49ea4c): undefined reference to `irq_generic_chip_ops'
> > :(.text+0x49ea5c): undefined reference to `irq_alloc_domain_generic_chips'
> > :(.text+0x49ea60): undefined reference to `irq_get_domain_generic_chip'
> > :(.text+0x49ea64): undefined reference to `irq_gc_ack_set_bit'
> > :(.text+0x49ea6c): undefined reference to `irq_gc_mask_clr_bit'
> > :(.text+0x49ea70): undefined reference to `irq_gc_mask_set_bit'
> 
> Let's take a step back, and ask the obvious question: is it reasonable
> to make use if GENERIC_IRQ_CHIP in this driver?

While I haven't looked at this driver in particular, I know that
Thomas Gleixner has been rather upset in the past when new irqchip
drivers got introduced that were reimplementing the generic irqchip
rather than using it.

You can argue over whether it should be an irqchip at all or not,
I don't know, and I simply had to assume that this part of the
code is ok.

> Bear in mind that this is a platform driver (and so can be unbound), and
> the IRQ domain stuff does not support tear-down.  This code contains this...
> 
> static void ipu_irq_exit(struct ipu_soc *ipu)
> {
>         int i, irq;
> 
>         irq_set_chained_handler(ipu->irq_err, NULL);
>         irq_set_handler_data(ipu->irq_err, NULL);
>         irq_set_chained_handler(ipu->irq_sync, NULL);
>         irq_set_handler_data(ipu->irq_sync, NULL);
> 
>         /* TODO: remove irq_domain_generic_chips */
> 
>         for (i = 0; i < IPU_NUM_IRQS; i++) {
>                 irq = irq_linear_revmap(ipu->domain, i);
>                 if (irq)
>                         irq_dispose_mapping(irq);
>         }
> 
>         irq_domain_remove(ipu->domain);
> }
> 
> which rather hints at it being more broken than just the above.
> 
> So, I think you're just papering over the symptom of a broken
> implementation with your patch...

This seems more like a second bug in a related part of the code
to me. Looking at other generic irqchip users, it seems like
the same bug exists in gpio-dwapb.c, gpio-ml-ioh.c, gpio-pch.c
and possibly others, which are all loadable modules using a
generic irqchip that can't be freed.

	Arnd
