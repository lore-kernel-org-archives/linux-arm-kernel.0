From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 27 Apr 2013 16:21:09 +0100
Subject: [PATCH v4 5/7] ARM: KVM: rework HYP page table freeing
In-Reply-To: <CAEDV+gKZezvHtRAySvGpOgTsPPtwUEYo9v086U=Hz4QPZXGVSg@mail.gmail.com>
References: <1365790327-2138-1-git-send-email-marc.zyngier@arm.com>
 <1365790327-2138-6-git-send-email-marc.zyngier@arm.com>
 <20130426110558.GE5007@localhost.cambridge.arm.com> <517AAF3F.20500@arm.com>
 <CAEDV+gKZezvHtRAySvGpOgTsPPtwUEYo9v086U=Hz4QPZXGVSg@mail.gmail.com>
Message-ID: <1DF9CE3B-C034-483E-BAF1-92E11D6F112F@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 Apr 2013, at 22:07, "Christoffer Dall" <cdall@cs.columbia.edu> wrote:

> On Fri, Apr 26, 2013 at 9:45 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 26/04/13 12:05, Catalin Marinas wrote:
>>> On Fri, Apr 12, 2013 at 07:12:05PM +0100, Marc Zyngier wrote:
>>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>>>> index bfc5927..7464824 100644
>>>> --- a/arch/arm/kvm/mmu.c
>>>> +++ b/arch/arm/kvm/mmu.c
>>> ...
>>>> +static void clear_pmd_entry(pmd_t *pmd)
>>>> +{
>>>> +    pte_t *pte_table = pte_offset_kernel(pmd, 0);
>>>> +    pmd_clear(pmd);
>>>> +    pte_free_kernel(NULL, pte_table);
>>>> +    put_page(virt_to_page(pmd));
>>>> +}
>>> ...
>>>> static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>>> 
>>> Is there a chance that this function (or the other unmapping function
>>> for Hyp pages) is called on an active stage 2 table (VTTBR pointing to
>>> this pgd)? If yes, than you probably have to follow the mmu_gather
>>> mechanism of freeing page table pages to avoid speculative loads.
>>> Basically flushing the TLB between pmd_clear and pte_free_kernel.
>> 
>> Blah. You're right, we got it wrong.
>> 
>> We need to move our TLB invalidation out of kvm_unmap_hva_handler, and
>> put it in clear_pmd_entry. I'll cook a patch.
>> 
>> Thanks for reviewing.
> Ah, because clean_pmd_entry doesn't  flush stage2 TLB, that's the issue?

Yes. After clearing a pmd entry you need to flush the stage 2
TLB before freeing the pte page it was pointing to. Otherwise
you can get other CPUs loading the TLB with invalid data
(either because of intermediate level caching in the TLB or
simply because they haven't observed the actual pmd
clearing). 

Catalin
