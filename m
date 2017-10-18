From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 18 Oct 2017 20:59:11 +0200 (CEST)
Subject: [PATCH v6 4/5] clocksource: stm32: add clocksource support
In-Reply-To: <1508331506-23782-5-git-send-email-benjamin.gaignard@linaro.org>
References: <1508331506-23782-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508331506-23782-5-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <alpine.DEB.2.20.1710182036070.2477@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Oct 2017, Benjamin Gaignard wrote:

> Rework driver code to be able to implement clocksource and clockevent
> on the same hardware block.
> Before this patch only the counter of the hardware block was used to
> generate clock events. Now counter will be used to provide a 32 bits
> clock source and a comparator will provide clock events.

Again. Read, understand and comply with the patch submission
documentation. Proper changelogs are not optional.

"Before this patch ...." is bogus because it suggests that the patch is
already applied which is obviously not the case.

Let me give you an example.

  The stm32 timer hardware is currently only used as a clock event device,
  but it can be utilized as a clocksource as well.

  Implement this by enabling the free running counter in the hardware block
  and converting the clock event part from a count down event timer to a
  comparator based timer.

Can you see the difference?

> -static int stm32_clock_event_set_periodic(struct clock_event_device *evt)
> +static int stm32_clock_event_set_next_event(unsigned long evt,
> +					    struct clock_event_device *clkevt)
>  {
> -	struct timer_of *to = to_timer_of(evt);
> +	struct timer_of *to = to_timer_of(clkevt);
> +	unsigned long cnt;
>  
> -	writel_relaxed(timer_of_period(to), timer_of_base(to) + TIM_ARR);
> -	writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, timer_of_base(to) + TIM_CR1);
> +	cnt = readl_relaxed(timer_of_base(to) + TIM_CNT);
> +	writel_relaxed(cnt + evt, timer_of_base(to) + TIM_CCR1);
> +	writel_relaxed(TIM_DIER_CC1IE, timer_of_base(to) + TIM_DIER);

This implementation is doomed. You cannot rely on the assumption that the
read/modify/write sequence is 'atomic'.

Bus/pipeline delays, FIQs, hypervisor exits and whatever can delay it
enough so that the write comes too late which means that you have to wait
for a full wraparound of the counter for the next interrupt.

See the big fat comment in hpet_next_event() for gory details of issues
caused by comparator based timers.

Your change of min delay in one of the previous patches is papering over
this problem and I really wonder if your argumentation of 'required because
the CPU can't keep up otherwise' is just wrong and you failed to decode the
RMW issue proper.

Though fact is, that your implementation CANNOT cover all potential RMW
disturbances safely. You need a proper safety net for these cases.

To be honest. I prefer having a slow, inaccurate down counting timer over a
fast comparator based one any time as long as the comparator is not
cleverly implemented and can do less than equal comparisons which take the
wraparound of the counter into account. It's not rocket science to do that,
it just takes a few more gates, but hardware people can't be bothered to
think about the consequences of their cheap implementations ever.

Thanks,

	tglx
