From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Oct 2014 14:59:23 +0200
Subject: [PATCH v3] arm/arm64: KVM: map MMIO regions at creation time
In-Reply-To: <20141010105218.GB3717@cbox>
References: <1412861438-4449-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141010105218.GB3717@cbox>
Message-ID: <CAKv+Gu-2Gvp+y0sbZsv72tByK8zQmkvqpARVWBsGwFLUOo05SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2014 12:52, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Thu, Oct 09, 2014 at 03:30:38PM +0200, Ard Biesheuvel wrote:
>> There is really no point in faulting in memory regions page by page
>> if they are not backed by demand paged system RAM but by a linear
>> passthrough mapping of a host MMIO region. So instead, detect such
>> regions at setup time and install the mappings for the backing all
>> at once.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> I have omitted the other 5 patches of the series of which this was #6, as
>> Christoffer had indicated they could be merged separately.
>>
>> Changes since v2:
>> - moved the unmapping of moved/deleted regions to kvm_arch_flush_shadow_memslot
>>   so it occurs before parts of the new regions may be mapped in
>>   kvm_arch_prepare_memory_region
>> - allow memory regions with holes
>>
>> Changes since v1:
>> - move this logic to kvm_arch_prepare_memory_region() so it can be invoked
>>   when moving memory regions as well as when creating memory regions
>> - as we are reasoning about memory regions now instead of memslots, all data
>>   is retrieved from the 'mem' argument which points to a struct
>>   kvm_userspace_memory_region
>> - minor tweaks to the logic flow
>>
>> My test case (UEFI under QEMU/KVM) still executes correctly with this patch,
>> but more thorough testing with actual passthrough device regions is in order.
>>
>>  arch/arm/kvm/mmu.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 61 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 37c1b35f90ad..53d511524bb5 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -1132,13 +1132,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>>                                  const struct kvm_memory_slot *old,
>>                                  enum kvm_mr_change change)
>>  {
>> -     gpa_t gpa = old->base_gfn << PAGE_SHIFT;
>> -     phys_addr_t size = old->npages << PAGE_SHIFT;
>> -     if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
>> -             spin_lock(&kvm->mmu_lock);
>> -             unmap_stage2_range(kvm, gpa, size);
>> -             spin_unlock(&kvm->mmu_lock);
>> -     }
>>  }
>>
>>  int kvm_arch_prepare_memory_region(struct kvm *kvm,
>> @@ -1146,7 +1139,61 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>                                  struct kvm_userspace_memory_region *mem,
>>                                  enum kvm_mr_change change)
>>  {
>> -     return 0;
>> +     hva_t hva = mem->userspace_addr;
>> +     hva_t reg_end = hva + mem->memory_size;
>> +     int ret = 0;
>> +
>> +     if (change != KVM_MR_CREATE && change != KVM_MR_MOVE)
>> +             return 0;
>> +
>> +     /*
>> +      * A memory region could potentially cover multiple VMAs, and any holes
>> +      * between them, so iterate over all of them to find out if we can map
>> +      * any of them right now.
>> +      *
>> +      *     +--------------------------------------------+
>> +      * +---------------+----------------+   +----------------+
>> +      * |   : VMA 1     |      VMA 2     |   |    VMA 3  :    |
>> +      * +---------------+----------------+   +----------------+
>> +      *     |               memory region                |
>> +      *     +--------------------------------------------+
>> +      */
>> +     do {
>> +             struct vm_area_struct *vma = find_vma(current->mm, hva);
>> +             hva_t vm_start, vm_end;
>> +
>> +             if (!vma || vma->vm_start >= reg_end)
>> +                     break;
>> +
>> +             /*
>> +              * Take the intersection of this VMA with the memory region
>> +              */
>> +             vm_start = max(hva, vma->vm_start);
>> +             vm_end = min(reg_end, vma->vm_end);
>> +
>> +             if (vma->vm_flags & VM_PFNMAP) {
>> +                     gpa_t gpa = mem->guest_phys_addr +
>> +                                 (vm_start - mem->userspace_addr);
>> +                     phys_addr_t pa = (vma->vm_pgoff << PAGE_SHIFT) +
>> +                                      vm_start - vma->vm_start;
>> +                     bool writable = vma->vm_flags & VM_WRITE &&
>> +                                     !(mem->flags & KVM_MEM_READONLY);
>
> If I read the code correctly, in the case where you have (!(vma->vm_flags
> & VM_WRITE) && !(mem->falgs & KVM_MEM_READONLY)) you'll map as read-only
> and we'll take a Stage-2 fault on a write, but because the memslot is
> not marked as readonly, we'll just try to fault in the page writable,
> which should fail because (vma->vm_flags & VM_WRITE) == 0, so we'll
> crash the VM here by returning -EFAULT to userspace.
>
> So I'm wondering if this shouldn't return an error at this point
> instead?
>

I think you're right. Interestingly, it appears that read-only VMAs
are rejected early by the x86 version due to its access_ok()
implementation actually caring about the 'type' field.
For ARM/arm64, however, the type is ignored and the additional check
is in order, although it may be better to fix access_ok() at some
point (assuming we agree it makes no sense for KVM on ARM/arm64 to be
'special' and allow something that generic KVM does not.)

-- 
Ard.


>> +
>> +                     ret = kvm_phys_addr_ioremap(kvm, gpa, pa,
>> +                                                 vm_end - vm_start,
>> +                                                 writable);
>> +                     if (ret)
>> +                             break;
>> +             }
>> +             hva = vm_end;
>> +     } while (hva < reg_end);
>> +
>> +     if (ret) {
>> +             spin_lock(&kvm->mmu_lock);
>> +             unmap_stage2_range(kvm, mem->guest_phys_addr, mem->memory_size);
>> +             spin_unlock(&kvm->mmu_lock);
>> +     }
>> +     return ret;
>>  }
>>
>>  void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
>> @@ -1171,4 +1218,10 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
>>  void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>>                                  struct kvm_memory_slot *slot)
>>  {
>> +     gpa_t gpa = slot->base_gfn << PAGE_SHIFT;
>> +     phys_addr_t size = slot->npages << PAGE_SHIFT;
>> +
>> +     spin_lock(&kvm->mmu_lock);
>> +     unmap_stage2_range(kvm, gpa, size);
>> +     spin_unlock(&kvm->mmu_lock);
>>  }
>> --
>> 1.8.3.2
>>
>
> Otherwise, this looks good.
>
> Thanks!
> -Christoffer
