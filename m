From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 22 Feb 2016 16:45:17 +0100
Subject: [PATCH 1/8] arm64: move acpi/dt decision earlier in boot process
In-Reply-To: <1456148818-26257-2-git-send-email-aleksey.makarov@linaro.org>
References: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
 <1456148818-26257-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <56CB2D0D.3090408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/02/16 14:46, Aleksey Makarov wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
>
> In order to support selecting earlycon via either ACPI or DT, move
> the decision on whether to attempt ACPI configuration into the
> early_param handling. Then make acpi_boot_table_init() bail out if
> acpi_disabled.
>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>   arch/arm64/kernel/acpi.c | 54 ++++++++++++++++++++++++++----------------------
>   1 file changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index d1ce8e2..7a944f7 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -44,6 +44,19 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>   static bool param_acpi_off __initdata;
>   static bool param_acpi_force __initdata;
>
> +static int __init dt_scan_depth1_nodes(unsigned long node,
> +				       const char *uname, int depth,
> +				       void *data)
> +{
> +	/*
> +	 * Return 1 as soon as we encounter a node at depth 1 that is
> +	 * not the /chosen node.
> +	 */
> +	if (depth == 1 && (strcmp(uname, "chosen") != 0))
> +		return 1;
> +	return 0;
> +}
> +
>   static int __init parse_acpi(char *arg)
>   {
>   	if (!arg)
> @@ -57,23 +70,27 @@ static int __init parse_acpi(char *arg)
>   	else
>   		return -EINVAL;	/* Core will print when we return error */
>
> -	return 0;
> -}
> -early_param("acpi", parse_acpi);
> +	/*
> +	 * Enable ACPI instead of device tree unless
> +	 * - ACPI has been disabled explicitly (acpi=off), or
> +	 * - the device tree is not empty (it has more than just a /chosen node)
> +	 *   and ACPI has not been force enabled (acpi=force)
> +	 */
> +	if (param_acpi_off ||
> +	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
> +		return 0;
>
> -static int __init dt_scan_depth1_nodes(unsigned long node,
> -				       const char *uname, int depth,
> -				       void *data)
> -{
>   	/*
> -	 * Return 1 as soon as we encounter a node at depth 1 that is
> -	 * not the /chosen node.
> +	 * ACPI is disabled at this point. Enable it in order to parse
> +	 * the ACPI tables and carry out sanity checks
>   	 */
> -	if (depth == 1 && (strcmp(uname, "chosen") != 0))
> -		return 1;
> +	enable_acpi();
> +

So we only enable ACPI if we pass acpi=force as kernel parameter?
I'm not sure if this is what you wanted to do.

Regards,
Matthias
