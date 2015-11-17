From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 17 Nov 2015 12:26:22 +0000
Subject: [PATCH v3 61/62] arm/acpi: Add acpi parameter to enable/disable
 acpi
In-Reply-To: <1447753261-7552-62-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-62-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B1CEE.9030008@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

I would have appreciate if you I had looked on comments made on the
series sent by Parth.

On 17/11/15 09:41, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> ACPI will be disabled by default. Define new command line parameter
> "acpi" for enabling it.

I don't think this is right. We have to be able to boot platform where
there is only ACPI provided without adding a command line option.

Overall, it would be better if we follow the same behavior as Linux i.e
ACPI is enabled instead of DT unless:
        - ACPI has been disabled (acpi=off)
        - the DT is not empty (it has more than just a /chosen node) and
ACPI has not been forced to be enabled (acpi=force).

> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/setup.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/xen/arch/arm/setup.c b/xen/arch/arm/setup.c
> index 63feadf..1a40323 100644
> --- a/xen/arch/arm/setup.c
> +++ b/xen/arch/arm/setup.c
> @@ -59,6 +59,10 @@ static unsigned long opt_xenheap_megabytes __initdata;
>  integer_param("xenheap_megabytes", opt_xenheap_megabytes);
>  #endif
>  
> +/* "acpi=force" : Enables acpi */
> +static void parse_acpi_param(char *s);
> +custom_param("acpi", parse_acpi_param);
> +
>  static __used void init_done(void)
>  {
>      free_init_memory();
> @@ -84,6 +88,23 @@ static const char * __initdata processor_implementers[] = {
>      ['i'] = "Intel Corporation",
>  };
>  
> +static char __initdata acpi_param[10] = "";
> +static void __init parse_acpi_param(char *s)
> +{
> +    /* Save the parameter so it can be propagated to domain0. */
> +    safe_strcpy(acpi_param, s);

This acpi_param is never used within this series. Please drop it or
either implement what the comment claim.

> +
> +    /* Interpret the parameter for use within Xen. */
> +    if ( !parse_bool(s) )
> +    {
> +        disable_acpi();
> +    }
> +    else if ( !strcmp(s, "force") )
> +    {
> +        acpi_disabled = 0;
> +    }
> +}
> +
>  static void __init processor_id(void)
>  {
>      const char *implementer = "Unknown";
> @@ -729,6 +750,7 @@ void __init start_xen(unsigned long boot_phys_offset,
>          + (fdt_paddr & ((1 << SECOND_SHIFT) - 1));
>      fdt_size = boot_fdt_info(device_tree_flattened, fdt_paddr);
>  
> +    disable_acpi();
>      cmdline = boot_fdt_cmdline(device_tree_flattened);
>      printk("Command line: %s\n", cmdline);
>      cmdline_parse(cmdline);
> 

Regards,

-- 
Julien Grall
