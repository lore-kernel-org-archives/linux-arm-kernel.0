From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Wed, 14 Jun 2017 16:47:02 +0800
Subject: [PATCH v8 7/9] drivers: perf: hisi: Add support for Hisilicon SoC
 event counters
In-Reply-To: <20170609132320.GD10665@leverpostej>
References: <1495457315-238544-1-git-send-email-zhangshaokun@hisilicon.com>
 <20170609132320.GD10665@leverpostej>
Message-ID: <ed2faa00-bc24-ab97-6471-36cf824c77bd@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mark,

On 2017/6/9 21:23, Mark Rutland wrote:
> Hi,
> 
> On Mon, May 22, 2017 at 08:48:35PM +0800, Shaokun Zhang wrote:
>> +/*
>> + * ARMv8 HiSilicon Hardware counter Index.
>> + */
>> +enum hisi_l3c_pmu_counters {
>> +	HISI_IDX_L3C_COUNTER0		= 0x0,
>> +	HISI_IDX_L3C_COUNTER_MAX	= 0x8,
> 
> Just to check, there are 8 counters, numbered 0-7, right?
> 
> So HISI_IDX_L3C_COUNTER_MAX is a misleading name. It would be better to
> have:
> 
> #define HISI_L3C_NR_COUNTERS	8
> 
> ... and not bother with HISI_IDX_L3C_COUNTER0 at all.
> 

Agreed, Shall modify it.

> [...]
> 
>> +#define L3C_EVTYPE_REG_OFF 0x140
>> +#define L3C_EVCTRL_REG_OFF 0x04
>> +#define L3C_CNT0_REG_OFF 0x170
> 
> Please get rid of the _REG_OFF suffixes, and use tabs to indent the
> numbers so that they're kept aligned.
> 
> I see that L3C_EVTYPE_REG_OFF represents L3C_EVENT_TYPE0. Please use
> names for the specific registers.
> 
> #define L3C_EVENT_TYPE0		0x140
> #define L3C_EVENT_TYPE1		0x144
> 

Agreed, Shall modify it accordingly.

> [...]
> 
>> +#define L3C_EVENT_EN 0x1000000
> 
> It would be good to prefix this with the register name, to make it clear
> where it applies.
> 

Ok.

>> +/*
>> + * Default timer frequency to poll and avoid counter overflow.
>> + * CPU speed = 2.4Ghz, Therefore Access time = 0.4ns
>> + * L1 cache - 2 way set associative
>> + * L2  - 16 way set associative
>> + * L3  - 16 way set associative. L3 cache has 4 banks.
>> + *
>> + * Overflow time = 2^31 * (access time L1 + access time L2 + access time L3)
>> + * = 2^31 * ((2 * 0.4ns) + (16 * 0.4ns) + (4 * 16 * 0.4ns)) = 70 seconds
>> + *
>> + * L3 cache is also used by devices like PCIe, SAS etc. at
>> + * the same time. So the overflow time could be even smaller.
>> + * So on a safe side we use a timer interval of 10sec
>> + */
>> +#define L3C_HRTIMER_INTERVAL (10LL * MSEC_PER_SEC)
>> +
>> +#define GET_MODULE_ID(hwmod_data) hwmod_data->module_id
>> +#define GET_BANK_SEL(hwmod_data) hwmod_data->bank_select
> 
> Please get rid of these. They don't save anything over directly
> accessing these fields, while making it look as if they do.
> 

Ok, shall remove them.

>> +#define L3C_EVTYPE_REG(idx)	(L3C_EVTYPE_REG_OFF + (idx <= 3 ? 0 : 4))
>> +
>> +struct hisi_l3c_data {
>> +	struct hisi_djtag_client *client;
>> +	u32 module_id;
>> +	u32 bank_select;
> 
> ... and if typing is a pain, then we can shorten these to mod_id and
> bank_sel.
> 

ok, shall use mod_id and bank_sel.

>> +	u32 bank_id;
>> +};
>> +
>> +struct hisi_l3c_pmu_hw_diff {
>> +	u32 (*get_bank_id)(u32 module_id, u32 bank_select);
>> +};
> 
> This structure is confusingly named. What is the "diff" referring to?
> 

it refers to "difference", we want to handle difference in L3C hw between v1/v2 chips.

>> +
>> +/* hip05/06 chips L3C instance or bank identifier */
>> +static u32 l3c_bankid_map_v1[MAX_BANKS] = {
>> +	0x02, 0x04, 0x01, 0x08,
>> +};
>> +
>> +/* hip07 chip L3C instance or bank identifier */
>> +static u32 l3c_bankid_map_v2[MAX_BANKS] = {
>> +	0x01, 0x02, 0x03, 0x04,
>> +};
> 
> Back in v6, I asked for these to be described in the DT [1], and Anurup
> said they would be [2].
> 
> Please describe this mapping in the DT.
> 
> [1] https://lkml.kernel.org/r/20170321165252.GA29116 at leverpostej
> [2] https://lkml.kernel.org/r/58D8B25E.90308 at gmail.com
> 
> [...]
> 

Ok, we have described the module-id and instance-id values in DT and in source code and shall fix
the mapping in the DT.

>> +static void hisi_l3c_pmu_set_evtype(struct hisi_pmu *l3c_pmu, int idx, u32 val)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 reg_off, event_value, value = 0;
>> +
>> +	event_value = (val - HISI_HWEVENT_L3C_READ_ALLOCATE);
>> +
>> +	/*
>> +	 * Select the appropriate Event select register(L3C_EVENT_TYPEx).
>> +	 * There are 2 Event Select registers for the 8 hardware counters.
>> +	 * For the first 4 hardware counters, the L3C_EVTYPE_REG_OFF is chosen.
>> +	 * For the next 4 hardware counters, the second register is chosen.
>> +	 */
>> +	reg_off = L3C_EVTYPE_REG(idx);
>> +
>> +	/*
>> +	 * Write the event code in L3C_EVENT_TYPEx Register
>> +	 * Each byte in the 32 bit event select register is used to configure
>> +	 * the event code. Each byte correspond to a counter register to use.
>> +	 * Use (idx % 4) to select the byte to update in event select register
>> +	 * with the event code.
>> +	 */
>> +	val = event_value << (8 * (idx % 4));
>> +
>> +	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);
>> +	value &= ~(0xff << (8 * (idx % 4)));
>> +	value |= val;
>> +	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);
>> +}
>> +
>> +static void hisi_l3c_pmu_clear_evtype(struct hisi_pmu *l3c_pmu, int idx)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 reg_off, value;
>> +
>> +	if (!hisi_l3c_pmu_counter_valid(idx)) {
>> +		dev_err(l3c_pmu->dev, "Unsupported event index:%d!\n", idx);
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
>> +	reg_off = L3C_EVTYPE_REG(idx);
>> +
>> +	/*
>> +	 * Clear the event in L3C_EVENT_TYPEx Register
>> +	 * Each byte in the 32 bit event select register is used to configure
>> +	 * the event code. Each byte correspond to a counter register to use.
>> +	 * Use (idx % 4) to select the byte to clear in event select register
>> +	 * with the vale 0xff.
>> +	 */
>> +	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);
>> +	value &= ~(0xff << (8 * (idx % 4)));
>> +	value |= (0xff << (8 * (idx % 4)));
>> +	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);
>> +}
> 
> These set/clear functions share most of the same logic and comments.
> 
> Let's factor that out into a common helper:
> 
> static void hisi_l3c_pmu_set_evtype_idx(struct hisi_pmu *l3c_pmu, int idx, u8 type)
> {
> 	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
> 	struct hisi_djtag_client *client = l3c_data->client;
> 	u32 module_id = GET_MODULE_ID(l3c_data);
> 	u32 bank_sel = GET_BANK_SEL(l3c_data);
> 	u32 reg, reg_idx, shift, val;
> 
> 	if (!hisi_l3c_pmu_counter_valid(idx)) {
> 		dev_err(l3c_pmu->dev, "accessing invalid event idx %d\n", idx);
> 		return;
> 	}
> 
> 	/*
> 	 * Each event has an 8-bit field in the 32-bit L3C_EVENT_TYPEx
> 	 * registers. L3C_EVENT_TYPE0 handles events [0,3] and
> 	 * L3C_EVENT_TYPE1 handles events [4,7]. L3C_EVENT_TYPE0
> 	 * immediately precedes L3C_EVENT_TYPE1.
> 	 */
> 	reg = L3C_EVTYPE_REG_OFF + (idx / 4);
> 	reg_idx = idx % 4;
> 	shift = 8 * reg_idx;
> 
> 	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &val);
> 	val &= ~(0xff << shift);
> 	val |= ((u32)type << shift);
> 	hisi_djtag_writereg(module_id, bank_sel, reg_off, val, client);
> }
> 
> ... and simplify the clear/set functions:
> 
> #define L3C_EVTYPE_NONE		0xff
> 
> static void hisi_l3c_pmu_set_evtype(struct hisi_pmu *l3c_pmu, int idx, u32 type)
> {
> 	hisi_l3c_pmu_set_evtype_idx(l3c_pmu, idx, type);
> }
> 
> static void hisi_l3c_pmu_clear_evtype(struct hisi_pmu *l3c_pmu, int idx)
> {
> 	hisi_l3c_pmu_set_evtype_idx(l3c_pmu, idx, L3C_EVTYPE_NONE);
> }
> 
> ... also, can we have accessors that takes the l3c_data rather than
> having to extract that manually all over the place? e.g.
> 
> u32 l3c_reg_read(struct hisi_l3c_data *l3c, u32 reg)
> {
> 	u32 val;
> 	hisi_djtag_readreg(l3c->module_id, l3c->bank_select, client, &val);
> 	return val;
> }
> 
> void l3c_reg_write(struct hisi_l3c_data *l3c, u32 reg, u32 val)
> {
> 	hisi_djtag_writereg(l3c->module_id, l3c->bank_select, reg, val, l3c->client);
> }
> 
> ... this would significantly simplify most of the code.
> 

Thanks for the nice refactor, shall change them and simplify the code.

>> +static void hisi_l3c_pmu_write_counter(struct hisi_pmu *l3c_pmu,
>> +				       struct hw_perf_event *hwc, u32 value)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 reg_off;
>> +	int idx = GET_CNTR_IDX(hwc);
> 
> Please use hwc->idx directly, and get rid of GET_CNTR_IDX().
> 

Ok.

>> +
>> +	reg_off = get_counter_reg_off(idx);
>> +	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);
>> +}
>> +
>> +static void hisi_l3c_pmu_start_counters(struct hisi_pmu *l3c_pmu)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	unsigned long *used_mask = l3c_pmu->pmu_events.used_mask;
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
> 
> Is the register named L3C AUCNTRL or L3C_EVCTRL_REG_OFF?
> 
> Please make these consistent, and elsewhere, too.
> 

There is a L3C auxiliary control register and event control register, shall make these consistent.

>> +	value |= L3C_EVENT_EN;
>> +	hisi_djtag_writereg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
>> +			    value, client);
>> +}
>> +
>> +static void hisi_l3c_pmu_stop_counters(struct hisi_pmu *l3c_pmu)
>> +{
>> +	struct hisi_l3c_data *l3c_data = l3c_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = l3c_data->client;
>> +	u32 module_id = GET_MODULE_ID(l3c_data);
>> +	u32 bank_sel = GET_BANK_SEL(l3c_data);
>> +	u32 value;
>> +
> 
> Here you could also skip if there were no events.
> 
> [...]
> 

Ok.

>> +static struct attribute *hisi_l3c_pmu_events_attr[] = {
>> +	HISI_PMU_EVENT_ATTR_STR(read_allocate, "event=0x0"),
>> +	HISI_PMU_EVENT_ATTR_STR(write_allocate, "event=0x01"),
>> +	HISI_PMU_EVENT_ATTR_STR(read_noallocate, "event=0x02"),
>> +	HISI_PMU_EVENT_ATTR_STR(write_noallocate, "event=0x03"),
>> +	HISI_PMU_EVENT_ATTR_STR(read_hit, "event=0x04"),
>> +	HISI_PMU_EVENT_ATTR_STR(write_hit, "event=0x05"),
>> +	NULL,
>> +};
> 
> Duplicating these values is unfortunate. Can we use the mnemonics
> defined in enum hisi_l3c_pmu_event_types?
> 

Ok, shall modify it.

> [...]
> 
>> +	/* Get the L3C bank index to set the pmu name */
>> +	l3c_data->bank_id = l3c_hw->get_bank_id(l3c_data->module_id,
>> +						l3c_data->bank_select);
> 
> With this in the DT, hisi_l3c_pmu_get_module_instance_id() should
> probably handle this, and should be renamed to something like
> hisi_l3c_pmu_get_data().
> 

Ok.

>> +	if (l3c_data->bank_id == MAX_BANKS) {
>> +		dev_err(dev, "Invalid bank-select!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	hisi_l3c_pmu_init_data(l3c_pmu, client);
>> +
>> +	return 0;
>> +}
> 
> [...]
> 
>> +/*
>> + * PMU format attributes
>> + */
>> +ssize_t hisi_format_sysfs_show(struct device *dev,
>> +			       struct device_attribute *attr, char *buf)
>> +{
>> +	struct dev_ext_attribute *eattr;
>> +
>> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
>> +	return sprintf(buf, "%s\n", (char *) eattr->var);
>> +}
>> +
>> +/*
>> + * PMU event attributes
>> + */
>> +ssize_t hisi_event_sysfs_show(struct device *dev,
>> +			      struct device_attribute *attr, char *page)
>> +{
>> +	struct perf_pmu_events_attr *pmu_attr =
>> +		container_of(attr, struct perf_pmu_events_attr, attr);
>> +
>> +	return sprintf(page, "%s", pmu_attr->event_str);
>> +}
> 
> As we're just printing a string, surely you could use the same attribute
> type for both, and handle the newline consistently?
> 

Ok, will use dev_ext_attribute for both and handle the newline.

> [...]
> 
>> +static void hisi_uncore_pmu_disable_event(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
>> +
>> +	/* Disable the hardware event counting */
>> +	if (hisi_pmu->ops->disable_counter)
>> +		hisi_pmu->ops->disable_counter(hisi_pmu, GET_CNTR_IDX(hwc));
> 
> There's no disable_counter implementation in this patch or any
> subsequent patch. So I think we should remove it.
> 
> Likewise for enable_counter.
> 

Ok, agreed.

>> +
>> +	/*
>> +	 * Clear event in Event select registers.
>> +	 */
>> +	hisi_pmu->ops->clear_evtype(hisi_pmu, GET_CNTR_IDX(hwc));
>> +}
> 
> [...]
> 
>> +void hisi_uncore_pmu_start(struct perf_event *event, int flags)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
>> +
>> +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
>> +		return;
>> +
>> +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
>> +	hwc->state = 0;
>> +	hisi_pmu->ops->set_event_period(event);
>> +
>> +	if (flags & PERF_EF_RELOAD) {
>> +		u64 prev_raw_count =  local64_read(&hwc->prev_count);
>> +
>> +		hisi_pmu->ops->write_counter(hisi_pmu, hwc,
>> +					     (u32) prev_raw_count);
>> +	}
>> +
>> +	/* Start hrtimer when the first event is started in this PMU */
>> +	if (hisi_pmu->ops->start_hrtimer) {
>> +		hisi_pmu->num_active++;
>> +		list_add_tail(&event->active_entry, &hisi_pmu->active_list);
>> +
>> +		if (hisi_pmu->num_active == 1)
>> +			hisi_pmu->ops->start_hrtimer(hisi_pmu);
>> +	}
> 
> We should probably keep track of num_active regardless. Then we can use
> it to avoid work in the pmu_{enable,disable} methods.
> 

Ok, agreed.

>> +
>> +	hisi_uncore_pmu_enable_event(event);
>> +	perf_event_update_userpage(event);
>> +}
> 
> [...]
> 
>> +struct hisi_pmu *hisi_pmu_alloc(struct device *dev, u32 num_cntrs)
>> +{
>> +	struct hisi_pmu *hisi_pmu;
>> +	struct hisi_pmu_hwevents *pmu_events;
>> +
>> +	hisi_pmu = devm_kzalloc(dev, sizeof(*hisi_pmu), GFP_KERNEL);
>> +	if (!hisi_pmu)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	pmu_events = &hisi_pmu->pmu_events;
>> +	pmu_events->hw_events = devm_kcalloc(dev,
>> +					     num_cntrs,
>> +					     sizeof(*pmu_events->hw_events),
>> +					     GFP_KERNEL);
>> +	if (!pmu_events->hw_events)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	pmu_events->used_mask = devm_kcalloc(dev,
>> +					     BITS_TO_LONGS(num_cntrs),
>> +					     sizeof(*pmu_events->used_mask),
>> +					     GFP_KERNEL);
>> +	if (!pmu_events->used_mask)
>> +		return ERR_PTR(-ENOMEM);
> 
> Why is this a dynamic allocation ratehr than part of hisi_pmu_hwevents?
> 
> We already know an upper bound for num_cntrs that we can use for
> allocation.
> 

hisi_pmu_alloc is called by multiple hisi SoC uncore PMU devices like L3C, MN, DDRC etc.
and it is difficult to choose an upper bound for the max counters. so it is ok that we keep it dynamc alloc?

thanks
Shaokun

> Thanks,
> Mark.
> 
> .
> 
