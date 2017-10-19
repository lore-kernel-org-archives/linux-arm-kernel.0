From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 19 Oct 2017 10:06:05 +0200
Subject: [PATCH v6 4/5] clocksource: stm32: add clocksource support
In-Reply-To: <alpine.DEB.2.20.1710182036070.2477@nanos>
References: <1508331506-23782-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508331506-23782-5-git-send-email-benjamin.gaignard@linaro.org>
 <alpine.DEB.2.20.1710182036070.2477@nanos>
Message-ID: <CA+M3ks5K6+XnK1KDuSwAx1DF=jSJuWuGbvn64cWXrGnOTOPcCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-18 20:59 GMT+02:00 Thomas Gleixner <tglx@linutronix.de>:
> On Wed, 18 Oct 2017, Benjamin Gaignard wrote:
>
>> Rework driver code to be able to implement clocksource and clockevent
>> on the same hardware block.
>> Before this patch only the counter of the hardware block was used to
>> generate clock events. Now counter will be used to provide a 32 bits
>> clock source and a comparator will provide clock events.
>
> Again. Read, understand and comply with the patch submission
> documentation. Proper changelogs are not optional.
>
> "Before this patch ...." is bogus because it suggests that the patch is
> already applied which is obviously not the case.
>
> Let me give you an example.
>
>   The stm32 timer hardware is currently only used as a clock event device,
>   but it can be utilized as a clocksource as well.
>
>   Implement this by enabling the free running counter in the hardware block
>   and converting the clock event part from a count down event timer to a
>   comparator based timer.
>
> Can you see the difference?

I will rework the commit message

>
>> -static int stm32_clock_event_set_periodic(struct clock_event_device *evt)
>> +static int stm32_clock_event_set_next_event(unsigned long evt,
>> +                                         struct clock_event_device *clkevt)
>>  {
>> -     struct timer_of *to = to_timer_of(evt);
>> +     struct timer_of *to = to_timer_of(clkevt);
>> +     unsigned long cnt;
>>
>> -     writel_relaxed(timer_of_period(to), timer_of_base(to) + TIM_ARR);
>> -     writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, timer_of_base(to) + TIM_CR1);
>> +     cnt = readl_relaxed(timer_of_base(to) + TIM_CNT);
>> +     writel_relaxed(cnt + evt, timer_of_base(to) + TIM_CCR1);
>> +     writel_relaxed(TIM_DIER_CC1IE, timer_of_base(to) + TIM_DIER);
>
> This implementation is doomed. You cannot rely on the assumption that the
> read/modify/write sequence is 'atomic'.
>
> Bus/pipeline delays, FIQs, hypervisor exits and whatever can delay it
> enough so that the write comes too late which means that you have to wait
> for a full wraparound of the counter for the next interrupt.
>
> See the big fat comment in hpet_next_event() for gory details of issues
> caused by comparator based timers.

Other drivers like prima2 have the same problem.
They have solve it by checking if the current time is still below next event
time after wirting it, so the function will be like that:

unsigned long now, next;

next = readl_relaxed(timer_of_base(to) + TIM_CNT) + evt;
writel_relaxed(next, timer_of_base(to) + TIM_CCR1);
writel_relaxed(TIM_DIER_CC1IE, timer_of_base(to) + TIM_DIER);
now = readl_relaxed(timer_of_base(to) + TIM_CNT);

return next - now > delta ? -ETIME : 0;

>
> Your change of min delay in one of the previous patches is papering over
> this problem and I really wonder if your argumentation of 'required because
> the CPU can't keep up otherwise' is just wrong and you failed to decode the
> RMW issue proper.

The  CPU is a CortexM4 @ 200MHZ and the clocks driving the timers are at 90MHZ
with a min delta at 1 you could have an interrupt each 0.01 ms which
is really to much.
By increase it to 0x60 it give time to CPU to handle the interrupt.

Also want to remove 16 bits counters because the maximum period is around 750 ms
which is a short period for a clocksource.
With 32 bits this period is close 47 secondes.

>
> Though fact is, that your implementation CANNOT cover all potential RMW
> disturbances safely. You need a proper safety net for these cases.
>
> To be honest. I prefer having a slow, inaccurate down counting timer over a
> fast comparator based one any time as long as the comparator is not
> cleverly implemented and can do less than equal comparisons which take the
> wraparound of the counter into account. It's not rocket science to do that,
> it just takes a few more gates, but hardware people can't be bothered to
> think about the consequences of their cheap implementations ever.

I will forward you point of to the hardware designer but I will have to deal the
hardware I have anyway.

Benjamin
>
> Thanks,
>
>         tglx
>
>
