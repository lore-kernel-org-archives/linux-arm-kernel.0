From: anurupvasu@gmail.com (Anurup M)
Date: Mon, 14 Nov 2016 13:41:11 +0530
Subject: [RESEND PATCH v1 07/11] perf: hisi: Add support for Hisilicon SoC
 event counters
In-Reply-To: <20161110191058.GE10137@leverpostej>
References: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
 <1478151727-20250-8-git-send-email-anurup.m@huawei.com>
 <20161110191058.GE10137@leverpostej>
Message-ID: <5829719F.1010008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 11 November 2016 12:40 AM, Mark Rutland wrote:
> On Thu, Nov 03, 2016 at 01:42:03AM -0400, Anurup M wrote:
>> +	do {
>> +		/* Get count from individual L3C banks and sum them up */
>> +		for (i = 0; i < num_banks; i++) {
>> +			total_raw_count += hisi_read_l3c_counter(l3c_hwmod_data,
>> +									idx, i);
>> +		}
>> +		prev_raw_count = local64_read(&hwc->prev_count);
>> +
>> +		/*
>> +		 * As prev_raw_count is updated with average value of
>> +		 * L3 cache banks, we multiply it by no of banks and
>> +		 * compute the delta
>> +		 */
>> +		delta = (total_raw_count - (prev_raw_count * num_banks)) &
>> +								HISI_MAX_PERIOD;
>> +
>> +		local64_add(delta, &event->count);
>> +
>> +		/*
>> +		 * Divide by num of banks to get average count and
>> +		 * update prev_count with this value
>> +		 */
>> +		avg_raw_count = total_raw_count / num_banks;
>> +	} while (local64_cmpxchg(
>> +			 &hwc->prev_count, prev_raw_count, avg_raw_count) !=
>> +							 prev_raw_count);
> Please don't aggregate like this; expose separate PMUs instead.
>
> This is racy, and by averaging and multiplying we're making up and/or
> throwing away data.
>
> [...]
I have some concerns or doubts regarding registering each L3 cache bank 
as a separate PMU.

1) Each L3 cache PMU has total 22 statistics events. So if registered as 
a separate PMU, will it not
create multiple entries (with same event names) in event listing for 
multiple PMU's. Is there a way
I can avoid this? or this is acceptable?

Or is it acceptable to register as a single PMU and add a config 
parameter in the event listing to
identify the L3 cache bank. ex:  event name will appear as 
"hisi_l3c2/read_allocate,bank=?/".
And user can choose count from bank 0x01 as -e 
"hisi_l3c2/read_allocate,bank=0x01/"

2) The individual count from each L3 cache bank is not meaningful. Only 
aggregate count is useful.
Which is the accepted way to handle such counters?
a) Register each PMU instance as in hardware and handle the aggregation 
in user space.
b) Register as single PMU, handle aggregation in driver.

>> +	event_value = (val -
>> +			HISI_HWEVENT_L3C_READ_ALLOCATE);
>> +
>> +	/* Select the appropriate Event select register */
>> +	if (idx > 3)
>> +		reg_offset += 4;
>> +
>> +	/* Value to write to event type register */
>> +	val = event_value << (8 * idx);
>> +
> Please add helpers for these, and explain *why* the transformations are
> necessary.
Ok. shall add helpers.
>> +	/* Find the djtag Identifier of the Unit */
>> +	client = l3c_hwmod_data->client;
>> +
>> +	/*
>> +	 * Set the event in L3C_EVENT_TYPEx Register
>> +	 * for all L3C banks
>> +	 */
> As above, it seems like you should expose a separate PMU per bank
> instead. That applies for all the other instances where you iterate over
> banks.
>
> [...]
>
>> +	for (i = 0; i < l3c_hwmod_data->l3c_hwcfg.num_banks; i++) {
>> +		module_id = l3c_hwmod_data->l3c_hwcfg.module_id[i];
>> +		cfg_en = l3c_hwmod_data->l3c_hwcfg.bank_cfgen[i];
>> +		ret = hisi_djtag_writereg(module_id,
>> +					cfg_en,
>> +					reg_offset,
>> +					value,
>> +					client);
>> +		if (!ret)
>> +			ret = value;
>> +	}
> This is impossible to read. Please factor this into helpers such that
> you don't need this amount of indentation.
>
> Please do similarly elsewhere when you see this indentation pattern.
OK.
> [...]
>
>> +static int hisi_l3c_get_event_idx(struct hisi_pmu *pl3c_pmu)
>> +{
>> +	struct hisi_l3c_data *l3c_hwmod_data = pl3c_pmu->hwmod_data;
>> +	int event_idx;
>> +
>> +	event_idx =
>> +		find_first_zero_bit(
>> +			l3c_hwmod_data->hisi_l3c_event_used_mask,
>> +					 pl3c_pmu->num_counters);
>> +
>> +	if (event_idx == HISI_MAX_CFG_L3C_CNTR)
>> +		return -EAGAIN;
>> +
>> +	__set_bit(event_idx,
>> +		l3c_hwmod_data->hisi_l3c_event_used_mask);
>> +
>> +	return event_idx;
>> +}
> Please get rid of the weird hungarian notation (i.e. don't use 'p' as a
> prefix for pointers), and use temporary variables consistently, e.g.
Ok.
> static int hisi_l3c_get_event_idx(struct hisi_pmu *l3c_pmu)
> {
> 	struct hisi_l3c_data *l3c_hwmod_data = l3c_pmu->hwmod_data;
> 	unsigned long *used_mask = l3c_hwmod_data->hisi_l3c_event_used_mask;
> 	int num_counters = pl3c_pmu->num_counters
> 	int idx;
>
> 	idx = find_first_zero_bit(used_mask, num_counters);
> 	if (idx == num_counters)
> 		return -EAGAIN;
>
> 	set_bit(idx, used_mask);
>
> 	return idx;
> }
>
> [...]
>
>> +	if (of_property_read_u32(node, "counter-reg",
>> +				     &pl3c_hwcfg->counter_reg0_off)) {
>> +		dev_err(dev, "DT:Couldnot read counter-reg!\n");
>> +		return -EINVAL;
>> +	}
> Please use spaces in these messages.
>
> Otherwise, my comments on the binding apply here.
>
> [...]
>
>> +static int init_hisi_l3c_data(struct device *dev,
>> +					struct hisi_pmu *pl3c_pmu,
>> +					struct hisi_djtag_client *client)
>> +{
>> +	struct hisi_l3c_data *l3c_hwmod_data = NULL;
>> +	int ret;
>> +
>> +	l3c_hwmod_data = kzalloc(sizeof(struct hisi_l3c_data),
>> +							GFP_KERNEL);
> Use:
>
> 	l3c_hwmod_data = kzalloc(sizeof(*l3c_hwmod_data, GFP_KERNEL):
>
> [...]
Ok.
>> +static int hisi_pmu_l3c_dev_probe(struct hisi_djtag_client *client)
>> +{
>> +	struct hisi_pmu *pl3c_pmu = NULL;
>> +	struct device *dev = &client->dev;
>> +	int ret;
>> +
>> +	pl3c_pmu = hisi_pmu_alloc(dev);
>> +	if (IS_ERR(pl3c_pmu))
>> +		return PTR_ERR(pl3c_pmu);
> Why use error pointers for this?
>
> hisi_pmu_alloc() only ever returns ERR_PTR(-ENOMEM) if it failed to
> allocate.
>
> It's far simpler to have it pass on NULL there, and here do:
>
> 	pl3c_pmu = hisi_pmu_alloc(dev);
> 	if (!pl3c_pmu)
> 		return -ENOMEM;
>
> Please also s/pl3c_pmu/l3c_pmu/ here, and elsewhere throughout the
> driver. The 'p' only serves to make this harder to read.
>
> [...]
Ok.
>> +	/* Register with perf PMU */
>> +	pl3c_pmu->pmu = (struct pmu) {
>> +		.name = pl3c_pmu->name,
>> +		.task_ctx_nr = perf_invalid_context,
>> +		.event_init = hisi_uncore_pmu_event_init,
>> +		.add = hisi_uncore_pmu_add,
>> +		.del = hisi_uncore_pmu_del,
>> +		.start = hisi_uncore_pmu_start,
>> +		.stop = hisi_uncore_pmu_stop,
>> +		.read = hisi_uncore_pmu_read,
>> +	};
> Please remove the comment above this.
>
> [...]
Ok.
>> +int hisi_uncore_pmu_event_init(struct perf_event *event)
>> +{
>> +	int err;
>> +	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
> This is undefined behaviour. This must be done *after* we check the
> event->pmu->type.
Ok. shall move it after the check.
>> +
>> +	if (event->attr.type != event->pmu->type)
>> +		return -ENOENT;
>> +
>> +	/* we do not support sampling as the counters are all
>> +	 * shared by all CPU cores in a CPU die(SCCL). Also we
>> +	 * donot support attach to a task(per-process mode)
>> +	 */
>> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* counters do not have these bits */
>> +	if (event->attr.exclude_user	||
>> +	    event->attr.exclude_kernel	||
>> +	    event->attr.exclude_host	||
>> +	    event->attr.exclude_guest	||
>> +	    event->attr.exclude_hv	||
>> +	    event->attr.exclude_idle)
>> +		return -EINVAL;
>> +
>> +	if (event->cpu < 0)
>> +		return -EINVAL;
>> +
>> +	event->cpu = cpumask_first(&phisi_pmu->cpu);
> You should also check the event grouping.
>
> Take a look at what we do in arch/arm/mm/cache-l2x0-pmu.c.
>
> [...]
>
Ok. I got it. Thanks for the reference.
As you had suggested earlier I am thinking to put all these checks to a 
common lib function
and every uncore driver can call it.
Where can it be placed in source tree? Please suggest. shall add it.

>> +/*
>> + * Enable counter and set the counter to count
>> + * the event that we're interested in.
>> + */
>> +void hisi_uncore_pmu_enable_event(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
>> +
>> +	/* Disable the hardware event counting */
>> +	if (phisi_pmu->ops->disable_counter)
>> +		phisi_pmu->ops->disable_counter(phisi_pmu, GET_CNTR_IDX(hwc));
> Why isn't the counter already disabled?
>
In Hisilicon SoC PMU for L3C, MN etc, the hip05/06/07 chips don't have 
support for
stop/start individual counters.
The steps to start counting are
1) Stop counting(global control) in L3 cache AUCTRL register.
2) set event type in the event type register (Event code written to
3) Start counting (global control) in L3 cache AUCTRL register.

>> +	/*
>> +	 * Set event (if destined for Hisilicon SoC counters).
>> +	 */
>> +	if (phisi_pmu->ops->set_evtype)
>> +		phisi_pmu->ops->set_evtype(phisi_pmu, GET_CNTR_IDX(hwc),
>> +							hwc->config_base);
> Why isn't this done in the pmu::event_add callback?
hisi_uncore_pmu_enable_event is called by pmu::event_add.
The Call flow is  pmu::event_add (hisi_uncore_pmu_add) --> 
hisi_uncore_pmu_start --> hisi_uncore_pmu_enable_event
>> +
>> +	/* Enable the hardware event counting */
>> +	if (phisi_pmu->ops->enable_counter)
>> +		phisi_pmu->ops->enable_counter(phisi_pmu, GET_CNTR_IDX(hwc));
> This should be the only necessary part of this function.
>
>> +}
>> +
>> +void hisi_pmu_set_event_period(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
>> +
>> +	/*
>> +	 * The Hisilicon PMU counters have a period of 2^32. To account for the
>> +	 * possiblity of extreme interrupt latency we program for a period of
>> +	 * half that. Hopefully we can handle the interrupt before another 2^31
>> +	 * events occur and the counter overtakes its previous value.
>> +	 */
>> +	u64 val = 1ULL << 31;
>> +
>> +	local64_set(&hwc->prev_count, val);
>> +
>> +	/* Write to the hardware event counter */
>> +	phisi_pmu->ops->write_counter(phisi_pmu, hwc, val);
>> +}
>> +
>> +void hisi_uncore_pmu_start(struct perf_event *event, int flags)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
>> +	struct hisi_pmu_hw_events *hw_events;
>> +
>> +	hw_events = &phisi_pmu->hw_events;
>> +
>> +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
>> +		return;
>> +
>> +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
>> +	hwc->state = 0;
>> +
>> +	if (phisi_pmu->ops->set_event_period)
>> +		phisi_pmu->ops->set_event_period(event);
> When will this differ from hisi_pmu_set_event_period() above?
On some chips like hip05 and 06, the counter overflow handling with IRQ 
cannot
be supported as the Hisilicon Mbigen V1 driver cannot be upstream. So I 
am thinking
to have the counters start with value 0 and handle overflow with a poll 
method from
a hrtimer. So this method (hisi_pmu::set_event_period) could be changed 
in hisi_uncore(l3c/mn/ddrc).c.

Also for the DDRC PMU, the method (hisi_pmu::set_event_period) override 
to handle continous counting.
In DDRC PMU, the initial counter value start from 0.

Please share your comments.

>> +	if (flags & PERF_EF_RELOAD) {
>> +		u64 prev_raw_count =  local64_read(&hwc->prev_count);
>> +
>> +		phisi_pmu->ops->write_counter(phisi_pmu, hwc,
>> +						(u32)prev_raw_count);
>> +	}
> If we always go through hisi_pmu_set_event_period(), this looks
> redundant.
>
>> +
>> +	hisi_uncore_pmu_enable_event(event);
> There's no matching disable_event() call in this function, so this looks
> suspicious.
>
The hisi_uncore_pmu_enable_event includes
1) disable counting
2) set event type
3) enable counting

Sorry. I think this lead to confusion.

I shall split then to separate functions
a) disable_counter
b) set_event_type
c) enable_counter
>> +	perf_event_update_userpage(event);
>> +}
>> +
>> +void hisi_uncore_pmu_stop(struct perf_event *event, int flags)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hisi_pmu *phisi_pmu = to_hisi_pmu(event->pmu);
>> +
>> +	if (hwc->state & PERF_HES_UPTODATE)
>> +		return;
> Why?
A mistake. Will remove it.
> [...]
>
>> +int hisi_uncore_common_fwprop_read(struct device *dev,
>> +					struct hisi_pmu *phisi_pmu)
>> +{
>> +	if (device_property_read_u32(dev, "num-events",
>> +					&phisi_pmu->num_events)) {
>> +		dev_err(dev, "Cant read num-events from DT!\n");
>> +		return -EINVAL;
>> +	}
> For consistency with the rest of the driver, and given there is no ACPI
> support, please use the of_property_* API here.
Ok.

Thanks,
Anurup
> Thanks,
> Mark.
