From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Nov 2016 18:16:53 +0000
Subject: [PATCH v7] soc: qcom: add l2 cache perf events driver
In-Reply-To: <20161109175413.GE17020@leverpostej>
References: <1477687813-11412-1-git-send-email-nleeder@codeaurora.org>
 <20161109175413.GE17020@leverpostej>
Message-ID: <20161109181652.GK17771@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 05:54:13PM +0000, Mark Rutland wrote:
> On Fri, Oct 28, 2016 at 04:50:13PM -0400, Neil Leeder wrote:
> > +	struct perf_event *events[MAX_L2_CTRS];
> > +	struct l2cache_pmu *l2cache_pmu;
> > +	DECLARE_BITMAP(used_counters, MAX_L2_CTRS);
> > +	DECLARE_BITMAP(used_groups, L2_EVT_GROUP_MAX + 1);
> > +	int group_to_counter[L2_EVT_GROUP_MAX + 1];
> > +	int irq;
> > +	/* The CPU that is used for collecting events on this cluster */
> > +	int on_cpu;
> > +	/* All the CPUs associated with this cluster */
> > +	cpumask_t cluster_cpus;
> 
> I'm still uncertain about aggregating all cluster PMUs into a larger
> PMU, given the cluster PMUs are logically independent (at least in terms
> of the programming model).
> 
> However, from what I understand the x86 uncore PMU drivers aggregate
> symmetric instances of uncore PMUs (and also aggregate across packages
> to the same logical PMU).
> 
> Whatever we do, it would be nice for the uncore drivers to align on a
> common behaviour (and I think we're currently going the oppposite route
> with Cavium's uncore PMU). Will, thoughts?

I'm not a big fan of aggregating this stuff. Ultimately, the user in the
driving seat of perf is going to need some knowledge about the toplogy of
the system in order to perform sensible profiling using an uncore PMU.
If the kernel tries to present a single, unified PMU then we paint ourselves
into a corner when the hardware isn't as symmetric as we want it to be
(big/little on the CPU side is the extreme example of this). If we want
to be consistent, then exposing each uncore unit as a separate PMU is
the way to go. That doesn't mean we can't aggregate the components of a
distributed PMU (e.g. the CCN or the SMMU), but we don't want to aggregate
at the programming interface/IP block level.

We could consider exposing some topology information in sysfs if that's
seen as an issue with the non-aggregated case.

Will
