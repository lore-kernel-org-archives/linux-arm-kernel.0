From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Oct 2014 19:22:29 +0200
Subject: [PATCH v3 3/7] irqchip: gic: Support hierarchy irq domain.
In-Reply-To: <5436BF0C.1030508@arm.com>
References: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
 <1412864980-20273-4-git-send-email-yingjoe.chen@mediatek.com>
 <5436BF0C.1030508@arm.com>
Message-ID: <3400038.iFbzPVHU3g@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 October 2014 17:59:56 Marc Zyngier wrote:
> > @@ -952,7 +988,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
> >  
> >       gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
> >  
> > -     if (of_property_read_u32(node, "arm,routable-irqs",
> > +     if (IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) &&
> > +             of_find_property(node, "arm,irq-domain-hierarchy", NULL))
> > +             gic->domain = irq_domain_add_linear(node, gic_irqs,
> > +                                     &gic_irq_domain_hierarchy_ops, gic);
> 
> I really think that looking for a property is the wrong thing to do. If
> "node" is non-NULL, then we're pretty sure that we're initializing from
> DT, and that a pure linear domain should be the right thing, leaving the
> legacy stuff for the few non-DT platforms that are still around.

FWIW, these are the remaining ones that use gic:

arch/arm/mach-cns3xxx/core.c:   gic_init(0, 29, IOMEM(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT),
arch/arm/mach-realview/realview_eb.c:           gic_init(0, 29, __io_address(REALVIEW_EB11MP_GIC_DIST_BASE),
arch/arm/mach-realview/realview_eb.c:           gic_init(1, 96, __io_address(REALVIEW_EB_GIC_DIST_BASE),
arch/arm/mach-realview/realview_eb.c:           gic_init(0, 29, __io_address(REALVIEW_EB_GIC_DIST_BASE),
arch/arm/mach-realview/realview_pb1176.c:       gic_init(0, IRQ_DC1176_GIC_START,
arch/arm/mach-realview/realview_pb1176.c:       gic_init(1, IRQ_PB1176_GIC_START,
arch/arm/mach-realview/realview_pb11mp.c:       gic_init(0, 29, __io_address(REALVIEW_TC11MP_GIC_DIST_BASE),
arch/arm/mach-realview/realview_pb11mp.c:       gic_init(1, IRQ_PB11MP_GIC_START,
arch/arm/mach-realview/realview_pba8.c: gic_init(0, IRQ_PBA8_GIC_START,
arch/arm/mach-realview/realview_pbx.c:          gic_init(0, 29, __io_address(REALVIEW_PBX_TILE_GIC_DIST_BASE),
arch/arm/mach-realview/realview_pbx.c:          gic_init(0, IRQ_PBX_GIC_START,
arch/arm/mach-shmobile/intc-sh73a0.c:   gic_init(0, 29, gic_dist_base, gic_cpu_base);
arch/arm/mach-tegra/irq.c:              gic_init(0, 29, distbase,
arch/arm/mach-vexpress/ct-ca9x4.c:      gic_init(0, 29, ioremap(A9_MPCORE_GIC_DIST, SZ_4K),

Linus Walleij is working on realview, Pawel already has a patch for vexpress, the tegra one
can just be removed and the Renesas team will deal with shmobile.

This basically leaves cns3xxx, which now has a new maintainer but I suspect we won't
have DT-only support for it too soon anyway.

	Arnd
