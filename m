From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Mon, 11 Jul 2011 13:08:38 +0300
Subject: [PATCH 1/1] ARM: i.MX50/53: debug-macro: fix UART_PADDR
In-Reply-To: <20110711093055.GJ13840@pengutronix.de>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
	<20110711090609.GB2482@matterhorn1>
	<20110711093055.GJ13840@pengutronix.de>
Message-ID: <20110711100838.GD2482@matterhorn1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 Jul 11, Uwe Kleine-K?nig wrote:
> On Mon, Jul 11, 2011 at 12:06:09PM +0300, Amit Kucheria wrote:
> > On 11 Jul 09, Troy Kisky wrote:
> > > The i.MX51 UART_PADDR value does not work for MX50/53.
> > > 
> > > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > 
> > Acked-by: Amit Kucheria <amit.kucheria@canonical.com>
> > 
> > but I think we should switch to runtime detection of the machine (machine
> > ID?) and then set the port address.
> > 
> > See arch/arm/plat-omap/include/plat/uncompress.h for a possible scheme.
> mach/debug-macro.S and mach/uncompress.h are two different things. And
> the uncompress stuff is dynamic for mxc AFAIK.
 
Indeed they're different. But it seems to me that
arch/arm/mach-omap2/include/mach/debug-macro.S and arch/arm/plat-omap/include/plat/uncompress.h
show clearly how we can deal with the serial port addresses (for DEBUG_LL)
dynamically. No?

> > > ---
> > >  arch/arm/plat-mxc/include/mach/debug-macro.S |    9 ++++++++-
> > >  1 files changed, 8 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
> > > index 8e8d175..3919ad4 100644
> > > --- a/arch/arm/plat-mxc/include/mach/debug-macro.S
> > > +++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
> > > @@ -37,13 +37,20 @@
> > >  #define UART_PADDR	MX3x_UART1_BASE_ADDR
> > >  #endif
> > >  
> > > -#ifdef CONFIG_ARCH_MX5
> > > +#ifdef CONFIG_ARCH_MX51
> > >  #ifdef UART_PADDR
> > >  #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> > >  #endif
> > >  #define UART_PADDR	MX51_UART1_BASE_ADDR
> > >  #endif
> > >  
> > > +#if defined(CONFIG_ARCH_MX50) || defined(CONFIG_ARCH_MX53)
> > > +#ifdef UART_PADDR
> > > +#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> > > +#endif
> > > +#define UART_PADDR	MX53_UART1_BASE_ADDR
> > > +#endif
> > > +
> Hm, even though it's obvious, maybe add a comment that
> MX50_UART1_BASE_ADDR is identical to MX53_UART1_BASE_ADDR?
> 

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
