From: msalter@redhat.com (Mark Salter)
Date: Thu, 08 Jan 2015 08:53:13 -0500
Subject: [PATCH] arm64/efi: add missing call to early_ioremap_reset()
In-Reply-To: <1420710898-32298-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1420710898-32298-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1420725193.16211.68.camel@t520.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-01-08 at 09:54 +0000, Ard Biesheuvel wrote:
> The early ioremap support introduced by patch bf4b558eba92
> ("arm64: add early_ioremap support") failed to add a call to
> early_ioremap_reset() at an appropriate time. Without this call,
> invocations of early_ioremap etc. that are done too late will go
> unnoticed and may cause corruption.
> 
> This is exactly what happened when the first user of this feature
> was added in patch f84d02755f5a ("arm64: add EFI runtime services").
> The early mapping of the EFI memory map is unmapped during an early
> initcall, at which time the early ioremap support is long gone.
> 
> Fix by adding the missing call to early_ioremap_reset() to
> setup_arch(), and move the offending early_memunmap() to right after
> the point where the early mapping of the EFI memory map is last used.
> 
> Fixes: f84d02755f5a ("arm64: add EFI runtime services")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

Acked-by: Mark Salter <msalter@redhat.com>

> 
> After discussing off-list between Mark Salter, Leif and myself, this is the
> bare minimum to fix the early ioremap issue in kernels up to 3.19, combined
> into a single patch. Considering that the early_ioremap support was added in
> 3.15 (eol), but not used until EFI runtime services support was added in 3.16,
> there is no reason to split this up. Also, we have work underway to drastically
> change the way runtime services etc are mapped during early boot [which we hope
> will make it into 3.20] so it makes sense to do the bare minimum here and handle
> any fallout in terms of style etc later.
> 
>  arch/arm64/kernel/efi.c   | 2 +-
>  arch/arm64/kernel/setup.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 6fac253bc783..2bb4347d0edf 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -326,6 +326,7 @@ void __init efi_idmap_init(void)
>  
>  	/* boot time idmap_pg_dir is incomplete, so fill in missing parts */
>  	efi_setup_idmap();
> +	early_memunmap(memmap.map, memmap.map_end - memmap.map);
>  }
>  
>  static int __init remap_region(efi_memory_desc_t *md, void **new)
> @@ -380,7 +381,6 @@ static int __init arm64_enter_virtual_mode(void)
>  	}
>  
>  	mapsize = memmap.map_end - memmap.map;
> -	early_memunmap(memmap.map, mapsize);
>  
>  	if (efi_runtime_disabled()) {
>  		pr_info("EFI runtime services will be disabled.\n");
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index b80991166754..20fe2932ad0c 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -402,6 +402,7 @@ void __init setup_arch(char **cmdline_p)
>  	request_standard_resources();
>  
>  	efi_idmap_init();
> +	early_ioremap_reset();
>  
>  	unflatten_device_tree();
>  
