From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 23 Jul 2013 19:02:34 +0100
Subject: updates for be8 patch series
In-Reply-To: <CAA3XUr1o0cOCybSR=pCUT-WYP4xus5VrES6Hyzo-Wy4tcutTvQ@mail.gmail.com>
References: <CAA3XUr1o0cOCybSR=pCUT-WYP4xus5VrES6Hyzo-Wy4tcutTvQ@mail.gmail.com>
Message-ID: <51EEC53A.8070608@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/13 18:40, Victor Kamensky wrote:
> [resend in plain-text mode]
>
> Hi Ben,
>
> Wrt BE8 little endian instructions you will need to fix couple more places:
>      ftrace arch/arm/kernel/ftrace.c
>      kprobes arch/arm/kernel/kprobes.c
> Also in big endian mode atomic64_xxx function will need fixes, otherwise perf
> counters will be truncated on max of 32bit values
>      atomic64 arch/arm/include/asm/atomic.h
>
> I've attached board independent (core) patch from my work that made
> Pandaboard ES
> kernel run in BE mode. You can check my version of fixes for above issues in the
> patch. Look for corresponding files changes. Please rework them
> according to style
> and rules of your patch series. Note the patch itself contains fixes
> for few other
> issues that already fixed in your series. I'll cross check and compare
> individual
> areas latter. I think you may find attached patch interesting as well,
> it was developed
> independent from yours but matches it very well.
>
> Wrt of testing: ftrace was tested on Pandaboard ES, krprobes changes were tested
> with SystemTap at some point of patch version on Pandaboard ES (not
> thumb mode though),
> also it may deteriorated while ported across different kernel version,
> good idea to
> rested last patch. atomic64 were tested on Pandaboard ES and Marvell Armada XP.

Please wrap your emails to <80 characters, it was really difficult
to read this.

The atomic64 ops is an interesting one, I still think the in-kernel
one is correct. Why are atomic64 being used on 32bit? If you are
trying to decompose a 64bit into two 32bits, then that's probably
the problem.

The relocation code, the R_ARM instruction relocations should only
be instructions and therefore can be safely swapped using the correct
op-code accesses. The R_ARM_ABS32 IIRC is always in the same ordering
as the CPU would access data.

The kprobes stuff I am surprised if it works, due to the fact it calls
patch_text() which already uses <asm/opcodes.h> to do the relevant
byte-swapping. I think you only need to apply swaps to anything
that it loads from memory.

Which version of Linux did you patch?

I think this is the necessary change to kprobes:

diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 170e9f3..c548356 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -26,6 +26,7 @@
  #include <linux/stop_machine.h>
  #include <linux/stringify.h>
  #include <asm/traps.h>
+#include <asm/opcodes.h>
  #include <asm/cacheflush.h>

  #include "kprobes.h"
@@ -62,10 +63,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
  #ifdef CONFIG_THUMB2_KERNEL
         thumb = true;
         addr &= ~1; /* Bit 0 would normally be set to indicate Thumb 
code */
-       insn = ((u16 *)addr)[0];
+       insn = __mem_to_opcode_thumb16(((u16 *)addr)[0]);
         if (is_wide_instruction(insn)) {
                 insn <<= 16;
-               insn |= ((u16 *)addr)[1];
+               insn |= __mem_to_opcode_thumb16(((u16 *)addr)[1]);
                 decode_insn = thumb32_kprobe_decode_insn;
         } else
                 decode_insn = thumb16_kprobe_decode_insn;
@@ -73,7 +74,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
         thumb = false;
         if (addr & 0x3)
                 return -EINVAL;
-       insn = *p->addr;
+       insn = __mem_to_opcode_arm(*p->addr);
         decode_insn = arm_kprobe_decode_insn;
  #endif



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
