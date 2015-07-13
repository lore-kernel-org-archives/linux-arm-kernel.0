From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jul 2015 17:43:15 +0100
Subject: [PATCH v2 09/10] arm64/BUG: Use BRK instruction for generic BUG
 traps
In-Reply-To: <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150713164315.GC22840@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 13, 2015 at 02:25:56PM +0100, Dave P Martin wrote:
> Currently, the minimal default BUG() implementation from asm-
> generic is used for arm64.
> 
> This patch uses the BRK software breakpoint instruction to generate
> a trap instead, similarly to most other arches, with the generic
> BUG code generating the dmesg boilerplate.
> 
> This allows bug metadata to be moved to a separate table and
> reduces the amount of inline code at BUG and WARN sites.  This also
> avoids clobbering any registers before they can be dumped.
> 
> To mitigate the size of the bug table further, this patch makes
> use of the existing infrastructure for encoding addresses within
> the bug table as 32-bit offsets instead of absolute pointers.
> (Note that this limits the kernel size to 2GB.)
> 
> Traps are registered at arch_initcall time for aarch64, but BUG
> has minimal real dependencies and it is desirable to be able to
> generate bug splats as early as possible.  This patch redirects
> all debug exceptions caused by BRK directly to bug_handler() until
> the full debug exception support has been initialised.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

FWIW I've given this a spin and it seems to work, so:

Tested-by: Mark Rutland <mark.rutland@arm.com>

I have one concern with this below.

> +#ifndef _ARCH_ARM64_ASM_BUG_H
> +#define _ARCH_ARM64_ASM_BUG_H
> +
> +#include <asm/debug-monitors.h>
> +
> +#ifdef CONFIG_GENERIC_BUG
> +#define HAVE_ARCH_BUG
> +
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
> +#define __BUGVERBOSE_LOCATION(file, line)				\
> +		".pushsection .rodata.str,\"aMS\", at progbits,1\n"	\
> +	"2:	.string \"" file "\"\n\t"				\
> +		".popsection\n\t"					\
> +									\
> +		".long 2b - 0b\n\t"					\
> +		".short " #line "\n\t"
> +#else
> +#define _BUGVERBOSE_LOCATION(file, line)
> +#endif

Given the reliance on the labels in the caller, I think it might make
more sense to fold this into __BUG_FLAGS, and just have an #ifdef in the
middle.

That would also mean passing file and line to the macro for the general
case, like on arch/arm (even if !CONFIG_DEBUG_BUGVERBOSE), and moving
the double-indirection of those out to the caller.

Otherwise this looks good to me.

As an aside, it looks to me like the arch/arm implementation never
allocates space for flags in each bug_entry, which I would have expected
to mess up the bug table. I must be missing something there.

Thanks,
Mark.

> +
> +#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)
> +
> +#define __BUG_FLAGS(flags) asm volatile (		\
> +		".pushsection __bug_table,\"a\"\n\t"	\
> +		".align 2\n\t"				\
> +	"0:	.long 1f - 0b\n\t"			\
> +_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
> +		".short " #flags "\n\t"			\
> +		".popsection\n"				\
> +							\
> +	"1:	brk %[imm]"				\
> +		:: [imm] "i" (BUG_BRK_IMM)		\
> +)
> +
> +#define BUG() do {				\
> +	_BUG_FLAGS(0);				\
> +	unreachable();				\
> +} while (0)
> +
> +#define __WARN_TAINT(taint) _BUG_FLAGS(BUGFLAG_TAINT(taint))
> +
> +#endif /* ! CONFIG_GENERIC_BUG */
> +
> +#include <asm-generic/bug.h>
> +
> +#endif /* ! _ARCH_ARM64_ASM_BUG_H */
