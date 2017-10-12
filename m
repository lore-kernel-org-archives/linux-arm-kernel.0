From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 12 Oct 2017 10:40:57 +0100
Subject: [PATCH v3 1/2] arm_arch_timer: Expose event stream status
In-Reply-To: <20171012093010.GA7395@arm.com>
References: <1506682350-9023-1-git-send-email-julien.thierry@arm.com>
 <1506682350-9023-2-git-send-email-julien.thierry@arm.com>
 <88b96039-f0a5-879f-6f68-d30b09ab0cc7@arm.com>
 <20171012093010.GA7395@arm.com>
Message-ID: <e94ecbdc-47ae-7351-e422-1fa426e35fad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/10/17 10:30, Will Deacon wrote:
> On Thu, Oct 12, 2017 at 10:27:06AM +0100, Suzuki K Poulose wrote:
>> On 29/09/17 11:52, Julien Thierry wrote:
>>> The arch timer configuration for a CPU might get reset after suspending
>>> said CPU.
>>>
>>> In order to reliably use the event stream in the kernel (e.g. for delays),
>>> we keep track of the state where we can safely concider the event stream as
>>
>> nit: consider
>>
>>> properly configured.
>>>
>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> ---
>>>   arch/arm/include/asm/arch_timer.h    |  1 +
>>>   arch/arm64/include/asm/arch_timer.h  |  1 +
>>>   drivers/clocksource/arm_arch_timer.c | 20 ++++++++++++++++++--
>>>   include/clocksource/arm_arch_timer.h |  6 ++++++
>>>   4 files changed, 26 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
>>> index d4ebf56..0b6e104 100644
>>> --- a/arch/arm/include/asm/arch_timer.h
>>> +++ b/arch/arm/include/asm/arch_timer.h
>>> @@ -106,6 +106,7 @@ static inline u32 arch_timer_get_cntkctl(void)
>>>   static inline void arch_timer_set_cntkctl(u32 cntkctl)
>>>   {
>>>   	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
>>> +	isb();
>>>   }
>>>
>>>   #endif
>>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>>> index a652ce0..bdedd8f 100644
>>> --- a/arch/arm64/include/asm/arch_timer.h
>>> +++ b/arch/arm64/include/asm/arch_timer.h
>>> @@ -144,6 +144,7 @@ static inline u32 arch_timer_get_cntkctl(void)
>>>   static inline void arch_timer_set_cntkctl(u32 cntkctl)
>>>   {
>>>   	write_sysreg(cntkctl, cntkctl_el1);
>>> +	isb();
>>>   }
>>>
>>>   static inline u64 arch_counter_get_cntpct(void)
>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>> index fd4b7f6..47cf15e 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -77,6 +77,7 @@ struct arch_timer {
>>>   static bool arch_counter_suspend_stop;
>>>   static bool vdso_default = true;
>>>
>>> +static cpumask_t evtstrm_available;
>>>   static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
>>>
>>>   static int __init early_evtstrm_cfg(char *buf)
>>> @@ -740,6 +741,7 @@ static void arch_timer_evtstrm_enable(int divider)
>>>   #ifdef CONFIG_COMPAT
>>>   	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
>>>   #endif
>>> +	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
>>>   }
>>>
>>>   static void arch_timer_configure_evtstream(void)
>>> @@ -864,6 +866,11 @@ u32 arch_timer_get_rate(void)
>>>   	return arch_timer_rate;
>>>   }
>>>
>>> +bool arch_timer_evtstrm_available(void)
>>> +{
>>> +	return !!cpumask_test_cpu(smp_processor_id(), &evtstrm_available);
>>> +}
>>> +
>>
>> This could live in the header file as static inlin, if the evtstrm_available
>> is made global and could avoid a function call where it is used.
> 
> You might need an EXPORT_SYMBOl as well if you go down that route.

Hmmm, I'm not fond of making the cpu mask global. I understand you can 
avoid the branch + ret of the function, but generally you want to check 
if the event stream is present to know if you can use wfe and wake up, 
so I don't think it might be used in a performance critical path.

So I'm wondering, is it really worth it?

Cheers,

-- 
Julien Thierry
