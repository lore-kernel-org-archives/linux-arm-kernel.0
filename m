From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 22 Sep 2017 11:58:27 +0100
Subject: [PATCH v2 1/2] arm_arch_timer: Expose event stream status
In-Reply-To: <20170922102520.GA23365@arm.com>
References: <1502959160-30900-1-git-send-email-julien.thierry@arm.com>
 <1502959160-30900-2-git-send-email-julien.thierry@arm.com>
 <20170922102520.GA23365@arm.com>
Message-ID: <dd4432da-5695-4436-729a-cd9dfdf6450b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/09/17 11:25, Will Deacon wrote:
> On Thu, Aug 17, 2017 at 09:39:19AM +0100, Julien Thierry wrote:
>> The arch timer configuration for a CPU might get reset after suspending said
>> CPU.
>>
>> In order to reliably use the event stream in the kernel (e.g. for delays),
>> we keep track of the state where we can safely concider the event stream as
>> properly configured.
>>
>> Signed-off: Julien Thierry <julien.thierry@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>   arch/arm/include/asm/arch_timer.h    |  1 +
>>   arch/arm64/include/asm/arch_timer.h  |  1 +
>>   drivers/clocksource/arm_arch_timer.c | 32 ++++++++++++++++++++++++++++++--
>>   include/clocksource/arm_arch_timer.h |  6 ++++++
>>   4 files changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
>> index d4ebf56..0b6e104 100644
>> --- a/arch/arm/include/asm/arch_timer.h
>> +++ b/arch/arm/include/asm/arch_timer.h
>> @@ -106,6 +106,7 @@ static inline u32 arch_timer_get_cntkctl(void)
>>   static inline void arch_timer_set_cntkctl(u32 cntkctl)
>>   {
>>   	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
>> +	isb();
>>   }
>>
>>   #endif
>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>> index 74d08e4..26b3376 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -144,6 +144,7 @@ static inline u32 arch_timer_get_cntkctl(void)
>>   static inline void arch_timer_set_cntkctl(u32 cntkctl)
>>   {
>>   	write_sysreg(cntkctl, cntkctl_el1);
>> +	isb();
>>   }
>>
>>   static inline u64 arch_counter_get_cntpct(void)
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index aae87c4..866bbf8 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -77,6 +77,7 @@ struct arch_timer {
>>   static bool arch_counter_suspend_stop;
>>   static bool vdso_default = true;
>>
>> +static DEFINE_PER_CPU(bool, evtstrm_available) = false;
>>   static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
>>
>>   static int __init early_evtstrm_cfg(char *buf)
>> @@ -736,6 +737,7 @@ static void arch_timer_evtstrm_enable(int divider)
>>   #ifdef CONFIG_COMPAT
>>   	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
>>   #endif
>> +	__this_cpu_write(evtstrm_available, true);
>>   }
>>
>>   static void arch_timer_configure_evtstream(void)
>> @@ -860,6 +862,26 @@ u32 arch_timer_get_rate(void)
>>   	return arch_timer_rate;
>>   }
>>
>> +bool arch_timer_evtstrm_available(void)
>> +{
>> +	/*
>> +	 * This function might get called outside of a preempt disable context.
>> +	 * This is not an issue because the result of this function will stay
>> +	 * valid for the CPU the caller task will be running on, even if
>> +	 * preempted. The possible case are as follow:
>> +	 *   - evtstrm_available == false -> either event stream is disabled
>> +	 *     system-wide or event stream is momentarily disabled on this CPU
>> +	 *     meaning we won't be scheduling in/out tasks on this CPU until it
>> +	 *     is reconfigured. Current task is made aware it cannot rely on
>> +	 *     event stream.
>> +	 *   - evtstrm_available == true -> task was running on a CPU with event
>> +	 *     stream enabled, if it gets preempted, it will be resumed on a CPU
>> +	 *     where event stream is configured properly. The task can use the
>> +	 *     event stream.
>> +	 */
>> +	return this_cpu_read(evtstrm_available);
> 
> I think this means that a per-cpu variable isn't necessarily what we need
> here. It would be clearer to me if we maintained a cpumask instead, with an
> enable bit for each CPU. If the thing is disabled system-wide, then it's all
> zeroes, otherwise CPUs zero their entry for the cases where the stream is
> momentarily disabled during PM transitions.
> 

Yes, that sounds better. I'll do that.

Thanks for the suggestion.

-- 
Julien Thierry
