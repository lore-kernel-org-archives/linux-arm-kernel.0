From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Mar 2015 15:09:23 +0000
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <54FEFA23.7050307@arm.com>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
 <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
 <20150310112723.GY2896@worktop.programming.kicks-ass.net>
 <20150310120521.GD28168@leverpostej>
 <20150310125351.GD2896@worktop.programming.kicks-ass.net>
 <20150310130041.GC11574@worktop.ger.corp.intel.com>
 <54FEFA23.7050307@arm.com>
Message-ID: <20150310150923.GA31849@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think we could still solve this problem by deferring the 'context'
> validation to the core. The PMUs could validate the group, within its
> context. i.e, if it can accommodate its events as a group, during 
> event_init.  The problem we face now, is encountering an event from a 
> different PMU, which we could leave it to the core as we do already.

Good point: we're not reliant on other drivers because the core will
still check the context. We only hope that those other drivers don't
make similar mistakes and corrupt things.

[...]

>   static int
> -validate_event(struct pmu_hw_events *hw_events,
> -	       struct perf_event *event)
> +validate_event(struct pmu *pmu, struct pmu_hw_events *hw_events,
> +			       struct perf_event *event)
>   {
> -	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> +	struct arm_pmu *armpmu;
> 
>   	if (is_software_event(event))
>   		return 1;
> 
> +	/*
> +	 * We are only worried if we can accommodate the events
> +	 * from this pmu in this group.
> +	 */
> +	if (event->pmu != pmu)
> +		return 1;

It's better to explicitly reject this case. We know it's non-sensical
and there's no point wasting any time on it. That will also make
big.LITTLE support a bit nicer, whenever I get that under control -- big
and LITTLE events could live in the same task context (so the core won't
reject grouping them) but mustn't be in the same group (so we have to
reject grouping in the backend).

I'd still prefer the group validation being triggered explicitly by the
core code, so that it's logically separate from initialising the event
in isolation, but that's looking like a much bigger job, and I don't
trust myself to correctly update every PMU driver for v4.0.

For the moment let's clean up the commit message for the original patch.
I'll add splitting group validation to my TODO list; there seems to be a
slot free around 2035...

Thanks,
Mark.
