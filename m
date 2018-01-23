From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Jan 2018 10:04:47 +0000
Subject: [PATCH v3 11/20] arm64: mm: Map entry trampoline into trampoline
 and kernel page tables
In-Reply-To: <ca66f10b-50b6-b876-3dac-4ecd981903cf@huawei.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <1512563739-25239-12-git-send-email-will.deacon@arm.com>
 <ca66f10b-50b6-b876-3dac-4ecd981903cf@huawei.com>
Message-ID: <20180123100447.GB1686@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 04:28:45PM +0800, Yisheng Xie wrote:
> On 2017/12/6 20:35, Will Deacon wrote:
> > +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> > +static int __init map_entry_trampoline(void)
> > +{
> > +	extern char __entry_tramp_text_start[];
> > +
> > +	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> > +	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
> > +
> > +	/* The trampoline is always mapped and can therefore be global */
> > +	pgprot_val(prot) &= ~PTE_NG;
> > +
> > +	/* Map only the text into the trampoline page table */
> > +	memset(tramp_pg_dir, 0, PGD_SIZE);
> > +	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
> > +			     prot, pgd_pgtable_alloc, 0);
> 
> How the tramp_pg_dir is used, should it be set to ttbr1 when exit kernel? Sorry
> for I do not find where it is used.

Yes, that's what happens when we return to userspace. The code is a little
convoluted, but the tramp_pg_dir is placed at a fixed offset from swapper
(see the linker script) so the sub instruction in tramp_unmap_kernel is what
gives us the ttbr1 value we need.

Will
