From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Mar 2017 18:10:33 +0000
Subject: [PATCH/RFC] arm64: pmu: add Qualcomm Technologies extensions
In-Reply-To: <1488385085-19238-1-git-send-email-nleeder@codeaurora.org>
References: <1488385085-19238-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20170301181032.GL28874@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Wed, Mar 01, 2017 at 11:18:05AM -0500, Neil Leeder wrote:
> Adds CPU PMU perf events support for Qualcomm Technologies' Falkor CPU.
> 
> The Qualcomm Technologies CPU PMU is named qcom_pmuv3 and provides
> extensions to the architected PMU events.

Is this is a strict superset of PMUv3 (that could validly be treated as
just PMUv3), or do those IMP DEF parts need to be poked to use this at
all?

What is reported by ID_AA64DFR0_EL1.PMUVer on these CPUs?

Quite frankly, I'm less than thrilled about the prospect of
IMPLEMENTATION DEFINED CPU PMUs that fall outside of the architected PMU
model, especially for ACPI systems where the raison d'?tre is standards
and uniformity, and where we have no sensible mechanism to provide
information regarding IMPLEMENTATION DEFINED functionality.

This has knock-on effects for other things, like userspace PMU access
and/or virtualization, and this multiplies the support effort.

KVM already has (architected) PMU support, and without a corresponding
KVM patch this is at best insufficient. I don't imagine the KVM folk
will be too thrilled about the prospect of emulating an IMPLEMENTATION
DEFINED CPU feature like this.

Note that system PMUs are a very different case, since these are not
(implicitly) passed through to guests, nor do they have significant
overlap with architected functionality or each other. It's fine to add
support for those to the host kernel.

> The extended events are implemented by a set of registers which
> are programmed by shifting an event code into a group field.
> The PMNx event then points to that region/group combo.
> 
> Restrictions that limit only one concurrent region/group combination
> are also enforced.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> ---
> The Qualcomm Technologies CPU PMU extensions have an additional set of registers
> which need to be programmed when configuring an event. These are the PMRESRs,
> which are similar to the krait & scorpion registers in armv7, and the L2
> variants in the Qualcomm Technologies L2 PMU driver.

If these *must* be programmed, it sounds like this isn't PMUv3
compatible.

[...]

> There are additional constraints on qc events. The armv7 implementation checks
> these in get_event_idx, but during L2 PMU reviews it was thought better to do
> these during init processing where possible. I added these in the map_event
> callback because its the only callback from within armpmu_event_init(). I'm not
> sure if that would be considered stretching the acceptable use of that interface,
> so I'm open to other suggestions.

As a general rule for PMU drivers:

* pmu::event_init() should check whether the entire group the event is
  in (i.e. the parent and all siblings) can potentially be allocated
  into counters simultaneously. If it is always impossible for the whole
  group to go on, pmu::event_init should fail, since the group is
  impossible.

* pmu::add() needs to handle inter-group and intra-group conflicts that
  can arise dynamically dependent on how (other) events are scheduled.
  This also needs to fail in the event of a conflict.

> The qc driver also needs to check conflicts between events, using a bitmap. This
> has similar use to the hw_events->used_mask. I added the event_conflicts bitmap
> into hw_events, although I'm not sure if that's the best place for an
> implementation-specific field. An alternative would be a static DEFINE_PER_CPU
> bitmap, although that didn't seem as clean, but may be more acceptable.
> 
> qc_max_resr is a variable, rather than a constant, to accommodate future
> processors with different numbers of RESRs.
> 
> This requires Jeremy Linton's patch sequence to add arm64 CPU PMU ACPI support:
> https://patchwork.kernel.org/patch/9533677/

As a heads-up, I'm currently working on an alternative approach that you
can find at:

git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm/perf/acpi

That's a work-in-progress, and there are a few issues (notably IRQ
management) that I'm currently fixing up. I also intend to add a PMUv3
check to the PMUv3 probe.

[...]

> +static bool qc_pmu;

Sorry, but a global boolean to describe whether a (single ?) PMU
instance is a particular implementation is not going to fly.

> +static void qc_pmu_enable_event(struct perf_event *event,
> +				struct hw_perf_event *hwc, int idx);
> +static void qc_pmu_disable_event(struct perf_event *event,
> +				 struct hw_perf_event *hwc);
> +
>  /*
>   * Perf Events' indices
>   */
> @@ -704,10 +730,13 @@ static void armv8pmu_enable_event(struct perf_event *event)
>  	 */
>  	armv8pmu_disable_counter(idx);
>  
> -	/*
> -	 * Set event (if destined for PMNx counters).
> -	 */
> -	armv8pmu_write_evtype(idx, hwc->config_base);
> +	if (qc_pmu)
> +		qc_pmu_enable_event(event, hwc, idx);
> +	else
> +		/*
> +		 * Set event (if destined for PMNx counters).
> +		 */
> +		armv8pmu_write_evtype(idx, hwc->config_base);

Similarly, this is not a workable structure for these functions.

[...]

> +static void qc_pmu_reset(void *info)
> +{
> +	qc_clear_resrs();
> +	armv8pmu_reset(info);
> +}

Is the QC-specific reset required only if we use the QC-specific events,
or is that required for the standard PMUv3 features to be usable?

Are standard PMUv3 events guaranteed to work if we didn't call
qc_clear_resrs()?

If this is not required for the standard PMUv3 features, and/or any IMP
DEF reset is performed by FW, it looks like we *may* be able to treat
this as PMUv3.

> +static void qc_pmu_enable_event(struct perf_event *event,
> +				struct hw_perf_event *hwc, int idx)
> +{
> +	unsigned int reg, code, group;
> +
> +	if (QC_EVT_PFX(hwc->config_base) != QC_EVT_PREFIX) {
> +		armv8pmu_write_evtype(idx, hwc->config_base);
> +		return;
> +	}

This really shows that this is not a workable structure. It's hideous to
hook the PMUv3 code to call this, then try to duplicate what the PMUv3
code would have done in this case.

[...]

> +static int armv8_falkor_pmu_init(struct arm_pmu *cpu_pmu)
> +{
> +	armv8_pmu_init(cpu_pmu);
> +	cpu_pmu->name			= "qcom_pmuv3";
> +	cpu_pmu->map_event		= armv8_qc_map_event;
> +	cpu_pmu->reset			= qc_pmu_reset;
> +	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
> +		&armv8_pmuv3_events_attr_group;
> +	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
> +		&qc_pmu_format_attr_group;
> +	cpu_pmu->get_event_idx		= qc_get_event_idx;
> +	cpu_pmu->clear_event_idx	= qc_clear_event_idx;
> +
> +	qc_max_resr = QC_FALKOR_MAX_RESR;
> +	qc_clear_resrs();
> +	qc_pmu = true;
> +
> +	if (qc_max_resr > QC_MAX_RESRS) {
> +		/* Sanity check */
> +		pr_err("qcom_pmuv3: max number of RESRs exceeded\n");
> +		return -EINVAL;
> +	}
> +
> +	return armv8pmu_probe_pmu(cpu_pmu);
> +}
> +
>  static const struct of_device_id armv8_pmu_of_device_ids[] = {
>  	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_init},
>  	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_a53_pmu_init},
> @@ -1087,6 +1421,8 @@ static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
>   * aren't supported by the current PMU are disabled.
>   */
>  static const struct pmu_probe_info armv8_pmu_probe_table[] = {
> +	PMU_PROBE(QCOM_CPU_PART_FALKOR_V1 << MIDR_PARTNUM_SHIFT,
> +		  MIDR_PARTNUM_MASK, armv8_falkor_pmu_init),
>  	PMU_PROBE(0, 0, armv8_pmuv3_init), /* enable all defined counters */
>  	{ /* sentinel value */ }

We don't special-case other PMUs here, and the plan for ACPI was to
rely solely on the architectural information, i.e. the architected ID
registers associated with PMUv3.

I don't think we should special-case implementations like this.
My series removes this MIDR matching.

Thanks,
Mark.
