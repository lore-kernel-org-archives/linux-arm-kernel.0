From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 May 2016 18:14:25 +0100
Subject: [PATCH v2 5/5] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <1463674518-22477-6-git-send-email-aleksey.makarov@linaro.org>
References: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
 <1463674518-22477-6-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <20160527171424.GG10909@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 07:15:16PM +0300, Aleksey Makarov wrote:
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index aee323b..d75f6c7 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -113,4 +113,6 @@ static inline const char *acpi_get_enable_method(int cpu)
>  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
>  #endif
>  
> +#define ACPI_TABLE_UPGRADE_MAX_PHYS PFN_PHYS(max_pfn)
> +
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index feab2ee..4bce811 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -261,11 +261,13 @@ void __init setup_arch(char **cmdline_p)
>  	efi_init();
>  	arm64_memblock_init();
>  
> +	paging_init();
> +
> +	acpi_table_upgrade();
> +
>  	/* Parse the ACPI tables for possible boot-time configuration */
>  	acpi_boot_table_init();
>  
> -	paging_init();
> -
>  	if (acpi_disabled)
>  		unflatten_device_tree();

So ACPI_TABLE_UPGRADE_MAX_PHYS is defined in terms of max_pfn and
presumably used by acpi_table_upgrade(). max_pfn is only initialised in
the arm64 bootmem_init() called just below the last line of context in
the hunk above.

-- 
Catalin
