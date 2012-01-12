From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 12 Jan 2012 14:48:03 -0500 (EST)
Subject: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
 changes
In-Reply-To: <alpine.LFD.2.02.1201121441580.2722@xanadu.home>
References: <20120112184256.GA2287@atomide.com>
 <alpine.LFD.2.02.1201121441580.2722@xanadu.home>
Message-ID: <alpine.LFD.2.02.1201121447270.2722@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Jan 2012, Nicolas Pitre wrote:

> On Thu, 12 Jan 2012, Tony Lindgren wrote:
> 
> > Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
> > (Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linux
> > into devel-stable) merged generic ioremap changes.
> > 
> > Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
> > (ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
> > added a workaround for omap4.
> > 
> > In order for the errata to work, we now need the following
> > patch or else we'll get:
> > 
> > kernel BUG at mm/vmalloc.c:1134!
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > --- a/arch/arm/mach-omap2/common.h
> > +++ b/arch/arm/mach-omap2/common.h
> > @@ -132,6 +132,7 @@ void omap3_map_io(void);
> >  void am33xx_map_io(void);
> >  void omap4_map_io(void);
> >  void ti81xx_map_io(void);
> > +int omap_barriers_init(void);
> >  
> >  /**
> >   * omap_test_timeout - busy-loop, testing a condition
> > --- a/arch/arm/mach-omap2/io.c
> > +++ b/arch/arm/mach-omap2/io.c
> > @@ -306,7 +306,12 @@ void __init omapam33xx_map_common_io(void)
> >  #ifdef CONFIG_ARCH_OMAP4
> >  void __init omap44xx_map_common_io(void)
> >  {
> > +	int res;
> > +
> >  	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
> > +	res = omap_barriers_init();
> > +	if (res)
> > +		pr_err("Barriers broken\n");
> 
> Do you really need that return code?
> 
> It was initially hooked to core_initcall() which requires a return code.  
> Now that you call it directly you could get rid of it.

s/rid of it/rid of the return code/


Nicolas
