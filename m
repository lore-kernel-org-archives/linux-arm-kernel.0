From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Nov 2016 10:29:14 +0000
Subject: [PATCH V10 5/6] arm64: pmu: Detect and enable multiple PMUs in
 an ACPI system
In-Reply-To: <1478734793-6341-6-git-send-email-jeremy.linton@arm.com>
References: <1478734793-6341-1-git-send-email-jeremy.linton@arm.com>
 <1478734793-6341-6-git-send-email-jeremy.linton@arm.com>
Message-ID: <20161129102913.GB30283@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 05:39:52PM -0600, Jeremy Linton wrote:
> Its possible that an ACPI system has multiple CPU types in it
> with differing PMU counters. Iterate the CPU's and make a determination
> about how many of each type exist in the system. Then take and create
> a PMU platform device for each type, and assign it the interrupts parsed
> from the MADT. Creating a platform device is necessary because the PMUs
> are not described as devices in the DSDT table.
> 
> This code is loosely based on earlier work by Mark Salter.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c      |   8 +-
>  drivers/perf/arm_pmu_acpi.c | 234 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 240 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 6008be9..07e1404 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -1087,7 +1087,13 @@ int arm_pmu_device_probe(struct platform_device *pdev,
>  		if (!ret)
>  			ret = init_fn(pmu);
>  	} else if (probe_table) {
> -		ret = probe_plat_pmu(pmu, probe_table, read_cpuid_id());
> +		if (acpi_disabled) {
> +			/* use the current cpu. */
> +			ret = probe_plat_pmu(pmu, probe_table,
> +					     read_cpuid_id());
> +		} else {
> +			ret = probe_plat_pmu(pmu, probe_table, pdev->id);
> +		}
>  	}
>  
>  	if (ret) {
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 135851c..eecf1c1 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -2,13 +2,17 @@
>   * ARM ACPI PMU support
>   *
>   * Copyright (C) 2015 Red Hat Inc.
> + * Copyright (C) 2016 ARM Ltd.
>   * Author: Mark Salter <msalter@redhat.com>
> + *	   Jeremy Linton <jeremy.linton@arm.com>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2.  See
>   * the COPYING file in the top-level directory.
>   *
>   */
>  
> +#define pr_fmt(fmt) "ACPI-PMU: " fmt
> +
>  #include <asm/cpu.h>
>  #include <linux/acpi.h>
>  #include <linux/irq.h>
> @@ -20,7 +24,14 @@
>  struct pmu_irq {
>  	int  gsi;
>  	int  trigger;
> -	bool registered;
> +	int  irq;
> +	bool used;
> +};
> +
> +struct pmu_types {
> +	struct list_head list;
> +	int		 cpu_type;
> +	int		 cpu_count;
>  };
>  
>  static struct pmu_irq pmu_irqs[NR_CPUS];
> @@ -38,3 +49,224 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
>  	else
>  		pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
>  }
> +
> +static void __init arm_pmu_acpi_handle_alloc_failure(struct list_head *pmus)
> +{
> +	int i;
> +	struct pmu_types *pmu, *safe_temp;
> +
> +	list_for_each_entry_safe(pmu, safe_temp, pmus, list) {
> +		list_del(&pmu->list);
> +		kfree(pmu);
> +	}
> +
> +	for_each_possible_cpu(i)
> +		if (pmu_irqs[i].irq > 0)
> +			acpi_unregister_gsi(pmu_irqs[i].gsi);
> +}
> +
> +/*
> + * Count number and type of CPU cores in the system. Returns the number
> + * of "unused" MADT entries we could not associate with a PMU. This can
> + * be the result of CPU's not being online,  or errors in the MADT.
> + * Under normal circumstances this will be 0.
> + */
> +static int __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
> +{
> +	int i;
> +	int unused_madt_entries = 0;
> +
> +	for_each_possible_cpu(i) {
> +		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
> +		struct pmu_types *pmu;
> +
> +		/*
> +		 * Ignore GSI registration failure for now, as
> +		 * some of the MADT entries may not be used.
> +		 */
> +		pmu_irqs[i].irq = acpi_register_gsi(NULL, pmu_irqs[i].gsi,
> +						    pmu_irqs[i].trigger,
> +						    ACPI_ACTIVE_HIGH);
> +		/* likely not online */
> +		if (cinfo->reg_midr == 0) {

I appreciate that this code only gets built for arm64 at the moment, but
given that you've introduced the read_specific_cpuid macro, it seems like
it would be better to use it here too and avoid the reference to struct
cpuinfo_arm64 altogether. Similarly for the other references in this file.

Will
