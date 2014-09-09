From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 9 Sep 2014 17:37:45 +0100
Subject: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140909163745.GB6370@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 03:57:42PM +0100, Hanjun Guo wrote:
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -74,3 +74,18 @@ void __init acpi_boot_table_init(void)
>   * TBD when ARM/ARM64 starts to support suspend...
>   */
>  int (*acpi_suspend_lowlevel)(void) = NULL;
> +
> +static int __init parse_acpi(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	/* "acpi=off" disables both ACPI table parsing and interpreter */
> +	if (strcmp(arg, "off") == 0)
> +		disable_acpi();
> +	else
> +		return -EINVAL;	/* Core will print when we return error */
> +
> +	return 0;
> +}
> +early_param("acpi", parse_acpi);

I forgot about early param, so there is a way to set acpi_disabled to 1
before populating the tables.

-- 
Catalin
