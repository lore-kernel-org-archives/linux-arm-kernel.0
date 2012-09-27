From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Sep 2012 16:26:28 +0100
Subject: [kvmarm] [PATCH 13/15] KVM: ARM: Handle guest faults in KVM
In-Reply-To: <000901cd9c5d$cc53fbc0$64fbf340$@samsung.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153552.21241.8656.stgit@ubuntu>
 <000101cd9b0e$78934fe0$69b9efa0$@samsung.com>
 <CANM98qLuY3G6bBBnK+GJtEVZMRYX+Bk+bKh-bEQq0r7RyX9Nuw@mail.gmail.com>
 <000901cd9c5d$cc53fbc0$64fbf340$@samsung.com>
Message-ID: <50647024.2070307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/09/12 04:11, Min-gyu Kim wrote:
> 
> 
>> -----Original Message-----
>> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org] On
>> Behalf Of Christoffer Dall
>> Sent: Tuesday, September 25, 2012 9:39 PM
>> To: Min-gyu Kim
>> Cc: kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> kvmarm at lists.cs.columbia.edu; ???
>> Subject: Re: [PATCH 13/15] KVM: ARM: Handle guest faults in KVM
>>
>>>> +
>>>> +     /*
>>>> +      * If this is a write fault (think COW) we need to make sure the
>>>> +      * existing page, which other CPUs might still read, doesn't go
>>>> away
>>>> +      * from under us, by calling gfn_to_pfn_prot(write_fault=true).
>>>> +      * Therefore, we call gfn_to_pfn_prot(write_fault=false), which
>>>> will
>>>> +      * pin the existing page, then we get a new page for the user
>> space
>>>> +      * pte and map this in the stage-2 table where we also make sure
>> to
>>>> +      * flush the TLB for the VM, if there was an existing entry
>>>> + (the
>>>> entry
>>>> +      * was updated setting the write flag to the potentially new
> page).
>>>> +      */
>>>> +     if (fault_status == FSC_PERM) {
>>>> +             pfn_existing = gfn_to_pfn_prot(vcpu->kvm, gfn, false,
> NULL);
>>>> +             if (is_error_pfn(pfn_existing))
>>>> +                     return -EFAULT;
>>>> +     }
>>>> +
>>>> +     pfn = gfn_to_pfn_prot(vcpu->kvm, gfn, write_fault, &writable);
>>>> +     if (is_error_pfn(pfn)) {
>>>> +             ret = -EFAULT;
>>>> +             goto out_put_existing;
>>>> +     }
>>>> +
>>>> +     /* We need minimum second+third level pages */
>>>> +     ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
>>>> +     if (ret)
>>>> +             goto out;
>>>> +     new_pte = pfn_pte(pfn, PAGE_KVM_GUEST);
>>>> +     if (writable)
>>>> +             pte_val(new_pte) |= L_PTE2_WRITE;
>>>> +     coherent_icache_guest_page(vcpu->kvm, gfn);
>>>
>>> why don't you flush icache only when guest has mapped executable page
>>> as __sync_icache_dcache function does currently?
>>>
>>>
>>
>> because we don't know if the guest will map the page executable. The guest
>> may read the page through a normal load, which causes the fault, and
>> subsequently execute it (even possible through different guest mappings).
>> The only way to see this happening would be to mark all pages as non-
>> executable and catch the fault when it occurs - unfortunately the HPFAR
>> which gives us the IPA is not populated on execute never faults, so we
>> would have to translate the PC's va to ipa using cp15 functionality when
>> this happens, which is then also racy with other CPUs. So the question is
>> really if this will even be an optimization, but it's definitely something
>> that requires further investigation.
> 
> OK. I understand your point.
> 
> But if guest maps a page for execution, guest will flush Icache
> from __sync_icache_dcache. Then coherent_icache_guest_page doesn't seem to
> be
> necessary again. One thing I'm not sure in this case is when guest maps
> for kernel executable page(module loading) and it reuses the kernel
> executable page
> from host(module unloading). But in that case, I think it is possible to
> reduce 
> the number of flush by limiting the address range for flush.

I think you're missing the major point:
When the guest maps a page for execution, it knows it has to synchronize
Icache and Dcache. But the guest never knows when we swap out a page
because of memory pressure.

When the guest eventually faults that page back in, chances are it will
be a different physical page, and the cache content may be inconsistent.
We must then sync Icache/Dcache for this page.

Now, as Christoffer mentioned, there's a number of schemes we could
potentially use to mitigate this effect (using the XN bit in the Stage2
page tables), but it remains to be seen how effective it will be.

	M.
-- 
Jazz is not dead. It just smells funny...
