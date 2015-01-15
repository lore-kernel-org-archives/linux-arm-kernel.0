From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Jan 2015 16:40:11 +0000
Subject: [PATCH] arm64/efi: handle potential failure to remap memory map
In-Reply-To: <1421323266-30973-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1421323266-30973-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150115164010.GK16217@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 12:01:06PM +0000, Ard Biesheuvel wrote:
> When remapping the UEFI memory map using ioremap_cache(), we
> have to deal with potential failure. Note that, even if the
> common case is for ioremap_cache() to return the existing linear
> mapping of the memory map, we cannot rely on that to be always the
> case, e.g., in the presence of a mem= kernel parameter.
> 
> At the same time, remove a stale comment and move the memmap code
> together.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

This should probably be picked up before my mem= patch, which I will be
resending shortly. I'll mention that when posting.

I guess Catalin should pick this up given the other portions are in the
arm64 tree, and this falls under arch/arm64.

Thanks,
Mark.

> ---
>  arch/arm64/kernel/efi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index a98415b5979c..c9cb0fbe7aa4 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -229,19 +229,21 @@ static int __init arm64_enable_runtime_services(void)
>  		return -1;
>  	}
>  
> -	mapsize = memmap.map_end - memmap.map;
> -
>  	if (efi_runtime_disabled()) {
>  		pr_info("EFI runtime services will be disabled.\n");
>  		return -1;
>  	}
>  
>  	pr_info("Remapping and enabling EFI services.\n");
> -	/* replace early memmap mapping with permanent mapping */
> +
> +	mapsize = memmap.map_end - memmap.map;
>  	memmap.map = (__force void *)ioremap_cache((phys_addr_t)memmap.phys_map,
>  						   mapsize);
> +	if (!memmap.map) {
> +		pr_err("Failed to remap EFI memory map\n");
> +		return -1;
> +	}
>  	memmap.map_end = memmap.map + mapsize;
> -
>  	efi.memmap = &memmap;
>  
>  	efi.systab = (__force void *)ioremap_cache(efi_system_table,
> -- 
> 1.8.3.2
> 
> 
