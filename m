From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 18:48:21 +0000
Subject: [PATCH v2 04/12] arm64/efi: split off EFI init and runtime code
 for reuse by 32-bit ARM
In-Reply-To: <1447698757-8762-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151116184821.GC8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 07:32:29PM +0100, Ard Biesheuvel wrote:
> +/*
> + * Enable the UEFI Runtime Services if all prerequisites are in place, i.e.,
> + * non-early mapping of the UEFI system table and virtual mappings for all
> + * EFI_MEMORY_RUNTIME regions.
> + */
> +static int __init arm64_enable_runtime_services(void)
> +{
> +	u64 mapsize;
> +
> +	if (!efi_enabled(EFI_BOOT)) {
> +		pr_info("EFI services will not be available.\n");
> +		return -1;
> +	}
> +
> +	if (efi_runtime_disabled()) {
> +		pr_info("EFI runtime services will be disabled.\n");
> +		return -1;
> +	}
> +
> +	pr_info("Remapping and enabling EFI services.\n");
> +
> +	mapsize = memmap.map_end - memmap.map;
> +	memmap.map = (__force void *)ioremap_cache(memmap.phys_map,
> +						   mapsize);
> +	if (!memmap.map) {
> +		pr_err("Failed to remap EFI memory map\n");
> +		return -1;
> +	}
> +	memmap.map_end = memmap.map + mapsize;
> +	efi.memmap = &memmap;
> +
> +	efi.systab = (__force void *)ioremap_cache(efi_system_table,
> +						   sizeof(efi_system_table_t));
> +	if (!efi.systab) {
> +		pr_err("Failed to remap EFI System Table\n");
> +		return -1;
> +	}
> +	set_bit(EFI_SYSTEM_TABLES, &efi.flags);
> +
> +	if (!efi_virtmap_init()) {
> +		pr_err("No UEFI virtual mapping was installed -- runtime services will not be available\n");
> +		return -1;
> +	}
> +
> +	/* Set up runtime services function pointers */
> +	efi_native_runtime_setup();
> +	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> +
> +	efi.runtime_version = efi.systab->hdr.revision;
> +
> +	return 0;
> +}
> +early_initcall(arm64_enable_runtime_services);

The above ought to be fixed - initcalls return negative errno numbers,
so returning -1 from them is really not acceptable.  (The original code
was doing the same - so it should be fixed as a separate patch.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
