From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Mar 2017 15:33:18 +0000
Subject: [PATCH V4] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <1489760657-26961-1-git-send-email-agustinv@codeaurora.org>
References: <1489760657-26961-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <20170323153317.GI9287@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Agustin,

Structurally, this looks good to me.

I have a few minor comments below; with those fixed up I think this is
ready to merge.

On Fri, Mar 17, 2017 at 10:24:17AM -0400, Agustin Vega-Frias wrote:
> +/*
> + * General constants
> + */
> +
> +/* Number of counters on each PMU */
> +#define L3_NUM_COUNTERS  8
> +/* Mask for the event type field within perf_event_attr.config and EVTYPE reg */
> +#define L3_MAX_EVTYPE    0xFF

Given it's a mask, it would be better to name this L3_EVTYPE_MASK.

Perhaps L3_EVTYPE_MASK, then?

[...]

> +/* L3_HML3_PM_EVTYPEx */
> +#define EVSEL(__val)          ((u32)((__val) & 0xFF))

This cast can go.

[...]

> +/* L3_M_BC_CR */
> +#define BC_RESET              (((u32)1) << 1)
> +#define BC_ENABLE             ((u32)1)

The u32 cast is somewhat unusual. Can we please do this as:

#define BC_RESET		(1UL << 1)
#define BC_ENABLE		(1UL << 0)

> +
> +/* L3_M_BC_SATROLL_CR */
> +#define BC_SATROLL_CR_RESET   (0)
> +
> +/* L3_M_BC_CNTENSET */
> +#define PMCNTENSET(__cntr)    (((u32)1) << ((__cntr) & 0x7))

Likewise:

#define PMCNTENSET(__cntr	(1UL << ((__cntr) & 0x7))

... and so on for the other definitions of this form.

[...]

> +/*
> + * Events
> + */
> +
> +#define L3_CYCLES		0x01
> +#define L3_READ_HIT		0x20
> +#define L3_READ_MISS		0x21
> +#define L3_READ_HIT_D		0x22
> +#define L3_READ_MISS_D		0x23
> +#define L3_WRITE_HIT		0x24
> +#define L3_WRITE_MISS		0x25

Can we please Please give these a L3_EVT_ (or L3_EVENT_) prefix?

Then we can add a NONE event for the odd counter in the long conter
case.

[...]

> +struct l3cache_event_ops {
> +	struct perf_event	*event;
> +	/* Called to start event monitoring */
> +	void (*start)(struct perf_event *event);
> +	/* Called to stop event monitoring */
> +	void (*stop)(struct perf_event *event, int flags);
> +	/* Called to update the perf_event */
> +	void (*update)(struct perf_event *event);
> +};

I believe the event field can go.

> +/*
> + * Implementation of long counter operations
> + *
> + * 64bit counters are implemented by chaining two of the 32bit physical
> + * counters. The PMU only supports chaining of adjacent even/odd pairs
> + * and for simplicity the driver always configures the odd counter to
> + * count the overflows of the lower-numbered even counter. Note that since
> + * the resulting hardware counter is 64bits no IRQs are required to maintain
> + * the software counter which is also 64bits.
> + */

This is a really useful comment; thanks for putting this together!

> +
> +static void qcom_l3_cache__64bit_counter_start(struct perf_event *event)
> +{
> +	struct l3cache_pmu *l3pmu = to_l3cache_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +	u32 evsel = get_event_type(event);
> +	u32 gang = readl_relaxed(l3pmu->regs + L3_M_BC_GANG);
> +
> +	/* Set the odd counter to count the overflows of the even counter */
> +	writel_relaxed(gang | GANG_EN(idx + 1), l3pmu->regs + L3_M_BC_GANG);

Not a big deal, but could we organise this like:

	/* Set the odd counter to count the overflows of the even counter */
	gang = readl_relaxed(l3pmu->regs + L3_M_BC_GANG);
	gang |= GANG_EN(idx + 1);
	writel_relaxed(gang, l3pmu->regs + L3_M_BC_GANG);

... it makes it a little easier to spot the precise manipulation of the
register value, and easier to spot that this is an RMW sequence for the
same register.

> +
> +	/* Initialize the hardware counters and reset prev_count*/
> +	local64_set(&event->hw.prev_count, 0);
> +	writel_relaxed(0, l3pmu->regs + L3_HML3_PM_EVCNTR(idx+1));
> +	writel_relaxed(0, l3pmu->regs + L3_HML3_PM_EVCNTR(idx));

Nit: please use spaces around binary operators, i.e. s/idx+1/idx + 1/g.

[...]

> +static void qcom_l3_cache__64bit_counter_update(struct perf_event *event)
> +{
> +	struct l3cache_pmu *l3pmu = to_l3cache_pmu(event->pmu);
> +	int idx = event->hw.idx;
> +	u32 hi, lo;
> +	u64 prev, now;

Nit: s/now/new/ so as to match other drivers.

[...]

> +struct l3cache_event_ops event_ops_long = {
> +	.start = qcom_l3_cache__64bit_counter_start,
> +	.stop = qcom_l3_cache__64bit_counter_stop,
> +	.update = qcom_l3_cache__64bit_counter_update,
> +};

Please make this static const.

> +struct l3cache_event_ops event_ops_std = {
> +	.start = qcom_l3_cache__32bit_counter_start,
> +	.stop = qcom_l3_cache__32bit_counter_stop,
> +	.update = qcom_l3_cache__32bit_counter_update,
> +};

Likewise, please make this static const.

> +
> +/* Retrieve the appropriate operations for the given event */
> +static struct l3cache_event_ops *l3cache_event_get_ops(struct perf_event *event)

This will need to return a const pointer for the ops changes above.

[...]

> +static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
> +{
> +	struct l3cache_pmu *l3pmu;
> +	struct acpi_device *acpi_dev;
> +	struct resource *memrc;
> +	int rc;

Nit: please use ret rather than rc. I'd like to align the PMU drivers on
this convention.

Thanks,
Mark.
