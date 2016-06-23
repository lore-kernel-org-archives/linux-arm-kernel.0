From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Jun 2016 15:32:01 +0100
Subject: [PATCH v4 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <1466618819-2697-4-git-send-email-ttnguyen@apm.com>
References: <1466618819-2697-1-git-send-email-ttnguyen@apm.com>
 <1466618819-2697-4-git-send-email-ttnguyen@apm.com>
Message-ID: <20160623143201.GI8836@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 22, 2016 at 11:06:58AM -0700, Tai Nguyen wrote:
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 04e2653..be597dd 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -12,4 +12,11 @@ config ARM_PMU
>  	  Say y if you want to use CPU performance monitors on ARM-based
>  	  systems.
>  
> +config XGENE_PMU
> +        depends on PERF_EVENTS && ARCH_XGENE
> +        bool "APM SoC X-Gene PMU"

Nit: make this "APM X-Gene SoC PMU"

> +        default n
> +        help
> +          Say y if you want to use APM X-Gene SOC performance monitors.

Nit: s/SOC/SoC/ for consistency.

[...]

> +#include <linux/acpi.h>
> +#include <linux/clk.h>
> +#include <linux/cpumask.h>
> +#include <linux/efi.h>

Looking at the driver, I don't see any reason you need linux/efi.h, and
I can't imagine why this driver would care about EFI. Please drop that
include.

The other includes look fine.

> +#define PMU_MAX_COUNTERS	4
> +#define PMU_CNT_MAX_VAL		0x100000000ULL

I was a little confused by this. Please s/VAL/PERIOD/ (as the maximum
*value* will be 0xFFFFFFFF).

> +#define _GET_CNTR(ev)     (ev->hw.extra_reg.reg)
> +#define _GET_EVENTID(ev)  (ev->hw.config & 0xFFULL)
> +#define _GET_AGENTID(ev)  (ev->hw.extra_reg.config & 0xFFFFFFFFULL)
> +#define _GET_AGENT1ID(ev) ((ev->hw.extra_reg.config >> 32) & 0xFFFFFFFFULL)

I don't think you need to use the extra_reg fields for this. It's a
little bit confusing to use them, as the extra_reg (and branch_reg)
fields are for separately allocated PMU state.

_GET_CNTR can use hw_perf_event::idx,  and _GET_AGENT*_ID can use
config_base.

> +struct xgene_pmu_dev {
> +	struct hw_pmu_info *inf;
> +	struct xgene_pmu *parent;
> +	struct pmu pmu;
> +	u8 max_counters;
> +	DECLARE_BITMAP(cntr_assign_mask, PMU_MAX_COUNTERS);
> +	raw_spinlock_t lock;
> +	u64 max_period;
> +	const struct attribute_group **attr_groups;
> +	struct perf_event *pmu_counter_event[4];
> +};

I believe that the 4 should be PMU_MAX_COUNTERS, to match the bitmap.

[...]

> +#define XGENE_PMU_FORMAT_ATTR(_name, _config) \
> +	struct dev_ext_attribute pmu_format_attr_##_name = \
> +		{ __ATTR(_name, S_IRUGO, xgene_pmu_format_show, NULL), _config }
> +
> +static XGENE_PMU_FORMAT_ATTR(l3c_eventid, "config:0-7");
> +static XGENE_PMU_FORMAT_ATTR(l3c_agentid, "config1:0-9");
> +static XGENE_PMU_FORMAT_ATTR(iob_eventid, "config:0-7");
> +static XGENE_PMU_FORMAT_ATTR(iob_agentid, "config1:0-63");
> +static XGENE_PMU_FORMAT_ATTR(mcb_eventid, "config:0-5");
> +static XGENE_PMU_FORMAT_ATTR(mcb_agentid, "config1:0-9");
> +static XGENE_PMU_FORMAT_ATTR(mc_eventid, "config:0-28");
> +
> +static const struct attribute *l3c_pmu_format_attrs[] = {
> +	&pmu_format_attr_l3c_eventid.attr.attr,
> +	&pmu_format_attr_l3c_agentid.attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute *iob_pmu_format_attrs[] = {
> +	&pmu_format_attr_iob_eventid.attr.attr,
> +	&pmu_format_attr_iob_agentid.attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute *mcb_pmu_format_attrs[] = {
> +	&pmu_format_attr_mcb_eventid.attr.attr,
> +	&pmu_format_attr_mcb_agentid.attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute *mc_pmu_format_attrs[] = {
> +	&pmu_format_attr_mc_eventid.attr.attr,
> +	NULL,
> +};

As mentioned before, you can use compound literals for these and avoid
the redundancy. There is a trick to this, which I didn't explain last
time. You need to update XGENE_PMU_FORMAT_ATTR to match what we do in
the arm-cci driver for CCI_EXT_ATTR_ENTRY, using a single element array
to allow the compiler to statically allocate an anonymous struct and
generate a pointer to a sub-field at compile time. e.g.

#define XGENE_PMU_FORMAT_ATTR(_name, _config)                                           \
        &((struct dev_ext_attribute[]) {                                                \
                { __ATTR(_name, S_IRUGO, xgene_pmu_format_show, NULL), _config }        \
        })[0].attr.attr

static struct attribute *l3c_pmu_format_attrs[] = {
        XGENE_PMU_FORMAT_ATTR(l3c_eventid, "config:0-7"),
        XGENE_PMU_FORMAT_ATTR(l3c_agentid, "config1:0-9"),
        NULL,
};

> +static const struct attribute_group l3c_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = (struct attribute **) l3c_pmu_format_attrs,
> +};

I see based on that suspicious cast that attribute_group::attrs isn't
const, and so we're throwing away the constness of
xgene_pmu_cpumask_attrs here. I didn't realise that when I suggested
making the structures const; sorry for the bad advice in the last round
of review.

Forcefully casting away const isn't a great idea. For the timebeing,
please drop any casts which throw away const, and remove the instances
of const that made those necessary.

> +#define XGENE_PMU_EVENT_ATTR(_name) \
> +		__ATTR(_name, S_IRUGO, xgene_pmu_event_show, NULL)
> +#define XGENE_PMU_EVENT(_name, _config) { \
> +		.attr = XGENE_PMU_EVENT_ATTR(_name), \
> +		.config = _config, }
> +
> +static const struct xgene_pmu_event l3c_pmu_events[] = {
> +	XGENE_PMU_EVENT(cycle-count,			0x00),
> +	XGENE_PMU_EVENT(cycle-count-div-64,		0x01),
> +	XGENE_PMU_EVENT(read-hit,			0x02),
> +	XGENE_PMU_EVENT(read-miss,			0x03),
> +	XGENE_PMU_EVENT(write-need-replacement,		0x06),
> +	XGENE_PMU_EVENT(write-not-need-replacement,	0x07),
> +	XGENE_PMU_EVENT(tq-full,			0x08),
> +	XGENE_PMU_EVENT(ackq-full,			0x09),
> +	XGENE_PMU_EVENT(wdb-full,			0x0a),
> +	XGENE_PMU_EVENT(bank-fifo-full,			0x0b),
> +	XGENE_PMU_EVENT(odb-full,			0x0c),
> +	XGENE_PMU_EVENT(wbq-full,			0x0d),
> +	XGENE_PMU_EVENT(bank-conflict-fifo-issue,	0x0e),
> +	XGENE_PMU_EVENT(bank-fifo-issue,		0x0f),
> +};

[...]

> +/* Populated in xgene_pmu_probe */
> +static struct attribute *l3c_pmu_events_attrs[ARRAY_SIZE(l3c_pmu_events) + 1];
> +static struct attribute *iob_pmu_events_attrs[ARRAY_SIZE(iob_pmu_events) + 1];
> +static struct attribute *mcb_pmu_events_attrs[ARRAY_SIZE(mcb_pmu_events) + 1];
> +static struct attribute *mc_pmu_events_attrs[ARRAY_SIZE(mc_pmu_events) + 1];

As with the other attributes above, please use the CCI_EXT_ATTR_ENTRY
trick to initialise these at compile time, rather than initialising this
in xgene_pmu_probe. e.g.

#define XGENE_PMU_EVENT_ATTR(_name, _config)                                    \
        &((struct xgene_pmu_event[]) {{                                         \
                .attr = __ATTR(_name, S_IRUGO, xgene_pmu_event_show, NULL),     \
                .config = _config,                                              \
        }})[0].attr.attr

static struct attribute *l3c_pmu_events_attrs[] = {
        XGENE_PMU_EVENT_ATTR(cycle-count,                       0x00),
        XGENE_PMU_EVENT_ATTR(cycle-count-div-64,                0x01),
        XGENE_PMU_EVENT_ATTR(read-hit,                          0x02),
        XGENE_PMU_EVENT_ATTR(read-miss,                         0x03),
        XGENE_PMU_EVENT_ATTR(write-need-replacement,            0x06),
        XGENE_PMU_EVENT_ATTR(write-not-need-replacement,        0x07),
        XGENE_PMU_EVENT_ATTR(tq-full,                           0x08),
        XGENE_PMU_EVENT_ATTR(ackq-full,                         0x09),
        XGENE_PMU_EVENT_ATTR(wdb-full,                          0x0a),
        XGENE_PMU_EVENT_ATTR(bank-fifo-full,                    0x0b),
        XGENE_PMU_EVENT_ATTR(odb-full,                          0x0c),
        XGENE_PMU_EVENT_ATTR(wbq-full,                          0x0d),
        XGENE_PMU_EVENT_ATTR(bank-conflict-fifo-issue,          0x0e),
        XGENE_PMU_EVENT_ATTR(bank-fifo-issue,                   0x0f),
        NULL,
};

> +	/*
> +	 * Each bit of the config1 field represents an agent from which the
> +	 * request of the event come. The event is counted only if it's caused
> +	 * by a request of an agent has the bit set.
> +	 * By default, the event is counted for all agents.
> +	 */
> +	if (config1)
> +		hwc->extra_reg.config = config1;
> +	else
> +		hwc->extra_reg.config = 0xFFFFFFFFFFFFFFFFULL;

Previously I asked you to invert the meaning of this, such that the
default would be to match all masters.

I understand that in HW, you need to write 0xFFFFFFFFFFFFFFFF to match
all masters, as you mentioned in your last reply. The simple way to
handle that is to bitwise invert the value when writing it to HW , i.e.
write ~(hwc->extra_reg.config). Please do so, updating the documentation
appropriately.

[...]

> +static int xgene_perf_add(struct perf_event *event, int flags)
> +{
> +	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +	struct hw_perf_event *hw = &event->hw;
> +
> +	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;

Please either use event->hw.field or hw->field consistently.

> +
> +	/* Allocate an event counter */
> +	hw->idx = get_next_avail_cntr(pmu_dev);
> +	if (hw->idx < 0)
> +		return -EAGAIN;
> +
> +	event->hw.extra_reg.reg = (u16) hw->idx;

That cast shouldn't be necessary, given idx will be between 0 and 4, and
reg is an unsigned int.

Given this is already in hw->idx, what is the benefit of duplicating this?

You can get rid of this line if you change _GET_CNTR to return
ev->hw.idx.

> +
> +	if (flags & PERF_EF_START)
> +		xgene_perf_start(event, PERF_EF_RELOAD);
> +
> +	/* Update counter event pointer for Interrupt handler */
> +	pmu_dev->pmu_counter_event[hw->idx] = event;

Are interrupts guaranteed to be disabled here, or should these be
swapped? Otherwise, what happens if an interrupt comes in before we
updated this pointer?

> +
> +	return 0;
> +}
> +
> +static void xgene_perf_del(struct perf_event *event, int flags)
> +{
> +	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +
> +	xgene_perf_stop(event, PERF_EF_UPDATE);
> +
> +	/* clear the assigned counter */
> +	clear_avail_cntr(pmu_dev, _GET_CNTR(event));
> +
> +	perf_event_update_userpage(event);
> +}

It would be a good idea to remove the dangling pmu_dev->pmu_counter_event
pointer, even if not strictly required.

> +
> +static u64 xgene_perf_event_update(struct perf_event *event)
> +{
> +	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 delta, prev_raw_count, new_raw_count;
> +
> +again:
> +	prev_raw_count = local64_read(&hwc->prev_count);
> +	new_raw_count = pmu_dev->max_period;

I don't understand this. Why are we not reading the counter here?

This means that the irq handler won't be reading the counter, which
means we're throwing away events, and I suspect other cases are broken
too.

> +
> +	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> +			    new_raw_count) != prev_raw_count)
> +		goto again;
> +
> +	delta = (new_raw_count - prev_raw_count) & pmu_dev->max_period;
> +
> +	local64_add(delta, &event->count);
> +	local64_sub(delta, &hwc->period_left);

Given we aren't sampling, does the period left matter? It looks like
drivers are inconsistent w.r.t. this, and I'm not immediately sure :(

> +
> +	return new_raw_count;
> +}
> +
> +static int xgene_perf_event_set_period(struct perf_event *event)
> +{
> +	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	s64 left = local64_read(&hwc->period_left);
> +	s64 period = hwc->sample_period;
> +	int ret = 0;
> +
> +	if (unlikely(left <= -period)) {
> +		left = period;
> +		local64_set(&hwc->period_left, left);
> +		hwc->last_period = period;
> +		ret = 1;
> +	}
> +
> +	if (unlikely(left <= 0)) {
> +		left += period;
> +		local64_set(&hwc->period_left, left);
> +		hwc->last_period = period;
> +		ret = 1;
> +	}
> +
> +	/*
> +	 * Limit the maximum period to prevent the counter value
> +	 * from overtaking the one we are about to program. In
> +	 * effect we are reducing max_period to account for
> +	 * interrupt latency (and we are being very conservative).
> +	 */
> +	if (left > (pmu_dev->max_period >> 1))
> +		left = pmu_dev->max_period >> 1;
> +
> +	local64_set(&hwc->prev_count, (u64) -left);
> +
> +	xgene_pmu_write_counter(pmu_dev, hwc->idx, (u64)(-left) & 0xffffffff);
> +
> +	perf_event_update_userpage(event);
> +
> +	return ret;
> +}

Given the lack of sampling, I suspect that you can simply follow what
the arm-cci driver does, and always use exactly half a max period.

[...]

> +static irqreturn_t _xgene_pmu_isr(int irq, struct xgene_pmu_dev *pmu_dev)
> +{
> +	struct xgene_pmu *xgene_pmu = pmu_dev->parent;
> +	u32 pmovsr;
> +	int idx;
> +
> +	pmovsr = readl(pmu_dev->inf->csr + PMU_PMOVSR) & PMU_OVERFLOW_MASK;
> +	/* Clear interrupt flag */
> +	if (xgene_pmu->version == PCP_PMU_V1)
> +		writel(0x0, pmu_dev->inf->csr + PMU_PMOVSR);
> +	else
> +		writel(pmovsr, pmu_dev->inf->csr + PMU_PMOVSR);
> +
> +	if (!pmovsr)
> +		return IRQ_NONE;
> +
> +	for (idx = 0; idx < PMU_MAX_COUNTERS; idx++) {
> +		struct perf_event *event = pmu_dev->pmu_counter_event[idx];
> +		int overflowed = pmovsr & BIT(idx);
> +
> +		/* Ignore if we don't have an event. */
> +		if (!event || !overflowed)
> +			continue;
> +		xgene_perf_event_update(event);
> +		xgene_perf_event_set_period(event);

As I mentioned earlier, the lack of a counter read in
xgene_perf_event_update() means this is broken.

> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t xgene_pmu_isr(int irq, void *dev_id)
> +{
> +	struct xgene_pmu_dev_ctx *ctx, *temp_ctx;
> +	struct xgene_pmu *xgene_pmu = dev_id;
> +	u32 val;
> +
> +	xgene_pmu_mask_int(xgene_pmu);

Why do you need to mask the IRQ? This handler is called in hard IRQ
context.

> +
> +	/* Get Interrupt PMU source */
> +	val = readl(xgene_pmu->pcppmu_csr + PCPPMU_INTSTATUS_REG)
> +	      & PCPPMU_INTMASK;

I don't think you need the mask here, given you only test masks below.
I think that can be removed.

Otherwise, please leave the '&' dangling on the first line.

> +	if (val & PCPPMU_INT_MCU) {
> +		list_for_each_entry_safe(ctx, temp_ctx,
> +				&xgene_pmu->mcpmus, next) {
> +			_xgene_pmu_isr(irq, ctx->pmu_dev);
> +		}
> +	}
> +	if (val & PCPPMU_INT_MCB) {
> +		list_for_each_entry_safe(ctx, temp_ctx,
> +				&xgene_pmu->mcbpmus, next) {
> +			_xgene_pmu_isr(irq, ctx->pmu_dev);
> +		}
> +	}
> +	if (val & PCPPMU_INT_L3C) {
> +		list_for_each_entry_safe(ctx, temp_ctx,
> +				&xgene_pmu->l3cpmus, next) {
> +			_xgene_pmu_isr(irq, ctx->pmu_dev);
> +		}
> +	}
> +	if (val & PCPPMU_INT_IOB) {
> +		list_for_each_entry_safe(ctx, temp_ctx,
> +				&xgene_pmu->iobpmus, next) {
> +			_xgene_pmu_isr(irq, ctx->pmu_dev);
> +		}
> +	}
> +
> +	xgene_pmu_unmask_int(xgene_pmu);
> +
> +	return IRQ_HANDLED;
> +}

[...]

> +	/* Populate PMU event atrribute arrays */
> +	for (i = 0; i < ARRAY_SIZE(l3c_pmu_events); i++)
> +		l3c_pmu_events_attrs[i] =
> +			(struct attribute *) &l3c_pmu_events[i].attr.attr;
> +	for (i = 0; i < ARRAY_SIZE(iob_pmu_events); i++)
> +		iob_pmu_events_attrs[i] =
> +			(struct attribute *) &iob_pmu_events[i].attr.attr;
> +	for (i = 0; i < ARRAY_SIZE(mcb_pmu_events); i++)
> +		mcb_pmu_events_attrs[i] =
> +			(struct attribute *) &mcb_pmu_events[i].attr.attr;
> +	for (i = 0; i < ARRAY_SIZE(mc_pmu_events); i++)
> +		mc_pmu_events_attrs[i] =
> +			(struct attribute *) &mc_pmu_events[i].attr.attr;

As mentioend earlier, you can do this at compile time. Please do.

Thanks,
Mark.
