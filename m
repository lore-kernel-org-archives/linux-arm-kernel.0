From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 08 Sep 2010 13:46:15 -0400 (EDT)
Subject: [PATCH 2/2] ARM: mxc: turn off HWCAP_NEON for older versions of
	imx51 silicon
In-Reply-To: <4C8796E6.3010905@ru.mvista.com>
References: <1283890733-6548-1-git-send-email-nico@fluxnic.net>
	<1283890733-6548-3-git-send-email-nico@fluxnic.net>
	<4C8796E6.3010905@ru.mvista.com>
Message-ID: <alpine.LFD.2.00.1009081334150.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Sep 2010, Sergei Shtylyov wrote:

> Hello.
> 
> Nicolas Pitre wrote:
> 
> > From: Amit Kucheria <amit.kucheria@verdurent.com>
> 
> > Versions of silicon older than TO3 have broken NEON implementation. Turn off
> > NEON in such cases.
> 
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Tested-by: Dave Martin <dave.martin@linaro.org>
> > Tested-by: Jason Hui <jason.hui@linaro.org>
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > ---
> >  arch/arm/mach-mx5/cpu.c |   19 +++++++++++++++++++
> >  1 files changed, 19 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> > index 2d37785..548c55b 100644
> > --- a/arch/arm/mach-mx5/cpu.c
> > +++ b/arch/arm/mach-mx5/cpu.c
> > @@ -70,6 +70,25 @@ int mx51_revision(void)
> >  }
> >  EXPORT_SYMBOL(mx51_revision);
> >  +#ifdef CONFIG_NEON
> > +
> > +/* All versions of the silicon before Rev. 3 have broken NEON
> > implementations.
> > + * Dependent on link order - so the assumption is that vfp_init is called
> > before us
> > + */
> > +static int __init mx51_neon_fixup(void)
> > +{
> > +	if (mx51_revision() <  MX51_CHIP_REV_3_0) {
> 
>   Too many spaces after '<'?

Yup.

> > +		if (elf_hwcap & HWCAP_NEON) {
> 
>    Could be collapsed into the preceding *if*, and so indentation level made
> one less...

I amended this patch with your suggestion and pushed it out.

Russell, if you pulled this already I'll just send you a fixup patch in 
that case.


Nicolas
