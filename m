From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Jul 2016 09:44:17 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <578FCC3A.6090805@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578F4608.4030901@arm.com> <578FCC3A.6090805@linaro.org>
Message-ID: <57908B61.2020901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/16 20:08, David Long wrote:
> On 07/20/2016 05:36 AM, Marc Zyngier wrote:
>> On 08/07/16 17:35, David Long wrote:
>>> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>>
>>> Add support for basic kernel probes(kprobes) and jump probes
>>> (jprobes) for ARM64.
>>>
>>> Kprobes utilizes software breakpoint and single step debug
>>> exceptions supported on ARM v8.
>>>
>>> A software breakpoint is placed at the probe address to trap the
>>> kernel execution into the kprobe handler.
>>>
>>> ARM v8 supports enabling single stepping before the break exception
>>> return (ERET), with next PC in exception return address (ELR_EL1). The
>>> kprobe handler prepares an executable memory slot for out-of-line
>>> execution with a copy of the original instruction being probed, and
>>> enables single stepping. The PC is set to the out-of-line slot address
>>> before the ERET. With this scheme, the instruction is executed with the
>>> exact same register context except for the PC (and DAIF) registers.
>>>
>>> Debug mask (PSTATE.D) is enabled only when single stepping a recursive
>>> kprobe, e.g.: during kprobes reenter so that probed instruction can be
>>> single stepped within the kprobe handler -exception- context.
>>> The recursion depth of kprobe is always 2, i.e. upon probe re-entry,
>>> any further re-entry is prevented by not calling handlers and the case
>>> counted as a missed kprobe).
>>>
>>> Single stepping from the x-o-l slot has a drawback for PC-relative accesses
>>> like branching and symbolic literals access as the offset from the new PC
>>> (slot address) may not be ensured to fit in the immediate value of
>>> the opcode. Such instructions need simulation, so reject
>>> probing them.
>>>
>>> Instructions generating exceptions or cpu mode change are rejected
>>> for probing.
>>>
>>> Exclusive load/store instructions are rejected too.  Additionally, the
>>> code is checked to see if it is inside an exclusive load/store sequence
>>> (code from Pratyush).
>>>
>>> System instructions are mostly enabled for stepping, except MSR/MRS
>>> accesses to "DAIF" flags in PSTATE, which are not safe for
>>> probing.
>>>
>>> This also changes arch/arm64/include/asm/ptrace.h to use
>>> include/asm-generic/ptrace.h.
>>>
>>> Thanks to Steve Capper and Pratyush Anand for several suggested
>>> Changes.
>>>
>>> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>>> ---
>>
>> [...]
>>
>>> +void __kprobes jprobe_return(void)
>>> +{
>>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>>> +
>>> +	/*
>>> +	 * Jprobe handler return by entering break exception,
>>> +	 * encoded same as kprobe, but with following conditions
>>> +	 * -a magic number in x0 to identify from rest of other kprobes.
>>> +	 * -restore stack addr to original saved pt_regs
>>> +	 */
>>> +	asm volatile ("ldr x0, [%0]\n\t"
>>> +		      "mov sp, x0\n\t"
>>> +		      ".globl jprobe_return_break\n\t"
>>> +		      "jprobe_return_break:\n\t"
>>> +		      "brk %1\n\t"
>>> +		      :
>>> +		      : "r"(&kcb->jprobe_saved_regs.sp),
>>> +		      "I"(BRK64_ESR_KPROBES)
>>> +		      : "memory");
>>
>> A couple of remarks here:
>> - the comment seems wrong, as you load the stack pointer in X0, nothing
>> else, and seem to identify the jprobe by looking at the PC, not X0.
> 
> Yes, this describes how it originally worked but I changed it based on 
> earlier feedback. Apparently this comment did not get updated.
> 
>> - using explicit registers is really ugly. How about something like this
>> instead:
>>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index c89811d..823cf92 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -513,13 +513,12 @@ void __kprobes jprobe_return(void)
>>   	 * -a magic number in x0 to identify from rest of other kprobes.
>>   	 * -restore stack addr to original saved pt_regs
>>   	 */
>> -	asm volatile ("ldr x0, [%0]\n\t"
>> -		      "mov sp, x0\n\t"
>> +	asm volatile ("mov sp, %0\n\t"
>>   		      ".globl jprobe_return_break\n\t"
>>   		      "jprobe_return_break:\n\t"
>>   		      "brk %1\n\t"
>>   		      :
>> -		      : "r"(&kcb->jprobe_saved_regs.sp),
>> +		      : "r" (kcb->jprobe_saved_regs.sp),
>>   		      "I"(BRK64_ESR_KPROBES)
>>   		      : "memory");
>>   }
>>
> 
> OK

I'll take that as an ack. Catalin, would you mind applying something
like this:

----8<----
>From 3b5ef8eb99e75c56a38117d0f64884458db85527 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 20 Jul 2016 11:52:30 +0100
Subject: [PATCH] arm64: kprobes: Cleanup jprobe_return

jprobe_return seems to have aged badly. Comments refering to
non-existent behaviours, and a dangerous habit of messing
with registers without telling the compiler.

This patches applies the following remedies:
- Fix the comments to describe the actual behaviour
- Tidy up the asm sequence to directly assign the
  stack pointer without clobbering extra registerse
- Mark the rest of the function as unreachable() so
  that the compiler knows that there is no need for
  an epilogue
- Stop making jprobe_return_break a global function
  (you really don't want to call that guy, and it isn't
  even a function).

Tested with tcp_probe.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/probes/kprobes.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 09f8ae9..973c15d 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -34,8 +34,6 @@
 
 #include "decode-insn.h"
 
-void jprobe_return_break(void);
-
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -516,18 +514,17 @@ void __kprobes jprobe_return(void)
 	/*
 	 * Jprobe handler return by entering break exception,
 	 * encoded same as kprobe, but with following conditions
-	 * -a magic number in x0 to identify from rest of other kprobes.
+	 * -a special PC to identify it from the other kprobes.
 	 * -restore stack addr to original saved pt_regs
 	 */
-	asm volatile ("ldr x0, [%0]\n\t"
-		      "mov sp, x0\n\t"
-		      ".globl jprobe_return_break\n\t"
-		      "jprobe_return_break:\n\t"
-		      "brk %1\n\t"
-		      :
-		      : "r"(&kcb->jprobe_saved_regs.sp),
-		      "I"(BRK64_ESR_KPROBES)
-		      : "memory");
+	asm volatile("				mov sp, %0	\n"
+		     "jprobe_return_break:	brk %1		\n"
+		     :
+		     : "r" (kcb->jprobe_saved_regs.sp),
+		       "I" (BRK64_ESR_KPROBES)
+		     : "memory");
+
+	unreachable();
 }
 
 int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
@@ -536,6 +533,7 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	long stack_addr = kcb->jprobe_saved_regs.sp;
 	long orig_sp = kernel_stack_pointer(regs);
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
+	extern const char jprobe_return_break[];
 
 	if (instruction_pointer(regs) != (u64) jprobe_return_break)
 		return 0;
-- 
2.1.4

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
