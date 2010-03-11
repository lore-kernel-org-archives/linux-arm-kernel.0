From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Mar 2010 10:56:37 +0000
Subject: [PATCH 1/2] mx1: fix build when DEBUG_LL is enabled
In-Reply-To: <20100311103940.GA19320@pengutronix.de>
References: <e5558b1571cff8472994ed51622339fd9e517f5e.1268129163.git.baruch@tkos.co.il>
	<20100311103940.GA19320@pengutronix.de>
Message-ID: <20100311105637.GE16376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 11, 2010 at 11:39:41AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Mar 09, 2010 at 12:12:04PM +0200, Baruch Siach wrote:
> > Commit "mx1: prefix SOC specific defines with MX1_ and deprecate old names"
> > redefined the IO_ADDRESS macro in a way that is incompatible with
> > debug-macro.S. Reintroduce AVIC_IO_ADDRESS, and use it in debug-macro.S.
> This feels wrong.  Can you please instead fix IMX_IO_ADDRESS?
> 
> Something like:
> 
> 	#ifdef __ASSEMBLY__
> 	#define IOREG(x) (x)
> 	#else
> 	#define IOREG(x) ((void __force __iomem *)(x))
> 	#endif
> 
> 	#define IMX_IO_ADDRESS(addr, module) IOREG(\
> 	...
> 
> could work.  Don't know if the cast to unsigned long works in assembler.
> Maybe it's unneeded?  Don't remember.

This is what I put in place for OMAP:

#ifdef __ASSEMBLER__
#define IOMEM(x)                (x)
#else
#define IOMEM(x)                ((void __force __iomem *)(x))
#endif

and then define all your device virtual addresses as normal hex integers
wrapped in IOMEM().

You can then use those symbols in assembly and C without any harm.

I'd prefer folk use the same macro across all platforms - it's something
we should eventually move to the asm/ includes - but not yet because there
isn't a clear include that it should go in.  (asm/io.h seems logical but
has problems for assembly.)
