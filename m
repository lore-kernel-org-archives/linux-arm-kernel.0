From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Jun 2016 16:56:16 +0100
Subject: [PATCH 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <be1cc820-7b9d-041b-06d8-cefeb43934d5@codeaurora.org>
References: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
 <1464987812-14360-3-git-send-email-nleeder@codeaurora.org>
 <20160606095139.GC6831@leverpostej>
 <be1cc820-7b9d-041b-06d8-cefeb43934d5@codeaurora.org>
Message-ID: <20160609155615.GE12201@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 11:16:06AM -0400, Neil Leeder wrote:
> On 6/6/2016 05:51 AM, Mark Rutland wrote:
> > On Fri, Jun 03, 2016 at 05:03:32PM -0400, Neil Leeder wrote:
> >> +/*
> >> + * The cache is made-up of one or more slices, each slice has its own PMU.
> >> + * This structure represents one of the hardware PMUs.
> >> + */
> > 
> > I take it each slice PMU is shared by several CPUs? i.e. there aren't
> > per-cpu slice PMU counters.
> > 
> 
> That is correct.

Ok, so this is certainly an uncore PMU.

That impacts a few things (e.g. task_ctx_nr, sampling), which I've tried
to elaborate on below.

> >> +struct hml2_pmu {
> >> +	struct list_head entry;
> >> +	struct perf_event *events[MAX_L2_CTRS];
> >> +	unsigned long used_mask[BITS_TO_LONGS(MAX_L2_EVENTS)];
> > 
> > What's the difference between MAX_L2_CTRS and MAX_L2_EVENTS?
> > 
> > I'm surprised that they are different. What precisely do either
> > represent?
> > 
> > Surely you don't have different events per-slice? Why do you need the
> > PMU pointers at the slice level?
> 
> Qualcomm PMUs have events arranged in a matrix of rows (codes) and columns (groups).
> Only one event can be enabled from each group at once.
> The upper part of used_mask is used to keep a record of which group has been
> used. This is the same mechanism used in armv7
> (arch/arm/perf_event_v7.c:krait_event_to_bit()).

Ah, I hadn't realised that was the case.

That's not how used_mask was originally intended to be used (it was
simply meant to cover which counters were in use), and I suspect that
means there are problems with things like cpu_pm_pmu_setup which are
expect that meaning.

It would be better if the Krait code were not doing that.

> So used_mask contains both an indication for a physical counter in use, and also
> for the group, which is why it's a different size from MAX_L2_CTRS.
> 
> I kept this because it's what's done in armv7. If there's an objection, I can
> move the group used_mask to its own bitmap.

These are two logically independent things, so I would split them.

If nothing else, placing them together has baffled me, and that should
demonstrate it's not trivial to follow.

> >> +static irqreturn_t l2_cache__handle_irq(int irq_num, void *data)
> >> +{
> >> +	struct hml2_pmu *slice = data;
> >> +	u32 ovsr;
> >> +	int idx;
> >> +	struct pt_regs *regs;
> >> +
> >> +	ovsr = hml2_pmu__getreset_ovsr();
> >> +	if (!hml2_pmu__has_overflowed(ovsr))
> >> +		return IRQ_NONE;
> >> +
> >> +	regs = get_irq_regs();
> >> +
> >> +	for (idx = 0; idx < l2cache_pmu.num_counters; idx++) {
> >> +		struct perf_event *event = slice->events[idx];
> >> +		struct hw_perf_event *hwc;
> >> +		struct perf_sample_data data;
> >> +
> >> +		if (!event)
> >> +			continue;
> >> +
> >> +		if (!hml2_pmu__counter_has_overflowed(ovsr, idx))
> >> +			continue;
> >> +
> >> +		l2_cache__event_update_from_slice(event, slice);
> >> +		hwc = &event->hw;
> >> +
> >> +		if (is_sampling_event(event)) {
> >> +			perf_sample_data_init(&data, 0, hwc->last_period);
> > 
> > I don't think sampling makes sense, given this is an uncore PMU and the
> > events are triggered by other CPUs.
> 
> There is origin filtering so events can be attributed to a CPU when sampling.

Ok. I believe that's different from all other uncore PMUs we support
(none of the drivers support sampling, certainly), so I'm not entirely
sure how/if we can make use of that sanely and reliably.

For the timebeing, I think this sampling needs to go, and the event_init
logic needs to reject sampling as with other uncore PMU drivers.

> >> +static inline int mpidr_to_cpu(u32 mpidr)
> >> +{
> >> +	return MPIDR_AFFINITY_LEVEL(mpidr, 0) |
> >> +		(MPIDR_AFFINITY_LEVEL(mpidr, 1) << mpidr_affl1_shift);
> >> +}
> > 
> > I don't follow the logic here.
> > 
> > What exactly are you trying to get? What space does the result exist in?
> > It's neither the Linux logical ID nor the physical ID.
> 
> It's the physical CPU number, constructed out of the MPIDR.AFFL1 (cluster number)
> and AFFL0 (CPU number within the cluster).
>
> The goal is to get a list of logical CPUs associated with each slice. As mentioned
> above, because of partial goods processing the only way to know this is to involve
> the physical id of each CPU from cpu_logical_map().

So this is an implementation defined physical CPU number? Please add a
comment describing it, so as to make clear it's not the MPIDR, Linux
logical ID, ACPI ID, etc.

I take it "partial good processing" is another term for binning, or some
initialisation logic related to it?

> An alternative way to process this would be to find each logical CPU where its
> cluster (MPIDR_AFFINITY_LEVEL( ,1)) matches the slice number from firmware.
> This would remove the need for AFFL0, affl1_shift and the num_cpus_in_cluster
> property, at the expense of searching every logical cpu per slice.
> And that may be a better approach?

This all sounds rather fragile. I can imagine a new revision where the
mapping scheme is completely different.

It would be better if the relationship between a slice and associated
CPUs were described explicitly by the FW, rather than attempting to
derive this detail from the MPIDR.

> >> +static int l2_cache_pmu_probe(struct platform_device *pdev)
> >> +{
> >> +	int result;
> >> +	int err;
> >> +
> >> +	INIT_LIST_HEAD(&l2cache_pmu.pmus);
> >> +
> >> +	l2cache_pmu.pmu = (struct pmu) {
> >> +		.name		= "l2cache",
> >> +		.pmu_enable	= l2_cache__pmu_enable,
> >> +		.pmu_disable	= l2_cache__pmu_disable,
> >> +		.event_init	= l2_cache__event_init,
> >> +		.add		= l2_cache__event_add,
> >> +		.del		= l2_cache__event_del,
> >> +		.start		= l2_cache__event_start,
> >> +		.stop		= l2_cache__event_stop,
> >> +		.read		= l2_cache__event_read,
> >> +		.attr_groups	= l2_cache_pmu_attr_grps,
> >> +	};

One thing I forgot to mention in my earlier comments is that as an
uncore PMU you need to have task_ctx_nr = perf_invalid_context here
also.

That will prevent conflict with the CPU PMU, though also means that this
PMU can't be allowed to open task-following events, nor can it strictly
monitor particular CPUs. See the arm-ccn driver for further details.

> >> +	result = perf_pmu_register(&l2cache_pmu.pmu,
> >> +				   l2cache_pmu.pmu.name, -1);
> >> +
> > 
> > May you have multiple sockets? You propbably want an instance ID on the
> > PMU name.
> > 
> 
> This is just a single socket implementation.

Sure, but is there any chance this may appear in a multi-socket
implementation in future?

The name is exposed to userspace as ABI, and you'd find it difficult to
change it at that point.

Thanks,
Mark.
