From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Mar 2015 13:57:29 +0000
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <20150310130041.GC11574@worktop.ger.corp.intel.com>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
 <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
 <20150310112723.GY2896@worktop.programming.kicks-ass.net>
 <20150310120521.GD28168@leverpostej>
 <20150310125351.GD2896@worktop.programming.kicks-ass.net>
 <20150310130041.GC11574@worktop.ger.corp.intel.com>
Message-ID: <20150310135728.GA31415@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So the problem is that event_init() is what will return the pmu, so we
> cannot make decisions on it until after that returns.

I took a look into hacking something into perf_try_init_event, but it
ends up duplicating all of the existing tests and looks really out of
place.

> Maybe we can pull out the validate step into its own funciton;
> pmu->validate() or whatnot, to be called slightly later.

Perhaps the other way around: move the call to pmu::event_init() later
(after the other checks in perf_event_open), and in its original spot
add a new pmu::can_handle() that only tells us whether an event in
isolation is for this PMU, without validation of the specifics of the
event.

That would keep the split between the two callbacks more clearly
defined, though it would require updating most PMU drivers, so perhaps
that's too invasive.

I'll dig into this a bit.

Mark.
