From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 9 Oct 2014 12:43:38 +0200
Subject: [PATCH v2] arm/arm64: KVM: map MMIO regions at creation time
In-Reply-To: <CAKv+Gu8J7tVN_ZswFRVmw4G_3=syD8UTBqW82Zm4F43d_WD3XQ@mail.gmail.com>
References: <1412766310-9835-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141008115623.GO3717@cbox>
 <CAKv+Gu8REo3gGfwe=rEn=tvWVKYTDFEnPh41VDgZeTdZDxHmAQ@mail.gmail.com>
 <20141008191900.GS3717@cbox>
 <CAKv+Gu8J7tVN_ZswFRVmw4G_3=syD8UTBqW82Zm4F43d_WD3XQ@mail.gmail.com>
Message-ID: <20141009104338.GW3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 11:59:21AM +0200, Ard Biesheuvel wrote:
> On 8 October 2014 21:19, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Wed, Oct 08, 2014 at 02:08:34PM +0200, Ard Biesheuvel wrote:
> >> On 8 October 2014 13:56, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> >> > On Wed, Oct 08, 2014 at 01:05:10PM +0200, Ard Biesheuvel wrote:
> >> >> There is really no point in faulting in memory regions page by page
> >> >> if they are not backed by demand paged system RAM but by a linear
> >> >> passthrough mapping of a host MMIO region.
> >> >>
> >> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> >> ---
> >> >>
> >> >> I have omitted the other 5 patches of the series of which this was #6, as
> >> >> Christoffer had indicated they could be merged separately.
> >> >>
> >> >> Changes since v1:
> >> >> - move this logic to kvm_arch_prepare_memory_region() so it can be invoked
> >> >>   when moving memory regions as well as when creating memory regions
> >> >> - as we are reasoning about memory regions now instead of memslots, all data
> >> >>   is retrieved from the 'mem' argument which points to a struct
> >> >>   kvm_userspace_memory_region
> >> >> - minor tweaks to the logic flow
> >> >>
> >> >> Again, compile tested only, due to lack of test cases.
> >> >>
> >> >>  arch/arm/kvm/mmu.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >> >>  1 file changed, 51 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >> >> index fe53c3a30383..1403d9dc1190 100644
> >> >> --- a/arch/arm/kvm/mmu.c
> >> >> +++ b/arch/arm/kvm/mmu.c
> >> >> @@ -1151,7 +1151,57 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
> >> >>                                  struct kvm_userspace_memory_region *mem,
> >> >>                                  enum kvm_mr_change change)
> >> >>  {
> >> >> -     return 0;
> >> >> +     hva_t hva = mem->userspace_addr;
> >> >> +     hva_t reg_end = hva + mem->memory_size;
> >> >> +     phys_addr_t gpa = mem->guest_phys_addr;
> >> >> +     int ret = 0;
> >> >> +
> >> >> +     if (change != KVM_MR_CREATE && change != KVM_MR_MOVE)
> >> >> +             return 0;
> >> >> +
> >> >> +     /*
> >> >> +      * A memory region could potentially cover multiple VMAs, so iterate
> >> >> +      * over all of them to find out if we can map any of them right now.
> >> >> +      *
> >> >> +      *     +--------------------------------------------+
> >> >> +      * +---+---------+-------------------+--------------+----+
> >> >> +      * |   : VMA 1   |       VMA 2       |       VMA 3  :    |
> >> >> +      * +---+---------+-------------------+--------------+----+
> >> >> +      *     |               memory region                |
> >> >> +      *     +--------------------------------------------+
> >> >> +      */
> >> >> +     do {
> >> >> +             struct vm_area_struct *vma = find_vma(current->mm, hva);
> >> >> +             hva_t vm_end;
> >> >> +
> >> >> +             if (!vma || vma->vm_start > hva) {
> >> >> +                     ret = -EFAULT;
> >> >> +                     break;
> >> >> +             }
> >> >> +
> >> >> +             vm_end = min(reg_end, vma->vm_end);
> >> >> +
> >> >> +             if (vma->vm_flags & VM_PFNMAP) {
> >> >> +                     phys_addr_t pa = (vma->vm_pgoff << PAGE_SHIFT) + hva -
> >> >> +                                      vma->vm_start;
> >> >> +                     bool writable = (vma->vm_flags & VM_WRITE) &&
> >> >> +                                     !(mem->flags & KVM_MEM_READONLY);
> >> >> +
> >> >> +                     ret = kvm_phys_addr_ioremap(kvm, gpa, pa, vm_end - hva,
> >> >> +                                                 writable);
> >> >> +                     if (ret)
> >> >> +                             break;
> >> >> +             }
> >> >> +             gpa += vm_end - hva;
> >> >> +             hva = vm_end;
> >> >> +     } while (hva < reg_end);
> >> >> +
> >> >> +     if (ret) {
> >> >> +             spin_lock(&kvm->mmu_lock);
> >> >> +             unmap_stage2_range(kvm, mem->guest_phys_addr, mem->memory_size);
> >> >> +             spin_unlock(&kvm->mmu_lock);
> >> >> +     }
> >> >> +     return ret;
> >> >>  }
> >> >>
> >> >>  void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
> >> >
> >> > If userspace moves the memory region in the guest IPA, then when are we
> >> > unmapping the old IPA region?  Should we not do this before we create
> >> > the new mappings (which may potentially overlap with the old one)?
> >> >
> >>
> >> You are right: I will move this logic to
> >> kvm_arch_commit_memory_region() instead so we can execute it after the
> >> unmap() has occurred.
> >>
> > As we discussed over IRC, that won't work because you don't have an
> > error path.
> >
> > Can you instead, prior to the loop, check if (change == KVM_MR_MOVE),
> > and in that case lookup the old memslot based on mem->slot, unmap
> > whatever is in there, and then proceed with what you had before?
> >
> > Slightly quirky but it should work afaict.
> >
> 
> What about moving the unmap to kvm_arch_flush_shadow_memslot()? This
> looks like an appropriate place to do the unmap, as it is conveniently
> invoked only for KVM_MR_DELETE and KVM_MR_MOVE, and right before
> kvm_arch_prepare_memory_region()
> 
That sounds like a nicer solution and looks like what x86 and power do
to, let's do that.

Will you respin?

Thanks,
-Christoffer
