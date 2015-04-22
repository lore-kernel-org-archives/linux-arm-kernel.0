From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Apr 2015 11:38:41 +0100
Subject: [RESEND PATCH 4.0-rc7 v20 3/6] irqchip: gic: Introduce plumbing
 for IPI FIQ
In-Reply-To: <5536BDE8.2030403@linaro.org>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-4-git-send-email-daniel.thompson@linaro.org>
 <20150421145007.GB10164@leverpostej> <5536BDE8.2030403@linaro.org>
Message-ID: <20150422103841.GC27345@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I just gave this a spin on my (non-MCPM) TC2, and secondaries don't come
> > up:
> >
> > CPU1: failed to boot: -38
> > CPU2: failed to boot: -38
> > CPU3: failed to boot: -38
> > CPU4: failed to boot: -38
> > Brought up 1 CPUs
> > SMP: Total of 1 processors activated (48.00 BogoMIPS).
> >
> > I tried investigating with a debugger. The unbooted CPUs look to be
> > stuck at the FW's spin loop, but the text doesn't look right (I see a
> > load of ADDEQ r0, r0, r0, #LSL 1 where there was previously a WFI loop).
> > That could be a bug with my debugger though.
> >
> > If I pause the CPUs at the right point, they sometimes enter the kernel
> > successfully. I don't have a good explanation for that.
> >
> > [...]
> 
> Rats!
> 
> I presume it is patch 3 that causes the regression? Patch 3 is the one 
> that causes the GIC to adopt a different configuration if it find the 
> kernel running in secure world (it sets all interrupts to group 1 and 
> routes group 0 to FIQ).
> 
> I only ask because it isn't until patch 6 that we actually place any 
> interrupt sources into group 0.

Patch 3 appears to be to blame. I see the issue with patches 1-3 alone
applied atop of v4.0. With patch 3 reverted secondaries come up as
expected.

> >> @@ -427,6 +535,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
> >>          void __iomem *base = gic_data_cpu_base(gic);
> >>          unsigned int cpu_mask, cpu = smp_processor_id();
> >>          int i;
> >> +       unsigned long secure_irqs, secure_irq;
> >
> > I think secure_irq(s) is a misnomer here. It's just a mask of FIQ bits.
> 
> I guess so, on GICv2 without security extentions these are not secure 
> irqs. This is one of the places were IRQ, FIQ, irq and hwirq meet 
> together and naming things is hard.
> 
> What sort of name do you like: fiq(s), fiq_hwirq(s)?

I'd go for fiq_mask and fiq, or group1_mask and group1_irq.

[...]

> >> @@ -445,6 +554,20 @@ static void gic_cpu_init(struct gic_chip_data *gic)
> >>
> >>          gic_cpu_config(dist_base, NULL);
> >>
> >> +       /*
> >> +        * If the distributor is configured to support interrupt grouping
> >> +        * then set any PPI and SGI interrupts not set in SMP_IPI_FIQ_MASK
> >> +        * to be group1 and ensure any remaining group 0 interrupts have
> >> +        * the right priority.
> >> +        */
> >> +       if (GICD_ENABLE_GRP1 & readl_relaxed(dist_base + GIC_DIST_CTRL)) {
> >> +               secure_irqs = SMP_IPI_FIQ_MASK;
> >> +               writel_relaxed(~secure_irqs, dist_base + GIC_DIST_IGROUP + 0);
> >> +               gic->igroup0_shadow = ~secure_irqs;
> >> +               for_each_set_bit(secure_irq, &secure_irqs, 16)
> >> +                       gic_set_group_irq(gic, secure_irq, 0);
> >> +       }
> >
> > This only pokes GICD registers. Why isn't this in gic_dist_init?
> 
> GIC_DIST_IGROUP[0] (which controls grouping for SGIs and PPIs) is banked 
> per-cpu and form part of the per-cpu configuration.

Ah. Would you mind adding a note to the comment w.r.t. GICD_IGROUPR0
being banked per-cpu? I suspect I won't be the only one who fails to
recall that being the case.

We might want to rethink the gic_dist_init/gic_cpu_init naming if
they're no longer cleanly split across distributor and cpu interface
initialisation.

Thanks,
Mark.
