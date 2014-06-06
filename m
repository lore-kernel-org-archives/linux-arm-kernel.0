From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 06 Jun 2014 17:11:31 +0100
Subject: [PATCH v3] arm/arm64: KVM: Fix and refactor unmap_range
In-Reply-To: <20140606155939.GA33621@lvm>
References: <1401894943-11213-1-git-send-email-christoffer.dall@linaro.org>
 <CAPvkgC2s+itzV5H+444Qhz_XfWVgWC1NU=tSugaxZWimOW5uyA@mail.gmail.com>
 <20140606155939.GA33621@lvm>
Message-ID: <5391E833.3030205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/14 16:59, Christoffer Dall wrote:
> On Fri, Jun 06, 2014 at 10:28:59AM +0100, Steve Capper wrote:
>> Hi Christoffer,
>>
>> On 4 June 2014 16:15, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>>> unmap_range() was utterly broken, to quote Marc, and broke in all sorts
>>> of situations.  It was also quite complicated to follow and didn't
>>> follow the usual scheme of having a separate iterating function for each
>>> level of page tables.
>>>
>>> Address this by refactoring the code and introduce a pgd_clear()
>>> function.
>>>
>>> Tested on TC2 with/without THP and limited testing on the v8 Foundation
>>> Model.
>>>
>>> Reviewed-by: Jungseok Lee <jays.lee@samsung.com>
>>> Reviewed-by: Mario Smarduch <m.smarduch@samsung.com>
>>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>> ---
>>
>> This looks good to me.
>>
>> Reviewed-by: Steve Capper <steve.capper@linaro.org>
>>
> 
> thanks.
> 
>> One minor comment below (sorry just spotted this now)...
>>
>> [ ... ]
>>
>>> -static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
>>> +static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
>>> +                      phys_addr_t addr, phys_addr_t end)
>>>  {
>>> -       if (pte_present(*pte)) {
>>> -               kvm_set_pte(pte, __pte(0));
>>> -               put_page(virt_to_page(pte));
>>> -               kvm_tlb_flush_vmid_ipa(kvm, addr);
>>> -       }
>>> +       pte_t *pte, *start_pte;
>>> +       unsigned long long start_addr = addr;
>>> +
>>> +       start_pte = pte = pte_offset_kernel(pmd, addr);
>>> +       do {
>>> +               if (!pte_none(*pte)) {
>>> +                       kvm_set_pte(pte, __pte(0));
>>> +                       put_page(virt_to_page(pte));
>>> +                       kvm_tlb_flush_vmid_ipa(kvm, addr);
>>
>> Can this hyp call be expensive if a lot of ptes are being unmapped
>> (for 64K pages we can have 8192 ptes per page)?
>> If so, can they be batched together?

The main problem here is that HYP doesn't have access to these pages at
all. They are only mapped at EL1, so HYP cannot parse the PTE table.

> I suppose we could, we would have to add something to flush the entire
> TLB for that VMID on aarch64 (or that entire range) to do so.

Yes, VMALL would be possible, but we'd have to find out pretty early if
we're tearing down the whole address space, or just a single page.

> I think it's reasonable to merge this now and apply that as an
> optimization.  Marc?

Agreed. Batching those require a bit more thoughts and more testing. I
remember heuristics about when it was more interesting to switch from
single TLBI to ALL, but I'd need to deep dive into my Inbox for this.

	M.
-- 
Jazz is not dead. It just smells funny...
