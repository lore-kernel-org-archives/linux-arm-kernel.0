From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 6 Jun 2014 17:59:39 +0200
Subject: [PATCH v3] arm/arm64: KVM: Fix and refactor unmap_range
In-Reply-To: <CAPvkgC2s+itzV5H+444Qhz_XfWVgWC1NU=tSugaxZWimOW5uyA@mail.gmail.com>
References: <1401894943-11213-1-git-send-email-christoffer.dall@linaro.org>
 <CAPvkgC2s+itzV5H+444Qhz_XfWVgWC1NU=tSugaxZWimOW5uyA@mail.gmail.com>
Message-ID: <20140606155939.GA33621@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 10:28:59AM +0100, Steve Capper wrote:
> Hi Christoffer,
> 
> On 4 June 2014 16:15, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > unmap_range() was utterly broken, to quote Marc, and broke in all sorts
> > of situations.  It was also quite complicated to follow and didn't
> > follow the usual scheme of having a separate iterating function for each
> > level of page tables.
> >
> > Address this by refactoring the code and introduce a pgd_clear()
> > function.
> >
> > Tested on TC2 with/without THP and limited testing on the v8 Foundation
> > Model.
> >
> > Reviewed-by: Jungseok Lee <jays.lee@samsung.com>
> > Reviewed-by: Mario Smarduch <m.smarduch@samsung.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> 
> This looks good to me.
> 
> Reviewed-by: Steve Capper <steve.capper@linaro.org>
> 

thanks.

> One minor comment below (sorry just spotted this now)...
> 
> [ ... ]
> 
> > -static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
> > +static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
> > +                      phys_addr_t addr, phys_addr_t end)
> >  {
> > -       if (pte_present(*pte)) {
> > -               kvm_set_pte(pte, __pte(0));
> > -               put_page(virt_to_page(pte));
> > -               kvm_tlb_flush_vmid_ipa(kvm, addr);
> > -       }
> > +       pte_t *pte, *start_pte;
> > +       unsigned long long start_addr = addr;
> > +
> > +       start_pte = pte = pte_offset_kernel(pmd, addr);
> > +       do {
> > +               if (!pte_none(*pte)) {
> > +                       kvm_set_pte(pte, __pte(0));
> > +                       put_page(virt_to_page(pte));
> > +                       kvm_tlb_flush_vmid_ipa(kvm, addr);
> 
> Can this hyp call be expensive if a lot of ptes are being unmapped
> (for 64K pages we can have 8192 ptes per page)?
> If so, can they be batched together?
> 
I suppose we could, we would have to add something to flush the entire
TLB for that VMID on aarch64 (or that entire range) to do so.

I think it's reasonable to merge this now and apply that as an
optimization.  Marc?

-Christoffer
