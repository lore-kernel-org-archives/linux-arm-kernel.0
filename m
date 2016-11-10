From: nleeder@codeaurora.org (Leeder, Neil)
Date: Thu, 10 Nov 2016 18:25:47 -0500
Subject: [PATCH v7] soc: qcom: add l2 cache perf events driver
In-Reply-To: <20161109175413.GE17020@leverpostej>
References: <1477687813-11412-1-git-send-email-nleeder@codeaurora.org>
 <20161109175413.GE17020@leverpostej>
Message-ID: <50feb4f2-f042-5f75-732e-5a99653b51f2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Thanks for the review. I'll handle all the syntactic comments, so I 
won't reply to them all individually here.

For the aggregation, I'll reply separately to Will's post to
keep all those comments together.

On 11/9/2016 12:54 PM, Mark Rutland wrote:
>> +
>> +/*
>> + * The cache is made up of one or more clusters, each cluster has its own PMU.
>> + * Each cluster is associated with one or more CPUs.
>> + * This structure represents one of the hardware PMUs.
>> + *
>> + * Events can be envisioned as a 2-dimensional array. Each column represents
>> + * a group of events. There are 8 groups. Only one entry from each
>> + * group can be in use at a time. When an event is assigned a counter
>> + * by *_event_add(), the counter index is assigned to group_to_counter[group].
>
> If I've followed correctly, this means each group has a dedicated
> counter?
>
> I take it groups are not symmetric (i.e. each column has different
> events)? Or does each column contain the same events?
>
> Is there any overlap?

Each group will have at most one counter, but it's not dedicated.
There's no requirement that an implementation have as many counters as 
there are groups, so an event can be assigned to any available counter.

Every entry in the 2-dimensional array is unique, so no duplicates. Once 
you have used an event, you cannot use any other event from its column. 
As an aside, hardware designers put in some effort to ensure that events 
which may need to be collected at the same time are located in different 
columns.

>> +static int l2_cache__event_init(struct perf_event *event)
>> +{
[...]
>> +	/* Don't allow groups with mixed PMUs, except for s/w events */
>> +	if (event->group_leader->pmu != event->pmu &&
>> +	    !is_software_event(event->group_leader)) {
>> +		dev_warn(&l2cache_pmu->pdev->dev,
>> +			 "Can't create mixed PMU group\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
>> +			    group_entry)
>> +		if (sibling->pmu != event->pmu &&
>> +		    !is_software_event(sibling)) {
>> +			dev_warn(&l2cache_pmu->pdev->dev,
>> +				 "Can't create mixed PMU group\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +	/* Ensure all events in a group are on the same cpu */
>> +	cluster = get_hml2_pmu(event->cpu);
>> +	if ((event->group_leader != event) &&
>> +	    (cluster->on_cpu != event->group_leader->cpu)) {
>> +		dev_warn(&l2cache_pmu->pdev->dev,
>> +			 "Can't create group on CPUs %d and %d",
>> +			 event->cpu, event->group_leader->cpu);
>> +		return -EINVAL;
>> +	}
>
> It's probably worth also checking that the events are co-schedulable
> (e.g. they don't conflict column-wise).

That's what filter_match() is doing - stopping column-conflicting events 
from even getting to init(). In init() we don't have a record of which 
other events are being co-scheduled. We could keep a list of groups used 
by other events to compare against, but because there's no matching 
term() function there's no obvious way of removing them from the list.

In my very first patchset I had the check inside event_add() because 
entries could be removed in event_del(). That was where you suggested 
that I use filter_match().

>
>> +	if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
>> +		return -ENODEV;
>> +
>> +	if (kstrtol(device->pnp.unique_id, 10, &fw_cluster_id) < 0) {
>> +		dev_err(&pdev->dev, "unable to read ACPI uid\n");
>> +		return -ENODEV;
>> +	}
>
>> +	cluster->l2cache_pmu = l2cache_pmu;
>> +	for_each_present_cpu(cpu) {
>> +		if (topology_physical_package_id(cpu) == fw_cluster_id) {
>> +			cpumask_set_cpu(cpu, &cluster->cluster_cpus);
>> +			per_cpu(pmu_cluster, cpu) = cluster;
>> +		}
>> +	}
>
> I'm still uneasy about this.
>
> The topology_* API doesn't have a well-defined mapping to the MPIDR.Aff*
> levels, which itself also don't have a well-defined mapping to your
> hardware's clusters (and therefore fw_cluster_id).
>
> Thus, I'm rather worried that this is going to get broken easily, either
> by changes in the kernel, or in future HW revisions where the mapping of
> clusters to MPIDR.Aff* fields changes.

I'm not sure how else to get a mapping of CPU to cluster which doesn't 
eventually end with MPIDR.

This is the definition of topology_physical_package_id() from 
asm/topology.h:

#define topology_physical_package_id(cpu) 
(cpu_topology[cpu].cluster_id)

It seems to be a pretty solid connection between cpu and cluster. I 
don't think this is an abuse of this function. Unless there is some 
other way of getting this mapping I'd suggest using this, and if some 
future chip should change MPIDR usage it can be addressed it then.

>
> Thanks,
> Mark.
>

Thanks,

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
