From: agustinv@codeaurora.org (agustinv at codeaurora.org)
Date: Mon, 21 Mar 2016 12:37:45 -0400
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <20160321120409.GT6344@twins.programming.kicks-ass.net>
References: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
 <20160321103507.GB17326@leverpostej>
 <20160321120409.GT6344@twins.programming.kicks-ass.net>
Message-ID: <a872fdb890d5a2a09fe3915f67b24487@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-21 08:04, Peter Zijlstra wrote:
> On Mon, Mar 21, 2016 at 10:35:08AM +0000, Mark Rutland wrote:
>> > +static
>> > +int qcom_l3_cache__event_add(struct perf_event *event, int flags)
>> > +{
>> > +	struct l3cache_pmu *system = to_l3cache_pmu(event->pmu);
>> > +	struct hw_perf_event *hwc = &event->hw;
>> > +	int idx;
>> > +	int prev_cpu;
>> > +	int err = 0;
>> > +
>> > +	/*
>> > +	 * We need to disable the pmu while adding the event, otherwise
>> > +	 * the perf tick might kick-in and re-add this event.
>> > +	 */
>> > +	perf_pmu_disable(event->pmu);
> 
> Why did you write that? If you really need this you did something
> seriously wrong elsewhere, because:
> 
> kernel/events/core.c:event_sched_in() is the only place calling
> pmu::add() and that explicitly already does this.

This might have been before I added the restriction that only one CPU 
can open the events, but I will double-check and remove this as it is 
unnecessary.

Thanks,
Agustin
