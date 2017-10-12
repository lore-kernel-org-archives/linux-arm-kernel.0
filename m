From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 12 Oct 2017 09:47:26 +0100
Subject: [PATCH v3 2/2] arm64: use WFE for long delays
In-Reply-To: <20171011151335.GA14341@arm.com>
References: <1506682350-9023-1-git-send-email-julien.thierry@arm.com>
 <1506682350-9023-3-git-send-email-julien.thierry@arm.com>
 <20171011151335.GA14341@arm.com>
Message-ID: <e4206f9a-4ba6-550c-fa2a-92d89b5fbc8b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 11/10/17 16:13, Will Deacon wrote:
> Hi Julien,
> 
> On Fri, Sep 29, 2017 at 11:52:30AM +0100, Julien Thierry wrote:
>> The current delay implementation uses the yield instruction, which is a
>> hint that it is beneficial to schedule another thread. As this is a hint,
>> it may be implemented as a NOP, causing all delays to be busy loops. This
>> is the case for many existing CPUs.
>>
>> Taking advantage of the generic timer sending periodic events to all
>> cores, we can use WFE during delays to reduce power consumption. This is
>> beneficial only for delays longer than the period of the timer event
>> stream.
>>
>> If timer event stream is not enabled, delays will behave as yield/busy
>> loops.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> ---
>>   arch/arm64/lib/delay.c               | 23 +++++++++++++++++++----
>>   include/clocksource/arm_arch_timer.h |  4 +++-
>>   2 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
>> index dad4ec9..4dc27f3 100644
>> --- a/arch/arm64/lib/delay.c
>> +++ b/arch/arm64/lib/delay.c
>> @@ -24,10 +24,28 @@
>>   #include <linux/module.h>
>>   #include <linux/timex.h>
>>
>> +#include <clocksource/arm_arch_timer.h>
>> +
>> +#define USECS_TO_CYCLES(TIME_USECS)			\
>> +	xloops_to_cycles((TIME_USECS) * 0x10C7UL)
> 
> The macro parameter can be lower-case here.
> 

Noted, I'll change it.

>> +static inline unsigned long xloops_to_cycles(unsigned long xloops)
>> +{
>> +	return (xloops * loops_per_jiffy * HZ) >> 32;
>> +}
>> +
>>   void __delay(unsigned long cycles)
>>   {
>>   	cycles_t start = get_cycles();
>>
>> +	if (arch_timer_evtstrm_available()) {
> 
> Hmm, is this never called in a context where preemption is enabled?
> Maybe arch_timer_evtstrm_available should be using raw_smp_processor_id()
> under the hood.
> 

This can be called from a preemptible context. But when it is, the event 
stream is either enabled both on the preemptible context and on the 
context where a preempted context can be resumed, or the event stream is 
just disabled in the whole system.

Does using raw_smp_processor_id solve an issue here?

Thanks,

>> +		const cycles_t timer_evt_period =
>> +			USECS_TO_CYCLES(ARCH_TIMER_EVT_STREAM_PERIOD_US);
>> +
>> +		while ((get_cycles() - start + timer_evt_period) < cycles)
>> +			wfe();
>> +	}
>> +
>>   	while ((get_cycles() - start) < cycles)
>>   		cpu_relax();
>>   }
>> @@ -35,10 +53,7 @@ void __delay(unsigned long cycles)
>>
>>   inline void __const_udelay(unsigned long xloops)
>>   {
>> -	unsigned long loops;
>> -
>> -	loops = xloops * loops_per_jiffy * HZ;
>> -	__delay(loops >> 32);
>> +	__delay(xloops_to_cycles(xloops));
>>   }
>>   EXPORT_SYMBOL(__const_udelay);
>>
>> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
>> index 4e28283..349e595 100644
>> --- a/include/clocksource/arm_arch_timer.h
>> +++ b/include/clocksource/arm_arch_timer.h
>> @@ -67,7 +67,9 @@ enum arch_timer_spi_nr {
>>   #define ARCH_TIMER_USR_VT_ACCESS_EN	(1 << 8) /* virtual timer registers */
>>   #define ARCH_TIMER_USR_PT_ACCESS_EN	(1 << 9) /* physical timer registers */
>>
>> -#define ARCH_TIMER_EVT_STREAM_FREQ	10000	/* 100us */
>> +#define ARCH_TIMER_EVT_STREAM_PERIOD_US	100
>> +#define ARCH_TIMER_EVT_STREAM_FREQ				\
>> +	(USEC_PER_SEC / ARCH_TIMER_EVT_STREAM_PERIOD_US)
> 
> This needs an ack from Marc or Mark.
> 
> Will
> 

-- 
Julien Thierry
