From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Thu, 20 Jul 2017 22:06:38 +0800
Subject: [PATCH v3 3/6] perf: hisi: Add support for HiSilicon SoC L3C PMU
 driver
In-Reply-To: <20170719172841.00007827@huawei.com>
References: <1500364799-90518-1-git-send-email-zhangshaokun@hisilicon.com>
 <1500364799-90518-4-git-send-email-zhangshaokun@hisilicon.com>
 <20170719172841.00007827@huawei.com>
Message-ID: <a95324d5-f6c3-329f-c887-459c8a9e53b4@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On 2017/7/19 17:28, Jonathan Cameron wrote:
> On Tue, 18 Jul 2017 15:59:56 +0800
> Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> 
>> This patch adds support for L3C PMU driver in HiSilicon SoC chip, Each
>> L3C has own control, counter and interrupt registers and is an separate
>> PMU. For each L3C PMU, it has 8-programable counters and supports 0x60
>> events, event code is 8-bits and every counter is free-running.
>> Interrupt is supported to handle counter (48-bits) overflow.
>>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>  
> Hi Shaokun,
> 
> A few minor points inline.
> 
> Thanks,
> 
> Jonathan
>> ---
>>  drivers/perf/hisilicon/Makefile              |   2 +-
>>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 556 +++++++++++++++++++++++++++
>>  include/linux/cpuhotplug.h                   |   1 +
>>  3 files changed, 558 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>>
>> diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
>> index 2783bb3..4a3d3e6 100644
>> --- a/drivers/perf/hisilicon/Makefile
>> +++ b/drivers/perf/hisilicon/Makefile
>> @@ -1 +1 @@
>> -obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o
>> +obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>> new file mode 100644
>> index 0000000..d430508
>> --- /dev/null
>> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>> @@ -0,0 +1,556 @@
>> +/*
>> + * HiSilicon SoC L3C uncore Hardware event counters support
>> + *
>> + * Copyright (C) 2017 Hisilicon Limited
>> + * Author: Anurup M <anurup.m@huawei.com>
>> + *         Shaokun Zhang <zhangshaokun@hisilicon.com>
>> + *
>> + * This code is based on the uncore PMUs like arm-cci and arm-ccn.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> Missed this on previous but putting full gpl text in is not normally done any
> more. 
>> + */
>> +#include <linux/acpi.h>
>> +#include <linux/bitmap.h>  
> Not immediately seeing any bitmaps in use in here.
> (I may well have missed something though!)
> 

Ok, shall remove it.

>> +#include <linux/cpuhotplug.h>
>> +#include <linux/module.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/topology.h>
>> +#include "hisi_uncore_pmu.h"
> <snip>
>> +
>> +/* Check if the CPU belongs to the SCCL and CCL of PMU */
>> +static bool hisi_l3c_is_cpu_in_ccl(struct hisi_pmu *l3c_pmu)
>> +{
>> +	u32 ccl_id, scl_id;
>> +
>> +	/* Read Super CPU cluster ID from CPU MPIDR_EL1 */
>> +	hisi_read_scl_and_ccl_id(&scl_id, &ccl_id);
>> +
>> +	/* Check if the CPU match with the SCCL and CCL */
>> +	if (scl_id != l3c_pmu->scl_id)
>> +		return false;
>> +	if (ccl_id != l3c_pmu->ccl_id)
>> +		return false;
>> +
>> +	/* Return true if matched */  
> I think the name of the function makes this clear enough to
> not need a comment here, but up to you.

Shall remove some redundant comments

>> +	return true;
>> +}
>> +
>> +static int hisi_l3c_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct hisi_pmu *l3c_pmu;
>> +
>> +	l3c_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
>> +
>> +	/* Proceed only when CPU belongs to the same SCCL and CCL */
>> +	if (!hisi_l3c_is_cpu_in_ccl(l3c_pmu))
>> +		return 0;
>> +
>> +	/* If another CPU is already managing the CPU cluster, simply return */
>> +	if (!cpumask_empty(&l3c_pmu->cpus))
>> +		return 0;
>> +
>> +	/* Use this CPU for event counting in the CCL */
>> +	cpumask_set_cpu(cpu, &l3c_pmu->cpus);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_l3c_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct hisi_pmu *l3c_pmu;
>> +	cpumask_t ccl_online_cpus;
>> +	unsigned int target;
>> +
>> +	l3c_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
>> +
>> +	/* Proceed only when CPU belongs to the same SCCL and CCL */
>> +	if (!hisi_l3c_is_cpu_in_ccl(l3c_pmu))
>> +		return 0;
>> +
>> +	/* Proceed if this CPU is used for event counting */
>> +	if (!cpumask_test_cpu(cpu, &l3c_pmu->cpus))
>> +		return 0;
>> +
>> +	/* Give up ownership of CCL */
>> +	cpumask_test_and_clear_cpu(cpu, &l3c_pmu->cpus);
>> +
>> +	/* Any other CPU for this CCL which is still online */
>> +	cpumask_and(&ccl_online_cpus, cpu_coregroup_mask(cpu),
>> +		    cpu_online_mask);
>> +	target = cpumask_any_but(&ccl_online_cpus, cpu);
>> +	if (target >= nr_cpu_ids)
>> +		return 0;
>> +
>> +	perf_pmu_migrate_context(&l3c_pmu->pmu, cpu, target);
>> +	/* Use this CPU for event counting in the CCL */
>> +	cpumask_set_cpu(target, &l3c_pmu->cpus);
>> +
>> +	return 0;
>> +}
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
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	unsigned long long id;
>> +	acpi_status status;
>> +
>> +	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_UID", NULL, &id);
>> +	if (ACPI_FAILURE(status))
>> +		return false;  
> Nitpick: A blank line here would slightly aid readability.
>> +	l3c_pmu->l3c_tag_id = id;
>> +
>> +	/* Get the L3C SCCL ID */
>> +	if (device_property_read_u32(dev, "hisilicon,scl-id",
>> +				     &l3c_pmu->scl_id)) {
>> +		dev_err(dev, "Can not read l3c scl-id!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Get the L3C CPU cluster(CCL) ID */
>> +	if (device_property_read_u32(dev, "hisilicon,ccl-id",
>> +				     &l3c_pmu->ccl_id)) {
>> +		dev_err(dev, "Can not read l3c ccl-id!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	l3c_pmu->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(l3c_pmu->base)) {
>> +		dev_err(dev, "ioremap failed for l3c_pmu resource\n");
>> +		return PTR_ERR(l3c_pmu->base);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct attribute *hisi_l3c_pmu_format_attr[] = {
>> +	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group hisi_l3c_pmu_format_group = {
>> +	.name = "format",
>> +	.attrs = hisi_l3c_pmu_format_attr,
>> +};
>> +
>> +static struct attribute *hisi_l3c_pmu_events_attr[] = {
>> +	HISI_PMU_EVENT_ATTR(rd_cpipe,		0x00),
>> +	HISI_PMU_EVENT_ATTR(wr_cpipe,		0x01),
>> +	HISI_PMU_EVENT_ATTR(rd_hit_cpipe,	0x02),
>> +	HISI_PMU_EVENT_ATTR(wr_hit_cpipe,	0x03),
>> +	HISI_PMU_EVENT_ATTR(victim_num,		0x04),
>> +	HISI_PMU_EVENT_ATTR(rd_spipe,		0x20),
>> +	HISI_PMU_EVENT_ATTR(wr_spipe,		0x21),
>> +	HISI_PMU_EVENT_ATTR(rd_hit_spipe,	0x22),
>> +	HISI_PMU_EVENT_ATTR(wr_hit_spipe,	0x23),
>> +	HISI_PMU_EVENT_ATTR(back_invalid,	0x29),
>> +	HISI_PMU_EVENT_ATTR(retry_cpu,		0x40),
>> +	HISI_PMU_EVENT_ATTR(retry_ring,		0x41),
>> +	HISI_PMU_EVENT_ATTR(prefetch_drop,	0x42),
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group hisi_l3c_pmu_events_group = {
>> +	.name = "events",
>> +	.attrs = hisi_l3c_pmu_events_attr,
>> +};
>> +
>> +static struct attribute *hisi_l3c_pmu_attrs[] = {
>> +	NULL,
>> +};  
> Why have the empty group? 
>> +
>> +static const struct attribute_group hisi_l3c_pmu_attr_group = {
>> +	.attrs = hisi_l3c_pmu_attrs,
>> +};
>> +
>> +static DEVICE_ATTR(cpumask, 0444, hisi_cpumask_sysfs_show, NULL);
>> +
>> +static struct attribute *hisi_l3c_pmu_cpumask_attrs[] = {
>> +	&dev_attr_cpumask.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group hisi_l3c_pmu_cpumask_attr_group = {
>> +	.attrs = hisi_l3c_pmu_cpumask_attrs,
>> +};
>> +
>> +static const struct attribute_group *hisi_l3c_pmu_attr_groups[] = {
>> +	&hisi_l3c_pmu_attr_group,
>> +	&hisi_l3c_pmu_format_group,
>> +	&hisi_l3c_pmu_events_group,
>> +	&hisi_l3c_pmu_cpumask_attr_group,
>> +	NULL,
>> +};
>> +
>> +static const struct hisi_uncore_ops hisi_uncore_l3c_ops = {
>> +	.write_evtype		= hisi_l3c_pmu_write_evtype,
>> +	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
>> +	.start_counters		= hisi_l3c_pmu_start_counters,
>> +	.stop_counters		= hisi_l3c_pmu_stop_counters,
>> +	.enable_counter		= hisi_l3c_pmu_enable_counter,
>> +	.disable_counter	= hisi_l3c_pmu_disable_counter,
>> +	.enable_counter_int	= hisi_l3c_pmu_enable_counter_int,
>> +	.disable_counter_int	= hisi_l3c_pmu_disable_counter_int,
>> +	.write_counter		= hisi_l3c_pmu_write_counter,
>> +	.read_counter		= hisi_l3c_pmu_read_counter,
>> +};
>> +
>> +static int hisi_l3c_pmu_dev_probe(struct platform_device *pdev,
>> +				  struct hisi_pmu *l3c_pmu)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	ret = hisi_l3c_pmu_init_data(pdev, l3c_pmu);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>> +				       &l3c_pmu->node);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d registering hotplug", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = hisi_l3c_pmu_init_irq(l3c_pmu, pdev);
>> +	if (ret)
>> +		goto fail;
>> +
>> +	l3c_pmu->name = devm_kasprintf(dev, GFP_KERNEL, "hisi_l3c%u_%u",
>> +				       l3c_pmu->l3c_tag_id, l3c_pmu->scl_id);
>> +	l3c_pmu->num_events = L3C_NR_EVENTS;
>> +	l3c_pmu->num_counters = L3C_NR_COUNTERS;
>> +	l3c_pmu->counter_bits = 48;
>> +	l3c_pmu->ops = &hisi_uncore_l3c_ops;
>> +	l3c_pmu->dev = dev;
>> +
>> +	return 0;
>> +
>> +fail:
>> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>> +				    &l3c_pmu->node);
>> +	return ret;
>> +}
>> +
>> +static int hisi_l3c_pmu_probe(struct platform_device *pdev)
>> +{
>> +	struct hisi_pmu *l3c_pmu;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	l3c_pmu = hisi_pmu_alloc(dev, L3C_NR_COUNTERS);
>> +	if (!l3c_pmu)
>> +		return -ENOMEM;
>> +
>> +	ret = hisi_l3c_pmu_dev_probe(pdev, l3c_pmu);
>> +	if (ret)
>> +		return ret;
>> +
>> +	l3c_pmu->pmu = (struct pmu) {
>> +		.name		= l3c_pmu->name,
>> +		.task_ctx_nr	= perf_invalid_context,
>> +		.event_init	= hisi_uncore_pmu_event_init,
>> +		.pmu_enable	= hisi_uncore_pmu_enable,
>> +		.pmu_disable	= hisi_uncore_pmu_disable,
>> +		.add		= hisi_uncore_pmu_add,
>> +		.del		= hisi_uncore_pmu_del,
>> +		.start		= hisi_uncore_pmu_start,
>> +		.stop		= hisi_uncore_pmu_stop,
>> +		.read		= hisi_uncore_pmu_read,
>> +		.attr_groups	= hisi_l3c_pmu_attr_groups,  
> Obviously not relevant to this patch as you work with what you
> have, but this is a structure that looks rather ripe for
> splitting into a const ops structure and a data structure
> containing the bits that tend to be dynamic (like the name.
> Perhaps it's not worth the hassle though.
>> +	};
>> +
>> +	ret = hisi_uncore_pmu_setup(l3c_pmu, l3c_pmu->name);  
> As mentioned for patch 2, I'd remove this wrapper.  That will make it
> clearer that the remove is reversing everything it needs to.
> 

Ok

>> +	if (ret) {
>> +		dev_err(l3c_pmu->dev, "hisi_uncore_pmu_setup failed!\n");
>> +		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>> +					    &l3c_pmu->node);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, l3c_pmu);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_l3c_pmu_remove(struct platform_device *pdev)
>> +{
>> +	struct hisi_pmu *l3c_pmu = platform_get_drvdata(pdev);
>> +
>> +	perf_pmu_unregister(&l3c_pmu->pmu);
>> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>> +				    &l3c_pmu->node);  
> The related add_instance call is wrapped up in
> hisi_l3c_pmu_dev_probe. 
> I would suggest wrapping this last call up in a hisi_l3c_pmu_dev_remove
> function so that the balance between probe and remove is obvious.
> 
> Basic aim of the game is to make the code as easy to review as possible
> and this would make it slightly more readable.

Agree, shall fix it.

>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver hisi_l3c_pmu_driver = {
>> +	.driver = {
>> +		.name = "hisi_l3c_pmu",
>> +		.acpi_match_table = ACPI_PTR(hisi_l3c_pmu_acpi_match),
>> +	},
>> +	.probe = hisi_l3c_pmu_probe,
>> +	.remove = hisi_l3c_pmu_remove,
>> +};
>> +
>> +static int __init hisi_l3c_pmu_module_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>> +				      "AP_PERF_ARM_HISI_L3_ONLINE",
>> +				      hisi_l3c_pmu_online_cpu,
>> +				      hisi_l3c_pmu_offline_cpu);
>> +	if (ret) {
>> +		pr_err("l3c_pmu_module_init: Error setup hotplug, ret=%d", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = platform_driver_register(&hisi_l3c_pmu_driver);
>> +	if (ret)
>> +		cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE);
>> +
>> +	return ret;
>> +}
>> +module_init(hisi_l3c_pmu_module_init);
>> +
>> +static void __exit hisi_l3c_pmu_module_exit(void)
>> +{
>> +	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE);
>> +	platform_driver_unregister(&hisi_l3c_pmu_driver);  
> 
> Would normally expect an exit function to reverse the order of what
> goes on in the init function.  This is true even if it doesn't
> matter as it makes it 'obviously correct' and the reviewer doesn't
> have to think about it! So...
> 
> platform_driver_unregister(&hisi_l3c_pmu_driver);
> cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE);
> 
> If not there should be a comment explaining why not.
> 

Agree to reverse the order of the init function and shall modify it.

Thanks.
Shaokun

>> +}
>> +module_exit(hisi_l3c_pmu_module_exit);
>> +
>> +MODULE_DESCRIPTION("HiSilicon SoC L3C uncore PMU driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Anurup M, Shaokun Zhang");
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index b56573b..2eab157 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -136,6 +136,7 @@ enum cpuhp_state {
>>  	CPUHP_AP_PERF_S390_SF_ONLINE,
>>  	CPUHP_AP_PERF_ARM_CCI_ONLINE,
>>  	CPUHP_AP_PERF_ARM_CCN_ONLINE,
>> +	CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>>  	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
>>  	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>>  	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,  
> 
> 
> .
> 
