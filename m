From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Jan 2015 11:42:55 +0000
Subject: [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
 and pass acpi=force to enable ACPI
In-Reply-To: <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150119114255.GF11835@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 03:04:52PM +0000, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Introduce one early parameters "off" and "force" for "acpi", acpi=off
> will be the default behavior for ARM64, so introduce acpi=force to
> enable ACPI on ARM64.
> 
> Disable ACPI before early parameters parsed, and enable it to pass
> "acpi=force" if people want use ACPI on ARM64. This ensures DT be
> the prefer one if ACPI table and DT both are provided at this moment.
[...]
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -62,6 +62,7 @@
>  #include <asm/memblock.h>
>  #include <asm/psci.h>
>  #include <asm/efi.h>
> +#include <asm/acpi.h>
>  
>  unsigned int processor_id;
>  EXPORT_SYMBOL(processor_id);
> @@ -388,6 +389,8 @@ void __init setup_arch(char **cmdline_p)
>  	early_fixmap_init();
>  	early_ioremap_init();
>  
> +	disable_acpi();
> +
>  	parse_early_param();
>  
>  	/*

Did we get to any conclusion here? DT being the preferred one is fine
when both DT and ACPI are present but do we still want the kernel to
ignore ACPI altogether if DT is not present? It's a bit harder to detect
the presence of DT at this point since the EFI_STUB added one already. I
guess we could move the "acpi=force" argument passing to EFI_STUB if no
DT is present at boot.

-- 
Catalin
