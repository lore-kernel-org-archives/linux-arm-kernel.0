From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Mar 2017 17:09:07 +0000
Subject: [PATCH V3] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <aad6234cbdd83994607249f91461281a@codeaurora.org>
References: <1488488312-6294-1-git-send-email-agustinv@codeaurora.org>
 <20170303145040.GB12945@leverpostej>
 <aad6234cbdd83994607249f91461281a@codeaurora.org>
Message-ID: <20170306170907.GE18519@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 06, 2017 at 10:29:25AM -0500, Agustin Vega-Frias wrote:
> On 2017-03-03 09:50, Mark Rutland wrote:
> >Hi Augustin,

Apologies for the typo here, btw.

> >On Thu, Mar 02, 2017 at 03:58:32PM -0500, Agustin Vega-Frias wrote:
> >>The driver exports formatting and event information to sysfs so it can
> >>be used by the perf user space tools with the syntaxes:
> >>   perf stat -a -e l3cache_0_0/read-miss/
> >>   perf stat -a -e l3cache_0_0/event=0x21/
> >
> >As a high-level thing, while we can't do aggregation of counts across
> >slices, and while we'd have to reject cross-slice groups, we *could*
> >have a single struct PMU that covers all those slices, with userspace
> >selecting which slice an event targets via
> >perf_event_attr::config{,1,2}. i.e. we'd treat those as independent
> >sub-units under the PMU.
> >
> >With some sysfs and userspace work, it would then be possible to have
> >the perf tool infer automatically that it should open an event on each
> >sub-unit as it currently does per-cpu.
> 
> Agreed, I will be looking at that change later, which can be seen as
> related Andi Kleen's work on uncore events [1].

Interesting; I had not spotted this series, and will have to look at it
in more detail.

> In my opinion having the separate perf PMUs fits more cleanly into that
> work, since there is currently no way to translate something like:
> 
>   l3cache/read-miss,slice=0xF/ # slices 0-3
> 
> into the individual events:
> 
>   l3cache/read-miss,slice=0x1/ # slice 0
>   l3cache/read-miss,slice=0x2/ # slice 1
>   l3cache/read-miss,slice=0x4/ # slice 2
>   l3cache/read-miss,slice=0x8/ # slice 3
> 
> I'd prefer something like:
> 
>   l3cache_0_[0123]/read-miss/ # slices 0-3 on socket 0
>   l3cache_0_*/read-miss/      # all slices on socket 0
> 
> Thoughts?

At present, I don't have a strong feeling either way.

I'll have to consider this more deeply.

[...]

> >>+ *
> >>+ * The hardware also supports a feature that asserts the IRQ on
> >>the toggling
> >>+ * of the most significanty bit in the 32bit counter.
> >
> >Nit: s/significanty/significant/
> >
> >This is just an overflow interrupt, right?
> >
> >Or does this interrupt also trigger when bit 31 goes from 0 to 1?
> >
> 
> Yes the interrupt also triggers when bit 31 goes from 0 to 1. This
> feature was added so we can avoid counter reprogramming and leave the
> counters as free running and still handle the deltas properly.

I see. That is somewhat surprising, so it might be worth having more
detail in the comment.

I guess that makes sense, though it's somewhat annoying that this means
this has to be different to every other PMU w.r.t. interrupt handling.
I'll have to try to recall the various races our usual approach avoids.

> >>+/*
> >>+ * Decoding of settings from perf_event_attr
> >>+ *
> >>+ * The config format for perf events is:
> >>+ * - config: bits 0-7: event type
> >>+ *           bit  32:  HW counter size requested, 0: 32 bits,
> >>1: 64 bits
> >>+ */
> >
> >Not really a problem, but is there a specific reason to avoid bits
> >31-8?
> 
> No, just leaving some space in case the event types are expanded.

Ok. If you could drop in a comment to that effect, that would be great.

[...]

> >>+static inline int get_hw_counter_size(struct perf_event *event)
> >>+{
> >>+	return event->attr.config >> 32 & 1;
> >>+}
> >
> >This would be better as something like
> >
> >#define L3_EVENT_ATTR_LC_BIT	32
> >
> >static inline bool event_uses_long_counter(struct perf_event *event)
> >{
> >	return !!(event->attr.config & BIT_ULL(L3_EVENT_ATTR_LC_BIT));
> >}

> I was implementing it this way so I can just directly use it as a
> parameter to bitmap_find_free_region,

Sure. I found this made those calls harder to read, since it wasn't
obvious what the size variable was exactly.

> but I can take a look to see how to make this cleaner.

Great. FWIW, I think it would be clearer to either have a wrapper of
bitmap_find_free_region that took a 'long' boolean parameter, or just
have a ternary when calling it to figure out the size parameter.

[...]

> >>+struct l3cache_pmu_hwc {
> >>+	struct perf_event	*event;
> >>+	/* Called to start event monitoring */
> >>+	void (*start)(struct perf_event *event);
> >>+	/* Called to stop event monitoring */
> >>+	void (*stop)(struct perf_event *event, int flags);
> >>+	/* Called to update the perf_event */
> >>+	void (*update)(struct perf_event *event);
> >>+};
> >
> >Even if having separate ops makes handling chaining simpler, I don't
> >think we need a copy of all these per-event.
> >
> >We can instead have something like:
> >
> >struct l3cache_event_ops {
> >	void (*start)(struct perf_event *event);
> >	void (*stop)(struct perf_event *event, int flags);
> >	void (*update)(struct perf_event *event);
> >};
> >
> >struct l3cache_event_ops event_ops_std;
> >struct l3cache_event_ops event_ops_long;
> >
> >static struct l3cache_event_ops *l3cache_event_get_ops(struct
> >perf_event *event)
> >{
> >	if (event_uses_long_counter(event))
> >		return &event_ops_long;
> >	else
> >		return &event_ops_std;
> >}
> >
> >... and callers the need the ops can consult
> >l3cache_event_get_ops(event).
> 
> Understood. How about a single pointer to ops in the counter struct?
> E.g.:
> 
> struct l3cache_pmu_hwc {
> 	struct perf_event	 *event;
>         struct l3cache_event_ops *ops;
> };
> 
> Then instead of the current:
> 	pmu->counters[hwc->idx].start(event);
> we have:
> 	pmu->counters[hwc->idx].ops->start(event);

I'd rather that we figured this out dynamically, since that way we don't
need a special l3cache_pmu_hwc type, and it's not possible for the ops
to becomes out of sync with the event somehow.

[...]

> >>+static void qcom_l3_cache__64bit_counter_start(struct
> >>perf_event *event)
> >>+{
> >>+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> >>+	int idx = event->hw.idx;
> >>+	u32 evsel = get_event_type(event);
> >>+	u64 evcnt = local64_read(&event->count);
> >>+	u32 gang = readl_relaxed(pmu->regs + L3_M_BC_GANG);
> >>+
> >>+	writel_relaxed(gang | GANG_EN(idx), pmu->regs + L3_M_BC_GANG);
> >
> >I take it this is what actually configures the chaining behaviour?
> 
> Correct, that's the register name, I might just change GANG to CHAIN
> even if the HW guys yell at me ;o)

The name is fine as-is; it should match the HW naming.

It might be worth a comment, but that's about it.

[...]

> >>+	writel_relaxed(EVSEL(0), pmu->regs + L3_HML3_PM_EVTYPE(idx+1));
> >>+	writel_relaxed(EVSEL(evsel), pmu->regs + L3_HML3_PM_EVTYPE(idx));
> >>+
> >>+	writel_relaxed(PMCNTENSET(idx+1), pmu->regs + L3_M_BC_CNTENSET);
> >>+	writel_relaxed(PMCNTENSET(idx), pmu->regs + L3_M_BC_CNTENSET);
> >>+}
> >
> >IIUC, we're not enabling the interrupt here, is that correct?
> >
> >If that's deliberate, there should be a comment as to why.
> 
> The IRQ is not needed because in essence we have a 64bit hardware
> counter which matches the software counter size. I will add a comment.

Ok. I take it that the (maximum potential) rate of increment is such
that this never feasibly overflows.

> >These are all relaxed, so what ensures the counter is actually started
> >when we return from this function?
> 
> Given how the framework works at a high level, once all events are
> scheduled into the PMU there is a pmu->enable call, which will use a
> non-relaxed write to do the final enable. Am I missing something?

Good point; I failed to consider that.

[...]

> >>+}
> >>+
> >>+/*
> >>+ * 32 bit counter interface implementation
> >>+ */
> >>+
> >>+static void qcom_l3_cache__32bit_counter_start(struct
> >>perf_event *event)
> >>+{
> >>+	struct l3cache_pmu *pmu = to_l3cache_pmu(event->pmu);
> >>+	int idx = event->hw.idx;
> >>+	u32 evsel = get_event_type(event);
> >>+	u32 irqctl = readl_relaxed(pmu->regs + L3_M_BC_IRQCTL);
> >>+
> >>+	local64_set(&event->hw.prev_count, 0);
> >
> >Please follow the example set elsewhere, and start the counter at half
> >its max value (e.g. 0x80000000 here). So long as the IRQ is taken
> >before
> >another 2^31 events occur, that caters for extreme IRQ latency, and the
> >IRQ handler doesn't have to treat the overflow as an implicit extra
> >counter bit.
> 
> We can start at zero given that we enable the feature that asserts the
> IRQ on toggle of the MSB. In essence we are doing the same thing other
> drivers do with hardware support that obviates the need to adjust the
> counter on every overflow. I will add a block comment to explain this.

Ok. I think that's ok, but as above I'll need to consider this a bit
more.

[...]

> >>+static irqreturn_t qcom_l3_cache__handle_irq(int irq_num, void *data)
> >>+{
> >>+	struct l3cache_pmu *pmu = data;
> >>+	u32 status = readl_relaxed(pmu->regs + L3_M_BC_OVSR);
> >>+	int idx;
> >>+
> >>+	if (status == 0)
> >>+		return IRQ_NONE;
> >>+
> >>+	writel_relaxed(status, pmu->regs + L3_M_BC_OVSR);
> >
> >I take it this clears the overflow status bits? i.e. it's write to
> >clear?
> >
> >It would be worth a comment.
> >
> 
> Will do
> 
> >>+	while (status) {
> >>+		struct perf_event *event;
> >>+
> >>+		idx = __ffs(status);
> >>+		status &= ~(1 << idx);
> >
> >It would be better to have status in an unsigned long, and use
> >for_each_set_bit() over that.
> 
> Will do, however I have seen that the AARCH64 compiler can optimize
> better
> if we use __ffs directly. It might be the version that I'm using, I will
> double-check.

I'd prefer the for_each_set_bit() approach regardless. It's clearer, and
I can't imagine that it has significant overhead here.

[...]

> >>+static void qcom_l3_cache__pmu_disable(struct pmu *perf_pmu)
> >>+{
> >>+	struct l3cache_pmu *pmu = to_l3cache_pmu(perf_pmu);
> >>+
> >>+	writel_relaxed(0, pmu->regs + L3_M_BC_CR);
> >>+
> >>+	/* Ensure the basic counter unit is stopped before proceeding */
> >>+	wmb();
> >
> >You presumably want likewise on the enable path, before enabling the
> >PMU.
> 
> I am doing that, I am using writel on the last operation of pmu_enable,

Ah, true.

> I will make it a separate barrier to be more explicit.

It would also be fine to drop a comment in the pmu_enable() use of
writel(); either way is fine.

Thanks,
Mark.
