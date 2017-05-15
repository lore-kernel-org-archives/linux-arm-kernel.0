From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 15 May 2017 14:38:08 +0100
Subject: [PATCH 2/2] kvm: arm/arm64: Fix use after free of stage2 page
 table
In-Reply-To: <e8255936-1480-1306-edcb-5aef57271a5f@arm.com>
References: <1493821072-29713-1-git-send-email-suzuki.poulose@arm.com>
 <1493821072-29713-3-git-send-email-suzuki.poulose@arm.com>
 <20170515100017.GJ9309@cbox> <e8255936-1480-1306-edcb-5aef57271a5f@arm.com>
Message-ID: <c9c972f3-817a-fc1b-e4f3-a039778732f4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/17 14:36, Suzuki K Poulose wrote:
> On 15/05/17 11:00, Christoffer Dall wrote:
>> Hi Suzuki,
>>
>> On Wed, May 03, 2017 at 03:17:52PM +0100, Suzuki K Poulose wrote:
>>> We yield the kvm->mmu_lock occassionaly while performing an operation
>>> (e.g, unmap or permission changes) on a large area of stage2 mappings.
>>> However this could possibly cause another thread to clear and free up
>>> the stage2 page tables while we were waiting for regaining the lock and
>>> thus the original thread could end up in accessing memory that was
>>> freed. This patch fixes the problem by making sure that the stage2
>>> pagetable is still valid after we regain the lock. The fact that
>>> mmu_notifer->release() could be called twice (via __mmu_notifier_release
>>> and mmu_notifier_unregsister) enhances the possibility of hitting
>>> this race where there are two threads trying to unmap the entire guest
>>> shadow pages.
>>>
>>> While at it, cleanup the redudant checks around cond_resched_lock in
>>> stage2_wp_range(), as cond_resched_lock already does the same checks.
>>>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Radim Kr?m?? <rkrcmar@redhat.com>
>>> Cc: andreyknvl at google.com
>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>  arch/arm/kvm/mmu.c | 17 ++++++++++++-----
>>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>>> index 909a1a7..5b3e0db 100644
>>> --- a/arch/arm/kvm/mmu.c
>>> +++ b/arch/arm/kvm/mmu.c
>>> @@ -301,9 +301,14 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>>>          /*
>>>           * If the range is too large, release the kvm->mmu_lock
>>>           * to prevent starvation and lockup detector warnings.
>>> +         * Make sure the page table is still active when we regain
>>> +         * the lock.
>>>           */
>>> -        if (next != end)
>>> +        if (next != end) {
>>>              cond_resched_lock(&kvm->mmu_lock);
>>> +            if (!READ_ONCE(kvm->arch.pgd))
>>> +                break;
>>> +        }
>>
>> So I don't think this change is wrong, but I wonder if it's sufficient.
>> For example, I can see that this function is called from
>>
>> stage2_unmsp_vm
>>  -> stage2_unmap_memslot
>>    -> unmap_stage2_range
>>
>> and
>>
>> kvm_arch_flush_shadow_memslot
>>  -> unmap_stage2_range
>>
>> which never check if the pgd pointer is valid,
>
> You are right. Those two callers do not check it. We could fix all of this by simply
> moving the check to the beginning of the loop.
> i.e, something like this :
>
> @@ -295,6 +295,12 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>     assert_spin_locked(&kvm->mmu_lock);
>     pgd = kvm->arch.pgd + stage2_pgd_index(addr);
>     do {
> +        /*
> +         * Make sure the page table is still active, as we could
> +         * another thread could have possibly freed the page table.
> +         */

The comment portion has been fixed locally.
