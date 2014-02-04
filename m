From: msalter@redhat.com (Mark Salter)
Date: Tue, 04 Feb 2014 13:57:24 -0500
Subject: arm64: kernel panic in paging_init()
In-Reply-To: <20140204121452.GI30676@arm.com>
References: <1391460649.13327.51.camel@deneb.redhat.com>
 <20140204121452.GI30676@arm.com>
Message-ID: <1391540244.18760.5.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-04 at 12:14 +0000, Catalin Marinas wrote:
> On Mon, Feb 03, 2014 at 08:50:49PM +0000, Mark Salter wrote:
> > I'm seeing the following panic in paging init. This is on the foundation
> > model with a modified dtb memory node which has a non section-aligned
> > bank:
> > 	memory at 80000000 {
> > 		device_type = "memory";
> > 		reg = <0x00000000 0x80000000 0 0x20000000>,
> > 		      <0x00000000 0xa0300000 0 0x1fd00000>;
> > 	};
> > 
> > I only see this with 64k pagesize configured. What happens is the
> > non section-aligned bank causes alloc_init_pte() to allocate a page
> > for the new pte from the end of the first bank (the failing address
> > 0xfffffe001fff0000 [0x9fff0000 phys]). This should be a valid page
> > since it was mapped during the create_mapping() call for the first
> > memory bank. A flush_tlb_all() added to the end of create_mapping()
> > makes the panic go away so I think the problem is something stale
> > cached before the page with the failing address was mapped.
> 
> I think it goes like this:
> 
> head.S maps enough memory to get started but using 64K pages rather than
> 512M sections with a single pgd entry and several ptes. This never gets
> to the end of the first block (just up to KERNEL_END).
> 
> create_mapping() realises it can do a 512M section mapping, overriding
> the original table pgd entry with a block one. The memblock limit is set
> correctly PGDIR_SIZE but create_mapping, when it replaces the table pgd
> with a block one doesn't do any TLB invalidation.
> 
> So I wouldn't do a TLB invalidation all the time but only when the old
> pmd was set. Please give the patch below a try, I only compiled it (I'll
> add some text afterwards):

Yes, that works. Thanks.

> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index f557ebbe7013..f8dc7e8fce6f 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -203,10 +203,18 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>  	do {
>  		next = pmd_addr_end(addr, end);
>  		/* try section mapping first */
> -		if (((addr | next | phys) & ~SECTION_MASK) == 0)
> +		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
> +			pmd_t old_pmd =*pmd;
>  			set_pmd(pmd, __pmd(phys | prot_sect_kernel));
> -		else
> +			/*
> +			 * Check for previous table entries created during
> +			 * boot (__create_page_tables) and flush them.
> +			 */
> +			if (!pmd_none(old_pmd))
> +				flush_tlb_all();
> +		} else {
>  			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys));
> +		}
>  		phys += next - addr;
>  	} while (pmd++, addr = next, addr != end);
>  }
> 
> 
> Thanks.
> 
