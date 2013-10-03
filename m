From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 3 Oct 2013 13:33:52 -0700
Subject: [PATCH 3/3] KVM: ARM: Transparent huge pages and hugetlbfs support
In-Reply-To: <524013BB.4090303@arm.com>
References: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
 <1376021239-10532-4-git-send-email-christoffer.dall@linaro.org>
 <524013BB.4090303@arm.com>
Message-ID: <20131003203352.GE5108@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 11:11:07AM +0100, Marc Zyngier wrote:

[...]

> > 
> > +static bool transparent_hugepage_adjust(pfn_t *pfnp, phys_addr_t *ipap)
> > +{
> > +       pfn_t pfn = *pfnp;
> > +       gfn_t gfn = *ipap >> PAGE_SHIFT;
> > +
> > +       if (PageTransCompound(pfn_to_page(pfn))) {
> > +               unsigned long mask;
> > +               /*
> > +                * mmu_notifier_retry was successful and we hold the
> > +                * mmu_lock here, so the pmd can't become splitting
> > +                * from under us, and in turn
> > +                * __split_huge_page_refcount() can't run from under
> > +                * us and we can safely transfer the refcount from
> > +                * PG_tail to PG_head as we switch the pfn from tail to
> > +                * head.
> > +                */
> 
> -ECANTPARSE. Well, I sort of can, but this deserves a clearer explanation.
> 
> > +               mask = (PMD_SIZE / PAGE_SIZE) - 1;
> 
> 		mask = PTRS_PER_PMD -1;
> 
> > +               VM_BUG_ON((gfn & mask) != (pfn & mask));
> > +               if (pfn & mask) {
> > +                       gfn &= ~mask;
> 
> This doesn't seem to be used later on.
> 
> > +                       *ipap &= ~(PMD_SIZE - 1);
> 
> 			*ipap &= ~PMD_MASK;
> 
damn, I trust you too much, you surely meant
			*ipap &= PMD_MASK;

right?

> > +                       kvm_release_pfn_clean(pfn);
> > +                       pfn &= ~mask;
> > +                       kvm_get_pfn(pfn);
> > +                       *pfnp = pfn;
> > +               }
> 
> 
> 
> > +               return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +

-Christoffer
