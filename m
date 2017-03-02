From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 15:16:43 +0000
Subject: [PATCH/RFC] arm64: pmu: add Qualcomm Technologies extensions
In-Reply-To: <a44d89fa-c5ff-9511-c774-59e5a3f26676@codeaurora.org>
References: <1488385085-19238-1-git-send-email-nleeder@codeaurora.org>
 <20170301181032.GL28874@leverpostej>
 <a44d89fa-c5ff-9511-c774-59e5a3f26676@codeaurora.org>
Message-ID: <20170302151643.GO19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 01, 2017 at 04:36:07PM -0500, Leeder, Neil wrote:
> On 3/1/2017 1:10 PM, Mark Rutland wrote:
> >On Wed, Mar 01, 2017 at 11:18:05AM -0500, Neil Leeder wrote:
> >>Adds CPU PMU perf events support for Qualcomm Technologies' Falkor CPU.
> >>
> >>The Qualcomm Technologies CPU PMU is named qcom_pmuv3 and provides
> >>extensions to the architected PMU events.
> >
> >Is this is a strict superset of PMUv3 (that could validly be treated as
> >just PMUv3), or do those IMP DEF parts need to be poked to use this at
> >all?
> >
> >What is reported by ID_AA64DFR0_EL1.PMUVer on these CPUs?
> 
> It's a strict superset. If you don't use any of the extensions than
> it behaves as a PMUv3 for architected events. ID_AA64DFR0_EL1.PMUVer
> = 1.

> >>The Qualcomm Technologies CPU PMU extensions have an additional set of registers
> >>which need to be programmed when configuring an event. These are the PMRESRs,
> >>which are similar to the krait & scorpion registers in armv7, and the L2
> >>variants in the Qualcomm Technologies L2 PMU driver.
> >
> >If these *must* be programmed, it sounds like this isn't PMUv3
> >compatible.
> 
> Sorry for the imprecise wording. They only have to be programmed
> when using an event in these extensions, not for architected events.

Ok, so given that and the ID_AA64DFR0_EL1.PMUVer value, we can treat
this as a PMUv3.

Given that in general we do not support IMP DEF features like this,
given that this cannot work with KVM, and given that the only probing
mechanism we have is to identify the implementation, I'm not keen on
trying to support more than that.

> >> static const struct of_device_id armv8_pmu_of_device_ids[] = {
> >> 	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_init},
> >> 	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_a53_pmu_init},
> >>@@ -1087,6 +1421,8 @@ static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
> >>  * aren't supported by the current PMU are disabled.
> >>  */
> >> static const struct pmu_probe_info armv8_pmu_probe_table[] = {
> >>+	PMU_PROBE(QCOM_CPU_PART_FALKOR_V1 << MIDR_PARTNUM_SHIFT,
> >>+		  MIDR_PARTNUM_MASK, armv8_falkor_pmu_init),
> >> 	PMU_PROBE(0, 0, armv8_pmuv3_init), /* enable all defined counters */
> >> 	{ /* sentinel value */ }
> >
> >We don't special-case other PMUs here, and the plan for ACPI was to
> >rely solely on the architectural information, i.e. the architected ID
> >registers associated with PMUv3.
> >
> >I don't think we should special-case implementations like this.
> >My series removes this MIDR matching.
> 
> So would there be equivalent ACPI support for the various 3rd-party
> implementations (vulcan, thunder... and then qc) as there is with
> device tree?

So far, those are all PMUv3, and the code handling the compatible string
only sets up two things: a unique name (so as to avoid sysfs clashes),
and default event mapping (which largely could/should be derived from
PMCEID*).

The naming will differ when using ACPI. In Jeremy's series and in mine,
we append a unique suffix to the armv8_pmuv3 string.

We could certainly take a look at using PMCEID* to do a better job of
event mapping.

Thanks,
Mark.
