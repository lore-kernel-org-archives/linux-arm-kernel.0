From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Oct 2017 10:20:11 +0100
Subject: [PATCH v8 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20171010103303.32436-9-suzuki.poulose@arm.com>
References: <20171010103303.32436-1-suzuki.poulose@arm.com>
 <20171010103303.32436-9-suzuki.poulose@arm.com>
Message-ID: <20171018092011.auey5hgpnjwkpsej@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

This generally looks good. My comments below are mostly minor, modulo
the probing/hotplug bit at the end.

On Tue, Oct 10, 2017 at 11:33:03AM +0100, Suzuki K Poulose wrote:
> diff --git a/arch/arm64/include/asm/arm_dsu_pmu.h b/arch/arm64/include/asm/arm_dsu_pmu.h
> new file mode 100644
> index 000000000000..5d1b0d9ff5bb
> --- /dev/null
> +++ b/arch/arm64/include/asm/arm_dsu_pmu.h
> @@ -0,0 +1,124 @@
> +/*
> + * ARM DynamIQ Shared Unit (DSU) PMU Low level register access routines.
> + *
> + * Copyright (C) ARM Limited, 2017.
> + *
> + * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <asm/sysreg.h>
> +

I believe you also need the following headers:

#include <linux/bitops.h>
#include <linux/bug.h>
#include <linux/compiler.h>
#include <linux/types.h>

#include <asm/barrier.h>

[...]

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index e5197ffb7422..ee3d7d13977c 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -17,6 +17,15 @@ config ARM_PMU_ACPI
>  	depends on ARM_PMU && ACPI
>  	def_bool y
>  
> +config ARM_DSU_PMU
> +	tristate "ARM DynamIQ Shared Unit (DSU) PMU"
> +	depends on ARM64 && PERF_EVENTS

The PERF_EVENTS dependency is handled at the top of the
drivers/perf/Kconfig file since commit:

  bddb9b68d3fb0dfb ("drivers/perf: commonise PERF_EVENTS dependency")

... so it can be dropped here.

> +	  help
> +	  Provides support for performance monitor unit in ARM DynamIQ Shared
> +	  Unit (DSU). The DSU integrates one or more cores  with an L3 memory

Nit: double spacing in "cores  with".

[...]

> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 6420bd4394d5..0adb4f6926a4 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
>  obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
> +obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o

Nit: this should go first in the list, to keep alphabetical order.

[...]

> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> new file mode 100644
> index 000000000000..6352e5f3fa0a
> --- /dev/null
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -0,0 +1,826 @@

> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/arm_dsu_pmu.h>

I believe you also need the following headers:

#include <linux/bitmap.h>
#include <linux/bitops.h>
#include <linux/bug.h>
#include <linux/cpumask.h>
#include <linux/smp.h>
#include <linux/sysfs.h>
#include <linux/types.h>

#include <asm/local64.h>

[...]

> +static struct attribute *dsu_pmu_event_attrs[] = {
> +	DSU_EVENT_ATTR(cycles, 0x11),
> +	DSU_EVENT_ATTR(bus_acecss, 0x19),

Typo for 'bus_access'?

> +	DSU_EVENT_ATTR(memory_error, 0x1a),
> +	DSU_EVENT_ATTR(bus_cycles, 0x1d),
> +	DSU_EVENT_ATTR(l3d_cache_allocate, 0x29),
> +	DSU_EVENT_ATTR(l3d_cache_refill, 0x2a),
> +	DSU_EVENT_ATTR(l3d_cache, 0x2b),
> +	DSU_EVENT_ATTR(l3d_cache_wb, 0x2c),
> +	NULL,
> +};

[...]

> +static int dsu_pmu_get_event_idx(struct dsu_hw_events *hw_events,
> +				 struct perf_event *event)
> +{

> +	idx = find_next_zero_bit(used_mask, dsu_pmu->num_counters, 0);

Perhaps:

	idx = find_first_zero_bit(used_mask, dsu_pmu->num_counters);

[...]

> +static irqreturn_t dsu_pmu_handle_irq(int irq_num, void *dev)
> +{
> +	int i;
> +	bool handled = false;
> +	struct dsu_pmu *dsu_pmu = dev;
> +	struct dsu_hw_events *hw_events = &dsu_pmu->hw_events;
> +	unsigned long overflow, workset;
> +
> +	overflow = dsu_pmu_getreset_overflow();
> +	bitmap_and(&workset, &overflow, hw_events->used_mask,
> +		   DSU_PMU_MAX_HW_CNTRS);

Why do we need this bitmap_and()? Surely the bits for unused counters
shouldn't be set?

It would probably be better to reset those when we assocaite the first
CPU with a DSU.

[...]

> +static int dsu_pmu_event_init(struct perf_event *event)
> +{

> +	if (!dsu_pmu_validate_group(event))
> +		return -EINVAL;
> +	if (!cpumask_test_cpu(event->cpu, &dsu_pmu->associated_cpus)) {
> +		dev_dbg(dsu_pmu->pmu.dev,
> +			 "Requested cpu is not associated with the DSU\n");
> +		return -EINVAL;
> +	}

It might make sense to flip these two checks, so as to do the simpler
one first.

[...]

> +static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
> +{
> +	int i = 0, n, cpu;
> +	struct device_node *cpu_node;
> +
> +	n = of_count_phandle_with_args(dev, "cpus", NULL);
> +	if (n <= 0)
> +		return -ENODEV;
> +	for (; i < n; i++) {

Can we put the i = 0 here? That would make this easier to read.

[...]

> +static void dsu_pmu_probe_pmu(void *data)
> +{
> +	struct dsu_pmu *dsu_pmu = data;
> +	u64 num_counters;
> +	u32 cpmceid[2];
> +
> +	num_counters = (__dsu_pmu_read_pmcr() >> CLUSTERPMCR_N_SHIFT) &
> +						CLUSTERPMCR_N_MASK;
> +	/* We can only support upto 31 independent counters */

s/upto/up to/

Does the hardware spec allow for more than this?

> +	if (WARN_ON(num_counters > 31))
> +		num_counters = 31;
> +	dsu_pmu->num_counters = num_counters;
> +	if (!dsu_pmu->num_counters)
> +		return;
> +	cpmceid[0] = __dsu_pmu_read_pmceid(0);
> +	cpmceid[1] = __dsu_pmu_read_pmceid(1);
> +	bitmap_from_u32array(dsu_pmu->cpmceid_bitmap,
> +				DSU_PMU_MAX_COMMON_EVENTS,
> +				cpmceid,
> +				ARRAY_SIZE(cpmceid));
> +}

[...]

> +
> +static int dsu_pmu_device_probe(struct platform_device *pdev)
> +{
> +	int irq, rc, cpu;
> +	struct dsu_pmu *dsu_pmu;
> +	char *name;
> +	static atomic_t pmu_idx = ATOMIC_INIT(-1);
> +
> +	dsu_pmu = dsu_pmu_alloc(pdev);
> +	if (IS_ERR(dsu_pmu))
> +		return PTR_ERR(dsu_pmu);
> +
> +	rc = dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpus);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
> +		return rc;
> +	}
> +
> +	rc = smp_call_function_any(&dsu_pmu->associated_cpus,
> +					dsu_pmu_probe_pmu,
> +					dsu_pmu, 1);

Can we probe the relevant CPUs in the same was as the qcom l2 pmu, using
notifiers?

That way we'd work better with maxcpus=.

We have to do this cross-call in the arm_pmu driver because we need the
name at probe time, but that doesn't apply here. We should be able to
lazily initialize the set of events and number of counters.

That also keeps the IRQ affintiy management in one place.

Thanks,
Mark.
