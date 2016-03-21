From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 21 Mar 2016 13:04:09 +0100
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <20160321103507.GB17326@leverpostej>
References: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
 <20160321103507.GB17326@leverpostej>
Message-ID: <20160321120409.GT6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 10:35:08AM +0000, Mark Rutland wrote:
> > +static
> > +int qcom_l3_cache__event_add(struct perf_event *event, int flags)
> > +{
> > +	struct l3cache_pmu *system = to_l3cache_pmu(event->pmu);
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	int idx;
> > +	int prev_cpu;
> > +	int err = 0;
> > +
> > +	/*
> > +	 * We need to disable the pmu while adding the event, otherwise
> > +	 * the perf tick might kick-in and re-add this event.
> > +	 */
> > +	perf_pmu_disable(event->pmu);

Why did you write that? If you really need this you did something
seriously wrong elsewhere, because:

kernel/events/core.c:event_sched_in() is the only place calling
pmu::add() and that explicitly already does this.
