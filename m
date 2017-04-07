From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Apr 2017 15:27:06 +0100
Subject: [PATCHv2 14/16] drivers/perf: arm_pmu: add ACPI framework
In-Reply-To: <1491503363-17731-15-git-send-email-mark.rutland@arm.com>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
 <1491503363-17731-15-git-send-email-mark.rutland@arm.com>
Message-ID: <20170407142706.GN19342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Just a couple of minor comments below.

On Thu, Apr 06, 2017 at 07:29:21PM +0100, Mark Rutland wrote:
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> new file mode 100644
> index 0000000..5cacd7b
> --- /dev/null
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -0,0 +1,240 @@
> +/*
> + * ACPI probing code for ARM performance counters.
> + *
> + * Copyright (C) 2017 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/percpu.h>
> +#include <linux/perf/arm_pmu.h>
> +
> +#include <asm/cputype.h>
> +
> +static DEFINE_PER_CPU(struct arm_pmu *, probed_pmus);
> +static DEFINE_PER_CPU(int, pmu_irqs);
> +
> +static int arm_pmu_acpi_parse_irq(int cpu)
> +{
> +	struct acpi_madt_generic_interrupt *gicc;
> +	int gsi, trigger;
> +
> +	gicc = acpi_cpu_get_madt_gicc(cpu);
> +	if (WARN_ON(!gicc))
> +		return -EINVAL;
> +
> +	gsi = gicc->performance_interrupt;
> +	if (gicc->flags & ACPI_MADT_PERFORMANCE_IRQ_MODE)
> +		trigger = ACPI_EDGE_SENSITIVE;
> +	else
> +		trigger = ACPI_LEVEL_SENSITIVE;
> +
> +	/*
> +	 * Helpfully, the MADT GICC doesn't have a polarity flag for the
> +	 * "performance interrupt". Luckily, on compliant GICs the polarity is
> +	 * fixed in HW (for both SPIs and PPIs), and thus we don't care. Other
> +	 * interrupt controllers are not supported with ACPI.
> +	 *
> +	 * Here we pass in ACPI_ACTIVE_HIGH to keep the core code happy.
> +	 */
> +	return acpi_register_gsi(NULL, gsi, trigger, ACPI_ACTIVE_HIGH);
> +}
> +
> +static void arm_pmu_acpi_unparse_irq(int cpu)
> +{

"unparse" is a bit weird. Can you rename this register/unregister please?

> +	struct acpi_madt_generic_interrupt *gicc;
> +	int gsi;
> +
> +	gicc = acpi_cpu_get_madt_gicc(cpu);
> +	if (!gicc)
> +		return;
> +
> +	gsi = gicc->performance_interrupt;
> +	acpi_unregister_gsi(gsi);
> +}
> +
> +static int arm_pmu_acpi_parse_irqs(void)
> +{
> +	int cpu, irq;
> +
> +	for_each_possible_cpu(cpu) {
> +		int irq = arm_pmu_acpi_parse_irq(cpu);
> +		if (irq < 0) {
> +			pr_warn("Unable to parse ACPI PMU IRQ for CPU%d: %d\n",
> +				cpu, irq);
> +			goto out_err;
> +		} else if (irq == 0) {
> +			pr_warn("No ACPI PMU IRQ for CPU%d\n", cpu);
> +		}
> +
> +		per_cpu(pmu_irqs, cpu) = irq;
> +	}
> +
> +	return 0;
> +
> +out_err:
> +	for_each_possible_cpu(cpu) {
> +		arm_pmu_acpi_unparse_irq(cpu);
> +		per_cpu(pmu_irqs, cpu) = 0;
> +	}

It might work at the moment (I really can't tell), but I'd rather we didn't
unregister GSIs that we didn't register.

Will
