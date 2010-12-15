From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 15 Dec 2010 17:40:46 +0100
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <201012151722.21939.arnd@arndb.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<1292244903-30392-2-git-send-email-shawn.guo@freescale.com>
	<201012151722.21939.arnd@arndb.de>
Message-ID: <20101215164046.GH28971@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 05:22:21PM +0100, Arnd Bergmann wrote:
> On Monday 13 December 2010, Shawn Guo wrote:
> > Add core definitions for MXS-based SoC MX23 and MX28.
> 
> How different are these from the MXC SoCs? Is it really
> worth having a totally separate plat-* directory for them?
They are different enough that Sascha and I suggested to seperate them.
The first version of this series integrated mxs into mach-imx +
plat-mxc.

> AFAICT, combining the two would make it much easier to build
> a kernel that works on mx23/28 as well as mx25 or the later
> MXS implementations.
Right, but seeing the differences to mxc I vote for an arm-global
approach to build a cross-platform kernel.

> > diff --git a/arch/arm/mach-mxs/include/mach/hardware.h b/arch/arm/mach-mxs/include/mach/hardware.h
> > new file mode 100644
> > index 0000000..53e89a0
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/include/mach/hardware.h
> > +
> > +#ifndef __MACH_MXS_HARDWARE_H__
> > +#define __MACH_MXS_HARDWARE_H__
> > +
> > +#ifdef __ASSEMBLER__
> > +#define IOMEM(addr)	(addr)
> > +#else
> > +#define IOMEM(addr)	((void __force __iomem *)(addr))
> > +#endif
> 
> This looks like a rather ugly hack to hide misuse of __iomem
> pointers. If you pass virtual addresses of I/O registers,
> just make them always be of type (void __iomem *), so you
> can actually benefit from the sparse annotations, rather
> working against them.
Actually this is to define the symbols for virtual addresses.  And
because gas doesn't understand void * it gets a plain number.

And note, this is something that rmk suggested.
 
> > +
> > +#ifndef __ASSEMBLER__
> > +static inline void __mxs_setl(u32 mask, void __iomem *reg)
> > +{
> > +	__raw_writel(mask, reg + MXS_SET_ADDR);
> > +}
> > +
> > +static inline void __mxs_clrl(u32 mask, void __iomem *reg)
> > +{
> > +	__raw_writel(mask, reg + MXS_CLR_ADDR);
> > +}
> > +
> > +static inline void __mxs_togl(u32 mask, void __iomem *reg)
> > +{
> > +	__raw_writel(mask, reg + MXS_TOG_ADDR);
> > +}
> > +#endif
> 
> Why __raw_writel()? All regular I/O accesses should use
> readl/writel etc, not the internal helpers.
nak, readl does little endian accesses, __raw_readl native endian.  So
for platform use __raw_readl is most of the time the better one.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
