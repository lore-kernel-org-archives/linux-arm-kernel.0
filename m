From: amakarov.linux@gmail.com (Aleksey Makarov)
Date: Wed, 7 Sep 2016 12:30:19 +0300
Subject: [PATCH v10 3/4] ARM64: ACPI: enable ACPI_SPCR_TABLE
In-Reply-To: <20160905123617.18775-4-aleksey.makarov@linaro.org>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <20160905123617.18775-4-aleksey.makarov@linaro.org>
Message-ID: <7e5486cc-4080-2d1e-8f6d-98874379887d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/05/2016 03:36 PM, Aleksey Makarov wrote:
> SBBR mentions SPCR as a mandatory ACPI table.  So enable it for ARM64
> 
> Earlycon should be set up as early as possible.  ACPI boot tables are
> mapped in arch/arm64/kernel/acpi.c:acpi_boot_table_init() that
> is called from setup_arch() and that's where we parse SPCR.
> So it has to be opted-in per-arch.
> 
> When ACPI_SPCR_TABLE is defined initialization of DT earlycon is
> deferred until the DT/ACPI decision is done.  Initialize DT earlycon
> if ACPI is disabled.

Hi Will, Catalin,

Can you review this patch and consider ACKing it please?

Thank you
Aleksey Makarov

> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Tested-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm64/Kconfig       |  1 +
>  arch/arm64/kernel/acpi.c | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index bc3f00f..11a2d36 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -4,6 +4,7 @@ config ARM64
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ACPI_MCFG if ACPI
> +	select ACPI_SPCR_TABLE if ACPI
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 3e4f1a4..252a6d9 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -24,6 +24,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/smp.h>
> +#include <linux/serial_core.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/cpu_ops.h>
> @@ -206,7 +207,7 @@ void __init acpi_boot_table_init(void)
>  	if (param_acpi_off ||
>  	    (!param_acpi_on && !param_acpi_force &&
>  	     of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
> -		return;
> +		goto done;
>  
>  	/*
>  	 * ACPI is disabled at this point. Enable it in order to parse
> @@ -226,6 +227,14 @@ void __init acpi_boot_table_init(void)
>  		if (!param_acpi_force)
>  			disable_acpi();
>  	}
> +
> +done:
> +	if (acpi_disabled) {
> +		if (earlycon_init_is_deferred)
> +			early_init_dt_scan_chosen_stdout();
> +	} else {
> +		parse_spcr(earlycon_init_is_deferred);
> +	}
>  }
>  
>  #ifdef CONFIG_ACPI_APEI
> 
