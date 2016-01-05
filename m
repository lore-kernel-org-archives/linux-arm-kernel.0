From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 5 Jan 2016 15:53:19 +0100
Subject: [PATCH v4 05/12] arm-cci: PMU: Add support for transactions
In-Reply-To: <568BC882.70702@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
 <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
 <20151217184255.GI6344@twins.programming.kicks-ass.net>
 <5673DFC7.6060406@arm.com>
 <20151218104234.GN6344@twins.programming.kicks-ass.net>
 <5673E6C9.7040304@arm.com>
 <20151218114751.GP6344@twins.programming.kicks-ass.net>
 <20151221105528.GA19617@e106634-lin.cambridge.arm.com>
 <20160105133703.GN6344@twins.programming.kicks-ass.net>
 <568BC882.70702@arm.com>
Message-ID: <20160105145319.GO6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 01:43:30PM +0000, Suzuki K. Poulose wrote:
> On 05/01/16 13:37, Peter Zijlstra wrote:
> >On Mon, Dec 21, 2015 at 10:55:29AM +0000, Suzuki K. Poulose wrote:
> >>Thanks for that hint. Here is what I cam up with. We don't reschedule
> >>the events, all we need to do is group the writes to the counters. Hence
> >>we could as well add a flag for those events which need programming
> >>and perform the write in pmu::pmu_enable().
> >
> >I'm still somewhat confused..
> >
> >>Grouping the writes to counters can ammortise the cost of the operation
> >>on PMUs where it is expensive (e.g, CCI-500).
> >
> >This rationale makes me think you want to reduce the number of counter
> >writes, not batch them per-se.
> >
> >So why are you unconditionally writing all counters, instead of only
> >those that changed?
> >
> 
> The ARM CCI PMU reprograms all the counters with a specific value (2^31)
> to account for high interrupt latencies in recording the counters that
> overflowed. So, pmu_stop() updates the counter and pmu_start() resets
> the counter to the above value, always.
> 
> Now, writing to a single counter requires
> 
> 1) Stopping and disabling all the counters in HW (So that step 3 doesn't
> interfere with the other counters)
> 2) Program the target counter with invalid event and enable the counter.
> 3) Enable the PMU and then write to the counter.
> 4) Reset everything back to normal.
> 
> 
> So, the approach here is to delay the writes to the counters as much as possible
> and batch them. So that we don't have to repeat steps 1 & 4 for every single
> counter.
> 
> Does it help ?

Yes, thanks!
