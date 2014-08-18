From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:27:21 +0100
Subject: [PATCH v2 05/18] ARM64 / ACPI: Parse FADT table to get PSCI
 flags for PSCI init
In-Reply-To: <1407166105-17675-6-git-send-email-hanjun.guo@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-6-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140818142721.GR20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 04:28:12PM +0100, Hanjun Guo wrote:
> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
> the former signals to the OS that the hardware is PSCI compliant.

Actually it signals that the firmware is PSCI compliant. The hardware
doesn't care much.

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 6400312..6e04868 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -19,6 +19,18 @@ extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
>  
> +/* 1 to indicate PSCI 0.2+ is implemented */
> +static inline bool acpi_psci_present(void)
> +{
> +	return !!(acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_COMPLIANT);
> +}
> +
> +/* 1 to indicate HVC must be used instead of SMC as the PSCI conduit */
> +static inline bool acpi_psci_use_hvc(void)
> +{
> +	return !!(acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC);
> +}

Do we actually need !! here? Shouldn't the compiler figure out
conversion to bool automatically?

> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 9cf9127..69a315d 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -11,6 +11,8 @@
>   *  published by the Free Software Foundation.
>   */
>  
> +#define pr_fmt(fmt) "ACPI: " fmt
> +
>  #include <linux/init.h>
>  #include <linux/acpi.h>
>  #include <linux/cpumask.h>
> @@ -47,6 +49,26 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
>  	early_memunmap(map, size);
>  }
>  
> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
> +{
> +	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> +
> +	/*
> +	 * Revision in table header is the FADT Major version,
> +	 * and there is a minor version of FADT which was introduced
> +	 * by ACPI 5.1, we only deal with ACPI 5.1 or higher version
> +	 * to get arm boot flags, or we will disable ACPI.
> +	 */
> +	if (table->revision < 5 || fadt->minor_revision < 1) {

If we ever get revision 6.0, this would trigger.

> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 85c6326..dfc4e4f3 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -395,6 +395,8 @@ void __init setup_arch(char **cmdline_p)
>  	efi_idmap_init();
>  
>  	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
> +	acpi_boot_init();
> +
>  	unflatten_device_tree();

Unless that's changed in a subsequent patch, do we still need to call
unflatten_device_tree() if ACPI was successful?

>  	psci_init();

I would also rename this to something like psci_dt_init() and move the
acpi_disabled check here rather than in the callee.

-- 
Catalin
