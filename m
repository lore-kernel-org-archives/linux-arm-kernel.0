From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 25 Jul 2013 19:09:12 +0100
Subject: [PATCH] ARM: kdgb: use .inst for data to be assembled as
 intruction
In-Reply-To: <51F15CAE.7020008@codethink.co.uk>
References: <1374763778-5305-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374763778-5305-2-git-send-email-ben.dooks@codethink.co.uk>
 <20130725171130.GE2546@localhost.localdomain>
 <51F15CAE.7020008@codethink.co.uk>
Message-ID: <20130725180912.GG2546@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 06:13:18PM +0100, Ben Dooks wrote:
> On 25/07/13 18:11, Dave Martin wrote:
> >On Thu, Jul 25, 2013 at 03:49:38PM +0100, Ben Dooks wrote:
> >>The arch_kgdb_breakpoint() function uses an inline assembly directive
> >>to assemble a specific instruction using .word. This means the linker
> >>will not treat is as an instruction, and therefore incorrectly swap
> >>the endian-ness if running BE8.
> >>
> >>Note, not tested, please comment if this is wrong.
> >>
> >>Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
> >>---
> >>  arch/arm/include/asm/kgdb.h |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
> >>index 48066ce..76227c8 100644
> >>--- a/arch/arm/include/asm/kgdb.h
> >>+++ b/arch/arm/include/asm/kgdb.h
> >>@@ -41,7 +41,7 @@
> >>
> >>  static inline void arch_kgdb_breakpoint(void)
> >>  {
> >>-	asm(".word 0xe7ffdeff");
> >>+	asm(".inst 0xe7ffdeff");
> >
> >Yikes, this isn't going to work in a Thumb kernel.
> >
> >We should make HAVE_ARCH_KGDB depend on !THUMB2_KERNEL until/unless that
> >gets fixed...  It looks like the incompatibilities may be more extensive
> >than just this one instruction.
> >
> >
> >For the ARM case, similarly to the other patches, please use the __inst
> >macros from<asm/opcodes.h>  instead of emitting the opcode explicitly.
> 
> See previous objections to that, plus they're marked for internal use
> only!

Ditto my counterarguments.  I'm not emotionally attached to __inst*(), but
we should use one or the other: either .inst or __inst(), not a mixture.
However, the __inst macros work for inline asm and .S, and do more than
just emitting a single opcode; see opcodes-virt.h for example, so while
removing them isn't rocket science, it would involve churn in a few places.


Note, the "Don't use these directly" comment only applies to the triple-
underscored helpers.

The broader "using these macros directly is poor practice" comment was
an attempt to engourage people to write the likes of

#define __KGDB_BKPT_INSTR __inst_arm(0xxe7ffdeff)

static inline void arch_kgdb_breakpoint(void)
{
	asm(__KGDB_BKPT_INSTR);
}

...on the basis that this ought to be more readable.

But this is a bit moot in a situation like this where the opcode is
only used in one place, by itself, in a wrapper whose name makes the
intent clear anyway.

Cheers
---Dave
