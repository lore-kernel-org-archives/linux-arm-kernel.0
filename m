From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 7 Feb 2014 17:20:10 +0100
Subject: Why are imprecise external aborts masked on recent kernel while
 booting ?
In-Reply-To: <52EFC72A.6060608@st.com>
References: <52EBC86D.1010509@st.com>
 <20140131170827.GH15937@n2100.arm.linux.org.uk> <52EF5D8E.4050600@st.com>
 <52EFC72A.6060608@st.com>
Message-ID: <52F507BA.7050900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I think there should be differences depending on ARM version.
I'm using armv7, "cpsie     a" is ok,
On other arm version, it might be necessary to use different instruction 
as Russel advised previously.

Does it makes sense to add an abort enable/disable macro or function ?

I'm sending a separate patch to illustrate.

Thanks,
BR,
Fabrice

On 02/03/2014 05:43 PM, Fabrice Gasnier wrote:
> Hi,
>
> I had no success with msr instruction to set CPSR.A bit.
>
> I re-checked on a 3.4 kernel, msr instruction present in former 
> "kernel_thread_helper()" routine was not responsible for clearing 
> CPSR.A bit.
> 'A' bit was cleared because SPSR was altered before executing 
> following instruction in arch/arm/kernel/entry-header.S :
> movs    pc, lr                @ return & move spsr_svc into cpsr
>
> Sorry for the confusion in my first email: that movs instruction was 
> responsible for clearing 'A' bit on 3.4 kernel. But on recent kernel, 
> "restore_user_regs" macro seems no longer called for a kernel thread.
>
> So, I tried the 'cps'instruction that does it! I re-worked slightly 
> your previous patch.
> I also noticed that secondary needs to be set separately.
>
> Please, could you comment on the following patch ? (I can resend 
> correctly formated patch if you wish) :
>
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index dc894ab..e22b109 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -378,6 +378,9 @@ asmlinkage void secondary_start_kernel(void)
>         local_irq_enable();
>         local_fiq_enable();
>
> +       /* Enable imprecise aborts */
> +       asm volatile("cpsie     a");
> +
>         /*
>          * OK, it's off to the idle thread for us
>          */
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 4636d56..a9567bb 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -900,6 +900,10 @@ void __init early_trap_init(void *vectors_base)
>
>         flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
>         modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
> +
> +       /* Enable imprecise aborts */
> +       asm volatile("cpsie     a");
> +
>  #else /* ifndef CONFIG_CPU_V7M */
>         /*
>          * on V7-M there is no need to copy the vector table to a 
> dedicated
>
> Thanks,
> BR,
> Fabrice
>
> On 02/03/2014 10:12 AM, Fabrice Gasnier wrote:
>> Hi Russell,
>>
>> Thank you for your help.
>> I just tried following patch on both 3.10 and above vanilla 3.13.1.
>> Unfortunately, these instructions have no effect on the arm cpsr.
>> I dumped regs right after msr instruction have been executed. It 
>> remains untouched :
>>
>> Here is assembly from gdb:
>>
>>    0xc064a400 <+128>:    mov    r3, #256    ; 0x100
>>    0xc064a404 <+132>:    mrs    r2, CPSR
>>    0xc064a408 <+136>:    bic    r2, r2, r3
>>    0xc064a40c <+140>:    msr    CPSR_c, r2
>>
>> CPSR.A bit is still set after these instructions : 0x600001d3
>> Although, I see it has been cleared in r2: 0x600000d3
>>
>> Please advise.
>> Thanks,
>> BR,
>> Fabrice
>> On 01/31/2014 06:08 PM, Russell King - ARM Linux wrote:
>>>> Is it possible to unmask imprecise data aborts earlier in the boot
>>>> >process (e.g. before PCIe bus enumeration, when drivers are being 
>>>> probed)
>>>> >?
>>> How about this patch?
>>>
>>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>>> index 172ee18ff124..b0ff06f49cd0 100644
>>> --- a/arch/arm/kernel/traps.c
>>> +++ b/arch/arm/kernel/traps.c
>>> @@ -900,6 +900,15 @@ void __init early_trap_init(void *vectors_base)
>>>         flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
>>>       modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
>>> +
>>> +    /* Enable imprecise aborts */
>>> +    asm volatile(
>>> +        "mrs    %0, cpsr\n"
>>> +    "    bic    %0, %0, %1\n"
>>> +    "    msr    cpsr_c, %0"
>>> +        : "=&r" (i)
>>> +        : "r" (PSR_A_BIT));
>>> +
>>>   #else /* ifndef CONFIG_CPU_V7M */
>>>       /*
>>>        * on V7-M there is no need to copy the vector table to a 
>>> dedicated
>>
>
