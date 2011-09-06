From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Sep 2011 14:33:23 -0400 (EDT)
Subject: [PATCH 3/6] ARM: mach-omap1: clean up debug-macro.S
In-Reply-To: <20110905094928.GC1903@atomide.com>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
	<1314932353-24813-4-git-send-email-nico@fluxnic.net>
	<20110905094928.GC1903@atomide.com>
Message-ID: <alpine.LFD.2.00.1109061430210.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Sep 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [110901 19:26]:
> > --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > @@ -34,13 +29,13 @@ omap_uart_virt:	.word	0x0
> >  		.macro	addruart, rp, rv, tmp
> >  
> >  		/* Use omap_uart_phys/virt if already configured */
> > -9:		mrc	p15, 0, \rp, c1, c0
> > -		tst	\rp, #1			@ MMU enabled?
> > -		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
> > -		ldrne	\rp, =omap_uart_phys	@ MMU enabled
> > -		add	\rv, \rp, #4		@ omap_uart_virt
> > -		ldr	\rp, [\rp, #0]
> > -		ldr	\rv, [\rv, #0]
> > +9:		adr	\rp, 11f		@ get effective addr of 11f
> > +		ldr	\rv, [\rp]		@ get absolute addr of 11f
> > +		sub	\rv, \rv, \rp		@ offset between the two
> > +		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
> > +		sub	\tmp, \rp, \rv		@ make it effective
> > +		ldr	\rp, [\tmp, #0]		@ omap_uart_phys
> > +		ldr	\rv, [\tmp, #4]		@ omap_uart_virt
> >  		cmp	\rp, #0			@ is port configured?
> >  		cmpne	\rv, #0
> >  		bne	99f			@ already configured
> 
> The 11f above will fail for omap1 as we already have 11 defined there
> for omap1 uart1. The prepare patch I posted as 2.5/6 fixes that issue.

Thanks, fixed here now.

> This will also allow further clean-up to combine omap1 and omap2+
> debug-macro.S.

I'll leave that to you.  My motive was to get rid of PLAT_PHYS_OFFSET so 
that mach/memory.h could eventually be deleted further down my patch 
series.


Nicolas
