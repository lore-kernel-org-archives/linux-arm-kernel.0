From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Jun 2016 10:04:16 +0100
Subject: [PATCH 0/2] qcom: add l2 cache perf events driver
In-Reply-To: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
References: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20160606090416.GB6831@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 05:03:30PM -0400, Neil Leeder wrote:
> This adds a new dynamic PMU to the Perf Events framework to program
> and control the L2 cache PMUs in some Qualcomm Technologies SOCs.
> 
> The driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntax:
> perf stat -e l2cache/event=0x42/
> 
> One point to note is that there are certain combinations of events
> which are invalid, and which are detected in event_add().

Which combinations of events are invalid?

Please elaborate.

> Simply having event_add() fail would result in event_sched_in() making
> it Inactive, treating it as over-allocation of counters, leading to
> repeated attempts to allocate the events and ending up with a
> statistical count.  A solution for this situation is to turn the
> conflicting event off in event_add(). This allows a single error
> message to be generated, and no recurring attempts to re-add the
> invalid event. In order for this to work, event_sched_in()
> needs to detect that event_add() changed the state, and not override it
> and force it to Inactive.

For heterogeneous PMUs, we added the pmu::filter_match(event) callback
for a similar purpose: preventing an event from being scheduled on a
core which does not support that event, while allowing other events to
be scheduled.

So if you truly need to filter events, the infrastructure for doing so
already exists.

However, you will need to elaborate on "there are certain combinations
of events which are invalid".

> This patchset requires:
> [PATCH] soc: qcom: provide mechanism for drivers to access L2 registers

A link would be remarkably helpful.

Better would be to fold that patch into this series, as it's the only
user, and both are helpful review context for the other.

Thanks,
Mark.
