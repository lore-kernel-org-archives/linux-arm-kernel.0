From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Jun 2017 16:23:27 +0100
Subject: [PATCH v3 2/2] perf: ThunderX2: Add Cavium Thunderx2 SoC UNCORE
 PMU driver
In-Reply-To: <1496645464-26062-3-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1496645464-26062-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1496645464-26062-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170609152326.GG10665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 12:21:04PM +0530, Ganapatrao Kulkarni wrote:
> This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
> Controller(DMC) and Level 3 Cache(L3C).

Can you elaborate a bit on this please? At minimum, it would be worht
mentioning:

* Whether the PMU has an overflow interrupt
* whether counters are programmable, or fixed-purpose
* whether counters are free-running
* whethar a single PMU cover the DMC & L3c, or if those are separate
* whether there can be multiple instances

[...]

> +#define UNCORE_MAX_COUNTERS		4
> +#define UNCORE_L3_MAX_TILES		16
> +#define UNCORE_DMC_MAX_CHANNELS		8
> +
> +#define UNCORE_HRTIMER_INTERVAL		(2 * NSEC_PER_SEC)

Please mention the lack of an overflow interrupt in the commit message.

Can you please add a comment explaining why 2 seconds is necessary
and/or sufficient?

What's the maximum rate that a counter can increment (in theory), and
how long would it take to overflow given that rate?

> +#define GET_EVENTID(ev)			((ev->hw.config) & 0x1ff)
> +#define GET_COUNTERID(ev)		((ev->hw.idx) & 0xf)
> +#define GET_CHANNELID(pmu_uncore)	(pmu_uncore->channel)
> +
> +#define DMC_COUNTER_CTL			0x234
> +#define DMC_COUNTER_DATA		0x240
> +#define L3C_COUNTER_CTL			0xA8
> +#define L3C_COUNTER_DATA		0xAC
> +
> +#define SELECT_CHANNEL			0xC
> +#define THUNDERX2_SMC_ID		0xC200FF00
> +#define THUNDERX2_SMC_READ		0xB004
> +#define THUNDERX2_SMC_WRITE		0xB005
> +
> +enum thunderx2_uncore_l3_events {
> +	L3_EVENT_NBU_CANCEL = 1,

What does zero mean?

L3_EVENT_NONE, perhaps?

> +	L3_EVENT_DIB_RETRY,
> +	L3_EVENT_DOB_RETRY,
> +	L3_EVENT_DIB_CREDIT_RETRY,
> +	L3_EVENT_DOB_CREDIT_RETRY,
> +	L3_EVENT_FORCE_RETRY,
> +	L3_EVENT_IDX_CONFLICT_RETRY,
> +	L3_EVENT_EVICT_CONFLICT_RETRY,
> +	L3_EVENT_BANK_CONFLICT_RETRY,
> +	L3_EVENT_FILL_ENTRY_RETRY,
> +	L3_EVENT_EVICT_NOT_READY_RETRY,
> +	L3_EVENT_L3_RETRY,
> +	L3_EVENT_READ_REQ,
> +	L3_EVENT_WRITE_BACK_REQ,
> +	L3_EVENT_INVALIDATE_NWRITE_REQ,
> +	L3_EVENT_INV_REQ,
> +	L3_EVENT_SELF_REQ,
> +	L3_EVENT_REQ,
> +	L3_EVENT_EVICT_REQ,
> +	L3_EVENT_INVALIDATE_NWRITE_HIT,
> +	L3_EVENT_INVALIDATE_HIT,
> +	L3_EVENT_SELF_HIT,
> +	L3_EVENT_READ_HIT,
> +	L3_EVENT_MAX,
> +};
> +
> +enum thunderx2_uncore_dmc_events {

Likewise, DMC_EVENT_NONE?

> +	DMC_EVENT_COUNT_CYCLES = 1,
> +	DMC_EVENT_RES2,
> +	DMC_EVENT_RES3,
> +	DMC_EVENT_RES4,
> +	DMC_EVENT_RES5,
> +	DMC_EVENT_RES6,
> +	DMC_EVENT_RES7,
> +	DMC_EVENT_RES8,
> +	DMC_EVENT_READ_64B,
> +	DMC_EVENT_READ_LESS_THAN_64B,
> +	DMC_EVENT_WRITE,
> +	DMC_EVENT_TXN_CYCLES,
> +	DMC_EVENT_DATA_TXFERED,
> +	DMC_EVENT_CANCELLED_READ_TXN,
> +	DMC_EVENT_READ_TXN_CONSUMED,
> +	DMC_EVENT_MAX,
> +};
> +
> +enum thunderx2_uncore_type {
> +	PMU_TYPE_INVALID,
> +	PMU_TYPE_L3C,
> +	PMU_TYPE_DMC,
> +};
> +
> +struct active_timer {
> +	struct perf_event *event;
> +	struct hrtimer hrtimer;
> +};
> +
> +/*
> + * pmu on each socket has 2 uncore devices(dmc and l3),
> + * each uncore device has up to 16 channels, each channel can sample
> + * events independently with counters up to 4.
> + *
> + * struct thunderx2_pmu_uncore_channel created per channel.
> + * struct thunderx2_pmu_uncore_dev per uncore device.
> + * struct thunderx2_pmu created per socket.
> + */
> +struct thunderx2_pmu_uncore_channel {
> +	struct thunderx2_pmu_uncore_dev *uncore_dev;
> +	struct pmu pmu;
> +	int counter;
> +	int channel;
> +	DECLARE_BITMAP(counter_mask, UNCORE_MAX_COUNTERS);
> +	struct active_timer *active_timers;

Do we really need a timer per-event? Can't have a single timer
per-channel, at least?

If we do need this, it would be better to make this an array within
thunderx2_pmu_uncore_channel. UNCORE_MAX_COUNTERS is small.

> +	/* to sync counter alloc/release */
> +	raw_spinlock_t lock;
> +};

[...]

> +static struct attribute *l3c_pmu_events_attrs[] = {
> +	EVENT_ATTR(nbu_cancel,			L3_EVENT_NBU_CANCEL),
> +	EVENT_ATTR(dib_retry,			L3_EVENT_DIB_RETRY),
> +	EVENT_ATTR(dob_retry,			L3_EVENT_DOB_RETRY),
> +	EVENT_ATTR(dib_credit_retry,		L3_EVENT_DIB_CREDIT_RETRY),
> +	EVENT_ATTR(dob_credit_retry,		L3_EVENT_DOB_CREDIT_RETRY),
> +	EVENT_ATTR(force_retry,			L3_EVENT_FORCE_RETRY),
> +	EVENT_ATTR(idx_conflict_retry,		L3_EVENT_IDX_CONFLICT_RETRY),
> +	EVENT_ATTR(evict_conflict_retry,	L3_EVENT_EVICT_CONFLICT_RETRY),
> +	EVENT_ATTR(bank_conflict_retry,		L3_EVENT_BANK_CONFLICT_RETRY),
> +	EVENT_ATTR(fill_entry_retry,		L3_EVENT_FILL_ENTRY_RETRY),
> +	EVENT_ATTR(evict_not_ready_retry,	L3_EVENT_EVICT_NOT_READY_RETRY),
> +	EVENT_ATTR(l3_retry,			L3_EVENT_L3_RETRY),
> +	EVENT_ATTR(read_requests,		L3_EVENT_READ_REQ),
> +	EVENT_ATTR(write_back_requests,		L3_EVENT_WRITE_BACK_REQ),
> +	EVENT_ATTR(inv_nwrite_requests,		L3_EVENT_INVALIDATE_NWRITE_REQ),
> +	EVENT_ATTR(inv_requests,		L3_EVENT_INV_REQ),
> +	EVENT_ATTR(self_requests,		L3_EVENT_SELF_REQ),
> +	EVENT_ATTR(requests,			L3_EVENT_REQ),
> +	EVENT_ATTR(evict_requests,		L3_EVENT_EVICT_REQ),
> +	EVENT_ATTR(inv_nwrite_hit,		L3_EVENT_INVALIDATE_NWRITE_HIT),
> +	EVENT_ATTR(inv_hit,			L3_EVENT_INVALIDATE_HIT),
> +	EVENT_ATTR(self_hit,			L3_EVENT_SELF_HIT),
> +	EVENT_ATTR(read_hit,			L3_EVENT_READ_HIT),
> +	NULL,
> +};

Some of these are plural, while others are not. Please be consistent 

> +static struct attribute *dmc_pmu_events_attrs[] = {
> +	EVENT_ATTR(cnt_cycles,			DMC_EVENT_COUNT_CYCLES),
> +	EVENT_ATTR(read_64b_txns,		DMC_EVENT_READ_64B),
> +	EVENT_ATTR(read_less_than_64b_txns,	DMC_EVENT_READ_LESS_THAN_64B),
> +	EVENT_ATTR(write_txns,			DMC_EVENT_WRITE),
> +	EVENT_ATTR(txn_cycles,			DMC_EVENT_TXN_CYCLES),
> +	EVENT_ATTR(data_txfered,		DMC_EVENT_DATA_TXFERED),
> +	EVENT_ATTR(cancelled_read_txn,		DMC_EVENT_CANCELLED_READ_TXN),
> +	EVENT_ATTR(read_txn_consumed,		DMC_EVENT_READ_TXN_CONSUMED),
> +	NULL,
> +};

Likewise.

[...]

> +static void secure_write_reg(uint32_t value, uint64_t pa)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(THUNDERX2_SMC_ID, THUNDERX2_SMC_WRITE,
> +			0, pa, value, 0, 0, 0, &res);
> +}
> +
> +static uint32_t secure_read_reg(uint64_t pa)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(THUNDERX2_SMC_ID, THUNDERX2_SMC_READ,
> +			0, pa, 0, 0, 0, 0,  &res);
> +	return res.a0;
> +}

These sounds *very* unsafe.

How exactly does the secure side handle these?

[...]

> +static void init_cntr_base_l3c(struct perf_event *event,
> +		struct thunderx2_pmu_uncore_dev *uncore_dev) {
> +
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* counter ctrl/data reg offset at 8 */
> +	hwc->config_base = uncore_dev->base
> +		+ L3C_COUNTER_CTL + (8 * GET_COUNTERID(event));
> +	hwc->event_base =  uncore_dev->base
> +		+ L3C_COUNTER_DATA + (8 * GET_COUNTERID(event));
> +}

Surely we can calculate this as required?

That way we can kill off reg_{readl,writel}, and use {readl,writel}
directly.

[...]

> +static void thunderx2_uncore_update(struct perf_event *event)
> +{
> +	s64 prev, new = 0;
> +	u64 delta;
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore;
> +	enum thunderx2_uncore_type type;
> +
> +	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> +	type = pmu_uncore->uncore_dev->type;
> +
> +	if (pmu_uncore->uncore_dev->select_channel)
> +		pmu_uncore->uncore_dev->select_channel(event);
> +
> +	new = reg_readl(hwc->event_base);
> +	prev = local64_xchg(&hwc->prev_count, new);
> +
> +	/* handle rollover of counters */
> +	if (new < prev)
> +		delta = (((1UL << 32) - prev) + new);
> +	else
> +		delta = new - prev;

We should be able to handle this without an explicit check, by doing
arithmetic on an unsigned 32-bit type.

[...]

> +	/* Pick one core from the node to use for cpumask attributes */
> +	event->cpu = cpumask_first(
> +			cpumask_of_node(pmu_uncore->uncore_dev->node));

Use uncore_dev->cpu_mask.

[...]

> +	/*
> +	 * We must NOT create groups containing mixed PMUs,
> +	 * although software events are acceptable
> +	 */
> +	if (event->group_leader->pmu != event->pmu &&
> +			!is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
> +			group_entry)
> +		if (sibling->pmu != event->pmu &&
> +				!is_software_event(sibling))
> +			return -EINVAL;

Please also check that the group doesn't require more counters than the
PMU has. Such groups can never be scheduled, and we should reject them
early.

[...]

> +static void thunderx2_uncore_start(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore;
> +	struct thunderx2_pmu_uncore_dev *uncore_dev;
> +	unsigned long irqflags;
> +	struct active_timer *active_timer;
> +
> +	hwc->state = 0;
> +	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> +	uncore_dev = pmu_uncore->uncore_dev;
> +
> +	raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
> +
> +	if (uncore_dev->select_channel)
> +		uncore_dev->select_channel(event);
> +	uncore_dev->start_event(event, flags);
> +	raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
> +
> +	perf_event_update_userpage(event);
> +	active_timer = &pmu_uncore->active_timers[GET_COUNTERID(event)];
> +	active_timer->event = event;
> +
> +	if (!hrtimer_active(&active_timer->hrtimer))

This looks dubious. we should balance starting/stopping the timer such
that we don't need to check if it's already running.

> +		hrtimer_start(&active_timer->hrtimer,
> +			ns_to_ktime(uncore_dev->hrtimer_interval),
> +			HRTIMER_MODE_REL_PINNED);
> +}
> +
> +static void thunderx2_uncore_stop(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore;
> +	struct thunderx2_pmu_uncore_dev *uncore_dev;
> +	unsigned long irqflags;
> +
> +	if (hwc->state & PERF_HES_UPTODATE)
> +		return;
> +
> +	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> +	uncore_dev = pmu_uncore->uncore_dev;
> +
> +	raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
> +
> +	if (uncore_dev->select_channel)
> +		uncore_dev->select_channel(event);
> +	uncore_dev->stop_event(event);
> +
> +	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> +	hwc->state |= PERF_HES_STOPPED;
> +	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
> +		thunderx2_uncore_update(event);
> +		hwc->state |= PERF_HES_UPTODATE;
> +	}
> +	raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
> +}
> +
> +static int thunderx2_uncore_add(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore;
> +	struct thunderx2_pmu_uncore_dev *uncore_dev;
> +
> +	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> +	uncore_dev = pmu_uncore->uncore_dev;
> +
> +	/* Allocate a free counter */
> +	hwc->idx  = alloc_counter(pmu_uncore);
> +	if (hwc->idx < 0)
> +		return -EAGAIN;
> +
> +	/* set counter control and data registers base address */
> +	uncore_dev->init_cntr_base(event, uncore_dev);
> +
> +	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> +	if (flags & PERF_EF_START)
> +		thunderx2_uncore_start(event, PERF_EF_RELOAD);
> +
> +	return 0;
> +}
> +
> +static void thunderx2_uncore_del(struct perf_event *event, int flags)
> +{
> +	struct thunderx2_pmu_uncore_channel *pmu_uncore =
> +			pmu_to_thunderx2_pmu_uncore(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	thunderx2_uncore_stop(event, PERF_EF_UPDATE);
> +
> +	hrtimer_cancel(
> +		&pmu_uncore->active_timers[GET_COUNTERID(event)].hrtimer);

This doesn't pair with add, where we didn't touch the hrtimer at all.

Either add/del should poke the hrtimer, or start/stop should.

[...]

> +	/* we can run up to (max_counters * max_channels) events simultaneously.
> +	 * allocate hrtimers per channel.
> +	 */
> +	pmu_uncore->active_timers = devm_kzalloc(dev,
> +			sizeof(struct active_timer) * uncore_dev->max_counters,
> +			GFP_KERNEL);

As mentioned above, I think we can fold these into the channel
structure, and don't need to allocate it separately.

[...]

> +	/* Pick one core from the node to use for cpumask attributes */
> +	cpumask_set_cpu(cpumask_first(cpumask_of_node(uncore_dev->node)),
> +			&uncore_dev->cpu_mask);

What about !CONFIG_NUMA? cpu_mask_of_node() will be cpu_online_mask.

... so surely that will result in erroneous behaviour from the driver?

We should have the FW describe the affinity explicitly rather than
trying to infer it via Linux's internal (advisory) abstractions.

Thanks,
Mark.
