From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Feb 2017 11:24:34 +0000
Subject: [PATCH v8] perf: add qcom l2 cache perf events driver
In-Reply-To: <09ac83e5-4cab-0a1e-b9bd-93bf366aa82d@codeaurora.org>
References: <1484592767-23687-1-git-send-email-nleeder@codeaurora.org>
 <20170130151901.GB1160@leverpostej>
 <09ac83e5-4cab-0a1e-b9bd-93bf366aa82d@codeaurora.org>
Message-ID: <20170203112434.GB30497@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 01, 2017 at 02:57:55PM -0500, Leeder, Neil wrote:
> >>+		conflict_event =
> >>+			cluster->events[cluster->group_to_counter[group]];
> >>+		if (conflict_event != event) {
> >
> >If it's possible for conflict_event == event, it sounds like this is
> >fragile to the order events are added or removed.
> >
> >When does conflict_event == event?
> 
> Hmmm, when testing this many months ago I saw filter_match being called
> multiple times with the same event so it would conflict with itself. I
> don't see this now so if I can't reproduce it I'll remove the test.
> 
> >>+			l2cache_pmu = to_l2cache_pmu(event->pmu);
> >>+			chwc = &conflict_event->hw;
> >>+			dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
> >>+				    "column exclusion between events %lx %lx\n",
> >>+				    hwc->config_base, chwc->config_base);
> >
> >This could happen fairly often, and even with ratelimiting we're doing
> >unnecessary work. Can we get rid of the debug logic here?
> 
> Does this happen often? We're not doing sampling or running in task
> mode which involve rapid adds and deletes of events, so this really
> only happens when enabling an event.

When more events exist than are programmed in hardware, the core code
periodically attempts to rotate events. See perf_mux_hrtimer_handler()
and perf_rotate_context(). As part of this, the code wil sched events
out and sched events in, which will call pmu::filter_match() as usual.

That's intended to happen once every timer tick, so that means this
would hit HZ times per second per conflicting event per cpu. HZ is
somewhere in the range 100-1000 (250 with defconfig), so that can happen
a lot.

> I'd like to keep some type of message because it's the only thing that
> will inform a user why the event they specified didn't count anything.
> And really why I'd prefer it to be a warn instead of dbg, but I can
> live with the dbg.

I disagree that this should be a warning, since this is not indicative
of an issue affecting correctness, and the user can easily trigger this
in normal operation. We don't do likewise for other PMUs when events
conflict and fail to schedule. At best, this should be a dev_dbg() in
pmu::event_init().

We should add something to Documentation/perf/ to explain the rough
shape of the qcom l2 pmu (as we already have for the xgene pmu driver).
In there, we can describe the event groups, and conflicts, and a user
can look at that to figure out what's happening.

> >To ensure that we reliably reset clusters, and so as to avoid redundant
> >cpumask copies, I think we should rewrite the hotplug callbacks
> >something like as follows.
> 
> I'm fine with this except for one case:
> 
> >	/* Try to find a new owner */
> >	target = cpumask_any_any(cpu_online_mask, &cluster->cluster_cpus);
> 
> (assuming typo for cpumask_any_and)

Whoops, yes. 

> The current cpu is still in cpu_online_mask, so we can end up with
> target==cpu. So we need the AND, and then an any_but(..., cpu), which
> is why I had that originally.

Ok. I agree we need to temporary cpumask in this case, then.

> >>+	cluster->l2cache_pmu = l2cache_pmu;
> >>+	for_each_present_cpu(cpu) {
> >>+		if (topology_physical_package_id(cpu) == fw_cluster_id) {
> >>+			cpumask_set_cpu(cpu, &cluster->cluster_cpus);
> >>+			per_cpu(pmu_cluster, cpu) = cluster;
> >>+		}
> >>+	}
> >
> >Sorry to go back-and-forth on this particular point, but I am worried
> >that this is a little fragile, since the topology stuff is largely a
> >guess, and I can imagine it might change in future.
> >
> >What exactly is the fw_cluster_id? Is it always a particular Aff<N>
> >field? Might it differ in future?
> 
> fw_cluster_id is the cluster id assigned by firmware, which matches
> Aff1 for CPUs without multi-threading, Aff2 for those with. I think
> last time we discussed this I agreed to add a comment block regarding
> the expectation that this stays the same, which I didn't do. I can add
> it now.

That would mostly allay my fear.

> I understand your concern about future changes, but I believe this will
> remain as-is for the current generation of Qualcomm Technologies
> processors, and although I can't talk about unannounced devices I
> believe that this item will not be a problem for this driver in future.
> And if that somehow turns out not to be the case, updating this to
> whatever new scheme is used should be fairly self-contained.

Sure.

My concern was with the topology_*() guesswork changing in a way as to
adversely affect this driver, rather than future generations of the HW
changing. Given we're going to need the comment regardless, it's
probably better to manually check the relevant Aff fields here.

Thanks,
Mark.
