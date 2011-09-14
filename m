From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 14 Sep 2011 05:54:46 -0600 (MDT)
Subject: [PATCH] OMAP2+: hwmod: remove OMAP_CHIP*
In-Reply-To: <CANOLnOOkz2ZkhPSafTLxUUH2bSVoRrYA44-C1+yku8naYaRz3w@mail.gmail.com>
References: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
	<CANOLnOOkz2ZkhPSafTLxUUH2bSVoRrYA44-C1+yku8naYaRz3w@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1109140546300.27954@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gra?vydas,

On Mon, 5 Sep 2011, Grazvydas Ignotas wrote:

> On Mon, Sep 5, 2011 at 5:43 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> > index 84cc0bd..d7138070 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> <snip>
> 
> >
> > ?int __init omap3xxx_hwmod_init(void)
> > ?{
> > - ? ? ? return omap_hwmod_register(omap3xxx_hwmods);
> > + ? ? ? int r;
> > + ? ? ? struct omap_hwmod **h = NULL;
> > +
> > + ? ? ? /* Register hwmods common to all OMAP3 */
> > + ? ? ? r = omap_hwmod_register(omap3xxx_hwmods);
> > + ? ? ? if (!r)
> > + ? ? ? ? ? ? ? return r;
> > +
> > + ? ? ? /*
> > + ? ? ? ?* Register hwmods common to individual OMAP3 families, all
> > + ? ? ? ?* silicon revisions (e.g., 34xx, or AM3505/3517, or 36xx)
> > + ? ? ? ?* All possible revisions should be included in this conditional.
> > + ? ? ? ?*/
> > + ? ? ? if (omap_rev() == OMAP3430_REV_ES1_0 ||
> > + ? ? ? ? ? omap_rev() == OMAP3430_REV_ES2_0 ||
> > + ? ? ? ? ? omap_rev() == OMAP3430_REV_ES2_1 ||
> > + ? ? ? ? ? omap_rev() == OMAP3430_REV_ES3_0 ||
> > + ? ? ? ? ? omap_rev() == OMAP3430_REV_ES3_1 ||
> > + ? ? ? ? ? omap_rev() == OMAP3430_REV_ES3_1_2) {
> > + ? ? ? ? ? ? ? h = omap34xx_hwmods;
> > + ? ? ? } else if (omap_rev() & OMAP3505_REV(0)) {
> > + ? ? ? ? ? ? ? h = am35xx_hwmods;
> 
> This check will be always true I think?

Thanks for the review; you are absolutely right and this will be fixed.

> Why not just use cpu_is_omap3xxx() for these tests, since it does same
> omap_rev() call but only once per family?

cpu_is_omap*() doesn't do what one would expect :-(

For example, cpu_is_omap34xx() returns 1 on not only 34xx, but also 36xx 
and 3517/3505.  Unfortunately, we don't currently do a good job of 
separating SoC family detection from individual SoC detection.

If your objection is to the multiple calls to omap_rev(), those do indeed 
appear in the source to be potentially expensive function calls -- 
although the compiler should inline them.  Just to be sure, the 
next revision will use a variable.

regards


- Paul
