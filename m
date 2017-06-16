From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 16 Jun 2017 12:51:44 +0300
Subject: arm64: next-20170614 panics on boot
In-Reply-To: <20170615123337.5qkrh72vt53jnwnf@yury-thinkpad>
References: <20170615120840.ce7v4hxflueu4s7o@yury-thinkpad>
 <20170615123337.5qkrh72vt53jnwnf@yury-thinkpad>
Message-ID: <20170616095144.nb43ur6fukkfen5c@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(CC irqchip maintainers)

On Thu, Jun 15, 2017 at 03:33:37PM +0300, Yury Norov wrote:
> On Thu, Jun 15, 2017 at 03:08:40PM +0300, Yury Norov wrote:
> > Hi all,
> > 
> > Today's linux next falls into panic in init_IRQ():
> > arch/arm64/kernel/irq.c:
> >  53 void __init init_IRQ(void)
> >  54 {
> >  55         irqchip_init();
> >  56         if (!handle_arch_irq)
> >  57                 panic("No interrupt controller found.");
> >  58 }
> > 
> > 
> > Bisecting points to the patch 6fedb069def034 ("of: Provide dummy
> > of_device_compatible_match() for compile-testing"), but reverting it
> > doesn't help. It seems like yesterday's linux-next also hangs.  Right
> > now I cannot continue with debugging, but if nothing will get clear,
> > I'll back to it at this evening.
> 
> Sorry, forgot to attach the config. This is it. Also, I run arm64 on
> qemu.

The next-20170616 boots well for me. I didn't manage to bisect the
source of problem - it points to different commmits, and reverting
them doesn't help. The source of the problem is that irqchip_init()
doesn't set the handle_arch_irq. It should be done in 
of_irq_init() at the line

drivers/of/irq.c:
542         while (!list_empty(&intc_desc_list)) {
        ...
561                         ret = desc->irq_init_cb(desc->dev,
562                                                 desc->interrupt_parent);
        ...
586         }

On next-20170614 and 15 intc_desc_list is empty at the point. It
should be populated earlier in the loop
510         for_each_matching_node_and_match(np, matches, &match)

But np becomes 0 at the 1st iteration, and so the program doesn't enter the
loop. At the first glance there's no recent changes in related code. Maybe it's dts
issue?..

Yury
