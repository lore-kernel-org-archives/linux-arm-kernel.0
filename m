From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 Oct 2010 14:34:16 +0200
Subject: [PATCH v2] i.MX35: use the correct IIM register to get CPU
	revision
In-Reply-To: <20101008123102.GH29673@pengutronix.de>
References: <1286524957-30218-1-git-send-email-eric@eukrea.com>
	<1286525909-30956-1-git-send-email-eric@eukrea.com>
	<20101008123102.GH29673@pengutronix.de>
Message-ID: <20101008123416.GO28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 08, 2010 at 02:31:02PM +0200, Uwe Kleine-K?nig wrote:
> Hello Eric,
> 
> On Fri, Oct 08, 2010 at 10:18:29AM +0200, Eric B?nard wrote:
> > instead of using ROM_SI_REV use IIM's Silicon Revision register
> > as described in :
> > - Reference Manual 29.3.3.10
> > - RM Errata 29.3.3.9.13
> > 
> > Signed-off-by: Eric B?nard <eric@eukrea.com>
> > ---
> > v2 : fix wrong part of previous patch in plat-mxc/include/mach/mx35.h
> >  arch/arm/mach-mx3/clock-imx35.c       |    1 +
> >  arch/arm/mach-mx3/cpu.c               |   23 +++++++++--------------
> >  arch/arm/plat-mxc/include/mach/mx35.h |    2 ++
> >  3 files changed, 12 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
> > index 85884c7..f7cec59 100644
> > --- a/arch/arm/mach-mx3/clock-imx35.c
> > +++ b/arch/arm/mach-mx3/clock-imx35.c
> > @@ -535,6 +535,7 @@ int __init mx35_clocks_init()
> >  	__raw_writel(cgr2, CCM_BASE + CCM_CGR2);
> >  	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);
> >  
> > +	clk_enable(&iim_clk);
> >  	mx35_read_cpu_rev();
> 
> Do you let the clock running on purpose?
> 
> >  	mxc_timer_init(&gpt_clk,
> > diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
> > index db7af50..d00a754 100644
> > --- a/arch/arm/mach-mx3/cpu.c
> > +++ b/arch/arm/mach-mx3/cpu.c
> > @@ -59,31 +59,26 @@ void __init mx31_read_cpu_rev(void)
> >  unsigned int mx35_cpu_rev;
> >  EXPORT_SYMBOL(mx35_cpu_rev);
> >  
> > -#define MX35_ROM_SI_REV		0x40
> > -
> >  void __init mx35_read_cpu_rev(void)
> >  {
> > -	void __iomem *rom = ioremap(MX35_IROM_BASE_ADDR, MX35_IROM_SIZE);
> >  	u32 rev;
> >  	char *srev = "unknown";
> >  
> > -	if (!rom)
> > -		return;
> > -
> > -	rev = readl(rom + MX35_ROM_SI_REV);
> > +	rev = __raw_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));
> >  	switch (rev) {
> > -	case 0x1:
> > -		mx35_cpu_rev = MX35_CHIP_REV_1_0;
> > +	case 0x00:
> > +		mx35_cpu_rev = MX3x_CHIP_REV_1_0;
> >  		srev = "1.0";
> >  		break;
> > -	case 0x2:
> > -		mx35_cpu_rev = MX35_CHIP_REV_2_0;
> > +	case 0x10:
> > +		mx35_cpu_rev = MX3x_CHIP_REV_2_0;
> >  		srev = "2.0";
> >  		break;
> > +	case 0x11:
> > +		mx35_cpu_rev = MX3x_CHIP_REV_2_1;
> > +		srev = "2.1";
> > +		break;
> Would it make sense here to do:
> 
> 	mx35_cpu_rev = 0x10 + rev;

I think this makes only sense when someone from Freescale says it's
correct. Otherwise I would prefer getting an 'unknown' here as a heads
up for new silicon versions.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
