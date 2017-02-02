From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 2 Feb 2017 23:55:54 +0900
Subject: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
In-Reply-To: <20170202143535.GM31394@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
 <20170201160354.GF4756@leverpostej>
 <20170202102131.GD13549@linaro.org>
 <20170202114437.GH31394@leverpostej>
 <20170202140102.GA22666@fireball>
 <20170202143535.GM31394@leverpostej>
Message-ID: <20170202145553.GA3238@fireball>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 02:35:35PM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2017 at 11:01:03PM +0900, AKASHI Takahiro wrote:
> > On Thu, Feb 02, 2017 at 11:44:38AM +0000, Mark Rutland wrote:
> > > On Thu, Feb 02, 2017 at 07:21:32PM +0900, AKASHI Takahiro wrote:
> > > > On Wed, Feb 01, 2017 at 04:03:54PM +0000, Mark Rutland wrote:
> > > > > Hi,
> > > > > 
> > > > > On Wed, Feb 01, 2017 at 09:46:23PM +0900, AKASHI Takahiro wrote:
> > > > > > A new function, remove_pgd_mapping(), is added.
> > > > > > It allows us to unmap a specific portion of kernel mapping later as far as
> > > > > > the mapping is made using create_pgd_mapping() and unless we try to free
> > > > > > a sub-set of memory range within a section mapping.
> > > > > 
> > > > > I'm not keen on adding more page table modification code. It was painful
> > > > > enough to ensure that those worked in all configurations.
> > > > > 
> > > > > Why can't we reuse create_pgd_mapping()? If we pass page_mappings_only,
> > > > > and use an invalid prot (i.e. 0), what is the problem?
> > > > 
> > > > As I did in v30?
> > > > (though my implementation in v30 should be improved.)
> > > 
> > > Something like that. I wasn't entirely sure why we needed to change
> > > those functions so much, so I'm clearly missing something there. I'll go
> > > have another look.
> > 
> > I would be much easier if you see my new code.
> 
> Sure. FWIW, I took a look, and I understand why those changes were
> necessary.
> 
> > > > If we don't need to free unused page tables, that would make things
> > > > much simple. There are still some minor problems on the merge, but
> > > > we can sort it out.
> > > 
> > > I'm not sure I follow what you mean by 'on merge' here. Could you
> > > elaborate?
> > 
> > What I had in mind is some changes needed to handle "__prot(0)" properly
> > in alloc_init_pxx(). For example, p[mu]d_set_huge() doesn't make
> > a "zeroed" entry.
> 
> I think that if we only allow ourselves to make PTEs invalid, we don't
> have to handle that case. If we use page_mappings_only, we should only
> check pgattr_change_is_safe() for the pte level, and the {pmd,pud,pgd}
> entries shouldn't change.
> 
> Is the below sufficient to allow that, or have I missed something?

I think it will be OK, but will double-check tomorrow.
However, is is acceptable that create_pgd_mapping( __prot(0) ) can
only handle the cases of page-mapping-only?
That would be fine to kdump, but in general?

-Takahiro AKASHI

> Thanks,
> Mark.
> 
> ---->8----
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 17243e4..05bf7bf 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -105,6 +105,22 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>         return old  == 0 || new  == 0 || ((old ^ new) & ~mask) == 0;
>  }
> 
> +static bool pte_change_is_valid(pte old, pte new)
> +{
> +       /*
> +        * So long as we subsequently perform TLB invalidation, it is safe to
> +        * change a PTE to an invalid, but non-zero value. We only allow this
> +        * for PTEs since there's no complicated allocation/free issues to deal
> +        * with.
> +        *
> +        * Otherwise, the usual attribute change rules apply.
> +        */
> +       if (!pte_valid(old) || !pte_valid(new))
> +               return true;
> +
> +       return pgattr_change_is_safe(pte_val(old), pte_val(new));
> +}
> +
>  static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>                                   unsigned long end, unsigned long pfn,
>                                   pgprot_t prot,
> @@ -143,11 +159,7 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>                 set_pte(pte, pfn_pte(pfn, __prot));
>                 pfn++;
> 
> -               /*
> -                * After the PTE entry has been populated once, we
> -                * only allow updates to the permission attributes.
> -                */
> -               BUG_ON(!pgattr_change_is_safe(pte_val(old_pte), pte_val(*pte)));
> +               BUG_ON(!pte_change_is_valid(old_pte, pte));
> 
>         } while (pte++, addr += PAGE_SIZE, addr != end);
> 
> 
