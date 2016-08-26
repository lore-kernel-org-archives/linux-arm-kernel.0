From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 26 Aug 2016 16:04:01 +0100
Subject: [PATCH v7 8/9] arm64: pmu: Detect and enable multiple PMUs in an
 ACPI system
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
 <1471985280-2243-9-git-send-email-jeremy.linton@arm.com>
Message-ID: <8737lro9lq.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

Jeremy Linton <jeremy.linton@arm.com> writes:

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

Thanks for squashing changes to arm_pmu_acpi.c from different patches in
v6 into one patch. Except for the a function definition in Patch 5 that can
be moved here I think you've got everything. The combined patch is a lot
easier to review.

Some comments below.

> ---
>  drivers/perf/arm_pmu.c      |   7 +-
>  drivers/perf/arm_pmu_acpi.c | 164 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 170 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index ee9e301..98a037a 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -1063,7 +1063,12 @@ int arm_pmu_device_probe(struct platform_device *pdev,
>  		if (!ret)
>  			ret = init_fn(pmu);
>  	} else if (probe_table) {
> -		ret = probe_plat_pmu(pmu, probe_table, read_cpuid_id());
> +		if (acpi_disabled) {
> +			/* use the current cpu. */
> +			ret = probe_plat_pmu(pmu, probe_table,
> +					     read_cpuid_id());
> +		} else
> +			ret = probe_plat_pmu(pmu, probe_table, pdev->id);

Please add matching braces on both sides of the else.

>  	}
>  
>  	if (ret) {
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index e784714..c0d6888 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c

[...]

> @@ -39,13 +49,167 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
>  		pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
>  }
>  
> +/* Count number and type of CPU cores in the system. */
> +static void __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
> +{
> +	int i;
> +	bool alloc_failure = false;
> +
> +	for_each_possible_cpu(i) {
> +		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
> +		u32 partnum = MIDR_PARTNUM(cinfo->reg_midr);
> +		struct pmu_types *pmu;
> +
> +		list_for_each_entry(pmu, pmus, list) {
> +			if (pmu->cpu_type == partnum) {
> +				pmu->cpu_count++;
> +				break;
> +			}
> +		}
> +
> +		/* we didn't find the CPU type, add an entry to identify it */
> +		if ((&pmu->list == pmus) && (!alloc_failure)) {

The parenthesis around the conditions can be dropped.

> +			pmu = kzalloc(sizeof(struct pmu_types), GFP_KERNEL);
> +			if (!pmu) {
> +				pr_warn("Unable to allocate pmu_types\n");
> +				/*
> +				 * continue to count cpus for any pmu_types
> +				 * already allocated, but don't allocate any
> +				 * more pmu_types. This avoids undercounting.
> +				 */
> +				alloc_failure = true;

Why not just fail probe and return an error? What is the benefit of
having some of the PMUs available?

> +			} else {
> +				pmu->cpu_type = partnum;
> +				pmu->cpu_count++;
> +				list_add_tail(&pmu->list, pmus);
> +			}
> +		}
> +	}
> +}
> +
> +/*
> + * Registers the group of PMU interfaces which correspond to the 'last_cpu_id'.
> + * This group utilizes 'count' resources in the 'res'.
> + */
> +static int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
> +					    int last_cpu_id)

Please drop the prefix "last_". AFAICS, it doesn't provide any
information.

> +{
> +	int i;
> +	int err = -ENOMEM;
> +	bool free_gsi = false;
> +	struct platform_device *pdev;
> +
> +	if (count) {
> +		pdev = platform_device_alloc(ARMV8_PMU_PDEV_NAME, last_cpu_id);
> +		if (pdev) {
> +			err = platform_device_add_resources(pdev, res, count);
> +			if (!err) {
> +				err = platform_device_add(pdev);
> +				if (err) {
> +					pr_warn("Unable to register PMU device\n");
> +					free_gsi = true;
> +				}
> +			} else {
> +				pr_warn("Unable to add resources to device\n");
> +				free_gsi = true;
> +				platform_device_put(pdev);
> +			}
> +		} else {
> +			pr_warn("Unable to allocate platform device\n");
> +			free_gsi = true;
> +		}
> +	}

This entire "if" block is quite hard to review.

Quoting Documentation/CodingStyle, "if you need more than 3 levels of
indentation, you're screwed anyway, and should fix your program."


> +
> +	/* unmark (and possibly unregister) registered GSIs */
> +	for_each_possible_cpu(i) {
> +		if (pmu_irqs[i].registered) {
> +			if (free_gsi)
> +				acpi_unregister_gsi(pmu_irqs[i].gsi);
> +			pmu_irqs[i].registered = false;
> +		}
> +	}

Moving the for_each_possible_cpu block out of this function should help
makes things simpler. It doesn't have any connection to registering the
platform device and you could then do 

if (!count)
   return count;

which should help reduce a level of indentation. But you can further use
the same approach with other conditions in the block as well.

> +
> +	return err;
> +}
> +
> +/*
> + * For the given cpu/pmu type, walk all known GSIs, register them, and add
> + * them to the resource structure. Return the number of GSI's contained
> + * in the res structure, and the id of the last CPU/PMU we added.
> + */
> +static int __init arm_pmu_acpi_gsi_res(struct pmu_types *pmus,
> +				       struct resource *res, int *last_cpu_id)
> +{
> +	int i, count;
> +	int irq;
> +
> +	/* lets group all the PMU's from similar CPU's together */
> +	count = 0;
> +	for_each_possible_cpu(i) {
> +		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
> +
> +		if (pmus->cpu_type == MIDR_PARTNUM(cinfo->reg_midr)) {
> +			if (pmu_irqs[i].gsi == 0)
> +				continue;

Please don't silently continue if the irq is missing. It deserves a user
visible message. We don't want users complaining about kernel issues
when the firmware fails to provide the required information.

> +
> +			irq = acpi_register_gsi(NULL, pmu_irqs[i].gsi,
> +						pmu_irqs[i].trigger,
> +						ACPI_ACTIVE_HIGH);

Check for the return value of acpi_register_gsi as it can return an
error.

> +
> +			res[count].start = res[count].end = irq;
> +			res[count].flags = IORESOURCE_IRQ;
> +
> +			if (pmu_irqs[i].trigger == ACPI_EDGE_SENSITIVE)
> +				res[count].flags |= IORESOURCE_IRQ_HIGHEDGE;
> +			else
> +				res[count].flags |= IORESOURCE_IRQ_HIGHLEVEL;
> +
> +			pmu_irqs[i].registered = true;
> +			count++;
> +			(*last_cpu_id) = cinfo->reg_midr;

What is the benefit of using the entire MIDR for cpu_id when the
grouping is done on the basis of a subset, i.e., part number.

> +		}
> +	}
> +	return count;
> +}
> +
>  static int __init pmu_acpi_init(void)
>  {
> +	struct resource	*res;
>  	int err = -ENOMEM;
> +	int count, cpu_id;
> +	struct pmu_types *pmu, *safe_temp;
> +	LIST_HEAD(pmus);
>  
>  	if (acpi_disabled)
>  		return 0;
>  
> +	arm_pmu_acpi_determine_cpu_types(&pmus);
> +
> +	list_for_each_entry_safe(pmu, safe_temp, &pmus, list) {
> +		res = kcalloc(pmu->cpu_count,
> +			      sizeof(struct resource), GFP_KERNEL);
> +
> +		/* for a given PMU type collect all the GSIs. */
> +		if (res) {
> +			count = arm_pmu_acpi_gsi_res(pmu, res,
> +						     &cpu_id);
> +			/*
> +			 * register this set of interrupts
> +			 * with a new PMU device
> +			 */
> +			err = arm_pmu_acpi_register_pmu(count, res, cpu_id);
> +			if (!err)
> +				pr_info("Registered %d devices for %X\n",
> +					count, pmu->cpu_type);
> +			kfree(res);
> +		} else
> +			pr_warn("PMU unable to allocate interrupt resource space\n");

Same comment about partial registration as above. It's better to error
out IMO.

Also if this stays, please use matching parenthesis on both sides of the else block.

Thanks,
Punit

> +
> +		list_del(&pmu->list);
> +		kfree(pmu);
> +	}
> +
>  	return err;
>  }
> +
>  arch_initcall(pmu_acpi_init);
