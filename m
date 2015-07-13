From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 13 Jul 2015 17:51:51 +0100
Subject: [PATCH v2 09/10] arm64/BUG: Use BRK instruction for generic BUG
 traps
In-Reply-To: <20150713164315.GC22840@leverpostej>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
 <20150713164315.GC22840@leverpostej>
Message-ID: <20150713165151.GC10670@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 05:43:15PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Mon, Jul 13, 2015 at 02:25:56PM +0100, Dave P Martin wrote:
> > Currently, the minimal default BUG() implementation from asm-
> > generic is used for arm64.
> > 
> > This patch uses the BRK software breakpoint instruction to generate
> > a trap instead, similarly to most other arches, with the generic
> > BUG code generating the dmesg boilerplate.

[...]

> FWIW I've given this a spin and it seems to work, so:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks for testing.

> I have one concern with this below.
> 
> > +#ifndef _ARCH_ARM64_ASM_BUG_H
> > +#define _ARCH_ARM64_ASM_BUG_H
> > +
> > +#include <asm/debug-monitors.h>
> > +
> > +#ifdef CONFIG_GENERIC_BUG
> > +#define HAVE_ARCH_BUG
> > +
> > +#ifdef CONFIG_DEBUG_BUGVERBOSE
> > +#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
> > +#define __BUGVERBOSE_LOCATION(file, line)				\
> > +		".pushsection .rodata.str,\"aMS\", at progbits,1\n"	\
> > +	"2:	.string \"" file "\"\n\t"				\
> > +		".popsection\n\t"					\
> > +									\
> > +		".long 2b - 0b\n\t"					\
> > +		".short " #line "\n\t"
> > +#else
> > +#define _BUGVERBOSE_LOCATION(file, line)
> > +#endif
> 
> Given the reliance on the labels in the caller, I think it might make

Not sure what you mean here, can you elaborate?

> more sense to fold this into __BUG_FLAGS, and just have an #ifdef in the
> middle.
> 
> That would also mean passing file and line to the macro for the general
> case, like on arch/arm (even if !CONFIG_DEBUG_BUGVERBOSE), and moving
> the double-indirection of those out to the caller.

I'll take a look -- it is probably more complex at present than it needs
to be.

[...]

Cheers
---Dave
