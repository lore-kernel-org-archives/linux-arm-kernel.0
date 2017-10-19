From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 19 Oct 2017 10:18:51 +0200 (CEST)
Subject: [PATCH v6 4/5] clocksource: stm32: add clocksource support
In-Reply-To: <CA+M3ks5K6+XnK1KDuSwAx1DF=jSJuWuGbvn64cWXrGnOTOPcCQ@mail.gmail.com>
References: <1508331506-23782-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508331506-23782-5-git-send-email-benjamin.gaignard@linaro.org>
 <alpine.DEB.2.20.1710182036070.2477@nanos>
 <CA+M3ks5K6+XnK1KDuSwAx1DF=jSJuWuGbvn64cWXrGnOTOPcCQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710191007480.1971@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Oct 2017, Benjamin Gaignard wrote:
> 2017-10-18 20:59 GMT+02:00 Thomas Gleixner <tglx@linutronix.de>:
> >> -static int stm32_clock_event_set_periodic(struct clock_event_device *evt)
> >> +static int stm32_clock_event_set_next_event(unsigned long evt,
> >> +                                         struct clock_event_device *clkevt)
> >>  {
> >> -     struct timer_of *to = to_timer_of(evt);
> >> +     struct timer_of *to = to_timer_of(clkevt);
> >> +     unsigned long cnt;
> >>
> >> -     writel_relaxed(timer_of_period(to), timer_of_base(to) + TIM_ARR);
> >> -     writel_relaxed(TIM_CR1_ARPE | TIM_CR1_CEN, timer_of_base(to) + TIM_CR1);
> >> +     cnt = readl_relaxed(timer_of_base(to) + TIM_CNT);
> >> +     writel_relaxed(cnt + evt, timer_of_base(to) + TIM_CCR1);
> >> +     writel_relaxed(TIM_DIER_CC1IE, timer_of_base(to) + TIM_DIER);
> >
> > This implementation is doomed. You cannot rely on the assumption that the
> > read/modify/write sequence is 'atomic'.
> >
> > Bus/pipeline delays, FIQs, hypervisor exits and whatever can delay it
> > enough so that the write comes too late which means that you have to wait
> > for a full wraparound of the counter for the next interrupt.
> >
> > See the big fat comment in hpet_next_event() for gory details of issues
> > caused by comparator based timers.
> 
> Other drivers like prima2 have the same problem.

That does not make it any better.

> > Your change of min delay in one of the previous patches is papering over
> > this problem and I really wonder if your argumentation of 'required because
> > the CPU can't keep up otherwise' is just wrong and you failed to decode the
> > RMW issue proper.
> 
> The  CPU is a CortexM4 @ 200MHZ and the clocks driving the timers are at 90MHZ
> with a min delta at 1 you could have an interrupt each 0.01 ms which
> is really to much.
> By increase it to 0x60 it give time to CPU to handle the interrupt.

Fair enough, but exactly this information wants to be in the changelog. And
still, if the hardware only supports 16 bit you still can use the clock
events part and not initialize the clocksource.

> Also want to remove 16 bits counters because the maximum period is around
> 750 ms which is a short period for a clocksource.  With 32 bits this
> period is close 47 secondes.

Again. The changelog is missing this information. You cannot expect
reviewers to crystal ball your reasonings.

> > To be honest. I prefer having a slow, inaccurate down counting timer over a
> > fast comparator based one any time as long as the comparator is not
> > cleverly implemented and can do less than equal comparisons which take the
> > wraparound of the counter into account. It's not rocket science to do that,
> > it just takes a few more gates, but hardware people can't be bothered to
> > think about the consequences of their cheap implementations ever.
> 
> I will forward you point of to the hardware designer but I will have to deal the
> hardware I have anyway.

I know that it's to late. Just wanted to mention it as a general note.

Thanks,

	tglx
