From: rtivy@ti.com (Tivy, Robert)
Date: Wed, 23 Jan 2013 01:37:22 +0000
Subject: [PATCH v5 9/9] ARM: davinci: da850: Added dsp clock definition
In-Reply-To: <50FE802E.2020306@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-10-git-send-email-rtivy@ti.com> <50FE802E.2020306@ti.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C1431206095@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nori, Sekhar
> Sent: Tuesday, January 22, 2013 4:04 AM
> 
> Rob,
> 
> On 1/11/2013 5:53 AM, Robert Tivy wrote:
> > Added dsp clock definition, keyed to "davinci-rproc.0".
> >
> > Signed-off-by: Robert Tivy <rtivy@ti.com>
> > ---
> >  arch/arm/mach-davinci/da850.c |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-
> davinci/da850.c
> > index 097fcb2..50107c5 100644
> > --- a/arch/arm/mach-davinci/da850.c
> > +++ b/arch/arm/mach-davinci/da850.c
> > @@ -375,6 +375,14 @@ static struct clk sata_clk = {
> >  	.flags		= PSC_FORCE,
> >  };
> >
> > +static struct clk dsp_clk = {
> > +	.name		= "dsp",
> > +	.parent		= &pll0_sysclk1,
> > +	.domain		= DAVINCI_GPSC_DSPDOMAIN,
> > +	.lpsc		= DA8XX_LPSC0_GEM,
> > +	.flags		= PSC_LRST,
> > +};
> > +
> >  static struct clk_lookup da850_clks[] = {
> >  	CLK(NULL,		"ref",		&ref_clk),
> >  	CLK(NULL,		"pll0",		&pll0_clk),
> > @@ -421,6 +429,7 @@ static struct clk_lookup da850_clks[] = {
> >  	CLK("spi_davinci.1",	NULL,		&spi1_clk),
> >  	CLK("vpif",		NULL,		&vpif_clk),
> >  	CLK("ahci",		NULL,		&sata_clk),
> > +	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
> 
> Adding this clock node without the having the driver probed leads to
> kernel hang while booting. With CONFIG_DAVINCI_RESET_CLOCKS=n, the
> kernel boot fine. It looks like there is some trouble disabling the
> clock if it is not used. Can you please check this issue?
> 
> Thanks,
> Sekhar

Sekhar,

Thankyou for trying that out.

I discovered that the kernel boot hang is caused when trying to disable this clk during init, from within the function davinci_clk_disable_unused().  That function calls davinci_psc_config() which attempts to disable the DSP clock.  Since this clk is enabled after reset, disabling it involves a state transition, and therefore the function must wait for GOSTAT[1] to be 0.  For most peripherals this happens automatically, but for the DSP (and ARM, too), the DSP must execute the IDLE instruction to allow a clock enable->disable transition.  Since this is bootup and there is no real program on the DSP yet, this doesn't happen.

I was able to overcome this by adding PSC_FORCE to the clk->flags for dsp_clk.  In fact, without PSC_FORCE I was not able to "rmmod davinci_remoteproc" since the firmware file that I'm loading did not execute IDLE.  It feels like for davinci we should have a way to control the clk->flags' PSC_FORCE setting at run-time.  The PSC_FORCE would be set initially (during boot) and the user (or system integrator) would have a way to unset it dynamically.  That way, when the DSP firmware does actually have a structured way to enter IDLE, the user can say "I'd like a structured shutdown" and unset PSC_FORCE (via a clean API).  But for now I'm just going to turn on PSC_FORCE:
	.flags		= PSC_LRST | PSC_FORCE,

Thanks & Regards,

- Rob
