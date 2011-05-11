From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 May 2011 11:40:45 +0100
Subject: [PATCH 20/19] ARM: LPAE: Invalidate the TLB before freeing the PMD
In-Reply-To: <4DCA6593.80403@ru.mvista.com>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1305109399-13156-1-git-send-email-catalin.marinas@arm.com>
	<4DCA6593.80403@ru.mvista.com>
Message-ID: <1305110445.10103.22.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-11 at 11:31 +0100, Sergei Shtylyov wrote:
> > Similar to the PTE freeing, this patch introduced __pmd_free_tlb() which
> > invalidates the TLB before freeing a PMD page. This is needed because on
> > newer processors the entry in the upper page table may be cached by the
> > TLB and point to random data after the PMD has been freed.
> 
> > Signed-off-by: Catalin Marinas<catalin.marinas@arm.com>
> > ---
> 
> > This patch should be part of the LPAE series but I haven't included it in the
> > latest series post.
> 
> >   arch/arm/include/asm/tlb.h |   12 +++++++++++-
> >   1 files changed, 11 insertions(+), 1 deletions(-)
> 
> > diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> > index f9f6ecd..ef72f19 100644
> > --- a/arch/arm/include/asm/tlb.h
> > +++ b/arch/arm/include/asm/tlb.h
> > @@ -181,8 +181,18 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> >       tlb_remove_page(tlb, pte);
> >   }
> >
> > +static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
> > +                               unsigned long addr)
> > +{
> > +#ifdef CONFIG_ARM_LPAE
> > +     tlb_add_flush(tlb, addr);
> > +     tlb_flush(tlb);
> > +     pmd_free((tlb)->mm, pmdp);
> 
>     This is not a macro, so parens around 'tlb' are not needed.

True, just copy/paste error.
> 
> > +#endif
> > +}
> > +
> 
>     Perhaps a better style would be (as SubmittingPatches suggest):
> 
> +#ifdef CONFIG_ARM_LPAE
> +static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
> +                                 unsigned long addr)
> +{
> +       tlb_add_flush(tlb, addr);
> +       tlb_flush(tlb);
> +       pmd_free(tlb->mm, pmdp);
> +}
> +#else
> +static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
> +                                 unsigned long addr) {}
> +#endif
> +
> 
> WBR, Sergei

No real preference here though smaller number of lines changed in my
initial patch.

Thanks.

-- 
Catalin
