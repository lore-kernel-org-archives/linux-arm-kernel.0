From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Jan 2010 11:03:38 -0800
Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic
In-Reply-To: <20100116193313.GA23092@n2100.arm.linux.org.uk>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013515.10065.30649.stgit@baageli.muru.com>
	<20100116093555.GA13596@n2100.arm.linux.org.uk>
	<20100116191820.GI10318@atomide.com>
	<20100116193313.GA23092@n2100.arm.linux.org.uk>
Message-ID: <20100121190337.GN23467@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 11:31]:
> On Sat, Jan 16, 2010 at 11:18:20AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 01:33]:
> > > On Fri, Jan 15, 2010 at 05:35:15PM -0800, Tony Lindgren wrote:
> > > > diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > > > index 23e4724..0174858 100644
> > > > --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> > > > +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > > > @@ -15,18 +15,71 @@
> > > >  
> > > >  #include <plat/serial.h>
> > > >  
> > > > +omap_uart_phys:	.word	0x0
> > > > +omap_uart_virt:	.word	0x0
> > > 
> > > I assume that you have no plans for XIP kernel support on OMAP, since
> > > these will be placed in the .text section, and is therefore read-only
> > > on XIP kernels.
> > 
> > Did not think of that.. Maybe some addruart_premable solution here would.
> > Or adding \tmp register for addruart and just do the detection for each
> > character.

<snip>
 
> Why not do something like this:
> 
> 		.pushsection .data
> omap_uart_phys:	.word 0
> omap_uart_virt:	.word 0
> 		.popsection
> 
> 		.macro addruart, rx
> ...		
> +               ldreq   \rx, =omap_uart_phys    @ physical base address
> +               ldrne   \rx, =omap_uart_virt    @ virtual base
> 		ldr	\rx, [\rx]
> +               cmp     \rx, #0                 @ is port configured?
> +               bne     99f                     @ already configured
> ...
> 
> ?

Works fine, but it add one issue. Looks like we need to add tmp register
into addruart to initially save the omap_uart_phys and omap_uart_virt:

+		/* Store both phys and virt address for the uart */
+98:		add	\rx, \rx, #0x48000000	@ phys base
+		ldr	\tmp, =omap_uart_phys
+		str	\rx, [\tmp, #0]
+		sub	\rx, \rx, #0x48000000	@ phys base
+		add	\rx, \rx, #0xfa000000	@ virt base
+		ldr	\tmp, =omap_uart_virt
+		str	\rx, [\tmp, #0]

Does the following patch look OK to you, or do you have some other way
in mind for doing it?

Regards,

Tony
