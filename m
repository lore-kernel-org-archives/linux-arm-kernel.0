From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 25 Mar 2015 21:45:33 +0800
Subject: [PATCH 4/5] ARM64: kernel: acpi: refactor ACPI tables init and
 checks
In-Reply-To: <1427219940-27201-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1427219940-27201-5-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5512BBFD.6040504@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/25 1:58, Lorenzo Pieralisi wrote:
> Current ACPI init code on ARM64 relies on acpi_table_parse() API to
> check if the FADT is present and to carry out sanity checks on that.
>
> The handler passed to the acpi_table_parse() function and used to
> carry out the parsing on the requested table returns a value that is
> ignored by the acpi_table_parse() function, so it is not possible
> to propagate errors back to the acpi_table_parse() caller through
> the handler.
>
> This forces ARM64 ACPI init code to have disable_acpi() calls scattered
> all over the place that makes code unwieldy and not easy to follow.
>
> This patch refactors the ARM64 ACPI init code, by creating a
> self-contained function (ie acpi_fadt_sanity_check()) that carries
> out the required checks on FADT and returns an adequate return value
> to the caller. This allows creating a common error path that disables
> ACPI and makes code more readable and easy to parse and change were
> further checks FADT to be added in the future.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---

I already reviewed this patch set, and it is fine to me

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

>  arch/arm64/kernel/acpi.c | 104 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 70 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index a70f714..542f045 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -218,43 +218,60 @@ void __init acpi_init_cpus(void)
>  	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
>  }
>  
> -static int __init acpi_parse_fadt(struct acpi_table_header *table)
> +/*
> + * acpi_fadt_sanity_check() - Check FADT presence and carry out sanity
> + *			      checks on it
> + *
> + * Return 0 on success,  <0 on failure
> + */
> +static int __init acpi_fadt_sanity_check(void)
>  {
> -	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> +	struct acpi_table_header *table;
> +	struct acpi_table_fadt *fadt;
> +	acpi_status status;
> +	acpi_size tbl_size;
> +	int ret = 0;
> +
> +	/*
> +	 * FADT is required on arm64; retrieve it to check its presence
> +	 * and carry out revision and ACPI HW reduced compliancy tests
> +	 */
> +	status = acpi_get_table_with_size(ACPI_SIG_FADT, 0, &table, &tbl_size);
> +	if (ACPI_FAILURE(status)) {
> +		const char *msg = acpi_format_exception(status);
> +
> +		pr_err("Failed to get FADT table, %s\n", msg);
> +		return -ENODEV;
> +	}
> +
> +	fadt = (struct acpi_table_fadt *)table;
>  
>  	/*
>  	 * Revision in table header is the FADT Major revision, and there
>  	 * is a minor revision of FADT which was introduced by ACPI 5.1,
>  	 * we only deal with ACPI 5.1 or newer revision to get GIC and SMP
> -	 * boot protocol configuration data, or we will disable ACPI.
> +	 * boot protocol configuration data.
>  	 */
> -	if (table->revision > 5 ||
> -	    (table->revision == 5 && fadt->minor_revision >= 1)) {
> -		if (!acpi_gbl_reduced_hardware) {
> -			pr_err("Not hardware reduced ACPI mode, will not be supported\n");
> -			goto disable_acpi;
> -		}
> -
> -		/*
> -		 * ACPI 5.1 only has two explicit methods to boot up SMP,
> -		 * PSCI and Parking protocol, but the Parking protocol is
> -		 * only specified for ARMv7 now, so make PSCI as the only
> -		 * way for the SMP boot protocol before some updates for
> -		 * the Parking protocol spec.
> -		 */
> -		if (acpi_psci_present())
> -			return 0;
> -
> -		pr_warn("No PSCI support, will not bring up secondary CPUs\n");
> -		return -EOPNOTSUPP;
> +	if (table->revision < 5 ||
> +	   (table->revision == 5 && fadt->minor_revision < 1)) {
> +		pr_err("Unsupported FADT revision %d.%d, should be 5.1+\n",
> +		       table->revision, fadt->minor_revision);
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  
> -	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
> -		table->revision, fadt->minor_revision);
> +	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
> +		pr_err("FADT not ACPI hardware reduced compliant\n");
> +		ret = -EINVAL;
> +	}
>  
> -disable_acpi:
> -	disable_acpi();
> -	return -EINVAL;
> +out:
> +	/*
> +	 * acpi_get_table_with_size() creates FADT table mapping that
> +	 * should be released after parsing and before resuming boot
> +	 */
> +	early_acpi_os_unmap_memory(table, tbl_size);
> +	return ret;
>  }
>  
>  /*
> @@ -262,12 +279,18 @@ disable_acpi:
>   *	1. find RSDP and get its address, and then find XSDT
>   *	2. extract all tables and checksums them all
>   *	3. check ACPI FADT revision
> + *	4. check ACPI FADT HW reduced flag
>   *
>   * We can parse ACPI boot-time tables such as MADT after
>   * this function is called.
> + *
> + * ACPI is enabled on return if ACPI tables initialized and sanity checks
> + * passed, disabled otherwise
>   */
>  void __init acpi_boot_table_init(void)
>  {
> +	int err;
> +
>  	/*
>  	 * Enable ACPI instead of device tree unless
>  	 * - ACPI has been disabled explicitly (acpi=off), or
> @@ -278,19 +301,32 @@ void __init acpi_boot_table_init(void)
>  	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
>  		return;
>  
> +	/*
> +	 * ACPI is disabled at this point. Enable it in order to parse
> +	 * the ACPI tables and carry out sanity checks
> +	 */
>  	enable_acpi();
>  
>  	/* Initialize the ACPI boot-time table parser. */
> -	if (acpi_table_init()) {
> -		disable_acpi();
> -		return;
> +	err = acpi_table_init();
> +	if (err) {
> +		pr_err("Failed to init ACPI tables\n");
> +		goto out;
>  	}
>  
> -	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt)) {
> -		/* disable ACPI if no FADT is found */
> +	/*
> +	 * Check FADT presence and carry out FADT sanity checks
> +	 */
> +	err = acpi_fadt_sanity_check();
> +
> +out:
> +	/*
> +	 * If ACPI tables are initialized and FADT sanity checks passed,
> +	 * leave ACPI enabled and carry on booting; otherwise disable ACPI
> +	 * on initialization error.
> +	 */
> +	if (err)
>  		disable_acpi();
> -		pr_err("Can't find FADT\n");
> -	}
>  }
>  
>  void __init acpi_gic_init(void)
