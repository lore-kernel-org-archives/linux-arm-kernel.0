From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Jun 2017 15:57:29 +0100
Subject: [PATCH v4 4/5] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <1496676177-29356-5-git-send-email-will.deacon@arm.com>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <1496676177-29356-5-git-send-email-will.deacon@arm.com>
Message-ID: <20170615145729.GB26471@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Sorry for the delay on this review; it's taken me a while to ingest DDI
0586A and get a feel for how profiling PMUs work.

I have a number of comments below.

On Mon, Jun 05, 2017 at 04:22:56PM +0100, Will Deacon wrote:
> +/* ID registers */
> +#define PMSIDR_EL1			sys_reg(3, 0, 9, 9, 7)

Nit: could we please give the sysreg definitions a SYS_ prefix, for
consistency with other (architected) sysregs?

Ideally, as these are architected they'd live in <asm/sysreg.h>, but I'm
happy to factor that out later.

> +#define PMSIDR_EL1_FE_SHIFT		0
> +#define PMSIDR_EL1_FT_SHIFT		1
> +#define PMSIDR_EL1_FL_SHIFT		2
> +#define PMSIDR_EL1_ARCHINST_SHIFT	3
> +#define PMSIDR_EL1_LDS_SHIFT		4
> +#define PMSIDR_EL1_ERND_SHIFT		5
> +#define PMSIDR_EL1_INTERVAL_SHIFT	8
> +#define PMSIDR_EL1_INTERVAL_MASK	0xfUL
> +#define PMSIDR_EL1_MAXSIZE_SHIFT	12
> +#define PMSIDR_EL1_MAXSIZE_MASK		0xfUL
> +#define PMSIDR_EL1_COUNTSIZE_SHIFT	16
> +#define PMSIDR_EL1_COUNTSIZE_MASK	0xfUL
> +
> +#define PMBIDR_EL1			sys_reg(3, 0, 9, 10, 7)
> +#define PMBIDR_EL1_ALIGN_SHIFT		0
> +#define PMBIDR_EL1_ALIGN_MASK		0xfU
> +#define PMBIDR_EL1_P_SHIFT		4
> +#define PMBIDR_EL1_F_SHIFT		5
> +
> +/* Sampling controls */
> +#define PMSCR_EL1			sys_reg(3, 0, 9, 9, 0)
> +#define PMSCR_EL1_E0SPE_SHIFT		0
> +#define PMSCR_EL1_E1SPE_SHIFT		1
> +#define PMSCR_EL1_CX_SHIFT		3
> +#define PMSCR_EL1_PA_SHIFT		4
> +#define PMSCR_EL1_TS_SHIFT		5
> +#define PMSCR_EL1_PCT_SHIFT		6
> +
> +#define PMSICR_EL1			sys_reg(3, 0, 9, 9, 2)
> +
> +#define PMSIRR_EL1			sys_reg(3, 0, 9, 9, 3)
> +#define PMSIRR_EL1_RND_SHIFT		0
> +#define PMSIRR_EL1_IVAL_MASK		0xffUL

This is a little odd. This covers RND and (some) RES0 bits, not
INTERVAL, so it's the opposite polarity to the rest of the masks, and
incomplete (missing the upper 32 RES0 bits).

Could we please have this in the same polarity as the other masks,
precisely covering the INTERVAL field? i.e.

#define PMSIRR_EL1_INTERVAL_SHIFT	8
#define PMSIRR_EL1_INTERVAL_MASK	0xffffffUL

... I've proposed corresponding updates to the usages below.

> +
> +/* Filtering controls */
> +#define PMSFCR_EL1			sys_reg(3, 0, 9, 9, 4)
> +#define PMSFCR_EL1_FE_SHIFT		0
> +#define PMSFCR_EL1_FT_SHIFT		1
> +#define PMSFCR_EL1_FL_SHIFT		2
> +#define PMSFCR_EL1_B_SHIFT		16
> +#define PMSFCR_EL1_LD_SHIFT		17
> +#define PMSFCR_EL1_ST_SHIFT		18
> +
> +#define PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
> +#define PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
> +
> +#define PMSLATFR_EL1			sys_reg(3, 0, 9, 9, 6)
> +#define PMSLATFR_EL1_MINLAT_SHIFT	0

I was going to suggest that we need a PMSLATFR_EL1_MINLAT_MASK, but I
see this is handled implicitly by ATTR_CFG_FLD_min_latency_{LO,HI} and
ATTR_CFG_GET_FLD().

> +
> +/* Buffer controls */
> +#define PMBLIMITR_EL1			sys_reg(3, 0, 9, 10, 0)
> +#define PMBLIMITR_EL1_E_SHIFT		0
> +#define PMBLIMITR_EL1_FM_SHIFT		1
> +#define PMBLIMITR_EL1_FM_MASK		0x3UL
> +#define PMBLIMITR_EL1_FM_STOP_IRQ	(0 << PMBLIMITR_EL1_FM_SHIFT)
> +
> +#define PMBPTR_EL1			sys_reg(3, 0, 9, 10, 1)
> +
> +/* Buffer error reporting */
> +#define PMBSR_EL1			sys_reg(3, 0, 9, 10, 3)
> +#define PMBSR_EL1_COLL_SHIFT		16
> +#define PMBSR_EL1_S_SHIFT		17
> +#define PMBSR_EL1_EA_SHIFT		18
> +#define PMBSR_EL1_DL_SHIFT		19
> +#define PMBSR_EL1_EC_SHIFT		26
> +#define PMBSR_EL1_EC_MASK		0x3fUL
> +
> +#define PMBSR_EL1_EC_BUF		(0x0UL << PMBSR_EL1_EC_SHIFT)
> +#define PMBSR_EL1_EC_FAULT_S1		(0x24UL << PMBSR_EL1_EC_SHIFT)
> +#define PMBSR_EL1_EC_FAULT_S2		(0x25UL << PMBSR_EL1_EC_SHIFT)
> +
> +#define PMBSR_EL1_FAULT_FSC_SHIFT	0
> +#define PMBSR_EL1_FAULT_FSC_MASK	0x3fUL

Nit: it might be worth having MSS in the name to show the field
hierarchy, e.g. PMBSR_EL1_MSS_FAULT_FSC_MASK

> +
> +#define PMBSR_EL1_BUF_BSC_SHIFT		0
> +#define PMBSR_EL1_BUF_BSC_MASK		0x3fUL
> +
> +#define PMBSR_EL1_BUF_BSC_FULL		(0x1UL << PMBSR_EL1_BUF_BSC_SHIFT)

Likewise here.

> +
> +#define psb_csync()			asm volatile("hint #17")

Other than my comments above, all the register/field/insn definitions
appear to be correct per DDI 0586A.

> +
> +struct arm_spe_pmu_buf {
> +	int					nr_pages;
> +	bool					snapshot;
> +	void					*base;
> +};
> +
> +struct arm_spe_pmu {
> +	struct pmu				pmu;
> +	struct platform_device			*pdev;
> +	cpumask_t				supported_cpus;
> +	struct hlist_node			hotplug_node;
> +
> +	int					irq; /* PPI */
> +
> +	u16					min_period;
> +	u16					cnt_width;

Elsewhere, we refer to this as the counter size (e.g.
SPE_PMU_CAP_CNT_SZ, and count_size in the sysfs interface).

Could we please pick one of "width" and "size" and use it consistently?

I guess "size" is preferable, given the architectural name is
"CountSize".

> +
> +#define SPE_PMU_FEAT_FILT_EVT			(1UL << 0)
> +#define SPE_PMU_FEAT_FILT_TYP			(1UL << 1)
> +#define SPE_PMU_FEAT_FILT_LAT			(1UL << 2)
> +#define SPE_PMU_FEAT_ARCH_INST			(1UL << 3)
> +#define SPE_PMU_FEAT_LDS			(1UL << 4)
> +#define SPE_PMU_FEAT_ERND			(1UL << 5)
> +#define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
> +	u64					features;
> +
> +	u16					max_record_sz;
> +	u16					align;
> +	struct perf_output_handle __percpu	*handle;
> +};
> +
> +#define to_spe_pmu(p) (container_of(p, struct arm_spe_pmu, pmu))
> +
> +/* Convert a free-running index from perf into an SPE buffer offset */
> +#define PERF_IDX2OFF(idx, buf)	((idx) & (((buf)->nr_pages << PAGE_SHIFT) - 1))

The masking logic here assumes nr_pages is a power of two.

That's not always true, as arm_spe_pmu_setup_aux() only ensures that
nr_pages is a multiple of 2 * PAGE_SIZE, and only when using snapshot
mode.

For example, with ten 4K pages:

nr_pages:			0b1010
(nr_pages << PAGE_SHIFT):	0b1010000000000000
(nr_pages << PAGE_SHIFT) - 1:	0b1001111111111111

> +
> +/* Keep track of our dynamic hotplug state */
> +static enum cpuhp_state arm_spe_pmu_online;
> +
> +/* This sysfs gunk was really good fun to write. */
> +enum arm_spe_pmu_capabilities {
> +	SPE_PMU_CAP_ARCH_INST = 0,

No need for the initializer; enums start at zero.

> +	SPE_PMU_CAP_ERND,
> +	SPE_PMU_CAP_FEAT_MAX,
> +	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
> +	SPE_PMU_CAP_MIN_IVAL,
> +};

IMO, it would be worth having s/CAP/CAP_FEAT/ for the HW features.

We could get rid of the confusing SPE_PMU_CAP_FEAT_MAX definition here,
if we were to:

> +
> +static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
> +	[SPE_PMU_CAP_ARCH_INST]	= SPE_PMU_FEAT_ARCH_INST,
> +	[SPE_PMU_CAP_ERND]	= SPE_PMU_FEAT_ERND,
> +};

.. change this to:

static int arm_spe_pmu_feat_caps[] = {
	...
};

... and:

> +
> +static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
> +{
> +	if (cap < SPE_PMU_CAP_FEAT_MAX)

... change this to:

	if (cap < ARRAY_SIZE(arm_spe_pmu_feat_caps))

> +		return !!(spe_pmu->features & arm_spe_pmu_feat_caps[cap]);
> +
> +	switch (cap) {
> +	case SPE_PMU_CAP_CNT_SZ:
> +		return spe_pmu->cnt_width;
> +	case SPE_PMU_CAP_MIN_IVAL:
> +		return spe_pmu->min_period;
> +	default:
> +		WARN(1, "unknown cap %d\n", cap);
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t arm_spe_pmu_cap_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct arm_spe_pmu *spe_pmu = platform_get_drvdata(pdev);
> +	struct dev_ext_attribute *ea =
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	int cap = (long)ea->var;
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n",
> +		arm_spe_pmu_cap_get(spe_pmu, cap));
> +}
> +
> +#define SPE_EXT_ATTR_ENTRY(_name, _func, _var)				\
> +	&((struct dev_ext_attribute[]) {				\
> +		{ __ATTR(_name, S_IRUGO, _func, NULL), (void *)_var }	\
> +	})[0].attr.attr
> +
> +#define SPE_CAP_EXT_ATTR_ENTRY(_name, _var)				\
> +	SPE_EXT_ATTR_ENTRY(_name, arm_spe_pmu_cap_show, _var)
> +
> +static struct attribute *arm_spe_pmu_cap_attr[] = {
> +	SPE_CAP_EXT_ATTR_ENTRY(arch_inst, SPE_PMU_CAP_ARCH_INST),
> +	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
> +	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
> +	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
> +	NULL,
> +};

I'd have expected GCC to warn about (integer/enum) _var values being
cast straight to void *, given the size mismatch.

Is that not the case, or do we need an unsigned long cast in
SPE_CAP_EXT_ATTR_ENTRY()?

Maybe GCC only complains the other way around.

[...]

> +/* Convert between user ABI and register values */
> +static u64 arm_spe_event_to_pmscr(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +	u64 reg = 0;
> +
> +	reg |= ATTR_CFG_GET_FLD(attr, ts_enable) << PMSCR_EL1_TS_SHIFT;
> +	reg |= ATTR_CFG_GET_FLD(attr, pa_enable) << PMSCR_EL1_PA_SHIFT;

We should limit PA access to privileged users.

> +
> +	if (!attr->exclude_user)
> +		reg |= BIT(PMSCR_EL1_E0SPE_SHIFT);
> +
> +	if (!attr->exclude_kernel)
> +		reg |= BIT(PMSCR_EL1_E1SPE_SHIFT);
> +
> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
> +		reg |= BIT(PMSCR_EL1_CX_SHIFT);

... maybe likewise for CONTEXTIDR, too.

> +
> +	return reg;
> +}
> +
> +static void arm_spe_event_sanitise_period(struct perf_event *event)
> +{
> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> +	u64 period = event->hw.sample_period & ~PMSIRR_EL1_IVAL_MASK;

... as noted above, the upper 32 bits are RES0 in addition to the low 8
bits, so we need to explicitly check bits 31:8, e.g.

	u64 period = event->hw.sample_period;
	period &= (PMSIRR_EL1_INTERVAL_MASK << PMSIRR_EL1_INTERVAL_SHIFT);

> +
> +	if (period < spe_pmu->min_period)
> +		period = spe_pmu->min_period;

We already verify this in arm_spe_pmu_event_init(), so we don't need to
check this here.

We can drop arm_spe_event_sanitise_period() entirely. Given we validate
the period at event_init() time, there's no need to sanitize the value.

> +
> +	event->hw.sample_period = period;
> +}
> +
> +static u64 arm_spe_event_to_pmsirr(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +	u64 reg = 0;
> +
> +	arm_spe_event_sanitise_period(event);
> +
> +	reg |= ATTR_CFG_GET_FLD(attr, jitter) << PMSIRR_EL1_RND_SHIFT;
> +	reg |= event->hw.sample_period;
> +
> +	return reg;
> +}

Given the above:

	u64 reg = event->hw.sample_period;
	reg |= ATTR_CFG_GET_FLD(attr, jitter) << PMSIRR_EL1_RND_SHIFT;

	return reg;

[...]

> +static bool arm_spe_pmu_buffer_mgmt_pending(u64 pmbsr)
> +{
> +	const char *err_str;
> +
> +	/* Service required? */
> +	if (!(pmbsr & BIT(PMBSR_EL1_S_SHIFT)))
> +		return false;
> +
> +	/* We only expect buffer management events */
> +	switch (pmbsr & (PMBSR_EL1_EC_MASK << PMBSR_EL1_EC_SHIFT)) {
> +	case PMBSR_EL1_EC_BUF:
> +		/* Handled below */
> +		break;
> +	case PMBSR_EL1_EC_FAULT_S1:
> +	case PMBSR_EL1_EC_FAULT_S2:
> +		err_str = "Unexpected buffer fault";
> +		goto out_err;
> +	default:
> +		err_str = "Unknown error code";
> +		goto out_err;
> +	}

For the error cases, I take it the assumption is that we leave
PMBSR_EL1.S set, so that the HW doesn't start again?

> +
> +	/* Buffer management event */
> +	switch (pmbsr & (PMBSR_EL1_BUF_BSC_MASK << PMBSR_EL1_BUF_BSC_SHIFT)) {
> +	case PMBSR_EL1_BUF_BSC_FULL:
> +		/* Ensure new profiling data is visible to the CPU */
> +		psb_csync();
> +		dsb(nsh);

I think that NSH might not be sufficient, given how this function is
used by callers below. I'll comment specifically in those call-sites.

> +		return true;
> +	default:
> +		err_str = "Unknown buffer status code";
> +	}
> +
> +out_err:
> +	pr_err_ratelimited("%s on CPU %d [PMBSR=0x%08llx]\n", err_str,
> +			   smp_processor_id(), pmbsr);

It might be worth dumping pmbsr with %016lx. The upper 64 bits are
currently RES0, but they do exist.

> +	return false;
> +}
> +

Could we have a comment block here to describe (roughly) what 
we're trying to do for the snapshot case?

> +static u64 arm_spe_pmu_next_snapshot_off(struct perf_output_handle *handle)
> +{
> +	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(handle->event->pmu);
> +	u64 head = PERF_IDX2OFF(handle->head, buf);
> +	u64 limit = buf->nr_pages * PAGE_SIZE;
> +
> +	/*
> +	 * The trace format isn't parseable in reverse, so clamp
> +	 * the limit to half of the buffer size in snapshot mode
> +	 * so that the worst case is half a buffer of records, as
> +	 * opposed to a single record.
> +	 */
> +	if (head < limit >> 1)
> +		limit >>= 1;

I was going to ask how we ensured nr_pages was 2 * SZ_4K * k, but I see
that arm_spe_pmu_setup_aux() ensures that when using snapshot mode.

> +
> +	/*
> +	 * If we're within max_record_sz of the limit, we must
> +	 * pad, move the head index and recompute the limit.
> +	 */
> +	if (limit - head < spe_pmu->max_record_sz) {
> +		memset(buf->base + head, 0, limit - head);

Could we have a mnemonic for the padding byte, and/or a helper that
wraps memset? e.g.

static void pad_buffer(void *start, u64 size)
{
	/* The padding packet is a single zero byte */
	memset(start, 0, size);
}

> +		handle->head = PERF_IDX2OFF(limit, buf);
> +		limit = ((buf->nr_pages * PAGE_SIZE) >> 1) + handle->head;
> +	}
> +
> +	return limit;
> +}
> +
> +static u64 __arm_spe_pmu_next_off(struct perf_output_handle *handle)
> +{
> +	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
> +	u64 head = PERF_IDX2OFF(handle->head, buf);
> +	u64 tail = PERF_IDX2OFF(handle->head + handle->size, buf);
> +	u64 wakeup = PERF_IDX2OFF(handle->wakeup, buf);
> +	u64 limit = buf->nr_pages * PAGE_SIZE;
> +
> +	/*
> +	 * Set the limit pointer to either the watermark or the
> +	 * current tail pointer; whichever comes first.
> +	 */
> +	if (handle->head + handle->size <= handle->wakeup) {
> +		/* The tail is next, so check for wrapping */
> +		if (tail >= head) {
> +			/*
> +			 * No wrapping, but need to align downwards to
> +			 * avoid corrupting unconsumed data.
> +			 */
> +			limit = round_down(tail, PAGE_SIZE);
> +
> +		}
> +	} else if (wakeup >= head) {

When wakeup == head, do we need to signal a wakeup event somehow?
Currently we'll pad the buffer, signal truncation, and end output, which
seems a little odd, but maybe that's what perf expects.

> +		/*
> +		 * The wakeup is next and doesn't wrap. Align upwards to
> +		 * ensure that we do indeed reach the watermark.
> +		 */
> +		limit = round_up(wakeup, PAGE_SIZE);
> +
> +		/*
> +		 * If rounding up crosses the tail, then we have to
> +		 * round down to avoid corrupting unconsumed data.
> +		 * Hopefully the tail will have moved by the time we
> +		 * hit the new limit.
> +		 */
> +		if (wakeup < tail && limit > tail)
> +			limit = round_down(wakeup, PAGE_SIZE);
> +	}

It took me a while to grok that we must consider the wakeup in
free-running counter space to avoid early wakeups, while we must
consider the tail in ring-buffer offset space to avoid clobbering data.

With that understanding, I think we have an issue here. If wakeup is
more than buffer size in the future, and the buffer is empty, I think we
set the limit too low.

In that case, we'd evaluate:

	handle->head + handle->size <= handle->wakeup

... as true, since size is at most buffer size. Thus we'd go into the
first if block. There we'd evaluate:

	tail >= head

... as true, since when the buffer is empty, head == tail. Thus, we'd
set the limit to:

	round_down(tail, PAGE_SIZE)

... which'll leave us with limit <= head, since head == tail. Thus,
we'll hit the case below:

> +
> +	/*
> +	 * If rounding down crosses the head, then the buffer is full,
> +	 * so pad to tail and end the session.
> +	 */
> +	if (limit <= head) {
> +		memset(buf->base + head, 0, handle->size);
> +		perf_aux_output_skip(handle, handle->size);
> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> +		perf_aux_output_end(handle, 0);
> +		limit = 0;
> +	}
> +
> +	return limit;
> +}

... and end all output, even though the entire buffer was empty, and we
could have returned the end of the buffer as the limit.

It might be that something prevents wakeup from being that far in the
future, but in previous discussions we'd assumed that it could be any
arbitrary value.

I believe we can solve that, and simplify the logic as below. I've left
the wakeup < head and wakeup == head cases as above, ignored and
terminating respectively.

static u64 __arm_spe_pmu_next_off(struct perf_output_handle *handle)
{
	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
	const u64 bufsize = buf->nr_pages * PAGE_SIZE;
	u64 limit = bufsize;
	u64 head = PERF_IDX2OFF(handle->head, buf);
	u64 tail = PERF_IDX2OFF(handle->head + handle->size, buf);
	u64 wakeup = PERF_IDX2OFF(handle->wakeup, buf);

	if (!handle->size)
		goto no_space;
	
	/*
	 * Avoid clobbering unconsumed data. We know we have space, so
	 * if we see head == tail we know that the buffer is empty. If
	 * head > tail, then there's nothing to clobber prior to
	 * wrapping.
	 */
	if (head < tail)
		limit = round_down(tail, PAGE_SIZE);
	
	/*
	 * Wakeup may be arbitrarily far into future. If it's not in the
	 * current generation, either we'll wrap before hitting it, or
	 * it's in the past and has been handled already.
	 *
	 * If there's a wakeup before we wrap, arrange to be woken up by
	 * the page boundary following it. Keep the tail boundary if
	 * that's lower.
	 */
	if ((handle->wakeup / bufsize) == (handle->head / bufsize)) &&
	    head <= wakeup)
		limit = min(limit, round_up(wakeup, PAGE_SIZE));

	if (limit <= head)
		goto no_space;
	
	return limit;

no_space:
	memset(buf->base + head, 0, handle->size);
	perf_aux_output_skip(handle, handle->size);
	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
	perf_aux_output_end(handle, 0);

	return 0;
}

> +
> +static u64 arm_spe_pmu_next_off(struct perf_output_handle *handle)
> +{
> +	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(handle->event->pmu);
> +	u64 limit = __arm_spe_pmu_next_off(handle);
> +	u64 head = PERF_IDX2OFF(handle->head, buf);
> +
> +	/*
> +	 * If the head has come too close to the end of the buffer,
> +	 * then pad to the end and recompute the limit.
> +	 */
> +	if (limit && (limit - head < spe_pmu->max_record_sz)) {
> +		memset(buf->base + head, 0, limit - head);
> +		perf_aux_output_skip(handle, limit - head);
> +		limit = __arm_spe_pmu_next_off(handle);
> +	}
> +
> +	return limit;
> +}
> +
> +static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> +					  struct perf_event *event)
> +{
> +	u64 base, limit;
> +	struct arm_spe_pmu_buf *buf;
> +
> +	/* Start a new aux session */
> +	buf = perf_aux_output_begin(handle, event);
> +	if (!buf) {
> +		event->hw.state |= PERF_HES_STOPPED;
> +		/*
> +		 * We still need to clear the limit pointer, since the
> +		 * profiler might only be disabled by virtue of a fault.
> +		 */
> +		limit = 0;
> +		goto out_write_limit;
> +	}
> +
> +	limit = buf->snapshot ? arm_spe_pmu_next_snapshot_off(handle)
> +			      : arm_spe_pmu_next_off(handle);
> +	if (limit)
> +		limit |= BIT(PMBLIMITR_EL1_E_SHIFT);
> +
> +	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
> +	write_sysreg_s(base, PMBPTR_EL1);
> +	limit += (u64)buf->base;
> +

I believe an isb() is necessary here to ensure the write to PMBPTR_EL1
occurs before the write to PMBLIMITR_EL1 enables the PMU. Otherwise, the
CPU could execute those out-of-order.

It's not clear to me whether that is sufficient for the PMU to observe
the new PMBPTR_EL1 before the new PMBLIMITR_EL1 value, though I assume
it must be.

> +out_write_limit:
> +	write_sysreg_s(limit, PMBLIMITR_EL1);
> +}
> +
> +static bool arm_spe_perf_aux_output_end(struct perf_output_handle *handle,
> +					struct perf_event *event,
> +					bool resume)
> +{
> +	u64 pmbptr, pmbsr, offset, size;
> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> +	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
> +	bool truncated;
> +
> +	/*
> +	 * We can be called via IRQ work trying to disable the PMU after
> +	 * a buffer full event. In this case, the aux session has already
> +	 * been stopped, so there's nothing to do here.
> +	 */
> +	if (!buf)
> +		return false;
> +
> +	/*
> +	 * If there isn't a pending management event and we're not stopping
> +	 * the current session, then just leave everything alone.
> +	 */
> +	pmbsr = read_sysreg_s(PMBSR_EL1);

When we call from arm_spe_pmu_irq_handler(), I think we need
synchronisation before reading PMBSR_EL1.

AFAICT from the spec, a context synchronisation event doesn't ensure
that the PMU's indirect write to PMBSR_EL1 is visible to the PE's direct
read above. I beleive we need a PSB CSYNC (and subsequent ISB) to ensure
that.

The only other caller is from arm_spe_pmu_stop(), which first calls
arm_spe_pmu_disable_and_drain_local(), so I guess the new barriers
should live in arm_spe_pmu_irq_handler(). I'll comment there.

> +	if (!arm_spe_pmu_buffer_mgmt_pending(pmbsr) && resume)
> +		return false; /* Spurious IRQ */
> +
> +	/* Ensure hardware updates to PMBPTR_EL1 are visible */
> +	isb();

Can we please move this into arm_spe_pmu_buffer_mgmt_pending(), after
the associated PSB CSYNC?

Then we can say that arm_spe_pmu_buffer_mgmt_pending() ensures all HW
updates have been synchronised (and made visible) if it returns true,
and it's easier to see that the synchronisation is correct.

> +
> +	/*
> +	 * Work out how much data has been written since the last update
> +	 * to the head index.
> +	 */
> +	pmbptr = round_down(read_sysreg_s(PMBPTR_EL1), spe_pmu->align);

I don't believe we need to align this.

Per the spec, PMBPTR_EL1[M:0] are RES0 in HW unless sync external abort
reporting is present, in which case they're valid. We write these bits
as zero, unless we have a bug elsewhere.

... so either the bits are zero, and we're fine, or an external abourt
has been hit. In the external abort case, we have no idea how far we
need to reverse the base pointer anyhow.

> +	offset = pmbptr - (u64)buf->base;
> +	size = offset - PERF_IDX2OFF(handle->head, buf);
> +
> +	if (buf->snapshot)
> +		handle->head = offset;

It's be worth a /* see arm_spe_pmu_next_snapshot_off() */ comment
or similar to explain what we're going for the snapshot case here.

> +
> +	/*
> +	 * Either the buffer is full or we're stopping the session. Check
> +	 * that we didn't write a partial record, since this can result
> +	 * in unparseable trace and we must disable the event.
> +	 */
> +	if (pmbsr & BIT(PMBSR_EL1_COLL_SHIFT))
> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> +
> +	truncated = pmbsr & BIT(PMBSR_EL1_DL_SHIFT);
> +	if (truncated)
> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> +
> +	perf_aux_output_end(handle, size);

The comment block above perf_aux_output_end() says:

  It is the pmu driver's responsibility to observe ordering rules of the
  hardware, so that all the data is externally visible before this is
  called.

... but in arm_spe_pmu_buffer_mgmt_pending() we only ensured that the
data was visible in the current NSH domain (i.e. only to this CPU).

I followed the callchain for updating head:

perf_aux_output_end()
-> perf_event_aux_event()
-> perf_output_end()
-> perf_output_put_handle()

... I see that there's an smp_wmb() (i.e. a DMB ISHST) on that path, but
it's not clear to me if that's sufficient to ensure that the PMU's
writes are made visible to other CPUs.

Given the comment, I'd feel happier if we had something here or in
arm_spe_pmu_buffer_mgmt_pending() to ensure that the PMU's prior writes
are visible to other CPUs.

> +
> +	/*
> +	 * If we're not resuming the session, then we can clear the fault
> +	 * and we're done, otherwise we need to start a new session.
> +	 */
> +	if (!resume)
> +		write_sysreg_s(0, PMBSR_EL1);
> +	else if (!truncated)
> +		arm_spe_perf_aux_output_begin(handle, event);
> +
> +	return true;
> +}
> +
> +/* IRQ handling */
> +static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> +{
> +	struct perf_output_handle *handle = dev;
> +
> +	if (!perf_get_aux(handle))
> +		return IRQ_NONE;
> +
> +	if (!arm_spe_perf_aux_output_end(handle, handle->event, true))
> +		return IRQ_NONE;

As commented in arm_spe_perf_aux_output_end(), I think we need a
psb_csync(); isb() sequence prior to the read of PMBSR_EL1 in
arm_spe_perf_aux_output_end() to ensure that it is up-to-date w.r.t. the
interrupt.

> +
> +	irq_work_run();
> +	isb(); /* Ensure the buffer is disabled if data loss has occurred */

What exactly are we synchronising here?

AFAICT, when truncation occurs we don't clear PMBLIMITR_EL1.E, so the
buffer is only implicitly disabled by the PMU's indirect write
PMBSR_EL1.S, which we must have already synchronised prior to reading
PMBSR_EL1.

... so I can't see why this is necessary.

> +	write_sysreg_s(0, PMBSR_EL1);

... and regardless, we clear PMBSR_EL1.S here, which'll start the PMU
again, even if truncation occured, which I don't think we want.

Can we have arm_spe_perf_aux_output_end() clear PMBLIMITR_EL1.E when
truncation occurs?

> +	return IRQ_HANDLED;
> +}
> +
> +/* Perf callbacks */
> +static int arm_spe_pmu_event_init(struct perf_event *event)
> +{
> +	u64 reg;
> +	struct perf_event_attr *attr = &event->attr;
> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> +
> +	/* This is, of course, deeply driver-specific */
> +	if (attr->type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (event->cpu >= 0 &&
> +	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
> +		return -ENOENT;

We're not rejecting cpu < 0, so I take it we're trying to handle
per-task events?

As I've mentioned before, that case worries me. One thing I've just
realised we need to figure out is what happens if attr.inherit is set.
The core doesn't reject that, and I suspect we may need to here.

> +
> +	if (arm_spe_event_to_pmsevfr(event) & PMSEVFR_EL1_RES0)
> +		return -EOPNOTSUPP;
> +
> +	if (event->hw.sample_period < spe_pmu->min_period ||
> +	    event->hw.sample_period & PMSIRR_EL1_IVAL_MASK)
> +		return -EOPNOTSUPP;

As mentioned in the sysreg comments, we need to check the upper 32 bits
of the PMSIRR value are zero, so we'll need something like:

	if (event->hw.sample_period < spe_pmu->min_period)
		return -EOPNOTSUPP;
	
	if (event->hw.sample_period &
	    ~(PMSIRR_EL1_INTERVAL_MASK << PMSIRR_EL1_INTERVAL_SHIFT))
		return -EOPNOTSUPP;

I think there's a slight miswording in the spec. Page 56 of the spec
(DDI 0586A) says of the PMSIRR_EL1.INTERVAL field:

    Software should set this to a value greater than the minimum
    indicated by PMSIDR_EL1.Interval.

... whereas here we're checking it's *at least* the minimum interval,
which I think is the intent of the spec. That's probably something we
should have clarified spec-side, with s/greater than/at least/.

> +
> +	if (attr->exclude_idle)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Feedback-directed frequency throttling doesn't work when we
> +	 * have a buffer of samples. We'd need to manually count the
> +	 * samples in the buffer when it fills up and adjust the event
> +	 * count to reflect that. Instead, force the user to specify a
> +	 * sample period instead.
> +	 */
> +	if (attr->freq)
> +		return -EINVAL;
> +
> +	reg = arm_spe_event_to_pmsfcr(event);
> +	if ((reg & BIT(PMSFCR_EL1_FE_SHIFT)) &&
> +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
> +		return -EOPNOTSUPP;
> +
> +	if ((reg & BIT(PMSFCR_EL1_FT_SHIFT)) &&
> +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
> +		return -EOPNOTSUPP;
> +
> +	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
> +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
> +		return -EOPNOTSUPP;

Does anything prevent this event from being added to a group?

Surely we should check that here?

> +
> +	return 0;
> +}
> +
> +static void arm_spe_pmu_start(struct perf_event *event, int flags)
> +{
> +	u64 reg;
> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_output_handle *handle = this_cpu_ptr(spe_pmu->handle);
> +
> +	hwc->state = 0;
> +	arm_spe_perf_aux_output_begin(handle, event);
> +	if (hwc->state)
> +		return;

I was expecting we'd do this last, since PMBLIIMITR.E enables profiling.

I understand that we're relying on the PMSCR_EL1 filtering value to
prevent anything being written to tbe buffer until we've vonfigured the
options, but I'd feel a lot happier if we consistently relied upon
PMBLIMITR.E for that.

> +
> +	reg = arm_spe_event_to_pmsfcr(event);
> +	write_sysreg_s(reg, PMSFCR_EL1);
> +
> +	reg = arm_spe_event_to_pmsevfr(event);
> +	write_sysreg_s(reg, PMSEVFR_EL1);
> +
> +	reg = arm_spe_event_to_pmslatfr(event);
> +	write_sysreg_s(reg, PMSLATFR_EL1);
> +
> +	if (flags & PERF_EF_RELOAD) {
> +		reg = arm_spe_event_to_pmsirr(event);
> +		write_sysreg_s(reg, PMSIRR_EL1);
> +		isb();
> +		reg = local64_read(&hwc->period_left);
> +		write_sysreg_s(reg, PMSICR_EL1);
> +	}
> +
> +	reg = arm_spe_event_to_pmscr(event);
> +	isb();
> +	write_sysreg_s(reg, PMSCR_EL1);
> +}
> +
> +static void arm_spe_pmu_disable_and_drain_local(void)
> +{
> +	/* Disable profiling at EL0 and EL1 */
> +	write_sysreg_s(0, PMSCR_EL1);
> +	isb();
> +
> +	/* Drain any buffered data */
> +	psb_csync();
> +	dsb(nsh);
> +
> +	/* Disable the profiling buffer */
> +	write_sysreg_s(0, PMBLIMITR_EL1);

Can't this be done when we clear PMSCR_EL1? Surely buffered data would
be written out regardless?

> +}

[...]

> +static void *arm_spe_pmu_setup_aux(int cpu, void **pages, int nr_pages,
> +				   bool snapshot)
> +{
> +	int i;
> +	struct page **pglist;
> +	struct arm_spe_pmu_buf *buf;
> +
> +	/*
> +	 * We require an even number of pages for snapshot mode, so that
> +	 * we can effectively treat the buffer as consisting of two equal
> +	 * parts and give userspace a fighting chance of getting some
> +	 * useful data out of it.
> +	 */
> +	if (!nr_pages || (snapshot && (nr_pages & 1)))
> +		return NULL;

As noted above, we may need to ensure that this is a pwoer of two.

> +
> +	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!buf)
> +		return NULL;
> +
> +	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
> +	if (!pglist)
> +		goto out_free_buf;
> +
> +	for (i = 0; i < nr_pages; ++i) {
> +		struct page *page = virt_to_page(pages[i]);
> +
> +		if (PagePrivate(page)) {
> +			pr_warn("unexpected high-order page for auxbuf!");

It looks like the intel-pt driver expects high-order pages.

What prevents us from seeing those?

Why can't we handle those?

How are these pages pinned? Does the core ensure that?

> +			goto out_free_pglist;
> +		}
> +
> +		pglist[i] = virt_to_page(pages[i]);
> +	}
> +
> +	buf->base = vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
> +	if (!buf->base)
> +		goto out_free_pglist;
> +
> +	buf->nr_pages	= nr_pages;
> +	buf->snapshot	= snapshot;
> +
> +	kfree(pglist);
> +	return buf;
> +
> +out_free_pglist:
> +	kfree(pglist);
> +out_free_buf:
> +	kfree(buf);
> +	return NULL;
> +}
> +
> +static void arm_spe_pmu_free_aux(void *aux)
> +{
> +	struct arm_spe_pmu_buf *buf = aux;
> +
> +	vunmap(buf->base);
> +	kfree(buf);
> +}
> +
> +/* Initialisation and teardown functions */
> +static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
> +{
> +	static atomic_t pmu_idx = ATOMIC_INIT(-1);
> +
> +	int idx;
> +	char *name;
> +	struct device *dev = &spe_pmu->pdev->dev;
> +
> +	spe_pmu->pmu = (struct pmu) {
> +		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
> +		.attr_groups	= arm_spe_pmu_attr_groups,
> +		/*
> +		 * We hitch a ride on the software context here, so that
> +		 * we can support per-task profiling (which is not possible
> +		 * with the invalid context as it doesn't get sched callbacks).
> +		 * This requires that userspace either uses a dummy event for
> +		 * perf_event_open, since the aux buffer is not setup until
> +		 * a subsequent mmap, or creates the profiling event in a
> +		 * disabled state and explicitly PERF_EVENT_IOC_ENABLEs it
> +		 * once the buffer has been created.
> +		 */
> +		.task_ctx_nr	= perf_sw_context,

While other tracing PMUs do this, I think this is a horrible bodge, and
a bad idea, given it violates assumptions made in the core code.

For example, unlike true SW events, add() and start() can fail, so a
tracing event can unexpectedly stop SW events from being scheduled.

AFAICT, we could also try to move a tracing event into a later-created
HW PMU group, which is very worrying.

I really think we should have a separate tracing context for this class
of PMU, or we make it so that the invalid context can receive sched
callbacks.

> +		.event_init	= arm_spe_pmu_event_init,
> +		.add		= arm_spe_pmu_add,
> +		.del		= arm_spe_pmu_del,
> +		.start		= arm_spe_pmu_start,
> +		.stop		= arm_spe_pmu_stop,
> +		.read		= arm_spe_pmu_read,
> +		.setup_aux	= arm_spe_pmu_setup_aux,
> +		.free_aux	= arm_spe_pmu_free_aux,
> +	};
> +
> +	idx = atomic_inc_return(&pmu_idx);
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%s_%d", PMUNAME, idx);
> +	return perf_pmu_register(&spe_pmu->pmu, name, -1);
> +}
> +
> +static void arm_spe_pmu_perf_destroy(struct arm_spe_pmu *spe_pmu)
> +{
> +	perf_pmu_unregister(&spe_pmu->pmu);
> +}
> +
> +static void __arm_spe_pmu_dev_probe(void *info)
> +{
> +	int fld;
> +	u64 reg;
> +	struct arm_spe_pmu *spe_pmu = info;
> +	struct device *dev = &spe_pmu->pdev->dev;
> +
> +	fld = cpuid_feature_extract_unsigned_field(read_cpuid(ID_AA64DFR0_EL1),
> +						   ID_AA64DFR0_PMSVER_SHIFT);
> +	if (!fld) {
> +		dev_err(dev,
> +			"unsupported ID_AA64DFR0_EL1.PMSVer [%d] on CPU %d\n",
> +			fld, smp_processor_id());
> +		return;
> +	}

Given we only bail out when PMSver is zero, surely we can just say:

	dev_err(dev, "SPE not supported on cpu %d", smp_processor_id())

Otherwise, the rest of the probing logic and boilerplate code looked
fine to me.

Thanks,
Mark.
