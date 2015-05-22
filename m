From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 22 May 2015 14:56:30 +0900
Subject: [v2 2/5] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <555055CE.7090000@linaro.org>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-3-git-send-email-takahiro.akashi@linaro.org>
 <20150424103900.GF29183@leverpostej> <555055CE.7090000@linaro.org>
Message-ID: <555EC50E.6070109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On 05/11/2015 04:10 PM, AKASHI Takahiro wrote:
> On 04/24/2015 07:39 PM, Mark Rutland wrote:
>> On Fri, Apr 24, 2015 at 08:53:05AM +0100, AKASHI Takahiro wrote:
>>> kdump calls machine_crash_shutdown() to shut down non-boot cpus and
>>> save per-cpu general-purpose registers before restarting the crash dump
>>> kernel. See kernel_kexec().
>>> ipi_cpu_stop() is used and a bit modified to support this behavior.
>>>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>   arch/arm64/include/asm/kexec.h    |   34 ++++++++++++++++++++++-
>>>   arch/arm64/kernel/machine_kexec.c |   55 ++++++++++++++++++++++++++++++++++++-
>>>   arch/arm64/kernel/smp.c           |   12 ++++++--
>>>   3 files changed, 97 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>>> index 3530ff5..eaf3fcb 100644
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
>>>                       struct pt_regs *oldregs)
>>>   {
>>> -    /* Empty routine needed to avoid build errors. */
>>> +    if (oldregs) {
>>> +        memcpy(newregs, oldregs, sizeof(*newregs));
>>> +    } else {
>>> +        __asm__ __volatile__ (
>>> +            "stp     x0,   x1, [%3]\n\t"
>>
>> Why the tabs?
>
> Don't know. Will remove them.
>
>> Please use #16 * N as the offset for consistency with entry.S, with 0
>> for the first N.
>
> OK.
>
>> [...]
>>
>>> +static void machine_kexec_mask_interrupts(void)
>>> +{
>>> +    unsigned int i;
>>> +    struct irq_desc *desc;
>>> +
>>> +    for_each_irq_desc(i, desc) {
>>> +        struct irq_chip *chip;
>>> +
>>> +        chip = irq_desc_get_chip(desc);
>>> +        if (!chip)
>>> +            continue;
>>> +
>>> +        if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
>>> +            chip->irq_eoi(&desc->irq_data);
>>> +
>>> +        if (chip->irq_mask)
>>> +            chip->irq_mask(&desc->irq_data);
>>> +
>>> +        if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
>>> +            chip->irq_disable(&desc->irq_data);
>>> +    }
>>> +}
>>
>> I'm surprised that this isn't left to the irqchip driver init code in
>> the crash kernel. For all we know this state could be corrupt anyway.
>>
>> Is there any reason we can't get the GIC driver to nuke all of this at
>> probe time?
>
> I don't get the point. You mean that the code be put in probe() of GIC driver?
> To be honest, this function was copied from arm's implementation.

Could you please elaborate a bit more details so that I can address the issue?

Thanks,
-Takahiro AKASHI

>> [...]
>>
>>> @@ -542,7 +543,7 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
>>>   /*
>>>    * ipi_cpu_stop - handle IPI from smp_send_stop()
>>>    */
>>> -static void ipi_cpu_stop(unsigned int cpu)
>>> +static void ipi_cpu_stop(unsigned int cpu, struct pt_regs *regs)
>>>   {
>>>       if (system_state == SYSTEM_BOOTING ||
>>>           system_state == SYSTEM_RUNNING) {
>>> @@ -556,6 +557,13 @@ static void ipi_cpu_stop(unsigned int cpu)
>>>
>>>       local_irq_disable();
>>>
>>> +#ifdef CONFIG_KEXEC
>>> +    if (in_crash_kexec) {
>>> +        crash_save_cpu(regs, cpu);
>>> +        flush_cache_all();
>>
>> Any cache maintenance will need to be by VA; flush_cache_all doesn't do
>> what the name implies, though may appear to work by chance.
>>
>> Is kdump implemented for ARM? I don't see equivalent for in the arch/arm
>> ipi_cpu_stop.
>
> Arm has a dedicated function in arch/arm/kernel/machine_kexec.c:
>     machine_crash_shutdown()
>        => machine_crash_nonpanic_core()
>
> Thanks,
> -Takahiro AKASHI
>
>> Mark.
>>
