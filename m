From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 1 Sep 2014 10:47:31 +0200
Subject: [PATCH v4 3/5] ARM: tegra: Initialize interrupt controller from DT
In-Reply-To: <3113165.EcqFA5vr07@wuerfel>
References: <1409239879-12376-1-git-send-email-thierry.reding@gmail.com>
 <20140829142408.GA31264@ulmo> <20140829150422.GA11035@ulmo>
 <3113165.EcqFA5vr07@wuerfel>
Message-ID: <20140901084729.GD24430@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 09:53:42PM +0200, Arnd Bergmann wrote:
> On Friday 29 August 2014 17:04:28 Thierry Reding wrote:
> >         static struct irq_chip *extn;
> > 
> >         void gic_arch_register(const struct irqchip *chip)
> >         {
> >                 if (WARN(extn != NULL))
> >                         return;
> > 
> >                 gic_chip.flags |= chip->flags;
> >                 extn = chip;
> >         }
> > 
> > Any preferences, or other ideas? Adding Thomas and Jason, perhaps they
> > can provide more input on how to solve this.
> 
> I think the entire gic_arch_extn method is done in a rather odd way
> and we should try to come up with a replacement.
> 
> These are the users at the moment:
> 
> arch/arm/mach-exynos/pm.c:      gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
> arch/arm/mach-imx/gpc.c:        gic_arch_extn.irq_mask = imx_gpc_irq_mask;
> arch/arm/mach-imx/gpc.c:        gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
> arch/arm/mach-imx/gpc.c:        gic_arch_extn.irq_set_wake = imx_gpc_irq_set_wake;
> arch/arm/mach-omap2/omap-wakeupgen.c:   gic_arch_extn.irq_mask = wakeupgen_mask;
> arch/arm/mach-omap2/omap-wakeupgen.c:   gic_arch_extn.irq_unmask = wakeupgen_unmask;
> arch/arm/mach-omap2/omap-wakeupgen.c:   gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_W
> arch/arm/mach-shmobile/intc-sh73a0.c:   gic_arch_extn.irq_set_wake = sh73a0_set_wake;
> arch/arm/mach-shmobile/setup-r8a7779.c: gic_arch_extn.irq_set_wake = r8a7779_set_wake;
> arch/arm/mach-tegra/irq.c:      gic_arch_extn.irq_ack = tegra_ack;
> arch/arm/mach-tegra/irq.c:      gic_arch_extn.irq_eoi = tegra_eoi;
> arch/arm/mach-tegra/irq.c:      gic_arch_extn.irq_mask = tegra_mask;
> arch/arm/mach-tegra/irq.c:      gic_arch_extn.irq_unmask = tegra_unmask;
> arch/arm/mach-tegra/irq.c:      gic_arch_extn.irq_retrigger = tegra_retrigger;
> arch/arm/mach-tegra/irq.c:      gic_arch_extn.irq_set_wake = tegra_set_wake;
> arch/arm/mach-tegra/irq.c:      gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
> arch/arm/mach-ux500/cpu.c:      gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
> arch/arm/mach-zynq/common.c:    gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
> 
> I have to admit I don't really understand how these work, but what
> I'd expect to work better is a way to turn the gic code into more
> of a library that can be used by specialized drivers. In that
> case you would register a driver for the tegra gic using IRQCHIP_DECLARE
> and that driver would call a variation of gic_of_init() or gic_init_bases()
> with the extra stuff as arguments.
> 
> We'd have to hack around the fact that all these platforms currently
> don't list a specialized compatible string, but at least for the future
> we should be able to do this without special hacks.

Besides the issue with the missing compatible values, the hardware
blocks that provide the additional functionality are separate from the
GIC. So they would have to look up the GIC node explicitly.

I suppose that might actually be to our advantage, since these blocks
will presumably have a specialized compatible string. So perhaps one
solution would be to make the drivers for these separate IP blocks look
up the GIC device tree node and call gic_of_init_ext() with a pointer to
the IRQ chip implementation of this platform-specific glue to replace
gic_arch_extn.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/3832df43/attachment.sig>
