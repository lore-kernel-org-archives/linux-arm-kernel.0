From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 18 Aug 2017 11:43:32 +0100
Subject: [PATCH v5 6/6] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20170817155742.GA21203@leverpostej>
References: <1502192246-5623-1-git-send-email-suzuki.poulose@arm.com>
 <1502192246-5623-7-git-send-email-suzuki.poulose@arm.com>
 <20170816141056.GB11934@leverpostej>
 <bb4b8a9c-1a4a-4ead-255b-9f0e43dcf73b@arm.com>
 <20170817155742.GA21203@leverpostej>
Message-ID: <e73da217-a3fb-4e49-3bb2-c2d2215f7aa8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/08/17 16:57, Mark Rutland wrote:
> On Thu, Aug 17, 2017 at 03:52:24PM +0100, Suzuki K Poulose wrote:
>> On 16/08/17 15:10, Mark Rutland wrote:
>>> On Tue, Aug 08, 2017 at 12:37:26PM +0100, Suzuki K Poulose wrote:
>
>>>> +static struct attribute *dsu_pmu_event_attrs[] = {
>>>> +	DSU_EVENT_ATTR(cycles, 0x11),
>>>> +	DSU_EVENT_ATTR(bus_acecss, 0x19),
>>>> +	DSU_EVENT_ATTR(memory_error, 0x1a),
>>>> +	DSU_EVENT_ATTR(bus_cycles, 0x1d),
>>>> +	DSU_EVENT_ATTR(l3d_cache_allocate, 0x29),
>>>> +	DSU_EVENT_ATTR(l3d_cache_refill, 0x2a),
>>>> +	DSU_EVENT_ATTR(l3d_cache, 0x2b),
>>>> +	DSU_EVENT_ATTR(l3d_cache_wb, 0x2c),
>>>
>>> MAX_COMMON_EVENTS seems to be 0x40, so are we just assuming the below
>>> are implemented?
>>>
>>> If so, why bother exposing them at all? We can't know that they're going
>>> to work...
>>
>> Thats right. The only defending argument is that the event codes are specific
>> to the DynamIQ, unlike the COMMON_EVENTS which matches the ARMv8 PMU event codes.
>> So, someone would need to carefully find the event code for a particular event.
>> Having these entries would make it easier for the user to do the profiling.
>>
>> Also, future revisions of the DSU could potentially expose more events. So there
>> wouldn't be any way to tell the user (provided there aren't any changes to the
>> programming model and we decide to reuse the same compatible string) what we *could*
>> potentially support. In short, this is not a problem at the moment and we could
>> do something about it as and when required.
>
> I'd rather that we only describes those that we can probe from the
> PMCEID* registers, and for the rest, left the user to consult a manual.
>
> I can well imagine future variants of this IP supporing different
> events, and I'd prefer to avoid poriflerating tables for those.
>
> [...]

Fair enough. I will trim the list.


>>>> +static struct attribute *dsu_pmu_cpumask_attrs[] = {
>>>> +	DSU_CPUMASK_ATTR(cpumask, DSU_ACTIVE_CPU_MASK),
>>>> +	DSU_CPUMASK_ATTR(supported_cpus, DSU_SUPPORTED_CPU_MASK),
>>>> +	NULL,
>>>> +};
>>>
>>> Normally we only expose one mask.
>>>
>>> Why do we need the supported cpu mask? What is the intended use-case?
>>
>> Thats just to let the user know the CPUs bound to this PMU instance.
>
> I guess that can be useful, though the cpumasks we expose today are
> confusing as-is, and this is another point of confusion.
>
> We could drop this for now, and add it when requested, or we should try
> to make the naming clearer somehow -- "supported" can be read in a
> number of ways.

How about dsu_cpus or connected_cpus ?

>
> Further, it would be worth documenting this PMU under
> Documentation/perf/.
>
> [...]
>

OK


>>>> +static int dsu_pmu_add(struct perf_event *event, int flags)
>>>> +{
>>>> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
>>>> +	struct dsu_hw_events *hw_events = &dsu_pmu->hw_events;
>>>> +	struct hw_perf_event *hwc = &event->hw;
>>>> +	int idx;
>>>> +
>>>> +	if (!cpumask_test_cpu(smp_processor_id(), &dsu_pmu->supported_cpus))
>>>> +		return -ENOENT;
>>>
>>> This shouldn't ever happen, and we can check against the active cpumask,
>>> with a WARN_ON_ONCE(). We have to do this for CPU PMUs since they
>>> support events which can migrate with tasks, but that's not the case
>>> here.
>>>
>>> [...]
>>
>> But, we have to make sure we are reading the events from a CPU within this
>> DSU in case we have multiple DSU units.
>
> Regardless of how many instances there are, the core should *never*
> add() a CPU-bound event (which DSU events are) on another CPU. To do so
> would be a major bug.
>
> So if this is just a paranoid check, we should WARN_ON_ONCE().
> Otherwise, it's unnecessary.

OK

>
>>>> +/**
>>>> + * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
>>>> + */
>>>> +static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
>>>> +{
>>>> +	int i = 0, n, cpu;
>>>> +	struct device_node *cpu_node;
>>>> +
>>>> +	n = of_count_phandle_with_args(dev, "cpus", NULL);
>>>> +	if (n <= 0)
>>>> +		return -ENODEV;
>>>> +	for (; i < n; i++) {
>>>> +		cpu_node = of_parse_phandle(dev, "cpus", i);
>>>> +		if (!cpu_node)
>>>> +			break;
>>>> +		cpu = of_cpu_node_to_id(cpu_node);
>>>> +		of_node_put(cpu_node);
>>>> +		if (cpu < 0)
>>>> +			break;
>>>
>>> I believe this can happen if the kernel's nr_cpus were capped below the
>>> number of CPUs in the system. So we need to iterate all entries of the
>>> cpus list regardless.
>>>
>>
>> Good point. Initial version of the driver used to ignore the failures, but
>> was changed later. I will roll it back.
>
> Thanks. If you could add a comment as to why, that'll hopefully avoid
> anyone trying to "fix" the logic later.
>
> [...]
>

Sure

>>>> +	cpmcr = __dsu_pmu_read_pmcr();
>>>> +	dsu_pmu->num_counters = ((cpmcr >> CLUSTERPMCR_N_SHIFT) &
>>>> +					CLUSTERPMCR_N_MASK);
>>>> +	if (!dsu_pmu->num_counters)
>>>> +		return;
>>>
>>> Is that valid? What range of values makes sense?
>>>
>>> [...]
>>>
>>
>> We should at least have one counter implemented (excluding the cycle counter).
>> And yes, we should check if the num_counters <= 31.
>
> Ok.
>
>>>> +	/*
>>>> +	 * Find one CPU in the DSU to handle the IRQs.
>>>> +	 * It is highly unlikely that we would fail
>>>> +	 * to find one, given the probing has succeeded.
>>>> +	 */
>>>> +	cpu = dsu_pmu_get_online_cpu(dsu_pmu);
>>>> +	if (cpu >= nr_cpu_ids)
>>>> +		return -ENODEV;
>>>> +	cpumask_set_cpu(cpu, &dsu_pmu->active_cpu);
>>>> +	rc = irq_set_affinity_hint(irq, &dsu_pmu->active_cpu);
>>>
>>> Is setting the affinity hint strong enough?
>>>
>>> Can the affinity be changed behind the back of this driver?
>>
>> Did you mean to use "force"d affinity settings ? If so, modules
>> don't have the luxury of doing that.
>
> Perhaps. We absolutely need to ensure that the driver makes the IRQ
> affine to the active CPU, and no other SW will change the affinitiy of
> the IRQ.
>
> Otherwise, the IRQ handler is dangerous, violating locking requirements,
> potentially corrupting memory, etc.
>
>> Hence this one. I think that also brings up the problem where we could
>> be reading the counters from a different CPU than we requested. So, I
>> think it would be good to keep the CPU check, wherever we could access
>> the PMU.
>
> While I'm happy to have that as a paranoid sanity check, we cannot rely
> upon that for correctness. We must ensure that we amange the interupt
> affinity correctly.
>
> If that means we need the forced affinity helpers, we must ensure that
> we have access to those.

As per our offline discussion, I will go ahead with set_affinity_hint and
IRQ_NO_BALANCING flag, so that the IRQ affinity is not disturbed by the
userspace.

Suzuki
