From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 24 Mar 2017 15:48:31 +0530
Subject: [PATCH v6 07/11] drivers: perf: hisi: Add support for Hisilicon
 SoC event counters
In-Reply-To: <20170321165252.GA29116@leverpostej>
References: <1489127311-112778-1-git-send-email-anurup.m@huawei.com>
 <20170321165252.GA29116@leverpostej>
Message-ID: <58D4F277.7080006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.

On Tuesday 21 March 2017 10:22 PM, Mark Rutland wrote:
> On Fri, Mar 10, 2017 at 01:28:31AM -0500, Anurup M wrote:
>> + * This code is based on the uncore PMU's like arm-cci and
>> + * arm-ccn.
> Nit: s/PMU's/PMUs/

Ok.

> [...]
>
>> +struct hisi_l3c_hwcfg {
>> +	u32 module_id;
>> +	u32 bank_select;
>> +	u32 bank_id;
>> +};
>> +/* hip05/06 chips L3C bank identifier */
>> +static u32 l3c_bankid_map_v1[MAX_BANKS] = {
>> +	0x02, 0x04, 0x01, 0x08,
>> +};
>> +
>> +/* hip07 chip L3C bank identifier */
>> +static u32 l3c_bankid_map_v2[MAX_BANKS] = {
>> +	0x01, 0x02, 0x03, 0x04,
>> +};
> What exactly are these?

Explained in below section.

> Why do they differ like this, and why is htis not described in the DT?
>

Shall make instance-id as separate as suggested. and describe it.

>> +/* Return the L3C bank index to use in PMU name */
>> +static u32 get_l3c_bank_v1(u32 module_id, u32 bank_select)
>> +{
>> +	u32 i;
>> +
>> +	/*
>> +	 * For v1 chip (hip05/06) the index of bank_select
>> +	 * in the bankid_map gives the bank index.
>> +	 */
>> +	for (i = 0 ; i < MAX_BANKS; i++)
>> +		if (l3c_bankid_map_v1[i] == bank_select)
>> +			break;
>> +
>> +	return i;
>> +}
>> +
>> +/* Return the L3C bank index to use in PMU name */
>> +static u32 get_l3c_bank_v2(u32 module_id, u32 bank_select)
>> +{
>> +	u32 i;
>> +
>> +	/*
>> +	 * For v2 chip (hip07) each bank has different
>> +	 * module ID. So index of module ID in the
>> +	 * bankid_map gives the bank index.
>> +	 */
>> +	for (i = 0 ; i < MAX_BANKS; i++)
>> +		if (l3c_bankid_map_v2[i] == module_id)
>> +			break;
>> +
>> +	return i;
>> +}
> Can you please elaborate on the relationship between the index, its
> bank, and its module?
>
> It's not clear to me what's going on above.

The module_id and bank_select values are both needed to identify the L3 
cache bank/instance.
The v1 and v2 chip differ in the way these values are mapped.

In v1 hw (hip05/06):
instance 0: module_id = 0x04, bank_select = 0x02
instance 1: module_id = 0x04, bank_select = 0x04
instance 2: module_id = 0x04, bank_select = 0x01
instance 3: module_id = 0x04, bank_select = 0x08

In v2 hw (hip07):
instance 0: module_id = 0x01, bank_select = 0x01
instance 1: module_id = 0x02, bank_select = 0x01
instance 2: module_id = 0x03, bank_select = 0x01
instance 3: module_id = 0x04, bank_select = 0x01

So here we can see that for v1 hw, module_id is same and bank_select is 
different.
In v2 hw, every instance has different module_id to make djtag access 
faster than v1.
so the module_id is different and bank_select is same.

So I create a map array to identify the L3 cache instance.

+/* hip05/06 chips L3C bank identifier */
+static u32 l3c_bankid_map_v1[MAX_BANKS] = {
+    0x02, 0x04, 0x01, 0x08,
+};
+
+/* hip07 chip L3C bank identifier */
+static u32 l3c_bankid_map_v2[MAX_BANKS] = {
+    0x01, 0x02, 0x03, 0x04,
+};


Is my approach OK? or can be improved?

> [...]
>
>> +static u32 hisi_l3c_read_counter(struct hisi_l3c_data *l3c_data, int cntr_idx)
>> +{
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 reg_off, value;
>> +
>> +	reg_off = get_counter_reg_off(cntr_idx);
>> +	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);
> This function can fail. If it fails, it doesn't initialise value, so
> that's full of junk.
>
> It is not ok to ignore that and return junk.

Agreed, Shall return 0 here. so counter would not be updated with junk.

> [...]
>
>> +	do {
>> +		/* Get count from the L3C bank / submodule */
>> +		new_raw_count += hisi_l3c_read_counter(l3c_data, idx);
>> +		prev_raw_count = local64_read(&hwc->prev_count);
>> +
>> +		/*
>> +		 *  compute the delta
>> +		 */
>> +		delta = (new_raw_count - prev_raw_count) & HISI_MAX_PERIOD;
>> +
>> +		local64_add(delta, &event->count);
>> +	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
>> +				 new_raw_count) != prev_raw_count);
> This is wrong. We shouldn't += the new_raw_count, and we should
> accumulate the delta outside of the loop. e.g.
>
> 	do {
> 		new_raw_count = hisi_l3c_read_counter(l3c_data, idx);
> 		prev_raw_count = local64_read(&hwc->prev_count);
> 	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> 				 new_raw_count) != prev_raw_count);
> 	
> 	delta = (new_raw_count - prev_raw_count) & HISI_MAX_PERIOD;
> 	local64_add(delta, &event->count);

Thanks for pointing it, Shall correct it.

> [...]
>
>> +static void hisi_l3c_set_evtype(struct hisi_pmu *l3c_pmu, int idx, u32 val)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 reg_off = L3C_EVTYPE_REG_OFF;
>> +	u32 event_value, value = 0;
>> +
>> +	event_value = (val - HISI_HWEVENT_L3C_READ_ALLOCATE);
>> +
>> +	/*
>> +	 * Select the appropriate Event select register(L3C_EVENT_TYPEx).
>> +	 * There are 2 Event Select registers for the 8 hardware counters.
>> +	 * For the first 4 hardware counters, the L3C_EVTYPE_REG_OFF is chosen.
>> +	 * For the next 4 hardware counters, the second register is chosen.
>> +	 */
>> +	if (idx > 3)
>> +		reg_off += 4;
> Please factor this logic out into a macro, e.g.
>
> #define L3C_EVTYPE_REG(idx)	(L3C_EVTYPE_REG_OFF + (idx <= 3 ? 0 : 4))
>
> ... then you can use it above to initialise reg_off.

Ok. shall add it.

>> +
>> +	/*
>> +	 * Value to write to event select register
>> +	 * Each byte in the 32 bit select register is used to
>> +	 * configure the event code. Each byte correspond to a
>> +	 * counter register to use.
>> +	 */
>> +	val = event_value << (8 * idx);
>> +
>> +	/*
>> +	 * Set the event in L3C_EVENT_TYPEx Register
>> +	 * for all L3C banks
>> +	 */
>> +	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);
>> +	value &= ~(0xff << (8 * idx));
>> +	value |= val;
>> +	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);
> This is a recurring pattern. Please factor it out.
>
> What happens when either of these fail?
>
>> +static void hisi_l3c_clear_evtype(struct hisi_pmu *l3c_pmu, int idx)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 reg_off = L3C_EVTYPE_REG_OFF;
>> +	u32 value;
>> +
>> +	if (!hisi_l3c_counter_valid(idx)) {
>> +		dev_err(l3c_pmu->dev,
>> +			"Unsupported event index:%d!\n", idx);
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Clear Counting in L3C event config register.
>> +	 * Select the appropriate Event select register(L3C_EVENT_TYPEx).
>> +	 * There are 2 Event Select registers for the 8 hardware counters.
>> +	 * For the first 4 hardware counters, the L3C_EVTYPE_REG_OFF is chosen.
>> +	 * For the next 4 hardware counters, the second register is chosen.
>> +	 */
>> +	if (idx > 3)
>> +		reg_off += 4;
>> +
>> +	/*
>> +	 * Clear the event in L3C_EVENT_TYPEx Register
>> +	 */
>> +	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);
>> +	value &= ~(0xff << (8 * idx));
>> +	value |= (0xff << (8 * idx));
>> +	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);
>> +}
> Same comments as for hisi_l3c_set_evtype().
>
>> +static u32 hisi_l3c_write_counter(struct hisi_pmu *l3c_pmu,
>> +				  struct hw_perf_event *hwc, u32 value)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 reg_off;
>> +	int idx = GET_CNTR_IDX(hwc);
>> +	int ret;
>> +
>> +	if (!hisi_l3c_counter_valid(idx)) {
>> +		dev_err(l3c_pmu->dev,
>> +			"Unsupported event index:%d!\n", idx);
>> +		return -EINVAL;
>> +	}
>> +
>> +	reg_off = get_counter_reg_off(idx);
>> +	ret = hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);
>> +	if (!ret)
>> +		ret = value;
>> +
>> +	return ret;
>> +}
> This does not make any sense.
>
> Why do we return the value upon a write?
>
> How is the caller supposed to distinguish that from an error code, given
> the return type is a u32 that cannot encode a negative error code?

Shall correct it. The return value will be either success or -EBUSY from 
djtag.

> What happens if the access times out?
>
>> +static void hisi_l3c_start_counters(struct hisi_pmu *l3c_pmu)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	unsigned long *used_mask = l3c_data->event_used_mask;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 num_counters = l3c_pmu->num_counters;
>> +	u32 value;
>> +	int enabled = bitmap_weight(used_mask, num_counters);
>> +
>> +	if (!enabled)
>> +		return;
>> +
>> +	/*
>> +	 * Set the event_bus_en bit in L3C AUCNTRL to start counting
>> +	 * for the L3C bank
>> +	 */
>> +	hisi_djtag_readreg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
>> +			   client, &value);
>> +	value |= L3C_EVENT_EN;
>> +	hisi_djtag_writereg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
>> +			    value, client);
>> +}
> What happens if these accesses time out?
>
> Why are we not proagating the error, or handling it somehow?
>
>> +static void hisi_l3c_stop_counters(struct hisi_pmu *l3c_pmu)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 value;
>> +
>> +	/*
>> +	 * Clear the event_bus_en bit in L3C AUCNTRL
>> +	 */
>> +	hisi_djtag_readreg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
>> +			   client, &value);
>> +	value &= ~(L3C_EVENT_EN);
>> +	hisi_djtag_writereg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
>> +			    value, client);
>> +}
> Likewise.

The djtag -EBUSY in hardware is a very rare scenario, and by design of 
hardware, does not occur unless there is a Chip hung situation.
The maximum timeout possible in djtag is 30us, and hardware logic shall 
reset it, if djtag is unavailable for more than 30us.
The timeout used in driver is 100ms to ensure that it does not fail in 
any case.
so I had ignored the error with just a warning.

I shall handle the error internally and propagate it until a void 
function (pmu->start, pmu->stop, pmu->del etc. are void).
e.g. in the scenario pmu->add ---> pmu->start. If start fail, pmu->add 
cannot catch it and continues.
the counter index could be cleared when pmu->del is called later.

Is this fine? Any suggestion to handle it?

>> +static void hisi_l3c_clear_event_idx(struct hisi_pmu *l3c_pmu, int idx)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	void *bitmap_addr;
>> +
>> +	if (!hisi_l3c_counter_valid(idx)) {
>> +		dev_err(l3c_pmu->dev, "Unsupported event index:%d!\n", idx);
>> +		return;
>> +	}
>> +
>> +	bitmap_addr = l3c_data->event_used_mask;
>> +	clear_bit(idx, bitmap_addr);
>> +}
> Please either replace bitmap_addr with:
>
> 	unsigned long *used_mask = l3c_data->event_used_mask;
>
> ... or get rid of it entirely and do:
>
> 	clear_bit(idx, l3c_data->event_used_mask);

Ok. Shall modify it

> [...]
>
>> +ssize_t hisi_event_sysfs_show(struct device *dev,
>> +			      struct device_attribute *attr, char *page)
>> +{
>> +	struct perf_pmu_events_attr *pmu_attr =
>> +		container_of(attr, struct perf_pmu_events_attr, attr);
>> +
>> +	if (pmu_attr->event_str)
>> +		return sprintf(page, "%s", pmu_attr->event_str);
>> +
>> +	return 0;
>> +}
> The absence of a string sounds like a bug.
>
> When can this happen?

Agreed, It will not be NULL.

Shall modify it as
return(sprintf(page, "%s", pmu_attr->event_str));

> [...]
>
>> +/* djtag read interface - Call djtag driver to access SoC registers */
>> +int hisi_djtag_readreg(int module_id, int bank, u32 offset,
>> +		       struct hisi_djtag_client *client, u32 *value)
>> +{
>> +	int ret;
>> +	u32 chain_id = 0;
>> +
>> +	while (bank != 1) {
>> +		bank = (bank >> 0x1);
>> +		chain_id++;
>> +	}
> Surely you can do this with fls or ilog2?
>
> A comment to explain why would be helpful.
>

Thanks, Shall use fls and add helper for this, shall add comment.

>> +/* djtag write interface - Call djtag driver  to access SoC registers */
>> +int hisi_djtag_writereg(int module_id, int bank, u32 offset,
>> +			u32 value, struct hisi_djtag_client *client)
>> +{
>> +	int ret;
>> +	u32 chain_id = 0;
>> +
>> +	while (bank != 1) {
>> +		bank = (bank >> 0x1);
>> +		chain_id++;
>> +	}
> ... please factor it out into a helper, regardless.
>
> [...]
>
>> +static int pmu_map_event(struct perf_event *event)
>> +{
>> +	return (int)(event->attr.config & HISI_EVTYPE_EVENT);
>> +}
>> +
>> +static int hisi_hw_perf_event_init(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
>> +	struct device *dev = hisi_pmu->dev;
>> +	struct perf_event *sibling;
>> +	int mapping;
>> +
>> +	mapping = pmu_map_event(event);
>> +	if (mapping < 0) {
>> +		dev_err(dev, "event %x:%llx not supported\n",
>> +			event->attr.type, event->attr.config);
>> +		return mapping;
>> +	}
>> +	/* For HiSilicon SoC update config_base based on event encoding */
>> +	hwc->config_base = event->attr.config;
> This is obviously not correct given the above, and the lack of other
> calls to pmu_map_event().

Agreed, I shall remove the pmu_map_event as there is no mapping done and do
hwc->config = event->attr.config;
as I currently only have the event code in it.

>> +
>> +	/*
>> +	 * We must NOT create groups containing mixed PMUs, although
>> +	 * software events are acceptable
>> +	 */
>> +	if (event->group_leader->pmu != event->pmu &&
>> +	    !is_software_event(event->group_leader))
>> +		return -EINVAL;
>> +
>> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
>> +			    group_entry)
>> +		if (sibling->pmu != event->pmu && !is_software_event(sibling))
>> +			return -EINVAL;
> Please also check the number of counters.

Ok

> [...]
>
>> +void hisi_uncore_pmu_enable(struct pmu *pmu)
>> +{
>> +	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
>> +
>> +	if (hisi_pmu->ops->start_counters)
>> +		hisi_pmu->ops->start_counters(hisi_pmu);
>> +}
>> +
>> +void hisi_uncore_pmu_disable(struct pmu *pmu)
>> +{
>> +	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
>> +
>> +	if (hisi_pmu->ops->stop_counters)
>> +		hisi_pmu->ops->stop_counters(hisi_pmu);
>> +}
> When do you not have these?
>
> In the absence of pmu::{enable,disable}, you must disallow groups, since
> their events will be enabled for different periods of time.

For L3 cache and MN PMU, pmu::{enable,disable}is present. But in case of 
Hisilicon DDRC PMU,
it is not available. It only support continuous counting. I shall 
disallow groups when adding support
for DDRC PMU.

> Thanks,
> Mark.
