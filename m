From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 17:58:42 +0100
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <20101215164046.GH28971@pengutronix.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<201012151722.21939.arnd@arndb.de>
	<20101215164046.GH28971@pengutronix.de>
Message-ID: <201012151758.42896.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, Uwe Kleine-K?nig wrote:
> On Wed, Dec 15, 2010 at 05:22:21PM +0100, Arnd Bergmann wrote:
> > AFAICT, combining the two would make it much easier to build
> > a kernel that works on mx23/28 as well as mx25 or the later
> > MXS implementations.
> Right, but seeing the differences to mxc I vote for an arm-global
> approach to build a cross-platform kernel.

Ok, makes sense.

> > > +
> > > +#ifndef __ASSEMBLER__
> > > +static inline void __mxs_setl(u32 mask, void __iomem *reg)
> > > +{
> > > +	__raw_writel(mask, reg + MXS_SET_ADDR);
> > > +}
> > > +
> > > +static inline void __mxs_clrl(u32 mask, void __iomem *reg)
> > > +{
> > > +	__raw_writel(mask, reg + MXS_CLR_ADDR);
> > > +}
> > > +
> > > +static inline void __mxs_togl(u32 mask, void __iomem *reg)
> > > +{
> > > +	__raw_writel(mask, reg + MXS_TOG_ADDR);
> > > +}
> > > +#endif
> > 
> > Why __raw_writel()? All regular I/O accesses should use
> > readl/writel etc, not the internal helpers.
> nak, readl does little endian accesses, __raw_readl native endian.  So
> for platform use __raw_readl is most of the time the better one.

Then we should define a proper function for this with well-defined
behaviour. I would suggest defining a mxs_readl/mxs_writel here,
that is defined to have the same endianess as the mxs SOC, but
otherwise has the same properties as readl/writel.

	Arnd
