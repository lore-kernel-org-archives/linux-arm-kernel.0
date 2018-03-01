From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 1 Mar 2018 11:49:12 +0000
Subject: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <5A972A7D.9020301@codeaurora.org>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5A90B77E.8040105@codeaurora.org>
 <20180225143653.peb4quk3ha5h3t5x@salmiak>
 <5A972A7D.9020301@codeaurora.org>
Message-ID: <20180301114911.fundyuqxtj5klk4e@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 02:17:33PM -0800, Saravana Kannan wrote:
> On 02/25/2018 06:36 AM, Mark Rutland wrote:
> > On Fri, Feb 23, 2018 at 04:53:18PM -0800, Saravana Kannan wrote:
> > > On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
> > > > +static void dsu_pmu_event_update(struct perf_event *event)
> > > > +{
> > > > +	struct hw_perf_event *hwc = &event->hw;
> > > > +	u64 delta, prev_count, new_count;
> > > > +
> > > > +	do {
> > > > +		/* We may also be called from the irq handler */
> > > > +		prev_count = local64_read(&hwc->prev_count);
> > > > +		new_count = dsu_pmu_read_counter(event);
> > > > +	} while (local64_cmpxchg(&hwc->prev_count, prev_count, new_count) !=
> > > > +			prev_count);
> > > > +	delta = (new_count - prev_count) & DSU_PMU_COUNTER_MASK(hwc->idx);
> > > > +	local64_add(delta, &event->count);
> > > > +}
> > > > +
> > > > +static void dsu_pmu_read(struct perf_event *event)
> > > > +{
> > > > +	dsu_pmu_event_update(event);
> > > > +}
> > 
> > > I sent out a patch that'll allow PMUs to set an event flag to avoid
> > > unnecessary smp calls when the event can be read from any CPU. You could
> > > just always set that if you can't have multiple DSU's running the kernel (I
> > > don't know if the current ARM designs support having multiple DSUs in a
> > > SoC/system) or set it if associated_cpus == cpu_present_mask.
> > 
> > As-is, that won't be safe, given the read function calls the event_update()
> > function, which has side-effects on hwc->prec_count and event->count. Those
> > need to be serialized somehow.
> 
> You have to grab the dsu_pmu->pmu_lock spin lock anyway because the system
> registers are shared across all CPUs.

I believe that lock is currently superfluous, because the perf core
ensures operations are cpu-affine, and have interrupts disabled in most
cases (thanks to the context lock).

> So, just expanding it a bit to lock the hwc->prev_count and
> event->count updated doesn't seem to be any worse.  In fact, it's
> better than sending pointless IPIs.

That's a fair point.

I'll leave it to Suzuki to decide.

> The local64_read/cmpxchg/add etc makes sense when you have per-cpu system
> registers like in the case of the ARM CPU PMU registers. It doesn't really
> buy us much for registers shared across the CPUs.

Theoretically, because operations are currnetly cpu-affine, they
potentially reduce the overhead of sertialization and synchronization.
In practice for arm64 they're just LL/SC loops, so I agree we don't lose
much.

Thanks,
Mark.
