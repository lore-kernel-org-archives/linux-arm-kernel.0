From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 5 Sep 2010 10:01:22 +0200
Subject: [PATCH] ARM: pxa: Fix pxa3xx-u2d crash when ULPI not used
In-Reply-To: <4C834CB7.70800@compulab.co.il>
References: <1283546146-20000-1-git-send-email-marek.vasut@gmail.com>
	<4C834CB7.70800@compulab.co.il>
Message-ID: <201009051001.22816.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 5. z??? 2010 09:54:31 Igor Grinberg napsal(a):
>  On 09/03/10 23:35, Marek Vasut wrote:
> > In case the pxa3xx-u2d driver isn't used, probing of ohci-pxa27x will
> > cause an ugly kernel crash (NULL pointer dereference in
> > pxa3xx_u2d_start_hc(), because struct u2d is NULL and clk_enable() call
> > will crash the kernel, trying to access it).
> 
> ohci code checks for pxa3xx cpu and only then runs start/stop hc.

Exactly ... and in case "struct pxa3xx_u2d_ulpi *u2d" is NULL, clk_enable will 
crash the kernel.

> pxa3xx_ulpi.c is compiled if CONFIG_PXA3xx is selected.
> The device <-> driver binding should not be a problem, so the
> pxa3xx_u2d_probe() will run.
> The only case, I see, when struct u2d does not exist is failure of the
> probe function. If this is the case, we are having an abnormal execution
> and if your patch is dealing with this issue, shouldn't you comment it as
> such?

Not at all ... if the pxa3xx-u2d driver isn't loaded at all, the function 
(start/stop hc) is still called, but struct pxa3xx_u2d_ulpi *u2d is NULL. In 
this case, if you call clk_enable(u2d->clk), you crash the kernel (because u2d 
is NULL).

Good night, I'll be back in 8 hrs or so :)

> 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> > 
> >  arch/arm/mach-pxa/pxa3xx-ulpi.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c
> > b/arch/arm/mach-pxa/pxa3xx-ulpi.c index e57439e..ce7168b 100644
> > --- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
> > +++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> > @@ -252,6 +252,10 @@ int pxa3xx_u2d_start_hc(struct usb_bus *host)
> > 
> >  {
> >  
> >  	int err = 0;
> > 
> > +	/* In case the PXA3xx ULPI isn't used, do nothing. */
> > +	if (!u2d)
> > +		return 0;
> > +
> > 
> >  	clk_enable(u2d->clk);
> >  	
> >  	if (cpu_is_pxa310()) {
> > 
> > @@ -264,6 +268,10 @@ int pxa3xx_u2d_start_hc(struct usb_bus *host)
> > 
> >  void pxa3xx_u2d_stop_hc(struct usb_bus *host)
> >  {
> > 
> > +	/* In case the PXA3xx ULPI isn't used, do nothing. */
> > +	if (!u2d)
> > +		return;
> > +
> > 
> >  	if (cpu_is_pxa310())
> >  	
> >  		pxa310_stop_otg_hc();
