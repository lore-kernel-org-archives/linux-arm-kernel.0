From: bp@alien8.de (Borislav Petkov)
Date: Mon, 5 Jan 2015 22:56:49 +0100
Subject: [PATCH v4 3/8] efi: split off remapping code from
 efi_config_init()
In-Reply-To: <1419245944-2424-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1419245944-2424-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419245944-2424-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150105215649.GI19655@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 10:58:59AM +0000, Ard Biesheuvel wrote:
> Split of the remapping code from efi_config_init() so that the caller
> can perform its own remapping. This is necessary to correctly handle
> virtually remapped UEFI memory regions under kexec, as efi.systab will
> have been updated to a virtual address.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

...

> @@ -344,13 +333,37 @@ int __init efi_config_init(efi_config_table_type_t *arch_tables)
>  		tablep += sz;
>  	}
>  	pr_cont("\n");
> -	early_memunmap(config_tables, efi.systab->nr_tables * sz);
> -
>  	set_bit(EFI_CONFIG_TABLES, &efi.flags);
> -
>  	return 0;
>  }
>  
> +int __init efi_config_init(efi_config_table_type_t *arch_tables)
> +{
> +	void *config_tables;
> +	int sz, ret;
> +
> +	if (efi_enabled(EFI_64BIT))
> +		sz = sizeof(efi_config_table_64_t);
> +	else
> +		sz = sizeof(efi_config_table_32_t);
> +
> +	/*
> +	 * Let's see what config tables the firmware passed to us.
> +	 */
> +	config_tables = early_memremap(efi.systab->tables,
> +				       efi.systab->nr_tables * sz);
> +	if (config_tables == NULL) {
> +		pr_err("Could not map Configuration table!\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = efi_config_parse_tables(config_tables, efi.systab->nr_tables,
> +				      arch_tables);

Just a nitpick:

You could hand down @sz to this function so that you don't have to
compute it again in efi_config_parse_tables().

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
