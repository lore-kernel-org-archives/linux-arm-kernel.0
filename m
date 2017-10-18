From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Wed, 18 Oct 2017 21:33:30 +0800
Subject: [PATCH v5 3/6] perf: hisi: Add support for HiSilicon SoC L3C PMU
 driver
In-Reply-To: <20171017151657.fr4k63bynmc65woo@lakrids.cambridge.arm.com>
References: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
 <1503389277-134131-4-git-send-email-zhangshaokun@hisilicon.com>
 <20171017151657.fr4k63bynmc65woo@lakrids.cambridge.arm.com>
Message-ID: <04e32a88-a719-9a4a-1f07-fb452e227297@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2017/10/17 23:16, Mark Rutland wrote:
> On Tue, Aug 22, 2017 at 04:07:54PM +0800, Shaokun Zhang wrote:
>> +static int hisi_l3c_pmu_init_irq(struct hisi_pmu *l3c_pmu,
>> +				 struct platform_device *pdev)
>> +{
>> +	int irq, ret;
>> +
>> +	/* Read and init IRQ */
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev, "L3C PMU get irq fail; irq:%d\n", irq);
>> +		return irq;
>> +	}
>> +
>> +	ret = devm_request_irq(&pdev->dev, irq, hisi_l3c_pmu_isr,
>> +			       IRQF_NOBALANCING | IRQF_NO_THREAD,
>> +			       dev_name(&pdev->dev), l3c_pmu);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"Fail to request IRQ:%d ret:%d\n", irq, ret);
>> +		return ret;
>> +	}
>> +
>> +	l3c_pmu->irq = irq;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Check whether the CPU is associated with this L3C PMU by SCCL_ID
>> + * and CCL_ID, if true, set the associated cpumask of the L3C PMU.
>> + */
>> +static void hisi_l3c_pmu_set_cpumask_by_ccl(void *arg)
>> +{
>> +	struct hisi_pmu *l3c_pmu = (struct hisi_pmu *)arg;
>> +	u32 ccl_id, sccl_id;
>> +
>> +	hisi_read_sccl_and_ccl_id(&sccl_id, &ccl_id);
>> +	if (sccl_id == l3c_pmu->sccl_id && ccl_id == l3c_pmu->ccl_id)
>> +		cpumask_set_cpu(smp_processor_id(), &l3c_pmu->associated_cpus);
>> +}
> 
> The shared code has hisi_uncore_pmu_set_cpumask_by_sccl(), and it would
> be nice to place this in the same place.
> 
> Otherwise, the same comments apply here.
> 

Ok, shall fix the same issues.

>> +
>> +static const struct acpi_device_id hisi_l3c_pmu_acpi_match[] = {
>> +	{ "HISI0213", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, hisi_l3c_pmu_acpi_match);
>> +
>> +static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
>> +				  struct hisi_pmu *l3c_pmu)
>> +{
>> +	unsigned long long id;
>> +	struct resource *res;
>> +	acpi_status status;
>> +	int cpu;
>> +
>> +	status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
>> +				       "_UID", NULL, &id);
>> +	if (ACPI_FAILURE(status))
>> +		return -EINVAL;
>> +
>> +	l3c_pmu->id = id;
>> +
>> +	/*
>> +	 * Use the SCCL_ID and CCL_ID to identify the L3C PMU, while
>> +	 * SCCL_ID is in MPIDR[aff2] and CCL_ID is in MPIDR[aff1].
>> +	 */
>> +	if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
>> +				     &l3c_pmu->sccl_id)) {
>> +		dev_err(&pdev->dev, "Can not read l3c sccl-id!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (device_property_read_u32(&pdev->dev, "hisilicon,ccl-id",
>> +				     &l3c_pmu->ccl_id)) {
>> +		dev_err(&pdev->dev, "Can not read l3c ccl-id!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Initialise the associated cpumask of the PMU */
>> +	for_each_present_cpu(cpu)
>> +		smp_call_function_single(cpu, hisi_l3c_pmu_set_cpumask_by_ccl,
>> +					 (void *)l3c_pmu, 1);
> 
> Ah, so that's why hisi_uncore_pmu_set_cpumask_by_sccl took a void
> pointer.
> 
> Please drop a comment above hisi_uncore_pmu_set_cpumask_by_sccl to cover
> that.
> 
> I think you can drop the void cast here; I don't beleive it is
> necessary.
> 

Ok.

> Rather than a proble-time smp_call_function_single(), can you follow the
> qcom l2's approach of associating CPUs with a PMU instance in the
> notifier? That will work even if CPUs are brought online very late.
> 

A good guidance, but HHA and DDRC PMUs are different from L3C PMU, the former
share the same SCCL and the latter share the same SCCL and CCL. I will
try to deal with this difference in online notifier.

Thanks,
Shaokun

>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	l3c_pmu->base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(l3c_pmu->base)) {
>> +		dev_err(&pdev->dev, "ioremap failed for l3c_pmu resource\n");
>> +		return PTR_ERR(l3c_pmu->base);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Thanks,
> Mark.
> 
> .
> 
