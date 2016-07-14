From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 13:09:54 +0200
Subject: [PATCH v2 02/10] irqchip: add irqchip driver for nuc900
In-Reply-To: <578752CD.3010408@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <5434334.4rKzx80y6W@wuerfel> <578752CD.3010408@iommu.org>
Message-ID: <4372420.eqVKsk1ckW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 14, 2016 4:52:29 PM CEST Wan Zongshun wrote:
> 
> On 2016?07?12? 16:26, Arnd Bergmann wrote:
> > On Tuesday, July 12, 2016 3:04:42 PM CEST Wan Zongshun wrote:
> >>>
> >>> Ideally, this should just go away once we use SPARSE_IRQ.
> >>
> >> This platform also can use SPARSE_IRQ? this just a simple irq map and no
> >> more irq number in this Soc.
> >>
> >
> > SPARSE_IRQ is implied by ARCH_MULTIPLATFORM, so we will have to
> > use it once that gets enabled.
> >
> > Your new irqchip driver already handles IRQ domains, so it will
> > work out of the box with SPARSE_IRQ, but you have to change the
> > reference to "NR_IRQS" into something else.
> >
> > I've prototyped a patch series to enable ARCH_MULTIPLATFORM,
> > I hope you can start working from what I have and get it to run.
> 
> I go through the ARCH_MULTIPLATFORM and SPARSE_IRQ related codes, but I 
> find I also have to define the NUC900_NR_IRQS firstly like below, so 
> that I can init the .nr_irq.
> 
> +#if !defined(CONFIG_SOC_NUC970)
>   #define NUC900_NR_IRQS		(IRQ_ADC+1)
> +#else
> +#define NUC900_NR_IRQS		62
> +#endif
> 
>   DT_MACHINE_START(nuc900_dt, "Nuvoton NUC900 (Device Tree Support)")
>          .dt_compat      = nuc900_dt_compat,
> +       .nr_irqs        = NUC900_NR_IRQS,
>   MACHINE_END

You don't need to set this for the DT based machines, this number
is just for the set of IRQ that have a hardcoded mapping. With DT,
they get dynamically allocated as required.

For the board files, you can hardcode the original definition of 32
IRQs, but I think you don't need that if you register a legacy IRQ
domain in mach-w90x900/irq.c.

> and then in my irqchip driver, I will use the NUC900_NR_IRQS:
> 
> +aic_domain = irq_domain_add_linear(node, NUC900_NR_IRQS,
> +				    &aic_irq_domain_ops, NULL);
> 
> 
> Is that a right usage?

This does not look right when NUC900_NR_IRQS can have configuration
dependent values. I can see two ways of handling it:

a) register the maximum number of IRQs that the irqchip can handle.
   There is no real cost for having a large number here, as SPARSE_IRQ
   ensures we only need to allocate the descriptors that are actually
   used.

b) make the number of interrupts dependent on the compatible string
   for the irqchip, and handle NUC970 differently from the others
   in the driver.

In the meantime, I also have a series to enable multiplatform support
for all of mach-w90x900 based on your patches, but lacking a proper
clk driver. I'll send that to you so you can include it in your
series (after verifying that it works, or fixing it where necessary).

	Arnd
