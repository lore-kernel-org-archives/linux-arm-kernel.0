From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Mon, 11 Apr 2016 13:01:34 +0100
Subject: [PATCH] arm64: acpi: add a Kconfig option to prefer ACPI boot
 over DT
In-Reply-To: <1460373568-4374-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460373568-4374-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160411120134.GA6724@xora-mmax.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 01:19:28PM +0200, Ard Biesheuvel wrote:
> If both ACPI and DT platform descriptions are available, and the
> kernel was configured at build time to support both flavours, the
> default policy in absence of a acpi=[off|force] kernel command line
> parameter is to prefer DT over ACPI.
> 
> This adds an option to invert that default policy, and prefer ACPI
> over DT instead. Note that this policy is still superseded by the
> value of the acpi= command line parameter.
> 

Looks sane to me

Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>

G

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/Kconfig       | 13 +++++++++++++
>  arch/arm64/kernel/acpi.c |  3 ++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4f436220384f..f3aef40ad0ac 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -918,6 +918,19 @@ config DMI
>  	  However, even with this option, the resultant kernel should
>  	  continue to boot on existing non-UEFI platforms.
>  
> +config PREFER_ACPI_OVER_DT
> +	bool "Prefer booting via ACPI if both ACPI and DT are available"
> +	depends on ACPI
> +	help
> +	  If both ACPI and DT platform descriptions are available, and the
> +	  kernel was configured at build time to support both flavours, the
> +	  default policy in absence of a acpi=[off|force] kernel command line
> +	  parameter is to prefer DT over ACPI.
> +
> +	  This option inverts that default policy, by preferring ACPI over DT
> +	  instead. Note that this default policy is still superseded by the
> +	  value of the acpi= command line parameter.
> +
>  endmenu
>  
>  menu "Userspace binary formats"
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index d1ce8e2f98b9..50ac056fb1fd 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -188,7 +188,8 @@ void __init acpi_boot_table_init(void)
>  	 *   and ACPI has not been force enabled (acpi=force)
>  	 */
>  	if (param_acpi_off ||
> -	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
> +	    (!IS_ENABLED(CONFIG_PREFER_ACPI_OVER_DT) &&
> +	     !param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
>  		return;
>  
>  	/*
> -- 
> 2.5.0
> 
