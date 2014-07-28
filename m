From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 28 Jul 2014 19:35:45 +0100
Subject: [PATCH 02/19] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <1406206825-15590-3-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <53D69801.9090901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/07/14 14:00, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
>
> Introduce two early parameters for "acpi", one is the parameter
> to disable ACPI on ARM64 and another one is acpi=strict to disable
> out-of-spec workarounds.
>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>   Documentation/kernel-parameters.txt |    3 ++-
>   arch/arm64/kernel/acpi.c            |   21 +++++++++++++++++++++
>   2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index b7fa2f5..d130bd5 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -165,7 +165,7 @@ multipliers 'Kilo', 'Mega', and 'Giga', equalling 2^10, 2^20, and 2^30
>   bytes respectively. Such letter suffixes can also be entirely omitted.
>
>
> -	acpi=		[HW,ACPI,X86]
> +	acpi=		[HW,ACPI,X86,ARM]
>   			Advanced Configuration and Power Interface
>   			Format: { force | off | strict | noirq | rsdt }
>   			force -- enable ACPI if default was off
> @@ -175,6 +175,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>   				strictly ACPI specification compliant.
>   			rsdt -- prefer RSDT over (default) XSDT
>   			copy_dsdt -- copy DSDT to memory
> +			For ARM64, ONLY "off" and "strict" are available.
>
>   			See also Documentation/power/runtime_pm.txt, pci=noacpi
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index c62fce6..ac78e4e 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -74,3 +74,24 @@ void __init acpi_boot_table_init(void)
>   		return;
>   	}
>   }
> +
> +static int __init parse_acpi(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	/* "acpi=off" disables both ACPI table parsing and interpreter */
> +	if (strcmp(arg, "off") == 0) {
> +		disable_acpi();
> +	}
> +	/* acpi=strict disables out-of-spec workarounds */
> +	else if (strcmp(arg, "strict") == 0) {
> +		acpi_strict = 1;

This should be default set as I mentioned in patch#1. We can introduce
this option if required in future.

Regards,
Sudeep
