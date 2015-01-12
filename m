From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 12 Jan 2015 20:43:18 +0100
Subject: [PATCH RESEND v15 07/10] KVM: arm: page logging 2nd stage fault
 handling
In-Reply-To: <54B41ACD.6010405@samsung.com>
References: <1420863441-32592-1-git-send-email-m.smarduch@samsung.com>
 <20150111140003.GA2722@cbox> <54B3F5D7.4010501@samsung.com>
 <20150112174927.GM3868@cbox> <54B41ACD.6010405@samsung.com>
Message-ID: <20150112194318.GA26222@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 11:04:45AM -0800, Mario Smarduch wrote:

[...]

> >>>> @@ -1059,12 +1104,35 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>>>  	if (is_error_pfn(pfn))
> >>>>  		return -EFAULT;
> >>>>  
> >>>> -	if (kvm_is_device_pfn(pfn))
> >>>> +	if (kvm_is_device_pfn(pfn)) {
> >>>>  		mem_type = PAGE_S2_DEVICE;
> >>>> +		set_pte_flags = KVM_S2PTE_FLAG_IS_IOMAP;
> >>>> +	}
> >>>>  
> >>>>  	spin_lock(&kvm->mmu_lock);
> >>>>  	if (mmu_notifier_retry(kvm, mmu_seq))
> >>>>  		goto out_unlock;
> >>>> +
> >>>> +	/*
> >>>> +	 * When logging is enabled general page fault handling changes:
> >>>> +	 * -  Writable huge pages are dissolved on a read or write fault.
> >>>
> >>> why dissolve huge pages on a read fault?
> >>
> >> What I noticed on write you would dissolve, on read you
> >> rebuild THPs, flip back and forth like that, performance
> >> & convergence was really bad.
> > 
> > ah, that makes sense, we should probably indicate that reasoning
> > somehow.  In fact, what threw me off was the use of the word "dissolve
> > huge pages" which is not really what you're doing on a read fault, there
> > you are just never adjusting to huge pages.
> > 
> > I'm wondering why that would slow things down much though, the only cost
> > would be the extra tlb invalidation and replacing the PMD on a
> > subsequent write fault, but I trust your numbers nevertheless.
> 
> If I understand correctly -
> you do few writes, dissolve a huge page insert pte TLB entries,
> then a read page fault installs a pmd clears the TLB cache
> for that range, and it repeats over. Appears like you
> need to constantly re-fault pte TLBs on writes to huge
> page range.

that makes good sense, thanks for the explanation.

[...]

> >>>  	} else {
> >>> +		unsigned long flags = 0;
> >>>  		pte_t new_pte = pfn_pte(pfn, mem_type);
> >>> +
> >>>  		if (writable) {
> >>>  			kvm_set_s2pte_writable(&new_pte);
> >>>  			kvm_set_pfn_dirty(pfn);
> >>>  		}
> >>>  		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE,
> >>>  					  fault_ipa_uncached);
> >>> -		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
> >>> -			pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE));
> >>> +
> >>> +		if (pgprot_val(mem_type) == pgprot_val(PAGE_S2_DEVICE))
> >>> +			flags |= KVM_S2PTE_FLAG_IS_IOMAP;
> >>> +
> >>> +		if (memslot_is_logging(memslot))
> >>> +			flags |= KVM_S2_FLAG_LOGGING_ACTIVE;
> >> Now that it either IOMAP or LOGGING_ACTIVE do we need to acumulate flags?
> >> Although we don't know if device mappings will be handled here.
> >>
> > 
> > so forget all I said about this in the past, I confused the code
> > checking for !cache with the iomap flag.
> > 
> > So, I think you can always safeful assume that stage2_get_pmd() gives you
> > something valid back when you have the LOGGING flag set, because you
> > always call the function with a valid cache when the LOGGING flag is
> > set.  It could be worth adding the following to stage2_set_pte():
> > 
> > VM_BUG_ON((flags & KVM_S2_FLAG_LOGGING_ACTIVE) && !cache)
> 
> I see ok, thanks for clearing that up.
> 
> > 
> > As for this code, the IOMAP flag's only effect is that we return -EFAULT
> > if we are seeing an existing PTE for the faulting address.  This would
> > no longer be valid if we allow logging dirty device memory pages, so we
> Sorry, do you mean allow or disallow?

if we (by these patches) allow logging dirty pages for device memory,
then we...

> 
> > really need to think about if there's any conceivable use case for this?
> > 
> > It doesn't really make sense to me, so I would suggest that we never
> > enable logging for pages that return kvm_is_device_pfn().
> > 
> > Thanks,
> > -Christoffer
> > 
> 
