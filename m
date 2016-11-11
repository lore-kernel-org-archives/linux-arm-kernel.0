From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Nov 2016 11:50:08 +0000
Subject: [PATCH v7] soc: qcom: add l2 cache perf events driver
In-Reply-To: <50feb4f2-f042-5f75-732e-5a99653b51f2@codeaurora.org>
References: <1477687813-11412-1-git-send-email-nleeder@codeaurora.org>
 <20161109175413.GE17020@leverpostej>
 <50feb4f2-f042-5f75-732e-5a99653b51f2@codeaurora.org>
Message-ID: <20161111115008.GB11945@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 06:25:47PM -0500, Leeder, Neil wrote:
> On 11/9/2016 12:54 PM, Mark Rutland wrote:
> >>+
> >>+/*
> >>+ * The cache is made up of one or more clusters, each cluster has its own PMU.
> >>+ * Each cluster is associated with one or more CPUs.
> >>+ * This structure represents one of the hardware PMUs.
> >>+ *
> >>+ * Events can be envisioned as a 2-dimensional array. Each column represents
> >>+ * a group of events. There are 8 groups. Only one entry from each
> >>+ * group can be in use at a time. When an event is assigned a counter
> >>+ * by *_event_add(), the counter index is assigned to group_to_counter[group].
> >
> >If I've followed correctly, this means each group has a dedicated
> >counter?
> >
> >I take it groups are not symmetric (i.e. each column has different
> >events)? Or does each column contain the same events?
> >
> >Is there any overlap?
> 
> Each group will have at most one counter, but it's not dedicated.
> There's no requirement that an implementation have as many counters
> as there are groups, so an event can be assigned to any available
> counter.
> 
> Every entry in the 2-dimensional array is unique, so no duplicates.
> Once you have used an event, you cannot use any other event from its
> column.

Ok; thanks for clarifying that!

> >>+static int l2_cache__event_init(struct perf_event *event)

> >>+	/* Don't allow groups with mixed PMUs, except for s/w events */
> >>+	if (event->group_leader->pmu != event->pmu &&
> >>+	    !is_software_event(event->group_leader)) {
> >>+		dev_warn(&l2cache_pmu->pdev->dev,
> >>+			 "Can't create mixed PMU group\n");
> >>+		return -EINVAL;
> >>+	}
> >>+
> >>+	list_for_each_entry(sibling, &event->group_leader->sibling_list,
> >>+			    group_entry)
> >>+		if (sibling->pmu != event->pmu &&
> >>+		    !is_software_event(sibling)) {
> >>+			dev_warn(&l2cache_pmu->pdev->dev,
> >>+				 "Can't create mixed PMU group\n");
> >>+			return -EINVAL;
> >>+		}
> >>+
> >>+	/* Ensure all events in a group are on the same cpu */
> >>+	cluster = get_hml2_pmu(event->cpu);
> >>+	if ((event->group_leader != event) &&
> >>+	    (cluster->on_cpu != event->group_leader->cpu)) {
> >>+		dev_warn(&l2cache_pmu->pdev->dev,
> >>+			 "Can't create group on CPUs %d and %d",
> >>+			 event->cpu, event->group_leader->cpu);
> >>+		return -EINVAL;
> >>+	}
> >
> >It's probably worth also checking that the events are co-schedulable
> >(e.g. they don't conflict column-wise).
> 
> That's what filter_match() is doing - stopping column-conflicting
> events from even getting to init(). In init() we don't have a record
> of which other events are being co-scheduled. We could keep a list
> of groups used by other events to compare against, but because
> there's no matching term() function there's no obvious way of
> removing them from the list.

I mean within the group, in addition to the filter_match() logic.

When you event_init() an event, you can determine whether there is any
column conflict within the group the new events is being placed in, and
whether you have sufficient counters to ever be able to schedule that
group. If not, the group should be rejected.

Other PMUs have similar checks; see l2x0_pmu_group_is_valid() in
arch/arm/mm/cache-l2x0-pmu.c, and valiate_group() in
drivers/perf/arm_pmu.c.

I don't believe that filer_match() can catch that, as it's called on
each event in a group individually prior to add() time, and thus there's
no visibility of the group as a whole.

Regardless, we can and should catch that case far earlier.

[...]

> >>+	if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
> >>+		return -ENODEV;
> >>+
> >>+	if (kstrtol(device->pnp.unique_id, 10, &fw_cluster_id) < 0) {
> >>+		dev_err(&pdev->dev, "unable to read ACPI uid\n");
> >>+		return -ENODEV;
> >>+	}
> >
> >>+	cluster->l2cache_pmu = l2cache_pmu;
> >>+	for_each_present_cpu(cpu) {
> >>+		if (topology_physical_package_id(cpu) == fw_cluster_id) {
> >>+			cpumask_set_cpu(cpu, &cluster->cluster_cpus);
> >>+			per_cpu(pmu_cluster, cpu) = cluster;
> >>+		}
> >>+	}
> >
> >I'm still uneasy about this.
> >
> >The topology_* API doesn't have a well-defined mapping to the MPIDR.Aff*
> >levels, which itself also don't have a well-defined mapping to your
> >hardware's clusters (and therefore fw_cluster_id).
> >
> >Thus, I'm rather worried that this is going to get broken easily, either
> >by changes in the kernel, or in future HW revisions where the mapping of
> >clusters to MPIDR.Aff* fields changes.
> 
> I'm not sure how else to get a mapping of CPU to cluster which
> doesn't eventually end with MPIDR.

This is unfortunate. :(

It would have been much nicer if the FW also provided the MPIDR.Aff<n>
level to match up to, as that would be unambiguous.

> This is the definition of topology_physical_package_id() from
> asm/topology.h:
> 
> #define topology_physical_package_id(cpu)
> (cpu_topology[cpu].cluster_id)
> 
> It seems to be a pretty solid connection between cpu and cluster.

As I mentioned above, there's no well-defined mapping from MPIDR.Aff* to
the topology API levels. The "cluster_id" here is a guess, and one that
might change in future based on other heuristics.

> I don't think this is an abuse of this function. Unless there is some
> other way of getting this mapping I'd suggest using this, and if some
> future chip should change MPIDR usage it can be addressed it then.

I don't think it's an abuse, as such, but I don't think that it is
reliable.

That said, I don't see that we can do any better, as you say.

It's probably worth adding a comment block regarding our expectations,
i.e. that cluster_id means Aff1 for CPUs without multi-threading, Aff2
otherwise, and that we hope future systems don't choose another
MPIDR.Aff* mapping scheme.

Thanks,
Mark.
