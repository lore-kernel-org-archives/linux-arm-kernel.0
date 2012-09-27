From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Sep 2012 18:21:23 +0100
Subject: [PATCH 13/15] KVM: ARM: Handle guest faults in KVM
In-Reply-To: <CANM98qLxCPRS8m5JsEvY+vMM6T_6EjxZwRjKkncMzu4Xn98cnw@mail.gmail.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153552.21241.8656.stgit@ubuntu>
 <000101cd9b0e$78934fe0$69b9efa0$@samsung.com>
 <CANM98qLuY3G6bBBnK+GJtEVZMRYX+Bk+bKh-bEQq0r7RyX9Nuw@mail.gmail.com>
 <CAHkRjk4Dik_cTXcezQB07HKMqLOzRrhkkDpSmbQaRndAfs3Zrg@mail.gmail.com>
 <CANM98qLxCPRS8m5JsEvY+vMM6T_6EjxZwRjKkncMzu4Xn98cnw@mail.gmail.com>
Message-ID: <20120927172123.GA8752@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 06:15:05PM +0100, Christoffer Dall wrote:
> On Thu, Sep 27, 2012 at 8:39 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On 25 September 2012 13:38, Christoffer Dall
> > <c.dall@virtualopensystems.com> wrote:
> >>>> +
> >>>> +     /*
> >>>> +      * If this is a write fault (think COW) we need to make sure the
> >>>> +      * existing page, which other CPUs might still read, doesn't go
> >>>> away
> >>>> +      * from under us, by calling gfn_to_pfn_prot(write_fault=true).
> >>>> +      * Therefore, we call gfn_to_pfn_prot(write_fault=false), which
> >>>> will
> >>>> +      * pin the existing page, then we get a new page for the user space
> >>>> +      * pte and map this in the stage-2 table where we also make sure to
> >>>> +      * flush the TLB for the VM, if there was an existing entry (the
> >>>> entry
> >>>> +      * was updated setting the write flag to the potentially new page).
> >>>> +      */
> >>>> +     if (fault_status == FSC_PERM) {
> >>>> +             pfn_existing = gfn_to_pfn_prot(vcpu->kvm, gfn, false, NULL);
> >>>> +             if (is_error_pfn(pfn_existing))
> >>>> +                     return -EFAULT;
> >>>> +     }
> >>>> +
> >>>> +     pfn = gfn_to_pfn_prot(vcpu->kvm, gfn, write_fault, &writable);
> >>>> +     if (is_error_pfn(pfn)) {
> >>>> +             ret = -EFAULT;
> >>>> +             goto out_put_existing;
> >>>> +     }
> >>>> +
> >>>> +     /* We need minimum second+third level pages */
> >>>> +     ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
> >>>> +     if (ret)
> >>>> +             goto out;
> >>>> +     new_pte = pfn_pte(pfn, PAGE_KVM_GUEST);
> >>>> +     if (writable)
> >>>> +             pte_val(new_pte) |= L_PTE2_WRITE;
> >>>> +     coherent_icache_guest_page(vcpu->kvm, gfn);
> >>>
> >>> why don't you flush icache only when guest has mapped executable page
> >>> as __sync_icache_dcache function does currently?
> >>
> >> because we don't know if the guest will map the page executable. The
> >> guest may read the page through a normal load, which causes the fault,
> >> and subsequently execute it (even possible through different guest
> >> mappings). The only way to see this happening would be to mark all
> >> pages as non-executable and catch the fault when it occurs -
> >> unfortunately the HPFAR which gives us the IPA is not populated on
> >> execute never faults, so we would have to translate the PC's va to ipa
> >> using cp15 functionality when this happens, which is then also racy
> >> with other CPUs.
> >
> > I think you can avoid the race in the stage 2 XN case. In the Hyp
> > exception handler entered because of a stage 2 XN bit you can get the
> > IPA via the CP15 ATS1CPR and PAR registers. If the address translation
> > failed because the same guest running on other CPU changed the stage 1
> > page table, you can simply return to the guest rather than switching
> > to host with incomplete information. The guest may handle its own
> > stage 1 fault and eventually trigger another stage 2 permission and
> > Hyp will try the address translation again. That's a very rare
> > situation, so just returning without handling it would not cause any
> > performance issues.
> >
> you're right that the race is not a big issue, but it's not clear to
> me that the trapping + ATS1CPR will be faster than just flushing
> icache - we'll have to measure this.

I agree, it needs measuring first as it may not be worth the hassle.

-- 
Catalin
