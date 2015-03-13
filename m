From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 13 Mar 2015 11:28:45 +0800
Subject: [PATCH v10 18/21] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY
 if ACPI is enabled on ARM64
In-Reply-To: <20150312182151.GA3867@red-moon>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-19-git-send-email-hanjun.guo@linaro.org>
 <20150312182151.GA3867@red-moon>
Message-ID: <5502596D.6020901@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/13 2:21, Lorenzo Pieralisi wrote:
> On Wed, Mar 11, 2015 at 12:39:44PM +0000, Hanjun Guo wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> ACPI reduced hardware mode is disabled by default, but ARM64
>> can only run properly in ACPI hardware reduced mode, so select
>> ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.
>>
>> If the firmware is not using hardware reduced ACPI mode, we
>> will disable ACPI to avoid nightmare such as accessing some
>> registers which are not available on ARM64.
>>
[...]
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index 6468f88..5819ef7 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -303,6 +303,11 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
>>  	 */
>>  	if (table->revision > 5 ||
>>  	    (table->revision == 5 && fadt->minor_revision >= 1)) {
>> +		if (!acpi_gbl_reduced_hardware) {
>> +			pr_err("Not hardware reduced ACPI mode, will not be supported\n");
>> +			goto disable_acpi;
>> +		}
>> +
> I reviewed the code and found that acpi_parse_fadt has become very
> complex to read and understand. On top of that, I still do not understand
> why you check PSCI presence in there (to print a warning ?) and as it

Since Parking protocol for bringing up secondary CPUs will be upstreamed,
it is ok to me to print no message for not supporting PSCI.

> was raised before disable_acpi() is scattered all over the place.
> I do not understand why we enable ACPI to disable it again if
> one of the checks fails, IMHO it is better to leave it disabled,
> carry out the checks and enable ACPI if all of them pass.
>
> I came up with the patch attached on top of your series, which should be
> split, tested on Juno, please test, let me know your opinion and shout if
> you spot something wrong, it should simplify things a lot.

Thanks, I have some minor comments below.

>
> I wonder if acpi_get_table_with_size() usage is frowned upon, but you
> use it anyway and it helps us remove the FADT parsing function that
> in my opinion is useless, since its return value is dumped by ACPI
> core.
>
> Thanks,
> Lorenzo
>
> ---
>  arch/arm64/kernel/acpi.c | 92 ++++++++++++++++++++++++------------------------
>  1 file changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 5819ef7..b7497fa 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -291,56 +291,23 @@ void acpi_unregister_gsi(u32 gsi)
>  }
>  EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>  
> -static int __init acpi_parse_fadt(struct acpi_table_header *table)
> -{
> -	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> -
> -	/*
> -	 * Revision in table header is the FADT Major revision, and there
> -	 * is a minor revision of FADT which was introduced by ACPI 5.1,
> -	 * we only deal with ACPI 5.1 or newer revision to get GIC and SMP
> -	 * boot protocol configuration data, or we will disable ACPI.
> -	 */
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
> -	}
> -
> -	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
> -		table->revision, fadt->minor_revision);
> -
> -disable_acpi:
> -	disable_acpi();
> -	return -EINVAL;
> -}
> -
>  /*
>   * acpi_boot_table_init() called from setup_arch(), always.
>   *	1. find RSDP and get its address, and then find XSDT
>   *	2. extract all tables and checksums them all
>   *	3. check ACPI FADT revision
> + *	4. check ACPI FADT HW reduced flag
>   *
>   * We can parse ACPI boot-time tables such as MADT after
>   * this function is called.
>   */
>  void __init acpi_boot_table_init(void)
>  {
> +	struct acpi_table_header *table;
> +	struct acpi_table_fadt *fadt;
> +	acpi_status status;
> +	acpi_size tbl_size;
> +
>  	/*
>  	 * Enable ACPI instead of device tree unless
>  	 * - ACPI has been disabled explicitly (acpi=off), or
> @@ -351,19 +318,52 @@ void __init acpi_boot_table_init(void)
>  	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
>  		return;
>  
> -	enable_acpi();
> -
>  	/* Initialize the ACPI boot-time table parser. */
>  	if (acpi_table_init()) {

Since we disable ACPI in default, it is a bit strange for me to init all
the ACPI tables and parse FADT when ACPI is disabled, could you
put some comments here to clarify the purpose? other than that, it is looks
good to me.

Thanks
Hanjun
