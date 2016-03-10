From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Mar 2016 18:39:51 +0000
Subject: [PATCH] arm64: Fix the ptep_set_wrprotect() to set PTE_DIRTY if
 (PTE_DBM && !PTE_RDONLY)
In-Reply-To: <CAFpQJXVy-FafeU+Uq40_27ZauDN6ziYtGugUBiWJ8eHGOwkCfQ@mail.gmail.com>
References: <1457499768-31176-1-git-send-email-gkulkarni@caviumnetworks.com>
 <20160309100605.GJ6192@e104818-lin.cambridge.arm.com>
 <CAFpQJXUaXYkVNCc1OjLxCmpKu6b26LOaMv0V9XYRn7pLAGk2SQ@mail.gmail.com>
 <20160309160352.GM6192@e104818-lin.cambridge.arm.com>
 <CAFpQJXVkjgpTaftiA7uK-GknoZXP+fP0pTX1ajZk6wfjovDwCw@mail.gmail.com>
 <CAFpQJXVy-FafeU+Uq40_27ZauDN6ziYtGugUBiWJ8eHGOwkCfQ@mail.gmail.com>
Message-ID: <20160310183951.GA2804@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 08:34:46AM +0530, Ganapatrao Kulkarni wrote:
> > On Wed, Mar 9, 2016 at 9:33 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index 7c73b365fcfa..b409a983f870 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -201,7 +201,7 @@ extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
> >>  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >>                               pte_t *ptep, pte_t pte)
> >>  {
> >> -       if (pte_valid(pte)) {
> >> +       if (pte_present(pte)) {
> >>                 if (pte_sw_dirty(pte) && pte_write(pte))
> >>                         pte_val(pte) &= ~PTE_RDONLY;
> >>                 else
>
> this diff works for me.
> 
> Tested-by: Ganapatrao Kulkarni <gkulkarni@cavium.com>

Thanks. I'll push it out during the merging window and cc stable (though
it needs a slightly different workaround for 4.4 anyway).

-- 
Catalin
