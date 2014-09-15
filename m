From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Sep 2014 16:01:36 +0100
Subject: [PATCH v4 14/18] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <1410530416-30200-15-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-15-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140915150136.GF5415@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 03:00:12PM +0100, Hanjun Guo wrote:
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 5b3546b..9869377 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -23,6 +23,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/bootmem.h>
>  #include <linux/smp.h>
> +#include <linux/irqchip/arm-gic-acpi.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/cpu_ops.h>
> @@ -312,6 +313,28 @@ void __init acpi_boot_table_init(void)
>  		pr_err("Can't find FADT or error happened during parsing FADT\n");
>  }
>  
> +void __init acpi_gic_init(void)
> +{
> +	struct acpi_table_header *table;
> +	acpi_status status;
> +	acpi_size tbl_size;
> +	int err;
> +
> +	status = acpi_get_table_with_size(ACPI_SIG_MADT, 0, &table, &tbl_size);
> +	if (ACPI_FAILURE(status)) {
> +		const char *msg = acpi_format_exception(status);
> +
> +		pr_err("Failed to get MADT table, %s\n", msg);
> +		return;
> +	}
> +
> +	err = gic_v2_acpi_init(table);
> +	if (err)
> +		pr_err("Failed to initialize GIC IRQ controller");
> +
> +	early_acpi_os_unmap_memory((char *)table, tbl_size);
> +}

Maybe this was discussed already but why does this function need to live
under arch/arm64? Isn't the driver code more appropriate?

-- 
Catalin
