From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 26 Aug 2015 16:35:18 +0100
Subject: [PATCH v2 5/5] arm64/efi: ignore DT memreserve entries instead
 of removing them
In-Reply-To: <1440576391-25725-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1440576391-25725-1-git-send-email-ard.biesheuvel@linaro.org>
 <1440576391-25725-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150826153518.GE10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 10:06:31AM +0200, Ard Biesheuvel wrote:
> Now that the reservation of the FDT image itself is split off, we
> can make the DT scanning of memreserves conditional on whether we
> booted via UEFI and have its memory map available. This allows us
> to drop deletion of these memreserves in the stub. It also fixes
> the issue where the /reserved-memory/ node (which offers another
> way of reserving memory ranges) was not being ignored under UEFI.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/mm/init.c               |  3 ++-
>  drivers/firmware/efi/libstub/fdt.c | 11 +----------
>  2 files changed, 3 insertions(+), 11 deletions(-)

Acked-by: Leif Lindholm <leif.lindholm@linaro.org>

And possibly a reference to 0ceac9e094b0?

As it is a bugfix, it would be nice to see this one go into 4.3, but...

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index ecbc051bc66b..0c33670ed1b6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -170,7 +170,8 @@ void __init arm64_memblock_init(void)
>  		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
>  #endif
>  
> -	early_init_fdt_scan_reserved_mem();
> +	if (!efi_enabled(EFI_MEMMAP))
> +		early_init_fdt_scan_reserved_mem();
>  
>  	/* 4GB maximum for 32-bit only capable devices */
>  	if (IS_ENABLED(CONFIG_ZONE_DMA))
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 343e7992bd8f..a7e87cd582f2 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -24,8 +24,7 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
>  			unsigned long map_size, unsigned long desc_size,
>  			u32 desc_ver)
>  {
> -	int node, num_rsv;
> -	int status;
> +	int node, status;
>  	u32 fdt_val32;
>  	u64 fdt_val64;
>  
> @@ -53,14 +52,6 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
>  	if (status != 0)
>  		goto fdt_set_fail;
>  
> -	/*
> -	 * Delete all memory reserve map entries. When booting via UEFI,
> -	 * kernel will use the UEFI memory map to find reserved regions.
> -	 */
> -	num_rsv = fdt_num_mem_rsv(fdt);
> -	while (num_rsv-- > 0)
> -		fdt_del_mem_rsv(fdt, num_rsv);
> -
>  	node = fdt_subnode_offset(fdt, 0, "chosen");
>  	if (node < 0) {
>  		node = fdt_add_subnode(fdt, 0, "chosen");
> -- 
> 1.9.1
> 
