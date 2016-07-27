From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 27 Jul 2016 09:04:54 -0600
Subject: [PATCH 08/14] timer: Export next wake up of a CPU
In-Reply-To: <alpine.DEB.2.11.1607271110140.19896@nanos>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <1466624209-27432-9-git-send-email-lina.iyer@linaro.org>
 <alpine.DEB.2.11.1607271110140.19896@nanos>
Message-ID: <20160727150454.GD1369@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27 2016 at 03:16 -0600, Thomas Gleixner wrote:
>On Wed, 22 Jun 2016, Lina Iyer wrote:
>> +static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
>> +{
>> +	ktime_t len = { .tv64 = NSEC_PER_SEC/HZ };
>> +
>> +	/* Next wake up is the tick period, assume it starts now */
>> +	return ktime_add(len, ktime_get());
>
>  return tick_next_period;
>
>Will tell you the point where the next tick interrupt is due.
>
That definitely is better, will change.

>> +}
>> +
>>  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
>>  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>>  #endif /* !CONFIG_NO_HZ_COMMON */
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index 536ada8..addf3235 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -979,6 +979,19 @@ ktime_t tick_nohz_get_sleep_length(void)
>>  	return ts->sleep_length;
>>  }
>>
>> +/**
>> + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
>> + *
>> + * Called with interrupts disabled on the cpu
>
>So why are you handing in the (undocumented) cpu argument if its called on
>that cpu anyway?
>
Oh, my comment is very misleading. The function may be called from any
CPU for any other CPU. It should be more like "Called when the
interrupts are disabled on the CPU". I guess that doesn't make sense
either. I will remove this comment.

Thanks,
Lina

>> + */
>> +ktime_t tick_nohz_get_next_wakeup(int cpu)
>> +{
>> +	struct clock_event_device *dev =
>> +			per_cpu(tick_cpu_device.evtdev, cpu);
>> +
>> +	return dev->next_event;
>
>Then this becomes
>
>     return __this_cpu_read(tick_cpu_device.evtdev)->nextevt;
>
>Thanks,
>
>	tglx
