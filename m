From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Mar 2015 10:49:25 -0800
Subject: [PATCH v9 13/21] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <1424853601-6675-14-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-14-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150305184925.GF4932@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 25, 2015 at 04:39:53PM +0800, Hanjun Guo wrote:
> MADT contains the information for MPIDR which is essential for
> SMP initialization, parse the GIC cpu interface structures to
> get the MPIDR value and map it to cpu_logical_map(), and add
> enabled cpu with valid MPIDR into cpu_possible_map.
> 
> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
> Parking protocol, but the Parking protocol is only specified for
> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
> before some updates for the ACPI spec or the Parking protocol spec.
> 
> Parking protocol patches for SMP boot will be sent to upstream when
> the new version of Parking protocol is ready.
> 
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Some nits below. Up to you if you fix incrementally or respin, but I'd like to
see them fixed for consistency's sake.

Acked-by: Olof Johansson <olof@lixom.net>

> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index 780f82c..bf22650 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -39,9 +39,10 @@ extern void show_ipi_list(struct seq_file *p, int prec);
>  extern void handle_IPI(int ipinr, struct pt_regs *regs);
>  
>  /*
> - * Setup the set of possible CPUs (via set_cpu_possible)
> + * Discover the set of possible CPUs and determine their
> + * SMP operations.
>   */
> -extern void smp_init_cpus(void);
> +extern void of_smp_init_cpus(void);

This is inconsistent naming, we use dt some places, of elsewhere.

> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index bdcc9fc..0f35d87 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -25,6 +25,10 @@
>  #include <linux/of_fdt.h>
>  #include <linux/smp.h>
>  
> +#include <asm/cputype.h>
> +#include <asm/cpu_ops.h>
> +#include <asm/smp_plat.h>
> +
>  int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
>  int acpi_disabled = 1;
>  EXPORT_SYMBOL(acpi_disabled);
> @@ -32,6 +36,12 @@ EXPORT_SYMBOL(acpi_disabled);
>  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
>  EXPORT_SYMBOL(acpi_pci_disabled);
>  
> +/* Processors with enabled flag and sane MPIDR */
> +static int enabled_cpus;
> +
> +/* Boot CPU is valid or not in MADT */
> +static bool __initdata bootcpu_valid;
> +
>  static bool __initdata param_acpi_off;
>  static bool __initdata param_acpi_force;
>  
> @@ -85,6 +95,129 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
>  	early_memunmap(map, size);
>  }
>  
> +/**
> + * acpi_map_gic_cpu_interface - generates a logical cpu number
> + * and map to MPIDR represented by GICC structure
> + * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
> + * @enabled: this cpu is enabled or not
> + *
> + * Returns the logical cpu number which maps to MPIDR
> + */
> +static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)
> +{
> +	int i;
> +
> +	if (mpidr == INVALID_HWID) {
> +		pr_info("Skip MADT cpu entry with invalid MPIDR\n");
> +		return -EINVAL;
> +	}
> +
> +	total_cpus++;
> +	if (!enabled)
> +		return -EINVAL;
> +
> +	if (enabled_cpus >=  NR_CPUS) {
> +		pr_warn("NR_CPUS limit of %d reached, Processor %d/0x%llx ignored.\n",
> +			NR_CPUS, total_cpus, mpidr);
> +		return -EINVAL;
> +	}
> +
> +	/* Check if GICC structure of boot CPU is available in the MADT */
> +	if (cpu_logical_map(0) == mpidr) {
> +		if (bootcpu_valid) {
> +			pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
> +			       mpidr);
> +			return -EINVAL;
> +		}
> +
> +		bootcpu_valid = true;
> +	}
> +
> +	/*
> +	 * Duplicate MPIDRs are a recipe for disaster. Scan
> +	 * all initialized entries and check for
> +	 * duplicates. If any is found just ignore the CPU.
> +	 */
> +	for (i = 1; i < enabled_cpus; i++) {
> +		if (cpu_logical_map(i) == mpidr) {
> +			pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
> +			       mpidr);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!acpi_psci_present())
> +		return -EOPNOTSUPP;
> +
> +	cpu_ops[enabled_cpus] = cpu_get_ops("psci");
> +	/* CPU 0 was already initialized */
> +	if (enabled_cpus) {
> +		if (!cpu_ops[enabled_cpus])
> +			return -EINVAL;
> +
> +		if (cpu_ops[enabled_cpus]->cpu_init(NULL, enabled_cpus))
> +			return -EOPNOTSUPP;
> +
> +		/* map the logical cpu id to cpu MPIDR */
> +		cpu_logical_map(enabled_cpus) = mpidr;
> +	}
> +
> +	enabled_cpus++;
> +	return enabled_cpus;
> +}
> +
> +static int __init
> +acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
> +				const unsigned long end)
> +{
> +	struct acpi_madt_generic_interrupt *processor;
> +
> +	processor = (struct acpi_madt_generic_interrupt *)header;
> +
> +	if (BAD_MADT_ENTRY(processor, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(header);
> +
> +	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
> +		processor->flags & ACPI_MADT_ENABLED);
> +
> +	return 0;
> +}
> +
> +/* Parse GIC cpu interface entries in MADT for SMP init */
> +void __init acpi_init_cpus(void)
> +{
> +	int count, i;
> +
> +	/*
> +	 * do a partial walk of MADT to determine how many CPUs
> +	 * we have including disabled CPUs, and get information
> +	 * we need for SMP init
> +	 */
> +	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
> +			acpi_parse_gic_cpu_interface, 0);
> +
> +	if (!count) {
> +		pr_err("No GIC CPU interface entries present\n");
> +		return;
> +	} else if (count < 0) {
> +		pr_err("Error parsing GIC CPU interface entry\n");
> +		return;
> +	}
> +
> +	if (!bootcpu_valid) {
> +		pr_err("MADT missing boot CPU MPIDR, not enabling secondaries\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < enabled_cpus; i++)
> +		set_cpu_possible(i, true);
> +
> +	/* Make boot-up look pretty */
> +	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
> +}
> +
>  static int __init acpi_parse_fadt(struct acpi_table_header *table)
>  {
>  	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> @@ -96,8 +229,20 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
>  	 * boot protocol configuration data, or we will disable ACPI.
>  	 */
>  	if (table->revision > 5 ||
> -	    (table->revision == 5 && fadt->minor_revision >= 1))
> -		return 0;
> +	    (table->revision == 5 && fadt->minor_revision >= 1)) {
> +		/*
> +		 * ACPI 5.1 only has two explicit methods to boot up SMP,
> +		 * PSCI and Parking protocol, but the Parking protocol is
> +		 * only specified for ARMv7 now, so make PSCI as the only
> +		 * way for the SMP boot protocol before some updates for
> +		 * the Parking protocol spec.
> +		 */
> +		if (acpi_psci_present())
> +			return 0;
> +
> +		pr_warn("No PSCI support, will not bring up secondary CPUs\n");
> +		return -EOPNOTSUPP;
> +	}
>  
>  	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
>  		table->revision, fadt->minor_revision);
> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index cce9524..fb8ff9b 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -35,7 +35,7 @@ static const struct cpu_operations *supported_cpu_ops[] __initconst = {
>  	NULL,
>  };
>  
> -static const struct cpu_operations * __init cpu_get_ops(const char *name)
> +const struct cpu_operations * __init cpu_get_ops(const char *name)
>  {
>  	const struct cpu_operations **ops = supported_cpu_ops;
>  
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 97fa7f3..b278311 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -393,13 +393,16 @@ void __init setup_arch(char **cmdline_p)
>  	if (acpi_disabled) {
>  		unflatten_device_tree();
>  		psci_dt_init();
> +		cpu_read_bootcpu_ops();
> +#ifdef CONFIG_SMP
> +		of_smp_init_cpus();
> +#endif
>  	} else {
>  		psci_acpi_init();
> +		acpi_init_cpus();
>  	}
>  
> -	cpu_read_bootcpu_ops();
>  #ifdef CONFIG_SMP
> -	smp_init_cpus();
>  	smp_build_mpidr_hash();
>  #endif

I'd rather do without another ifdef above and provide a stub for that function,
but again it might make sense to just keep a small smp_init_cpus() just as with
the psci setup.

The cpu_read_bootcpu_ops() should be pushed down to the dt implementation to
keep the paths more common between acpi and dt.


-Olof
