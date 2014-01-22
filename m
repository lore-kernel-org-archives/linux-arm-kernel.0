From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 22 Jan 2014 11:54:53 +0000
Subject: [PATCH 04/20] ARM64 / ACPI: Introduce arm_core.c and its related
 head file
In-Reply-To: <1389961514-13562-5-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140122115453.GC24288@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 12:24:58PM +0000, Hanjun Guo wrote:

[...]

> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index bd9bbd0..2210353 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -41,6 +41,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/elf.h>
> @@ -225,6 +226,11 @@ void __init setup_arch(char **cmdline_p)
>  
>  	arm64_memblock_init();
>  
> +	/* Parse the ACPI tables for possible boot-time configuration */
> +	acpi_boot_table_init();
> +	early_acpi_boot_init();
> +	acpi_boot_init();
> +
>  	paging_init();

Can I ask you please why we need to parse ACPI tables before
paging_init() ?

[...]

> +/*
> + * __acpi_map_table() will be called before page_init(), so early_ioremap()
> + * or early_memremap() should be called here.

Again, why is this needed ? What's needed before paging_init() from ACPI ?

[...]

> +/*
> + * acpi_boot_table_init() and acpi_boot_init()
> + *  called from setup_arch(), always.
> + *	1. checksums all tables
> + *	2. enumerates lapics
> + *	3. enumerates io-apics
> + *
> + * acpi_table_init() is separated to allow reading SRAT without
> + * other side effects.
> + */
> +void __init acpi_boot_table_init(void)
> +{
> +	/*
> +	 * If acpi_disabled, bail out
> +	 */
> +	if (acpi_disabled)
> +		return;
> +
> +	/*
> +	 * Initialize the ACPI boot-time table parser.
> +	 */
> +	if (acpi_table_init()) {
> +		disable_acpi();
> +		return;
> +	}
> +}
> +
> +int __init early_acpi_boot_init(void)
> +{
> +	/*
> +	 * If acpi_disabled, bail out
> +	 */
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	/*
> +	 * Process the Multiple APIC Description Table (MADT), if present
> +	 */
> +	early_acpi_process_madt();
> +
> +	return 0;
> +}
> +
> +int __init acpi_boot_init(void)
> +{
> +	/*
> +	 * If acpi_disabled, bail out
> +	 */
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt);
> +
> +	/*
> +	 * Process the Multiple APIC Description Table (MADT), if present
> +	 */
> +	acpi_process_madt();
> +
> +	return 0;
> +}

Well, apart from having three init calls, one returning void and two
returning proper values, do not understand why, and do not understand
why we need three calls in the first place...why should we process MADT
twice in two separate calls ? What is supposed to change in between that
prevents you from merging the two together ?

Thanks,
Lorenzo
