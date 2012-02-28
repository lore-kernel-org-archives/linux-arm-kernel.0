From: dmitry.antipov@linaro.org (Dmitry Antipov)
Date: Tue, 28 Feb 2012 10:19:32 +0400
Subject: [PATCH] sched: generalize CONFIG_IRQ_TIME_ACCOUNTING for X86
 and ARM
In-Reply-To: <1330337535.11248.45.camel@twins>
References: <1329717859-19378-1-git-send-email-dmitry.antipov@linaro.org>
 <1330337535.11248.45.camel@twins>
Message-ID: <4F4C71F4.7000604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2012 02:12 PM, Peter Zijlstra wrote:

>> -extern void enable_sched_clock_irqtime(void);
>> -extern void disable_sched_clock_irqtime(void);
>> +extern int sched_clock_irqtime;
>> +static inline void enable_sched_clock_irqtime(void)
>> +{
>> +	if (sched_clock_irqtime == -1)
>> +		sched_clock_irqtime = 1;
>> +}
>> +static inline void disable_sched_clock_irqtime(void)
>> +{
>> +	sched_clock_irqtime = 0;
>> +}
>>   #else
>>   static inline void enable_sched_clock_irqtime(void) {}
>>   static inline void disable_sched_clock_irqtime(void) {}
>
> Please keep them out-of-line, its not a fast path and it avoids having
> to expose the state variable.

OK

>> +/*
>> + * -1 if not initialized, 0 if disabled with "noirqtime" kernel option
>> + * or after unstable clock was detected, 1 if enabled and active.
>> + */
>
> You forgot to explain what you need the tri-state for.
>
>> +__read_mostly int sched_clock_irqtime = -1;

The comment above should be a sufficient explanation, isn't it?

It's a tri-state just because it "merges" two variables: internal state (enabled/disabled)
and the value passed by "noirqtime" option (turn it on, default/turn it off). It can be
enabled only if it was not turned off explicitly, i.e. -1 => 1 transition is possible,
but 0 -> 1 is not. The same rule applies to a situation when an unstable clock is detected.

Dmitry
