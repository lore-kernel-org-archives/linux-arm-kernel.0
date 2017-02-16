From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu, 16 Feb 2017 17:01:19 -0500
Subject: [PATCH V2] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <20170216164140.GC588@leverpostej>
References: <1487257385-28930-1-git-send-email-agustinv@codeaurora.org>
 <20170216164140.GC588@leverpostej>
Message-ID: <8ace145be288028fb5faeb90e48a0d64@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Mark,

On 2017-02-16 11:41, Mark Rutland wrote:
> Hi,
> 
> On Thu, Feb 16, 2017 at 10:03:05AM -0500, Agustin Vega-Frias wrote:
>> This adds a new dynamic PMU to the Perf Events framework to program
>> and control the L3 cache PMUs in some Qualcomm Technologies SOCs.
>> 
>> The driver supports a distributed cache architecture where the overall
>> cache is comprised of multiple slices each with its own PMU. The 
>> driver
>> aggregates counts across the whole system to provide a global picture
>> of the metrics selected by the user.
> 
> At a quick glance, this looks *awfully* similar to the L2 PMU, modulo
> using MMIO rather than sysreg accesses. The basic shape of the hardware
> seems the same, and the register offsets are practically identical.
> 
> I guess that the L2 and L3 are largely the same block?
> 
> How exactly does this relate to the L2 PMU hardware? Could you please
> elaborate on any major differences?

The L2 and L3 blocks are separate. In the current SoC each internal
cluster shares an L2, but all clusters in the SoC share all the L3
slices. Logically it is seen as a single, larger L3 cache, shared by
all CPUs in the system. In spite of this, each physical slice has its
own PMU. Which slice serves a given memory access is determined by
a hashing algorithm which means all CPUs might have cache lines on
every slice.

> 
> This has similar issues to earlier versions of the L2 PMU driver, such
> as permitting cross-{slice,pmu} groups, and aggregating per-slice
> events, which have been addressed in the upstreamed L2 PMU driver.

We represent this as a single perf PMU that can only be associated
with a sigle CPU context. We do aggregation here, since logically it
is a single L3 cache.

> 
> Given that, could you please take a look at that (and discussions
> surrounding it), and try to address those common issues? I would hope
> that Neil can help you with that.
> 
> Ideally, given the similarities, the two would be managed by the same
> driver (even if exposed as separate devices).

I agree there are similarities, but I think it would be difficult to
have a single driver. The more similar pieces are the probing code
and how we tried to use some common idioms to deal with disabled
devices. Neil and I work on the same team and we have helped each
other in the development of these two drivers.

> 
> Please also test this with Vince Weaver's perf fuzzer [1,2], as we did
> for the L2 PMU driver.
> 

Will do.

> Otherwise, I have some (additional) high-level comments/questions 
> below.
> 
> [1] http://web.eece.maine.edu/~vweaver/projects/perf_events/fuzzer/
> [2] https://github.com/deater/perf_event_tests
> 
>> +static void hml3_pmu__reset(struct hml3_pmu *pmu)
>> +{
>> +	int i;
>> +
>> +	writel_relaxed(BC_RESET, pmu->regs + L3_M_BC_CR);
>> +
>> +	/*
>> +	 * Use writel for the first programming command to ensure the basic
>> +	 * counter unit is stopped before proceeding
>> +	 */
>> +	writel(BC_SATROLL_CR_RESET, pmu->regs + L3_M_BC_SATROLL_CR);
>> +
>> +	writel_relaxed(BC_CNTENCLR_RESET, pmu->regs + L3_M_BC_CNTENCLR);
>> +	writel_relaxed(BC_INTENCLR_RESET, pmu->regs + L3_M_BC_INTENCLR);
>> +	writel_relaxed(PMOVSRCLR_RESET, pmu->regs + L3_M_BC_OVSR);
>> +	writel_relaxed(BC_GANG_RESET, pmu->regs + L3_M_BC_GANG);
>> +	writel_relaxed(BC_IRQCTL_RESET, pmu->regs + L3_M_BC_IRQCTL);
>> +	writel_relaxed(PM_CR_RESET, pmu->regs + L3_HML3_PM_CR);
>> +
>> +	for (i = 0; i < L3_NUM_COUNTERS; ++i) {
>> +		writel_relaxed(PMCNT_RESET, pmu->regs + L3_HML3_PM_CNTCTL(i));
>> +		writel_relaxed(EVSEL(0), pmu->regs + L3_HML3_PM_EVTYPE(i));
>> +	}
>> +
>> +	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRA);
>> +	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRAM);
>> +	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRB);
>> +	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRBM);
>> +	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRC);
>> +	writel_relaxed(PM_FLTR_RESET, pmu->regs + L3_HML3_PM_FILTRCM);
>> +}
>> +
>> +static inline void hml3_pmu__init(struct hml3_pmu *pmu, struct 
>> l3cache_pmu *s,
>> +				  void __iomem *regs)
>> +{
>> +	pmu->socket = s;
>> +	pmu->regs = regs;
>> +	hml3_pmu__reset(pmu);
>> +
>> +	/*
>> +	 * Use writel here to ensure all programming commands are done
>> +	 *  before proceeding
>> +	 */
>> +	writel(BC_ENABLE, pmu->regs + L3_M_BC_CR);
>> +}
> 
> I assume that as with the L2, each slice is affine to a cluster. Is 
> that
> correct?

No, as I explained above all the slices are global resources.

> 
> If so, what happens when all CPUs in a cluster are hotplugged off then
> back on? Can't the L3 lose state (as we expect the L2 may)?

We will certainly will have to handle that once we add support for
multi-socket systems, but we are not there yet.

> 
> [...]
> 
>> +static void qcom_l3_cache__64bit_counter_start(struct perf_event 
>> *event)
>> +{
>> +	struct l3cache_pmu *socket = to_l3cache_pmu(event->pmu);
>> +	struct hml3_pmu *slice;
>> +	int idx = event->hw.idx;
>> +	u64 value = local64_read(&event->count);
>> +
>> +	list_for_each_entry(slice, &socket->pmus, entry) {
>> +		hml3_pmu__counter_enable_gang(slice, idx+1);
>> +
>> +		if (value) {
>> +			hml3_pmu__counter_set_value(slice, idx+1, value >> 32);
>> +			hml3_pmu__counter_set_value(slice, idx, (u32)value);
>> +			value = 0;
>> +		} else {
>> +			hml3_pmu__counter_set_value(slice, idx+1, 0);
>> +			hml3_pmu__counter_set_value(slice, idx, 0);
>> +		}
>> +
>> +		hml3_pmu__counter_set_event(slice, idx+1, 0);
>> +		hml3_pmu__counter_set_event(slice, idx, get_event_type(event));
>> +
>> +		hml3_pmu__counter_enable(slice, idx+1);
>> +		hml3_pmu__counter_enable(slice, idx);
>> +	}
>> +}
> 
> As with other PMU drivers, NAK to aggregating (separately-controlled) 
> HW
> events behind a single event. We should not be aggregating across
> slices as we cannot start/stop those atomically.

In this case we start the hardware events in all slices. IOW there is a
one-to-many relationship between perf_events in this perf PMU and events
in the hardware PMUs.

> 
> Similarly, all events in a group must be started/stopped by the same HW
> controls. All events in a group should be part of the same slice, as we
> cannot start/stop those atomically.
> 
> Assuming slices are cluster-affine, is it safe to access the L3 for a
> cluster which is offlined? Is the L3 still in use if its associated 
> CPUs
> are offline?

The PMUs are accessible regardless of clock gating or other power saving
features used in the functional side of the hardware.

> 
> [...]
> 
>> +static int qcom_l3_cache__event_add(struct perf_event *event, int 
>> flags)
>> +{
>> +	struct l3cache_pmu *socket = to_l3cache_pmu(event->pmu);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int idx;
>> +	int sz;
>> +
>> +	/*
>> +	 * Try to allocate a counter.
>> +	 */
>> +	sz = get_hw_counter_size(event);
>> +	idx = bitmap_find_free_region(socket->used_mask, L3_NUM_COUNTERS, 
>> sz);
>> +	if (idx < 0)
>> +		/* The counters are all in use. */
>> +		return -EAGAIN;
>> +
>> +	hwc->idx = idx;
>> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +
>> +	if (sz == 0)
>> +		socket->counters[idx] = (struct l3cache_pmu_hwc) {
>> +			.event = event,
>> +			.start = qcom_l3_cache__32bit_counter_start,
>> +			.stop = qcom_l3_cache__32bit_counter_stop,
>> +			.update = qcom_l3_cache__32bit_counter_update
>> +		};
>> +	else {
>> +		socket->counters[idx] = (struct l3cache_pmu_hwc) {
>> +			.event = event,
>> +			.start = qcom_l3_cache__64bit_counter_start,
>> +			.stop = qcom_l3_cache__64bit_counter_stop,
>> +			.update = qcom_l3_cache__64bit_counter_update
>> +		};
>> +		socket->counters[idx+1] = socket->counters[idx];
>> +	}
>> +
>> +	if (flags & PERF_EF_START)
>> +		qcom_l3_cache__event_start(event, 0);
>> +
>> +	/* Propagate changes to the userspace mapping. */
>> +	perf_event_update_userpage(event);
>> +
>> +	return 0;
>> +}
> 
> So IIUC this doesn't follow the row/column event model of the L2, and
> doesn't have a dedicated cycle counter?

No, there is a single 8 bit event specification and a flat event space.
There is not dedicated cycle counter. An event counter can be programmed
to count cycles, though.

> 
> [...]
> 
>> +PMU_FORMAT_ATTR(event, "config:0-7");
>> +PMU_FORMAT_ATTR(lc, "config:32");
> 
> What is this 'lc' field?

It means "long counter". We have a feature that allows chaining two 32 
bit
hardware counters. This is how a user requests that.

> 
>> +static int qcom_l3_cache_pmu_offline_cpu(unsigned int cpu, struct 
>> hlist_node *n)
>> +{
>> +	struct l3cache_pmu *socket = hlist_entry_safe(n, struct l3cache_pmu, 
>> node);
>> +	unsigned int target;
>> +
>> +	if (!cpumask_test_and_clear_cpu(cpu, &socket->cpu))
>> +		return 0;
>> +	target = cpumask_any_but(cpu_online_mask, cpu);
>> +	if (target >= nr_cpu_ids)
>> +		return 0;
>> +	/*
>> +	 * TODO: migrate context once core races on event->ctx have
>> +	 * been fixed.
>> +	 */
>> +	cpumask_set_cpu(target, &socket->cpu);
>> +	return 0;
>> +}
> 
> The event->ctx race has been fixed for a while now.

Great, I was searching for that yesterday, but could not find anything 
and
assumed it had not been fixed, given that the CCI driver still has this
comment in it. So it is safe to add the call to perf_pmu_migrate_context 
now?
> 
> Please follow the example of the L2 PMU's hotplug callback, and also
> fold the reset into the hotplug callback.

I agree we will need to do that once we have multi-socket support, but
would you agree to keep this as-is for the time being?

> 
> [...]
> 
>> +static int qcom_l3_cache_pmu_probe_slice(struct device *dev, void 
>> *data)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev->parent);
>> +	struct platform_device *sdev = to_platform_device(dev);
>> +	struct l3cache_pmu *socket = data;
>> +	struct resource *memrc;
>> +	void __iomem *regs;
>> +	struct hml3_pmu *slice;
>> +	int irq, err;
>> +
>> +	memrc = platform_get_resource(sdev, IORESOURCE_MEM, 0);
>> +	slice = devm_kzalloc(&pdev->dev, sizeof(*slice), GFP_KERNEL);
>> +	if (!slice)
>> +		return -ENOMEM;
>> +
>> +	regs = devm_ioremap_resource(&pdev->dev, memrc);
>> +	if (IS_ERR(regs)) {
>> +		dev_err(&pdev->dev, "Can't map slice @%pa\n", &memrc->start);
>> +		return PTR_ERR(regs);
>> +	}
>> +
>> +	irq = platform_get_irq(sdev, 0);
>> +	if (irq <= 0) {
>> +		dev_err(&pdev->dev, "Failed to get valid irq for slice @%pa\n",
>> +			&memrc->start);
>> +		return irq;
>> +	}
>> +
>> +	err = devm_request_irq(&pdev->dev, irq, qcom_l3_cache__handle_irq, 
>> 0,
>> +			       "qcom-l3-cache-pmu", slice);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Request for IRQ failed for slice @%pa\n",
>> +			&memrc->start);
>> +		return err;
>> +	}
>> +
>> +	hml3_pmu__init(slice, socket, regs);
>> +	list_add(&slice->entry, &socket->pmus);
>> +	return 0;
>> +}
> 
> No cluster affinity to probe out of the ACPI tables?
> 
> Thanks,
> Mark.

Thank you for your prompt feedback. I'll add the migration code and run
the fuzzer, and post another version with this and any other feedback
I receive within the next few days.

Thanks,
Agustin

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
