From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 24 Sep 2013 16:41:19 +0100
Subject: [PATCH 3/3] KVM: ARM: Transparent huge pages and hugetlbfs support
In-Reply-To: <524013BB.4090303@arm.com>
References: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
 <1376021239-10532-4-git-send-email-christoffer.dall@linaro.org>
 <524013BB.4090303@arm.com>
Message-ID: <20130924154118.GA18779@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 11:11:07AM +0100, Marc Zyngier wrote:
> Hi Christoffer,
> 
> Finally taking some time to review this patch. Sorry for the delay...
> 
> On 09/08/13 05:07, Christoffer Dall wrote:
> > From: Christoffer Dall <cdall@cs.columbia.edu>
> > 

[ snip ]

> >  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> > -                         gfn_t gfn, struct kvm_memory_slot *memslot,
> > +                         struct kvm_memory_slot *memslot,
> >                           unsigned long fault_status)
> >  {
> > -       pte_t new_pte;
> > -       pfn_t pfn;
> >         int ret;
> > -       bool write_fault, writable;
> > +       bool write_fault, writable, hugetlb = false, force_pte = false;
> >         unsigned long mmu_seq;
> > +       gfn_t gfn = fault_ipa >> PAGE_SHIFT;
> > +       unsigned long hva = gfn_to_hva(vcpu->kvm, gfn);
> > +       struct kvm *kvm = vcpu->kvm;
> >         struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
> > +       struct vm_area_struct *vma;
> > +       pfn_t pfn;
> > +       unsigned long psize;
> > 
> >         write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
> >         if (fault_status == FSC_PERM && !write_fault) {
> > @@ -525,6 +638,27 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >                 return -EFAULT;
> >         }
> > 
> > +       /* Let's check if we will get back a huge page */
> > +       down_read(&current->mm->mmap_sem);
> > +       vma = find_vma_intersection(current->mm, hva, hva + 1);
> > +       if (is_vm_hugetlb_page(vma)) {
> > +               hugetlb = true;
> > +               hva &= PMD_MASK;
> > +               gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
> > +               psize = PMD_SIZE;
> > +       } else {
> > +               psize = PAGE_SIZE;
> > +               if (vma->vm_start & ~PMD_MASK)
> > +                       force_pte = true;
> > +       }
> > +       up_read(&current->mm->mmap_sem);
> > +
> > +       pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
> > +       if (is_error_pfn(pfn))
> > +               return -EFAULT;
> 
> How does this work with respect to the comment that talks about reading
> mmu_seq before calling gfp_to_pfn_prot? Either the comment is wrong, or
> we read this too early.
> 
> > +       coherent_icache_guest_page(kvm, hva, psize);
> > +
> >         /* We need minimum second+third level pages */
> >         ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
> >         if (ret)
> > @@ -542,26 +676,34 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >          */
> >         smp_rmb();
> > 
> > -       pfn = gfn_to_pfn_prot(vcpu->kvm, gfn, write_fault, &writable);
> > -       if (is_error_pfn(pfn))
> > -               return -EFAULT;
> > -
> > -       new_pte = pfn_pte(pfn, PAGE_S2);
> > -       coherent_icache_guest_page(vcpu->kvm, gfn);
> > -
> > -       spin_lock(&vcpu->kvm->mmu_lock);
> > -       if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
> > +       spin_lock(&kvm->mmu_lock);
> > +       if (mmu_notifier_retry(kvm, mmu_seq))
> >                 goto out_unlock;
> > -       if (writable) {
> > -               kvm_set_s2pte_writable(&new_pte);
> > -               kvm_set_pfn_dirty(pfn);
> > +       if (!hugetlb && !force_pte)
> > +               hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
> 
> How do we ensure that there is no race between this pte being promoted
> to a pmd and another page allocation in the same pmd somewhere else in
> the system? We only hold the kvm lock here, so there must be some extra
> implicit guarantee somewhere...
> 

This isn't a promotion to a huge page, it is a mechanism to ensure that
pfn corresponds with the head page of a THP as that's where refcount
information is stored. I think this is safe.

I'm still getting my brain working with kvm, so sorry don't have any
other feedback yet sorry :-).

Cheers,
-- 
Steve
