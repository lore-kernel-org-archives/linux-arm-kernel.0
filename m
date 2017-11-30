From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Nov 2017 18:29:56 +0000
Subject: [PATCH v2 11/18] arm64: mm: Map entry trampoline into trampoline
 and kernel page tables
In-Reply-To: <1512059986-21325-12-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-12-git-send-email-will.deacon@arm.com>
Message-ID: <20171130182956.uwc63g6i6yobxcqy@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Nov 30, 2017 at 04:39:39PM +0000, Will Deacon wrote:
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 4052ec39e8db..8119b49be98d 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -58,6 +58,10 @@ enum fixed_addresses {
>  	FIX_APEI_GHES_NMI,
>  #endif /* CONFIG_ACPI_APEI_GHES */
>  
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +	FIX_ENTRY_TRAMP_TEXT,
> +#define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
> +#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  	__end_of_permanent_fixed_addresses,

Defining TRAMP_VALIAS here is a little surprising, especially given we
reuse the name in asm-offsets:

> +  DEFINE(TRAMP_VALIAS,		TRAMP_VALIAS);

Can't we have asm-offsets do:

  DEFINE(TRAMP_VALIAS, __fix_to_virt(FIX_ENTRY_TRAMP_TEXT));

... and rely on the asm-offsets TRAMP_VALIAS definition everywhere?

[...]

> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +static int __init map_entry_trampoline(void)
> +{
> +	extern char __entry_tramp_text_start[];
> +
> +	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> +	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
> +
> +	/* The trampoline is always mapped and can therefore be global */
> +	pgprot_val(prot) &= ~PTE_NG;
> +
> +	/* Map only the text into the trampoline page table */
> +	memset((char *)tramp_pg_dir, 0, PGD_SIZE);

The (char *) cast can go; memset() takes a void pointer and we don't do
similar casts for other memset instances.

> +	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
> +			     prot, pgd_pgtable_alloc, 0);
> +
> +	/* ...as well as the kernel page table */

This might be clearer as:

	/* map the text in the kernel page table, too */

Otherwise, this looks good to me.

Thanks,
Mark.
