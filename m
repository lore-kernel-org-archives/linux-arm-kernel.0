From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Apr 2015 12:49:12 +0100
Subject: [PATCH v3 2/5] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <1426698308-726-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1426698308-726-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426698308-726-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150409114911.GB18488@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

This looks good to me (with some minor comments below).

As a heads-up, this clashes with other changes in the arm64
for-next/core branch due to some unrelated changes in head.S and
setup.c.

> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index f3c05b5f9f08..ab5a90adece3 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -45,11 +45,13 @@ sees fit.)
>  
>  Requirement: MANDATORY
>  
> -The device tree blob (dtb) must be placed on an 8-byte boundary within
> -the first 512 megabytes from the start of the kernel image and must not
> -cross a 2-megabyte boundary. This is to allow the kernel to map the
> -blob using a single section mapping in the initial page tables.
> +The device tree blob (dtb) must be placed on an 8-byte boundary and must
> +not cross a 2-megabyte boundary. This is to allow the kernel to map the
> +blob using a single section mapping in the fixmap region.

Please drop the mention of the fixmap. If we ever move this out of the
fixmap I don't want to have to update booting.txt again, and it
shouldn't matter to bootloader authors either way.

> +NOTE: versions prior to v4.1 require, in addition to the requirements
> +listed above, that the dtb be placed above the kernel Image inside the
> +same naturally aligned 512 MB region.

Minor nit: This would read a little better if we just said "versions
prior to v4.1 also require that ...", dropping "in addition to the
requirements listed above".

[...]

>  enum fixed_addresses {
>  	FIX_HOLE,
> +
> +	/*
> +	 * Reserve 2 MB of virtual space for the FDT at the top of the fixmap
> +	 * region. Keep this at the top so it remains 2 MB aligned.
> +	 */
> +#define FIX_FDT_SIZE		SZ_2M
> +	FIX_FDT_END,
> +	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
> +
>  	FIX_EARLYCON_MEM_BASE,
>  	FIX_TEXT_POKE0,
>  	__end_of_permanent_fixed_addresses,

[...]

> +static void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
> +{
> +	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
> +	phys_addr_t dt_phys_base = dt_phys & ~(FIX_FDT_SIZE - 1);
> +
> +	/*
> +	 * Make sure that the FDT region can be mapped without the need to
> +	 * allocate additional translation table pages, so that it is safe
> +	 * to call create_pgd_mapping() this early.
> +	 * On 4k pages, we'll use section mappings for the region so we
> +	 * only have to be in the same PUD as the rest of the fixmap.
> +	 * On 64k pages, we need to be in the same PMD as well, as the region
> +	 * will be mapped using PTEs.
> +	 */
> +	BUILD_BUG_ON(dt_virt_base & (SZ_2M - 1));

s/SZ_2M/FIX_FDT_SIZE/

Perhaps we should also have:

BUILD_BUG_ON_NOT_POWER_OF_2(FIX_FDT_SIZE);

... given it's necessary for the address masking we do here.

[...]

> +	/*
> +	 * Before passing the dt_virt pointer to early_init_dt_scan(), we have
> +	 * to ensure that the FDT size as reported in the FDT itself does not
> +	 * exceed the 2 MB window we just mapped for it.
> +	 */
> +	if (!dt_virt ||
> +	    fdt_check_header(dt_virt) != 0 ||
> +	    (dt_phys & (SZ_2M - 1)) + fdt_totalsize(dt_virt) > SZ_2M ||
> +	    !early_init_dt_scan(dt_virt)) {
> +		pr_crit("\n"
> +			"Error: invalid device tree blob at physical address %pa (virtual address 0x%p)\n"
> +			"The dtb must be 8-byte aligned and must not cross a 2 MB alignment boundary\n"
>  			"\nPlease check your bootloader.\n",
> -			dt_phys, phys_to_virt(dt_phys));
> +			&dt_phys, dt_virt);

Nit: drop the leading '\n' on the last line. There's no need for it.

I've tested this on my Juno (atop of arm64 for-next/core), and all seems
well, so with those points addressed:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
