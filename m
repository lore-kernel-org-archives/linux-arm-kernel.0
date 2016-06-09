From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 9 Jun 2016 21:41:36 +0200
Subject: [PATCH 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <20160609155615.GE12201@leverpostej>
References: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
 <1464987812-14360-3-git-send-email-nleeder@codeaurora.org>
 <20160606095139.GC6831@leverpostej>
 <be1cc820-7b9d-041b-06d8-cefeb43934d5@codeaurora.org>
 <20160609155615.GE12201@leverpostej>
Message-ID: <20160609194136.GZ30154@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 04:56:16PM +0100, Mark Rutland wrote:
> > >> +static irqreturn_t l2_cache__handle_irq(int irq_num, void *data)
> > >> +{
> > >> +	struct hml2_pmu *slice = data;
> > >> +	u32 ovsr;
> > >> +	int idx;
> > >> +	struct pt_regs *regs;
> > >> +
> > >> +	ovsr = hml2_pmu__getreset_ovsr();
> > >> +	if (!hml2_pmu__has_overflowed(ovsr))
> > >> +		return IRQ_NONE;
> > >> +
> > >> +	regs = get_irq_regs();
> > >> +
> > >> +	for (idx = 0; idx < l2cache_pmu.num_counters; idx++) {
> > >> +		struct perf_event *event = slice->events[idx];
> > >> +		struct hw_perf_event *hwc;
> > >> +		struct perf_sample_data data;
> > >> +
> > >> +		if (!event)
> > >> +			continue;
> > >> +
> > >> +		if (!hml2_pmu__counter_has_overflowed(ovsr, idx))
> > >> +			continue;
> > >> +
> > >> +		l2_cache__event_update_from_slice(event, slice);
> > >> +		hwc = &event->hw;
> > >> +
> > >> +		if (is_sampling_event(event)) {
> > >> +			perf_sample_data_init(&data, 0, hwc->last_period);
> > > 
> > > I don't think sampling makes sense, given this is an uncore PMU and the
> > > events are triggered by other CPUs.
> > 
> > There is origin filtering so events can be attributed to a CPU when sampling.
> 
> Ok. I believe that's different from all other uncore PMUs we support
> (none of the drivers support sampling, certainly), so I'm not entirely
> sure how/if we can make use of that sanely and reliably.

Right; because not only do you need to know which CPU originated the
event, the IRQ must also happen on that CPU. Simply knowing which CPU
triggered it is not enough for sampling.

> For the timebeing, I think this sampling needs to go, and the event_init
> logic needs to reject sampling as with other uncore PMU drivers.

Agreed.

> One thing I forgot to mention in my earlier comments is that as an
> uncore PMU you need to have task_ctx_nr = perf_invalid_context here
> also.

For good reasons, uncore PMUs (as is the case here) count strictly more
than the effect of single CPUs (and thus also the current task). So
attributing it back to a task is nonsense.
