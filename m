From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 2 Aug 2013 14:57:33 +0100
Subject: [PATCH 1/4] ARM: kprobes: fix instruction fetch order with
 <asm/opcodes.h>
In-Reply-To: <51F968CB.8060605@codethink.co.uk>
References: <1374786537-10726-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374786537-10726-2-git-send-email-ben.dooks@codethink.co.uk>
 <1375084901.3521.3.camel@linaro1.home>
 <51F968CB.8060605@codethink.co.uk>
Message-ID: <20130802135727.GA2361@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 08:43:07PM +0100, Ben Dooks wrote:
> On 29/07/13 09:01, Jon Medhurst (Tixy) wrote:
> >On Thu, 2013-07-25 at 22:08 +0100, Ben Dooks wrote:
> >>If we are running BE8, the data and instruction endian-ness do not
> >>match, so use<asm/opcodes.h>  to correctly translate memory accesses
> >>into ARM instructions.
> >>
> >>Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>y
> >>---
> >>  arch/arm/kernel/kprobes-common.c |   14 ++++++++------
> >>  arch/arm/kernel/kprobes.c        |    9 +++++----
> >>  2 files changed, 13 insertions(+), 10 deletions(-)
> >>
> >>diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
> >>index 18a7628..c0b202e 100644
> >>--- a/arch/arm/kernel/kprobes-common.c
> >>+++ b/arch/arm/kernel/kprobes-common.c
> >>@@ -14,6 +14,7 @@
> >>  #include<linux/kernel.h>
> >>  #include<linux/kprobes.h>
> >>  #include<asm/system_info.h>
> >>+#include<asm/opcodes.h>
> >>
> >>  #include "kprobes.h"
> >>
> >>@@ -305,7 +306,8 @@ kprobe_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
> >>
> >>  	if (handler) {
> >>  		/* We can emulate the instruction in (possibly) modified form */
> >>-		asi->insn[0] = (insn&  0xfff00000) | (rn<<  16) | reglist;
> >>+		asi->insn[0] = __opcode_to_mem_arm((insn&  0xfff00000) |
> >>+						   (rn<<  16) | reglist);
> >>  		asi->insn_handler = handler;
> >>  		return INSN_GOOD;
> >>  	}
> >>@@ -338,9 +340,9 @@ prepare_emulated_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
> >>  		thumb_insn[2] = 0x4770; /* Thumb bx lr */
> >
> >The line above and the one before it not in this diff also need fixing
> >by changing to __opcode_to_mem_thumb16(0x4770).
> 
> IIRC, these are then fixed by the set_emulated instruction, which is
> also why the insn return is not swapped.
> 
> >>  		return insn;
> >>  	}
> >>-	asi->insn[1] = 0xe12fff1e; /* ARM bx lr */
> >>+	asi->insn[1] = __opcode_to_mem_arm(0xe12fff1e); /* ARM bx lr */
> >>  #else
> >>-	asi->insn[1] = 0xe1a0f00e; /* mov pc, lr */
> >>+	asi->insn[1] = __opcode_to_mem_arm(0xe1a0f00e); /* mov pc, lr */
> >>  #endif
> >>  	/* Make an ARM instruction unconditional */
> >>  	if (insn<  0xe0000000)
> >>@@ -360,12 +362,12 @@ set_emulated_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
> >>  	if (thumb) {
> >>  		u16 *ip = (u16 *)asi->insn;
> >>  		if (is_wide_instruction(insn))
> >>-			*ip++ = insn>>  16;
> >>-		*ip++ = insn;
> >>+			*ip++ = ___asm_opcode_to_mem_thumb16(insn>>  16);
> >>+		*ip++ = ___asm_opcode_to_mem_thumb16(insn);
> >
> >
> >Should these two ___asm_opcode_thumb32_compose() not be
> >__opcode_thumb32_compose() ?
> 
> I decided to leave this as is.

Although the intent is not made as clear in the header as it could be,
the ___asm() functions are not supposed to be used directly:
__opcode_thumb32_compose() will map to the correct thing based on
whether we are preprocessing assembler or C.

In particular, ___asm_opcode_thumb32_compose() will give you inefficient
swabbing if used directly in C.

> >>  		return;
> >>  	}
> >>  #endif
> >>-	asi->insn[0] = insn;
> >>+	asi->insn[0] = __opcode_to_mem_arm(insn);
> >>  }
> >>
> >>  /*
> >>diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
> >>index 170e9f3..3775af1 100644
> >>--- a/arch/arm/kernel/kprobes.c
> >>+++ b/arch/arm/kernel/kprobes.c
> >>@@ -26,6 +26,7 @@
> >>  #include<linux/stop_machine.h>
> >>  #include<linux/stringify.h>
> >>  #include<asm/traps.h>
> >>+#include<asm/opcodes.h>
> >>  #include<asm/cacheflush.h>
> >>
> >>  #include "kprobes.h"
> >>@@ -62,10 +63,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >>  #ifdef CONFIG_THUMB2_KERNEL
> >>  	thumb = true;
> >>  	addr&= ~1; /* Bit 0 would normally be set to indicate Thumb code */
> >>-	insn = ((u16 *)addr)[0];
> >>+	insn = __mem_to_opcode_thumb16(((u16 *)addr)[0]);
> >>  	if (is_wide_instruction(insn)) {
> >>-		insn<<= 16;
> >>-		insn |= ((u16 *)addr)[1];
> >>+		u16 inst2 = __mem_to_opcode_thumb16(((u16 *)addr)[1]);
> >>+		insn = ___asm_opcode_thumb32_compose(insn, inst2);
> >
> >Again, __opcode_thumb32_compose instead of
> >___asm_opcode_thumb32_compose

ditto, this should be changed.

Cheers
---Dave
