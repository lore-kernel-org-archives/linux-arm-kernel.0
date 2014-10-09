From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Oct 2014 14:36:26 +0100
Subject: [PATCH v2 1/3] arm64: KVM: Implement 48 VA support for KVM EL2
 and Stage-2
In-Reply-To: <20141009110137.GX3717@cbox>
References: <1412627427-28629-1-git-send-email-christoffer.dall@linaro.org>
 <1412627427-28629-2-git-send-email-christoffer.dall@linaro.org>
 <20141007104846.GB12675@e104818-lin.cambridge.arm.com>
 <5433EA8B.6010502@arm.com> <20141007193954.GI3717@cbox>
 <20141008094703.GB5906@e104818-lin.cambridge.arm.com>
 <20141009110137.GX3717@cbox>
Message-ID: <20141009133625.GH17836@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 12:01:37PM +0100, Christoffer Dall wrote:
> On Wed, Oct 08, 2014 at 10:47:04AM +0100, Catalin Marinas wrote:
> > On Tue, Oct 07, 2014 at 08:39:54PM +0100, Christoffer Dall wrote:
> > > +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> > > +{
> > > +       pud_t *pud;
> > > +       pmd_t *pmd;
> > > +       unsigned int order, i;
> > > +       unsigned long hwpgd;
> > > +
> > > +       if (KVM_PREALLOC_LEVEL == 0)
> > > +               return 0;
> > > +
> > > +       order = get_order(PTRS_PER_S2_PGD);
> > 
> > Isn't order always 0 here? Based on our IRC discussion, PTRS_PER_S2_PGD
> > is 16 or less and the order should not be used.
> 
> no, if the kernel has 4K pages and 4 levels, then PGDIR_SHIFT is 39, and
> KVM_PHYS_SHIFT stays 40, so that means PTRS_PER_S2_PGD becomes 2, which
> means we concatenate two first level stage-2 page tables, which means we
> need to allocate two consecutive pages, giving us an order of 1, not 0.

So if PTRS_PER_S2_PGD is 2, how come get_order(PTRS_PER_S2_PGD) == 1? My
reading of the get_order() macro is that get_order(2) == 0.

Did you mean get_order(PTRS_PER_S2_PGD * PAGE_SIZE)?

Or you could define a PTRS_PER_S2_PGD_SHIFT as (KVM_PHYS_SHIFT -
PGDIR_SHIFT) and use this as the order directly.

> > > +       hwpgd = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > 
> > I assume you need __get_free_pages() for alignment.
> 
> yes, would you prefer a comment to that fact?

No, that's fine.

-- 
Catalin
