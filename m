From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Dec 2015 11:44:19 +0000
Subject: [PATCH v12 12/16] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <56696347.4060402@linaro.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <9ae67f7515c66bfd747486c8dc1c1772913a8d46.1448403503.git.geoff@infradead.org>
 <56586B27.9080508@arm.com> <56696347.4060402@linaro.org>
Message-ID: <56696593.2070703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/15 11:34, AKASHI Takahiro wrote:
> Marc,
> 
> I was back from my vacation.
> 
> On 11/27/2015 11:39 PM, Marc Zyngier wrote:
>> On 24/11/15 22:25, Geoff Levand wrote:
>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>
>>> kdump calls machine_crash_shutdown() to shut down non-boot cpus and
>>> save registers' status in per-cpu ELF notes before starting the crash
>>> dump kernel. See kernel_kexec().
>>>
>>> ipi_cpu_stop() is a bit modified and used to support this behavior.
>>>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>   arch/arm64/include/asm/kexec.h    | 34 +++++++++++++++++++++++++++++++++-
>>>   arch/arm64/kernel/machine_kexec.c | 31 +++++++++++++++++++++++++++++--
>>>   arch/arm64/kernel/smp.c           | 16 ++++++++++++++--
>>>   3 files changed, 76 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>>> index 46d63cd..555a955 100644
>>> --- a/arch/arm64/include/asm/kexec.h
>>> +++ b/arch/arm64/include/asm/kexec.h
>>> @@ -30,6 +30,8 @@
>>>
>>>   #if !defined(__ASSEMBLY__)
>>>
>>> +extern bool in_crash_kexec;
>>> +
>>>   /**
>>>    * crash_setup_regs() - save registers for the panic kernel
>>>    *
>>> @@ -40,7 +42,37 @@
>>>   static inline void crash_setup_regs(struct pt_regs *newregs,
>>>   				    struct pt_regs *oldregs)
>>>   {
>>> -	/* Empty routine needed to avoid build errors. */
>>> +	if (oldregs) {
>>> +		memcpy(newregs, oldregs, sizeof(*newregs));
>>> +	} else {
>>> +		__asm__ __volatile__ (
>>> +			"stp	 x0,   x1, [%3, #16 *  0]\n"
>>> +			"stp	 x2,   x3, [%3, #16 *  1]\n"
>>> +			"stp	 x4,   x5, [%3, #16 *  2]\n"
>>> +			"stp	 x6,   x7, [%3, #16 *  3]\n"
>>> +			"stp	 x8,   x9, [%3, #16 *  4]\n"
>>> +			"stp	x10,  x11, [%3, #16 *  5]\n"
>>> +			"stp	x12,  x13, [%3, #16 *  6]\n"
>>> +			"stp	x14,  x15, [%3, #16 *  7]\n"
>>> +			"stp	x16,  x17, [%3, #16 *  8]\n"
>>> +			"stp	x18,  x19, [%3, #16 *  9]\n"
>>> +			"stp	x20,  x21, [%3, #16 * 10]\n"
>>> +			"stp	x22,  x23, [%3, #16 * 11]\n"
>>> +			"stp	x24,  x25, [%3, #16 * 12]\n"
>>> +			"stp	x26,  x27, [%3, #16 * 13]\n"
>>> +			"stp	x28,  x29, [%3, #16 * 14]\n"
>>> +			"str	x30,	   [%3, #16 * 15]\n"
>>> +			"mov	%0, sp\n"
>>> +			"adr	%1, 1f\n"
>>> +			"mrs	%2, spsr_el1\n"
>>> +		"1:"
>>> +			: "=r" (newregs->sp),
>>> +			  "=r" (newregs->pc),
>>> +			  "=r" (newregs->pstate)
>>> +			: "r"  (&newregs->regs)
>>> +			: "memory"
>>> +		);
>>
>> I wonder how useful this thing is, given that it starts by corrupting
>> whatever register is holding newregs->regs. Maybe this is not supposed
>> to be accurate anyway...
> 
> I'm not quite sure about what part of my code you're mentioning here, but
> crash_setup_regs() is solely called by crash_kexec(), and panic() is
> the only caller of crash_kexec() with NULL argument which, in turn, is
> used as 'oldregs' in crash_setup_regs().

You have this assembly sequence:

stp	 x0,   x1, [%3, #16 *  0]
[...]

where %3 itself is one of the x[0..30] registers. So you are saving
things that have already been corrupted by the saving procedure. Not
sure how useful that is, but as I said, maybe it is not supposed to be
completely accurate.

> Given this fact, I think that the values saved in newregs as indicated above
> will be the best estimate of current cpu contexts.
> 
> The other caller of crash_kexec() is die() in traps.c, but here we call
> it with explicit cpu contexts at exception.
> 
>>
>>> +	}
>>>   }
>>>
>>>   #endif /* !defined(__ASSEMBLY__) */
>>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>>> index da28a26..d2d7e90 100644
>>> --- a/arch/arm64/kernel/machine_kexec.c
>>> +++ b/arch/arm64/kernel/machine_kexec.c
>>> @@ -9,6 +9,7 @@
>>>    * published by the Free Software Foundation.
>>>    */
>>>
>>> +#include <linux/kernel.h>
>>>   #include <linux/kexec.h>
>>>   #include <linux/of_fdt.h>
>>>   #include <linux/slab.h>
>>> @@ -23,6 +24,7 @@
>>>   extern const unsigned char arm64_relocate_new_kernel[];
>>>   extern const unsigned long arm64_relocate_new_kernel_size;
>>>
>>> +bool in_crash_kexec;
>>>   static unsigned long kimage_start;
>>>
>>>   /**
>>> @@ -203,13 +205,38 @@ void machine_kexec(struct kimage *kimage)
>>>   	 */
>>>
>>>   	cpu_soft_restart(virt_to_phys(cpu_reset),
>>> -		is_hyp_mode_available(),
>>> +		in_crash_kexec ? 0 : is_hyp_mode_available(),
>>>   		reboot_code_buffer_phys, kimage->head, kimage_start);
>>>
>>>   	BUG(); /* Should never get here. */
>>>   }
>>>
>>> +/**
>>> + * machine_crash_shutdown - shutdown non-boot cpus and save registers
>>> + */
>>>   void machine_crash_shutdown(struct pt_regs *regs)
>>>   {
>>> -	/* Empty routine needed to avoid build errors. */
>>> +	struct pt_regs dummy_regs;
>>> +	int cpu;
>>> +
>>> +	local_irq_disable();
>>> +
>>> +	in_crash_kexec = true;
>>> +
>>> +	/*
>>> +	 * clear and initialize the per-cpu info. This is necessary
>>> +	 * because, otherwise, slots for offline cpus would never be
>>> +	 * filled up. See smp_send_stop().
>>> +	 */
>>> +	memset(&dummy_regs, 0, sizeof(dummy_regs));
>>> +	for_each_possible_cpu(cpu)
>>> +		crash_save_cpu(&dummy_regs, cpu);
>>> +
>>> +	/* shutdown non-boot cpus */
>>> +	smp_send_stop();
>>> +
>>> +	/* for boot cpu */
>>> +	crash_save_cpu(regs, smp_processor_id());
>>> +
>>> +	pr_info("Starting crashdump kernel...\n");
>>>   }
>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>> index b1adc51..15aabef 100644
>>> --- a/arch/arm64/kernel/smp.c
>>> +++ b/arch/arm64/kernel/smp.c
>>> @@ -37,6 +37,7 @@
>>>   #include <linux/completion.h>
>>>   #include <linux/of.h>
>>>   #include <linux/irq_work.h>
>>> +#include <linux/kexec.h>
>>>
>>>   #include <asm/alternative.h>
>>>   #include <asm/atomic.h>
>>> @@ -54,6 +55,8 @@
>>>   #include <asm/ptrace.h>
>>>   #include <asm/virt.h>
>>>
>>> +#include "cpu-reset.h"
>>> +
>>>   #define CREATE_TRACE_POINTS
>>>   #include <trace/events/ipi.h>
>>>
>>> @@ -683,8 +686,12 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
>>>   /*
>>>    * ipi_cpu_stop - handle IPI from smp_send_stop()
>>>    */
>>> -static void ipi_cpu_stop(unsigned int cpu)
>>> +static void ipi_cpu_stop(unsigned int cpu, struct pt_regs *regs)
>>>   {
>>> +#ifdef CONFIG_KEXEC
>>> +	/* printing messages may slow down the shutdown. */
>>> +	if (!in_crash_kexec)
>>> +#endif
>>>   	if (system_state == SYSTEM_BOOTING ||
>>>   	    system_state == SYSTEM_RUNNING) {
>>>   		raw_spin_lock(&stop_lock);
>>
>> Irrespective of how useful this change is, how about having a predicate
>> instead? Something like:
>>
>> static inline bool is_in_crash_kexec(void)
>> {
>> #ifdef CONFIG_KEXEC
>> 	return in_crash_kexec;
>> #else
>> 	return false;
>> #endif
>> }
> 
> OK, I will take your idea.
> 
>> located in machine_kexec.c (making the in_crash_kernel static), and then
> 
> but cannot make in_crash_kernel static because it is also used in both smp.c
> and machine_kexec.c.

smp.c only reads from in_crash_kernel (at least from what I can see in
this patch), so it should be able to use the accessor.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
