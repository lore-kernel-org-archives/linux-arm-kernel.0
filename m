From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 09 Dec 2014 20:42:55 +0100
Subject: [PATCH v14 3/7] KVM: x86: switch to kvm_get_dirty_log_protect
In-Reply-To: <5486306A.3060901@samsung.com>
References: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
 <1415930268-7674-4-git-send-email-m.smarduch@samsung.com>
 <20141122191908.GM3401@cbox> <5486306A.3060901@samsung.com>
Message-ID: <548750BF.2070209@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/12/2014 00:12, Mario Smarduch wrote:
> Hi Paolo,
>    I took a closer look at Christoffers comment,
> the _log description in x86.c is a repeat of the
> _protect description in kvm_main.c.
> 
> I'm wondering if description below would be acceptable, or
> perhaps you had a reason leaving it as is.

Yes, it's okay.

> For the ARM variant I would word same. Please advise.
> 
> Thanks.
> 
> "
> /**
>  * kvm_vm_ioctl_get_dirty_log - get and clear the log of dirty pages in
> a slot
>  * @kvm: kvm instance
>  * @log: slot id and address to which we copy the log
>  *
>  * Steps 1-4 below provide general overview of dirty page logging. See
>  * kvm_get_dirty_log_protect() function description for additional details.
>  *
>  * We call kvm_get_dirty_log_protect() to handle steps 1-3, upon return we
>  * always flush the TLB (step 4) even if 'protect' failed and dirty bitmap

even if a previous step failed and the dirty bitmap may be corrupt.

>  * may be corrupt. Regardless of previous outcome KVM logging API does not

... the KVM logging API ...

>  * preclude user space subsequent dirty log read. Flushing TLB insures

s/insures/ensures/

Paolo

> writes
>  * will be marked dirty for next log read.
>  *
>  *   1. Take a snapshot of the bit and clear it if needed.
>  *   2. Write protect the corresponding page.
>  *   3. Copy the snapshot to the userspace.
>  *   4. Flush TLB's if needed.
>  */
> "
> 
> On 11/22/2014 11:19 AM, Christoffer Dall wrote:
>> On Thu, Nov 13, 2014 at 05:57:44PM -0800, Mario Smarduch wrote:
>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> We now have a generic function that does most of the work of
>>> kvm_vm_ioctl_get_dirty_log, now use it.
>>>
>>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>>> ---
>>>  arch/x86/include/asm/kvm_host.h |    3 --
>>>  arch/x86/kvm/Kconfig            |    1 +
>>>  arch/x86/kvm/mmu.c              |    4 +--
>>>  arch/x86/kvm/x86.c              |   64 ++++++---------------------------------
>>>  4 files changed, 12 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>> index 7c492ed..934dc24 100644
>>> --- a/arch/x86/include/asm/kvm_host.h
>>> +++ b/arch/x86/include/asm/kvm_host.h
>>> @@ -805,9 +805,6 @@ void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
>>>  
>>>  void kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
>>>  void kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
>>> -void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
>>> -				     struct kvm_memory_slot *slot,
>>> -				     gfn_t gfn_offset, unsigned long mask);
>>>  void kvm_mmu_zap_all(struct kvm *kvm);
>>>  void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm);
>>>  unsigned int kvm_mmu_calculate_mmu_pages(struct kvm *kvm);
>>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>>> index f9d16ff..d073594 100644
>>> --- a/arch/x86/kvm/Kconfig
>>> +++ b/arch/x86/kvm/Kconfig
>>> @@ -39,6 +39,7 @@ config KVM
>>>  	select PERF_EVENTS
>>>  	select HAVE_KVM_MSI
>>>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>>> +	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>>>  	select KVM_VFIO
>>>  	---help---
>>>  	  Support hosting fully virtualized guest machines using hardware
>>> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
>>> index 9314678..bf6b82c 100644
>>> --- a/arch/x86/kvm/mmu.c
>>> +++ b/arch/x86/kvm/mmu.c
>>> @@ -1224,7 +1224,7 @@ static bool __rmap_write_protect(struct kvm *kvm, unsigned long *rmapp,
>>>  }
>>>  
>>>  /**
>>> - * kvm_mmu_write_protect_pt_masked - write protect selected PT level pages
>>> + * kvm_arch_mmu_write_protect_pt_masked - write protect selected PT level pages
>>>   * @kvm: kvm instance
>>>   * @slot: slot to protect
>>>   * @gfn_offset: start of the BITS_PER_LONG pages we care about
>>> @@ -1233,7 +1233,7 @@ static bool __rmap_write_protect(struct kvm *kvm, unsigned long *rmapp,
>>>   * Used when we do not need to care about huge page mappings: e.g. during dirty
>>>   * logging we do not have any such mappings.
>>>   */
>>> -void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
>>> +void kvm_arch_mmu_write_protect_pt_masked(struct kvm *kvm,
>>>  				     struct kvm_memory_slot *slot,
>>>  				     gfn_t gfn_offset, unsigned long mask)
>>>  {
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 8f1e22d..9f8ae9a 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -3606,77 +3606,31 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
>>>   *
>>>   *   1. Take a snapshot of the bit and clear it if needed.
>>>   *   2. Write protect the corresponding page.
>>> - *   3. Flush TLB's if needed.
>>> - *   4. Copy the snapshot to the userspace.
>>> + *   3. Copy the snapshot to the userspace.
>>> + *   4. Flush TLB's if needed.
>>>   *
>>> - * Between 2 and 3, the guest may write to the page using the remaining TLB
>>> - * entry.  This is not a problem because the page will be reported dirty at
>>> - * step 4 using the snapshot taken before and step 3 ensures that successive
>>> - * writes will be logged for the next call.
>>> + * Between 2 and 4, the guest may write to the page using the remaining TLB
>>> + * entry.  This is not a problem because the page is reported dirty using
>>> + * the snapshot taken before and step 4 ensures that writes done after
>>> + * exiting to userspace will be logged for the next call.
>>>   */
>>
>> this seems to duplicate the comment in virt/kvm/kvm_main.c, but
>> whatever.
>>
>> FWIW:
>> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>>
> 
