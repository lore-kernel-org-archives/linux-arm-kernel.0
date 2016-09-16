From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Sep 2016 17:40:11 +0100
Subject: [PATCH v4 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <27f91809-f968-e278-7887-d0f9af275502@codeaurora.org>
References: <1472576493-26382-1-git-send-email-nleeder@codeaurora.org>
 <1472576493-26382-3-git-send-email-nleeder@codeaurora.org>
 <20160901163051.GA6731@leverpostej>
 <27f91809-f968-e278-7887-d0f9af275502@codeaurora.org>
Message-ID: <20160916164011.GB3179@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 11:33:39AM -0400, Neil Leeder wrote:
> Hi Mark,
> Thank you for the thorough review. I will post an updated patchset
> which addresses all of your comments. There is just one outstanding
> comment which I have a question about:

[...]

> On 9/1/2016 12:30 PM, Mark Rutland wrote:
> > On Tue, Aug 30, 2016 at 01:01:33PM -0400, Neil Leeder wrote:
> >> +	/* Don't allow groups with mixed PMUs, except for s/w events */
> >> +	if (event->group_leader->pmu != event->pmu &&
> >> +	    !is_software_event(event->group_leader)) {
> >> +		dev_warn(&l2cache_pmu->pdev->dev,
> >> +			 "Can't create mixed PMU group\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
> >> +			    group_entry)
> >> +		if (sibling->pmu != event->pmu &&
> >> +		    !is_software_event(sibling)) {
> >> +			dev_warn(&l2cache_pmu->pdev->dev,
> >> +				 "Can't create mixed PMU group\n");
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +	hwc->idx = -1;
> >> +	hwc->config_base = event->attr.config;
> >> +
> >> +	/*
> >> +	 * Ensure all events are on the same cpu so all events are in the
> >> +	 * same cpu context, to avoid races on pmu_enable etc.
> >> +	 */
> >> +	slice = get_hml2_pmu(event->cpu);
> >> +	event->cpu = slice->on_cpu;
> > 
> > This could put an event on a different CPU to its group siblings, which
> > is broken.
> 
> This is the same logic as in arm-ccn.c:arm_ccn_pmu_event_init(), where there
> is a single CPU designated as the CPU to be used for all events.
>
> All events for this slice are forced to slice->on_cpu which is the CPU
> set in the cpumask for this slice.

The CCN is a little different. For the CCN, a single CPU is designated
to handle *all* events.

For this driver, a CPU is designated per-slice, judging by the existence
of hml2_pmu::on_cpu (unless that's superfluous). We've only verified
that the events are all for this PMU, not the same slice, and thus each
event->cpu may differ.

> I'm not sure how this can put an event on a different CPU to its group
> siblings?

In practice today, we'll try to schedule the event on it's group
leader's CPU, but accounting and subsequent manipulation could go wrong.

Thanks,
Mark.
