From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2011 17:44:20 +0000
Subject: [PATCH 1/5] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <1321618848.24216.322.camel@hornet.cambridge.arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-2-git-send-email-pawel.moll@arm.com>
 <20111117154308.GS9581@n2100.arm.linux.org.uk>
 <1321618848.24216.322.camel@hornet.cambridge.arm.com>
Message-ID: <20111118174420.GG9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 12:20:48PM +0000, Pawel Moll wrote:
> On Thu, 2011-11-17 at 15:43 +0000, Russell King - ARM Linux wrote:
> > > +/* Tile's peripherals static mappings should start here */
> > > +#define V2T_PERIPH 0xf8200000
> > > +#define V2T_PERIPH_P2V(offset) ((void __iomem *)(V2T_PERIPH | (offset)))
> > > +
> > 
> > Please get rid of these blank lines at the end of files.
> 
> Patch splitting leftover. Will fix.
> 
> > > +static void __iomem *v2m_sysreg_base;
> > > +
> > > +
> > > +
> > 
> > More useless blank lines.
> 
> Ok, will change that. I just like the way that the data are visually
> separated from the code like here:
> 
> ceade897 (Russell King 2010-02-11 21:44:53 +0000  68)         .init   = v2m_timer_init,
> ceade897 (Russell King 2010-02-11 21:44:53 +0000  69) };
> ceade897 (Russell King 2010-02-11 21:44:53 +0000  70) 
> ceade897 (Russell King 2010-02-11 21:44:53 +0000  71) 
> ceade897 (Russell King 2010-02-11 21:44:53 +0000  72) static DEFINE_SPINLOCK(v2m_cfg_lock);
> 
> or here:
> 
> ceade897 (Russell King 2010-02-11 21:44:53 +0000 289)         &rtc_device,
> ceade897 (Russell King 2010-02-11 21:44:53 +0000 290) };
> ceade897 (Russell King 2010-02-11 21:44:53 +0000 291) 
> ceade897 (Russell King 2010-02-11 21:44:53 +0000 292) 
> ceade897 (Russell King 2010-02-11 21:44:53 +0000 293) static long v2m_osc_round(struct clk *clk, unsigned long rate)

Note the difference in the number.  Two is acceptable to split sections
of code.  Three is getting excessive.

> 
> > >  static void __init v2m_timer_init(void)
> > >  {
> > > +	void *sysctl_base;
> > > +	void *timer01_base;
> > 
> > Do you not use sparse?  __iomem.
> 
> Ok.
> 
> > > +	unsigned int timer01_irq;
> > >  	u32 scctrl;
> > >  
> > > +		sysctl_base = ioremap(V2M_SYSCTL, SZ_4K);
> > > +		BUG_ON(!sysctl_base);
> > > +		timer01_base = ioremap(V2M_TIMER01, SZ_4K);
> > > +		BUG_ON(!timer01_base);
> > > +		timer01_irq = IRQ_V2M_TIMER0;
> > 
> > What's going on with the indentation here?
> 
> Patch-splitting artefact again, will fix.
> 
> > > @@ -413,6 +431,10 @@ static void __init v2m_populate_ct_desc(void)
> > >  static void __init v2m_map_io(void)
> > >  {
> > >  	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
> > > +
> > > +	/* Will become an ioremap() when possible */
> > > +	v2m_sysreg_base = V2M_PERIPH_P2V(V2M_SYSREGS);
> > 
> > It won't if it stays here.
> 
> Excuse my inferior English language capabilities, but what do you
> suggest here?

What I'm saying is your comment is wrong.  ioremap() will never be
possible in the map_io function.
