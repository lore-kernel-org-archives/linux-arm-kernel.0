From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Apr 2013 16:49:07 +0200
Subject: [PATCH 03/21] ARM: shmobile: don't call irqchip_init
 unconditionally
In-Reply-To: <20130426004835.GA20070@verge.net.au>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-4-git-send-email-arnd@arndb.de>
 <20130426004835.GA20070@verge.net.au>
Message-ID: <201304291649.08084.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 April 2013, Simon Horman wrote:
> > diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
> > index 8871f77..5dc57f1 100644
> > --- a/arch/arm/mach-shmobile/intc-r8a7740.c
> > +++ b/arch/arm/mach-shmobile/intc-r8a7740.c
> > @@ -53,14 +53,23 @@ static void __init r8a7740_init_irq_common(void)
> >  
> >  void __init r8a7740_init_irq_of(void)
> >  {
> > +     if (!IS_ENABLED(CONFIG_OF))
> > +             return;
> > +
> 
> In other parts of the shmobile I believe that such code is
> guarded by #ifdef CONFIG_OF and I believe not guarding this code in
> some way was an oversight.
> 
> The above change seems fine to me.

Ok. The change that broke the code is only present in linux-next from
one of your trees, but is not in arm-soc. Could you include the change
in your tree, either by folding into one of your patches or adapting
my patch appropriately?

> > +
> > +     gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
> > +     gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
> >  
> >       /* initialize the Generic Interrupt Controller PL390 r0p0 */
> >       gic_init(0, 29, gic_dist_base, gic_cpu_base);
> 
> This one seems broken as the armadillo800eva board currently uses
> it to initialise GIC even if CONFIG_ATAGS is not defined.
> 
> I did test the above change on the armadillo800eva board
> with the above change and CONFIG_ATAGS disabled, the result was
> a boot failure. With the change reverted booting seems fine.

Yes, I see my mistake now. The second change was clearly wrong
as this function is also used for DT boards, not for ATAGS boards.

	Arnd
