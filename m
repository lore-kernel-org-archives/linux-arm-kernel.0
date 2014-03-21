From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 19:40:03 +0100
Subject: [PATCH 61/62] ARM: sunxi: fix build for THUMB2_KERNEL
In-Reply-To: <CAL_JsqKRW-T_5mAo-h7BHAwA7jBN8FfO6WpkJ9Uk_vpByYLHXA@mail.gmail.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <6006528.k1jnepzDNv@wuerfel>
 <CAL_JsqKRW-T_5mAo-h7BHAwA7jBN8FfO6WpkJ9Uk_vpByYLHXA@mail.gmail.com>
Message-ID: <4211929.spA11BNxmP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014 13:21:04 Rob Herring wrote:
> > diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
> > index 7b141d8..3f9b889 100644
> > --- a/arch/arm/mach-sunxi/platsmp.c
> > +++ b/arch/arm/mach-sunxi/platsmp.c
> > @@ -82,7 +82,7 @@ static int sun6i_smp_boot_secondary(unsigned int cpu,
> >         spin_lock(&cpu_lock);
> >
> >         /* Set CPU boot address */
> > -       writel(virt_to_phys(sun6i_secondary_startup),
> > +       writel(virt_to_phys(secondary_startup),
> >                cpucfg_membase + CPUCFG_PRIVATE0_REG);
> >
> >         /* Assert the CPU core in reset */
> > @@ -120,5 +120,5 @@ static int sun6i_smp_boot_secondary(unsigned int cpu,
> >
> >  struct smp_operations sun6i_smp_ops __initdata = {
> >         .smp_prepare_cpus       = sun6i_smp_prepare_cpus,
> > -       .smp_boot_secondary     = sun6i_smp_boot_secondary,
> > +       .smp_boot_secondary     = sun6i_smp_secondary_startup,
> 
> ?? This looks unintentional.
> 

Yes, I just noticed the same thing after testing the resulting tree.

I also had to add a global declaration for secondary_startup, which apparently
mach-qcom also needs but added locally.

	Arnd
