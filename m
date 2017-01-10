From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 10 Jan 2017 16:04:19 -0600
Subject: [RFC PATCH 09/10] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <1483467027-14547-10-git-send-email-will.deacon@arm.com>
References: <1483467027-14547-1-git-send-email-will.deacon@arm.com>
 <1483467027-14547-10-git-send-email-will.deacon@arm.com>
Message-ID: <20170110160419.4cc3d61c9d652e5d5da13f15@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jan 2017 18:10:26 +0000
Will Deacon <will.deacon@arm.com> wrote:

> +#define DRVNAME				"arm_spe_pmu"

Based on Intel naming "intel_pt" and "intel_bts', I had expected
"arm-spe" as the universal basename for SPE.  I don't really care about
whether '_pmu' is included, but it's yet another naming inconsistency we
have with coresight's "cs_etm" (the other being prefixed with "arm_").

Also, nit, since I don't know why perf userspace tools can't handle
dashes in PMU names (commit 3d1ff755e367 "arm: perf: clean up PMU
names" doesn't say), can we at least start to use dashes in our
filenames?  arm-spe-pmu.c is easier to type than arm_spe_pmu.c.

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
> +
> +	if (arm_spe_event_to_pmsevfr(event) & PMSEVFR_EL1_RES0)
> +		return -EOPNOTSUPP;
> +
> +	if (event->hw.sample_period < spe_pmu->min_period ||
> +	    event->hw.sample_period & PMSIRR_EL1_IVAL_MASK)
> +		return -EOPNOTSUPP;
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
> +	if (is_kernel_in_hyp_mode()) {
> +		if (attr->exclude_kernel != attr->exclude_hv)
> +			return -EOPNOTSUPP;
> +	} else if (!attr->exclude_hv) {
> +		return -EOPNOTSUPP;
> +	}
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
> +
> +	return 0;
> +}

Without being provided instructions on how to use, I had to add
debug printks here to find out e.g., an event period *must* be specified
with record -c, and then again to find out that only a certain set of
numbers is allowed by the h/w (256, 512, etc.). Is it possible to
report why the driver is returning an error before it does?  Otherwise,
all the user sees is, e.g.:

Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (arm_spe_pmu_0).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?

...and, in this case, with nothing in dmesg.  And, IIRC, the above text
is emitted only if perf is run with -v and/or built with DEBUG set.
Granted, *that* problem is not explicitly relevant to this patch, but
new drivers should nevertheless express their usage details better.

Also, curiously, arm_spe_pmu doesn't appear in 'perf list' (even when
SPE h/w is present).

Other than that, this gets my:

Tested-by: Kim Phillips <kim.phillips@arm.com>

Thanks,

Kim
