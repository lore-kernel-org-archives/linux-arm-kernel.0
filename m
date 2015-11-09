From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 9 Nov 2015 17:35:19 +0100
Subject: [PATCH] ARM/arm64: KVM: test properly for a PTE's uncachedness
In-Reply-To: <CAKv+Gu9RkX1A4rLvTbgkhTQxcVnLjc1tHRaMAOq0cgcpGvkpRg@mail.gmail.com>
References: <1446810188-13727-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151109162159.GA12968@cbox>
 <CAKv+Gu9RkX1A4rLvTbgkhTQxcVnLjc1tHRaMAOq0cgcpGvkpRg@mail.gmail.com>
Message-ID: <20151109163519.GB12968@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 05:27:40PM +0100, Ard Biesheuvel wrote:
> On 9 November 2015 at 17:21, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > On Fri, Nov 06, 2015 at 12:43:08PM +0100, Ard Biesheuvel wrote:
> >> The open coded tests for checking whether a PTE maps a page as
> >> uncached use a flawed 'pte_val(xxx) & CONST != CONST' pattern,
> >> which is not guaranteed to work since the type of a mapping is an
> >> index into the MAIR table, not a set of mutually exclusive bits.
> >>
> >> Considering that, on arm64, the S2 type definitions use the following
> >> MAIR indexes
> >>
> >>     #define MT_S2_NORMAL            0xf
> >>     #define MT_S2_DEVICE_nGnRE      0x1
> >>
> >> we have been getting lucky merely because the S2 device mappings also
> >> have the PTE_UXN bit set, which means that a device PTE still does not
> >> equal a normal PTE after masking with the former type.
> >>
> >> Instead, implement proper checking against the MAIR indexes that are
> >> known to define uncached memory attributes.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm/include/asm/kvm_mmu.h   | 11 +++++++++++
> >>  arch/arm/kvm/mmu.c               |  5 ++---
> >>  arch/arm64/include/asm/kvm_mmu.h | 12 ++++++++++++
> >>  3 files changed, 25 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> >> index 405aa1883307..422973835d41 100644
> >> --- a/arch/arm/include/asm/kvm_mmu.h
> >> +++ b/arch/arm/include/asm/kvm_mmu.h
> >> @@ -279,6 +279,17 @@ static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
> >>                                      pgd_t *merged_hyp_pgd,
> >>                                      unsigned long hyp_idmap_start) { }
> >>
> >> +static inline bool __kvm_pte_is_uncached(pte_t pte)
> >> +{
> >> +     switch (pte_val(pte) & L_PTE_MT_MASK) {
> >> +     case L_PTE_MT_UNCACHED:
> >> +     case L_PTE_MT_BUFFERABLE:
> >> +     case L_PTE_MT_DEV_SHARED:
> >> +             return true;
> >> +     }
> >
> > so PTEs created by setting PAGE_S2_DEVICE will end up hitting in one of
> > these because L_PTE_S2_MT_DEV_SHARED is the same as L_PTE_MT_BUFFERABLE
> > for stage-2 mappings and PAGE_HYP_DEVICE end up using
> > L_PTE_MT_DEV_SHARED.
> >
> > Totally obvious.
> >
> 
> Hmm, perhaps not. Would you prefer all aliases of the L_PTE_MT_xx
> constants that map to device permissions to be listed here?
> 

Meh, there's no great solution and this code is all the kind of code
that you just need to take the time to understand.  We could add a
comment I suppose, if I got the above correct, I can throw something in?

-Christoffer
