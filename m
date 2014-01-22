From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 22 Jan 2014 15:53:31 +0000
Subject: [PATCH 10/20] ARM64 / ACPI: Enumerate possible/present CPU set
 and map logical cpu id to APIC id
In-Reply-To: <1389961514-13562-11-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-11-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140122155331.GD24288@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 12:25:04PM +0000, Hanjun Guo wrote:

[...]

> +/* map logic cpu id to physical GIC id */
> +extern int arm_cpu_to_apicid[NR_CPUS];
> +#define cpu_physical_id(cpu) arm_cpu_to_apicid[cpu]

Sudeep already commented on this, please update it accordingly.

> +
>  #else	/* !CONFIG_ACPI */
>  #define acpi_disabled 1		/* ACPI sometimes enabled on ARM */
>  #define acpi_noirq 1		/* ACPI sometimes enabled on ARM */
> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
> index 8ba3e6f..1d9b789 100644
> --- a/drivers/acpi/plat/arm-core.c
> +++ b/drivers/acpi/plat/arm-core.c
> @@ -31,6 +31,7 @@
>  #include <linux/smp.h>
>  
>  #include <asm/pgtable.h>
> +#include <asm/cputype.h>
>  
>  /*
>   * We never plan to use RSDT on arm/arm64 as its deprecated in spec but this
> @@ -52,6 +53,13 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>   */
>  static u64 acpi_lapic_addr __initdata;

Is this variable actually needed ?

>  
> +/* available_cpus here means enabled cpu in MADT */
> +static int available_cpus;

Ditto.

> +
> +/* Map logic cpu id to physical GIC id (physical CPU id). */
> +int arm_cpu_to_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = -1 };
> +static int boot_cpu_apic_id = -1;

Do we need all these variables ? I think we should reuse cpu_logical_map
data structures for that, it looks suspiciously familiar.

>  #define BAD_MADT_ENTRY(entry, end) (					\
>  	(!entry) || (unsigned long)entry + sizeof(*entry) > end ||	\
>  	((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
> @@ -132,6 +140,55 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
>   * Please refer to chapter5.2.12.14/15 of ACPI 5.0
>   */
>  
> +/**
> + * acpi_register_gic_cpu_interface - register a gic cpu interface and
> + * generates a logic cpu number
> + * @id: gic cpu interface id to register
> + * @enabled: this cpu is enabled or not
> + *
> + * Returns the logic cpu number which maps to the gic cpu interface
> + */
> +static int acpi_register_gic_cpu_interface(int id, u8 enabled)
> +{
> +	int cpu;
> +
> +	if (id >= MAX_GIC_CPU_INTERFACE) {
> +		pr_info(PREFIX "skipped apicid that is too big\n");
> +		return -EINVAL;
> +	}
> +
> +	total_cpus++;
> +	if (!enabled)
> +		return -EINVAL;
> +
> +	if (available_cpus >=  NR_CPUS) {
> +		pr_warn(PREFIX "NR_CPUS limit of %d reached,"
> +		" Processor %d/0x%x ignored.\n", NR_CPUS, total_cpus, id);
> +		return -EINVAL;
> +	}

Hmm...what if you are missing the boot CPU ? It is a worthy check.
Have a look at smp_init_cpus(), it does not bail out on cpu>= NR_CPUS
because you do want to make sure that the DT contains the boot CPU
node. Same logic applies.

> +
> +	available_cpus++;
> +

Is available_cpus != num_possible_cpus() ? It does not look like hence
available_cpus can go.

> +	/* allocate a logic cpu id for the new comer */
> +	if (boot_cpu_apic_id == id) {
> +		/*
> +		 * boot_cpu_init() already hold bit 0 in cpu_present_mask
> +		 * for BSP, no need to allocte again.
> +		 */
> +		cpu = 0;
> +	} else {
> +		cpu = cpumask_next_zero(-1, cpu_present_mask);
> +	}
> +
> +	/* map the logic cpu id to APIC id */
> +	arm_cpu_to_apicid[cpu] = id;
> +
> +	set_cpu_present(cpu, true);
> +	set_cpu_possible(cpu, true);

This is getting nasty. Before adding this patch and previous ones we
need to put in place a method for the kernel to make a definite choice between
ACPI and DT and stick to that. We can't initialize the logical map twice
(which will happen if your DT has valid cpu nodes and a chosen node pointing
to proper ACPI tables) or even having some entries initialized from DT and
others by ACPI. It is a big fat no-no, please update the series accordingly.

> +
> +	return cpu;
> +}
> +
>  static int __init
>  acpi_parse_gic(struct acpi_subtable_header *header, const unsigned long end)
>  {
> @@ -144,6 +201,16 @@ acpi_parse_gic(struct acpi_subtable_header *header, const unsigned long end)
>  
>  	acpi_table_print_madt_entry(header);
>  
> +	/*
> +	 * We need to register disabled CPU as well to permit
> +	 * counting disabled CPUs. This allows us to size
> +	 * cpus_possible_map more accurately, to permit
> +	 * to not preallocating memory for all NR_CPUS
> +	 * when we use CPU hotplug.
> +	 */
> +	acpi_register_gic_cpu_interface(processor->gic_id,
> +			processor->flags & ACPI_MADT_ENABLED);
> +
>  	return 0;
>  }
>  
> @@ -186,6 +253,19 @@ static int __init acpi_parse_madt_gic_entries(void)
>  		return count;
>  	}
>  
> +#ifdef CONFIG_SMP
> +	if (available_cpus == 0) {
> +		pr_info(PREFIX "Found 0 CPUs; assuming 1\n");
> +		arm_cpu_to_apicid[available_cpus] =
> +			read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
> +		available_cpus = 1;	/* We've got at least one of these */
> +	}

I'd rather check the MADT for at least the boot cpu to present, if it is
not ACPI tables are horribly buggy and the kernel should barf on that.

> +#endif
> +
> +	/* Make boot-up look pretty */
> +	pr_info("%d CPUs available, %d CPUs total\n", available_cpus,
> +		total_cpus);

Ok, now, how can we use the "disabled" CPUs == (total_cpus - available_cpus) ?

Are we keeping track of them in the kernel at all ? It does not look
like, so I wonder whether we need this bit of info. I do not see why it
is pretty to know that there are disabled, aka unusable CPUs.

>  	return 0;
>  }
>  
> @@ -321,6 +401,9 @@ int __init early_acpi_boot_init(void)
>  	if (acpi_disabled)
>  		return -ENODEV;
>  
> +	/* Get the boot CPU's GIC cpu interface id before MADT parsing */
> +	boot_cpu_apic_id = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;

See Sudeep's comment.

Thanks,
Lorenzo
