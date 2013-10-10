From: anup@brainfault.org (Anup Patel)
Date: Thu, 10 Oct 2013 10:21:07 +0530
Subject: [RFC PATCH] arm64: KVM: honor cacheability attributes on S2 page
 fault
In-Reply-To: <20130911193855.GN9860@cbox>
References: <1378806670-2467-1-git-send-email-marc.zyngier@arm.com>
 <CAAhSdy2E6aRndw88_S_3wfyTOYd5rQQTc4+Cw5Hd1DFXuM6EBA@mail.gmail.com>
 <523063AC.8040803@arm.com> <20130911193855.GN9860@cbox>
Message-ID: <CAAhSdy0EZpzGOpVFOo-GWPs97XLHB8_uTZ7BTu0gP958y8JPeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 1:08 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Wed, Sep 11, 2013 at 01:35:56PM +0100, Marc Zyngier wrote:
>> On 11/09/13 13:21, Anup Patel wrote:
>> > On Tue, Sep 10, 2013 at 3:21 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> >> Anup Patel recently brought up the fact that when we run a guest
>> >> with cache disabled, we don't flush the cache to the Point of
>> >> Coherency, hence possibly missing bits of data that have been
>> >> written in the cache, but have not reached memory.
>> >>
>> >> There are several approaches to this issue:
>> >> - Using the DC bit when caches are off: this breaks guests assuming
>> >>   caches off while doing DMA operations. Bootloaders, for example.
>> >> - Fetch the memory attributes on translation fault, and flush the
>> >>   cache while handling the fault. This relies on using the PAR_EL1
>> >>   register to obtain the Stage-1 memory attributes.
>> >>
>> >> While this second solution is clearly not ideal (it duplicates what
>> >> the HW already does to generate HPFAR_EL2), it is more correct than
>> >> not doing anything.
>> >>
>> >> Cc: Anup Patel <anup@brainfault.org>
>> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> >> ---
>> >>
>> >>  arch/arm/include/asm/kvm_mmu.h    |  4 ++--
>> >>  arch/arm/kvm/mmu.c                |  2 +-
>> >>  arch/arm64/include/asm/kvm_host.h |  1 +
>> >>  arch/arm64/include/asm/kvm_mmu.h  |  9 +++++++--
>> >>  arch/arm64/kernel/asm-offsets.c   |  1 +
>> >>  arch/arm64/kvm/hyp.S              | 28 ++++++++++++----------------
>> >>  6 files changed, 24 insertions(+), 21 deletions(-)
>> >>
>> >> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> >> index 472ac70..faffdf0 100644
>> >> --- a/arch/arm/include/asm/kvm_mmu.h
>> >> +++ b/arch/arm/include/asm/kvm_mmu.h
>> >> @@ -105,7 +105,7 @@ static inline void kvm_set_s2pte_writable(pte_t *pte)
>> >>
>> >>  struct kvm;
>> >>
>> >> -static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>> >> +static inline void coherent_icache_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn)
>> >>  {
>> >>         /*
>> >>          * If we are going to insert an instruction page and the icache is
>> >> @@ -120,7 +120,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>> >>          * need any kind of flushing (DDI 0406C.b - Page B3-1392).
>> >>          */
>> >>         if (icache_is_pipt()) {
>> >> -               unsigned long hva = gfn_to_hva(kvm, gfn);
>> >> +               unsigned long hva = gfn_to_hva(vcpu->kvm, gfn);
>> >>                 __cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
>> >>         } else if (!icache_is_vivt_asid_tagged()) {
>> >>                 /* any kind of VIPT cache */
>> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> >> index 0988d9e..ffb3cc4 100644
>> >> --- a/arch/arm/kvm/mmu.c
>> >> +++ b/arch/arm/kvm/mmu.c
>> >> @@ -547,7 +547,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>> >>                 return -EFAULT;
>> >>
>> >>         new_pte = pfn_pte(pfn, PAGE_S2);
>> >> -       coherent_icache_guest_page(vcpu->kvm, gfn);
>> >> +       coherent_icache_guest_page(vcpu, gfn);
>> >>
>> >>         spin_lock(&vcpu->kvm->mmu_lock);
>> >>         if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
>> >> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> >> index 331a852..2530f92 100644
>> >> --- a/arch/arm64/include/asm/kvm_host.h
>> >> +++ b/arch/arm64/include/asm/kvm_host.h
>> >> @@ -79,6 +79,7 @@ struct kvm_mmu_memory_cache {
>> >>  struct kvm_vcpu_fault_info {
>> >>         u32 esr_el2;            /* Hyp Syndrom Register */
>> >>         u64 far_el2;            /* Hyp Fault Address Register */
>> >> +       u64 par_el2;            /* Result of FAR_EL2 translation */
>> >
>> > Please rename this to par_el1 because we are saving result of Stage1
>> > translation only.
>>
>> That'd be very confusing, as we deal with PAR_EL1 separately, as part of
>> the guest context.
>>
>> If anything, I may rename it to "what_I_d_love_HPFAR_to_return" instead.
>>
>
> while extremely clear, it may be a bit verbose ;)
>
> I honestly think that 'making up' a register name is a bit confusing as
> well.  I can live with it, but perhaps fault_ipa, or s1_fault_attr or
> something like that would work.  Eh.
>
> -Christoffer

Hi Marc,

Are you planning to go ahead with this approach ?

We really need this patch for X-Gene L3 cache.

Regards,
Anup
