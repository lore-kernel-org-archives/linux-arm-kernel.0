From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Tue, 23 Jan 2018 16:28:45 +0800
Subject: [PATCH v3 11/20] arm64: mm: Map entry trampoline into trampoline
 and kernel page tables
In-Reply-To: <1512563739-25239-12-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <1512563739-25239-12-git-send-email-will.deacon@arm.com>
Message-ID: <ca66f10b-50b6-b876-3dac-4ecd981903cf@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2017/12/6 20:35, Will Deacon wrote:
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
> +	memset(tramp_pg_dir, 0, PGD_SIZE);
> +	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
> +			     prot, pgd_pgtable_alloc, 0);

How the tramp_pg_dir is used, should it be set to ttbr1 when exit kernel? Sorry
for I do not find where it is used.

Thanks
Yisheng

> +
> +	/* ...as well as the kernel page table */
> +	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
> +	return 0;
> +}
> +core_initcall(map_entry_trampoline);
> +#endif
> +
>  /*
>   * Create fine-grained mappings for the kernel.
>   */
> 
