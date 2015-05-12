From: v.narang@samsung.com (Vaneet Narang)
Date: Tue, 12 May 2015 13:12:54 +0000 (GMT)
Subject: Fwd: Re: Re: [EDT] [PATCH 1/1] Fix: hw watchpoint continually triggers
 callback
Message-ID: <1609501084.68951431436373294.JavaMail.weblogic@ep2mlwas08a>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 12:48:13PM +0100, Maninder Singh wrote:
>> EP-2DAD0AFA905A4ACB804C4F82A001242F
>> 
>> On ARM, when a watchpoint is registered using register_wide_hw_breakpoint, 
>> the callback handler endlessly runs until the watchpoint is unregistered.
>> The reason for this issue is debug interrupts gets raised before executing the instruction,
>> and after interrupt handling ARM tries to execute the same instruction again , which results
>> in interrupt getting raised again.
>> 
>> This patch fixes this issue by using KPROBES (getting the instruction executed and incrementing PC
>> to next instruction).
>> 
>> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
>> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
>> Reviewed-by: Amit Arora <amit.arora@samsung.com>
>> Reviewed-by: Ajeet Yadav <ajeet.y@samsung.com>
>> ---
>>  arch/arm/kernel/hw_breakpoint.c |   18 ++++++++++++++++++
>>  1 files changed, 18 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
>> index dc7d0a9..ec72f86 100644
>> --- a/arch/arm/kernel/hw_breakpoint.c
>> +++ b/arch/arm/kernel/hw_breakpoint.c
>> @@ -37,6 +37,9 @@
>>  #include <asm/hw_breakpoint.h>
>>  #include <asm/kdebug.h>
>>  #include <asm/traps.h>
>> +#ifdef CONFIG_KPROBES
>> +#include <linux/kprobes.h>
>> +#endif
>>  
>>  /* Breakpoint currently in use for each BRP. */
>>  static DEFINE_PER_CPU(struct perf_event *, bp_on_reg[ARM_MAX_BRP]);
>> @@ -757,6 +760,21 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
>>  		 */
>>  		if (!wp->overflow_handler)
>>  			enable_single_step(wp, instruction_pointer(regs));
>> +#ifdef CONFIG_KPROBES
>> +		else {
>> +			struct kprobe kp;
>> +			unsigned long flags;
>> +
>> +			arch_uninstall_hw_breakpoint(wp);
>> +			kp.addr = (kprobe_opcode_t *)instruction_pointer(regs);
>> +			if (!arch_prepare_kprobe(&kp)) {
>> +				local_irq_save(flags);
>> +				kp.ainsn.insn_singlestep(&kp, regs);
>> +				local_irq_restore(flags);
>> +			}
>> +			arch_install_hw_breakpoint(wp);
>> +		}
>> +#endif

>I don't think this is the right thing to do at all; the kernel already
>handles step exceptions using mismatched breakpoints when there is no
>overflow handler specified (e.g. using perf mem events). If you register a
>handler (e.g. gdb via ptrace) then you have to handle the step yourself.

>Will

EP-2DAD0AFA905A4ACB804C4F82A001242F

Hi Will, 

This fix is given for kernel developers who wants to use perf interface by registering callback using register_wide_hw_breakpoint API.
On every callback trigger they have to unregister watchpoints otherwise callback gets called in a loop and now issue is "when to register watch point back ?". 
With this issue in place, it makes perf interface unusable. We didn't faced this issue with x86. 
For verification, we have used test code available at
samples/hw_breakpoint/data_breakpoint.c
 
Thanks & Regards,
Vaneet Narang 
