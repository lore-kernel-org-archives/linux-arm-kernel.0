From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 28 Nov 2011 10:54:22 +0000
Subject: [PATCH v2 2/4] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111125161808.GE2098@localhost.localdomain>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
 <1322060508-11298-3-git-send-email-pawel.moll@arm.com>
 <20111125161808.GE2098@localhost.localdomain>
Message-ID: <1322477662.3164.30.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-11-25 at 16:18 +0000, Dave Martin wrote:
> [Since this text is now stable enough to be proofread, I'll list minor
> pedantic nits along with the other comments -- they aren't vital to the
> meaning though, and the documentation still "works" if they aren't
> acted on.]

[snip]

Most appreciated! I'll "process" all your suggestions, thanks!

> > @@ -50,10 +55,34 @@ static void __iomem *v2m_sysreg_base;
> >
> >  static void __init v2m_timer_init(void)
> >  {
> > -     void __iomem *sysctl_base;
> > -     void __iomem *timer01_base;
> > +     void __iomem *sysctl_base = NULL;
> > +     void __iomem *timer01_base = NULL;
> > +     unsigned int timer01_irq = NO_IRQ;
> > +
> > +     if (of_have_populated_dt()) {
> > +#if defined(CONFIG_ARCH_VEXPRESS_DT)
> > +             int err;
> > +             const char *path;
> > +             struct device_node *node;
> > +
> > +             node = of_find_compatible_node(NULL, NULL, "arm,sp810");
> > +             if (node)
> > +                     sysctl_base = of_iomap(node, 0);
> > +
> > +             err = of_property_read_string(of_aliases, "timer", &path);
> > +             if (!err)
> > +                     node = of_find_node_by_path(path);
> > +             if (node) {
> > +                     timer01_base = of_iomap(node, 0);
> > +                     timer01_irq = irq_of_parse_and_map(node, 0);
> > +             }
> > +#endif
> > +     } else {
> > +             sysctl_base = ioremap(V2M_SYSCTL, SZ_4K);
> > +             timer01_base = ioremap(V2M_TIMER01, SZ_4K);
> > +             timer01_irq = IRQ_V2M_TIMER0;
> > +     }
> 
> Do we even have of_have_populated_dt() in a non-DT kernel?
> 
> Maybe change this to
> 
> #if defined(CONFIG_ARCH_VEXPRESS_DT)
>         if (of_have_populated_dt()) {
>                 /* ... */
>         } else
> #endif
>         /* follow on from previous else */
>         {
>                 /* ... */
>         }
> 
> ...or if that feels a little unclear, maybe do this:
> 
> #if defined(CONFIG_ARCH_VEXPRESS_DT)
>         if (of_have_populated_dt()) {
>                 /* ... */
>         } else {
> #else
>         {
> #endif
>                 /* ... */
>         }

of_have_populated_dt() is safe, see "include/linux/of.h":

#ifdef CONFIG_OF 
static inline bool of_have_populated_dt(void)
{       
        return allnodes != NULL;
}       
#else /* CONFIG_OF */
static inline bool of_have_populated_dt(void)
{       
        return false;
}       
#endif /* CONFIG_OF */

> > @@ -63,20 +92,20 @@ static void __init v2m_timer_init(void)
> >               writel(scctrl, sysctl_base + SCCTRL);
> >       }
> >
> > -     timer01_base = ioremap(V2M_TIMER01, SZ_4K);
> > -     WARN_ON(!timer01_base);
> > -     if (timer01_base) {
> > +     WARN_ON(!timer01_base || timer01_irq != NO_IRQ);
> 
> Is that supposed to be !timer01_base || timer01_irq == NO_IRQ ?

Yes, I spotted and fixed this in the mean time.

> If so, is might be better to write
> 
> WARN_ON(!(expr));
> if (expr) {
>         ...
> 
> so that the conditions are clear inverses.

Good point, will do.

> > @@ -470,3 +499,99 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
> >       .timer          = &v2m_timer,
> >       .init_machine   = v2m_init,
> >  MACHINE_END
> 
> It would be useful to have a comment somewhere indicating that the
> DT_MACHINE_START() entries live in the corresponding ct-*.c files for
> DT-enabled coretiles.
> 
> Not essential, though ... most people do know how to use grep.

Where exactly would you see that comment?

Thanks for the review!

Pawe?
