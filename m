From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Oct 2017 14:55:30 +0100
Subject: [PATCH v5 3/6] perf: hisi: Add support for HiSilicon SoC L3C PMU
 driver
In-Reply-To: <04e32a88-a719-9a4a-1f07-fb452e227297@hisilicon.com>
References: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
 <1503389277-134131-4-git-send-email-zhangshaokun@hisilicon.com>
 <20171017151657.fr4k63bynmc65woo@lakrids.cambridge.arm.com>
 <04e32a88-a719-9a4a-1f07-fb452e227297@hisilicon.com>
Message-ID: <20171018135530.qo54qe36zplp4etp@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 09:33:30PM +0800, Zhangshaokun wrote:
> On 2017/10/17 23:16, Mark Rutland wrote:
> > On Tue, Aug 22, 2017 at 04:07:54PM +0800, Shaokun Zhang wrote:
> >> +static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
> >> +				  struct hisi_pmu *l3c_pmu)
> >> +{
> >> +	unsigned long long id;
> >> +	struct resource *res;
> >> +	acpi_status status;
> >> +	int cpu;
> >> +
> >> +	status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
> >> +				       "_UID", NULL, &id);
> >> +	if (ACPI_FAILURE(status))
> >> +		return -EINVAL;
> >> +
> >> +	l3c_pmu->id = id;
> >> +
> >> +	/*
> >> +	 * Use the SCCL_ID and CCL_ID to identify the L3C PMU, while
> >> +	 * SCCL_ID is in MPIDR[aff2] and CCL_ID is in MPIDR[aff1].
> >> +	 */
> >> +	if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
> >> +				     &l3c_pmu->sccl_id)) {
> >> +		dev_err(&pdev->dev, "Can not read l3c sccl-id!\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (device_property_read_u32(&pdev->dev, "hisilicon,ccl-id",
> >> +				     &l3c_pmu->ccl_id)) {
> >> +		dev_err(&pdev->dev, "Can not read l3c ccl-id!\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/* Initialise the associated cpumask of the PMU */
> >> +	for_each_present_cpu(cpu)
> >> +		smp_call_function_single(cpu, hisi_l3c_pmu_set_cpumask_by_ccl,
> >> +					 (void *)l3c_pmu, 1);

> > Rather than a proble-time smp_call_function_single(), can you follow the
> > qcom l2's approach of associating CPUs with a PMU instance in the
> > notifier? That will work even if CPUs are brought online very late.
> 
> A good guidance, but HHA and DDRC PMUs are different from L3C PMU, the former
> share the same SCCL and the latter share the same SCCL and CCL. I will
> try to deal with this difference in online notifier.

FWIW, I think it makes sense for each PMU to have its own notifier
(perhaps with some shared code that each calls to do the migration).

I just want to avoid the smp_call_function_single() at probe time, as
that doesn't work in some cases.

Thanks,
Mark.
