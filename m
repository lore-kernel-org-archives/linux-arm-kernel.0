From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Mar 2015 12:05:21 +0000
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <20150310112723.GY2896@worktop.programming.kicks-ass.net>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
 <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
 <20150310112723.GY2896@worktop.programming.kicks-ass.net>
Message-ID: <20150310120521.GD28168@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 11:27:23AM +0000, Peter Zijlstra wrote:
> On Mon, Mar 09, 2015 at 12:46:30PM +0000, Suzuki K. Poulose wrote:
> > From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> > 
> > Don't allow grouping hardware events from different PMUs
> >  (eg. CCI + CPU).
> 
> Uhm, how does this work? If we have multiple hardware PMUs we'll stop
> scheduling events after the first failed event schedule. This can leave
> one of the PMUs severely under utilized.

The problem is here group validation at pmu::event_init() time, not
scheduling.

We don't allow grouping across disparate HW PMUs because we can't
provide group semantics anyway. Scheduling is not a problem in this case
(unlike the big.LITTLE case I have a patch for [1]).

We have a CPU PMU and an "uncore" CCI PMU. You can't create task-bound
events for the CCI, but you can create CPU-bound events for the CCI on
the nominal CPU the CCI is monitored from.

The context check you added in c3c87e770458aa00 "perf: Tighten (and fix)
the grouping condition" implicitly rejects groups that have CPU and CCI
events (each event::ctx will be the relevant pmu::pmu_cpu_context and
will differ), and this is sane -- you can't provide group semantics
across disparate HW PMUs.

Unfortunately that happens after we've done the
event->pmu->event_init(event) dance on each event, and in our event_init
function we try to verify the group is sane. In our verification we
ignore SW events, but assume that all !SW events are for the CPU PMU.
If you add a CPU event to a CCI group, that's not the case, and we use
container_of on an unsuitable object, derefence garbage, invoke the
eschaton and so on.

It would be nicer if we could prevent this in the core so we're not
reliant on every PMU driver doing the same verification. My initial
thought was that seemed like unnecessary duplication of the ctx checking
above, but if we're going to end up shoving it into several drivers
anyway perhaps it's the lesser evil.

Mark.

[1] https://lkml.org/lkml/2015/2/5/520
