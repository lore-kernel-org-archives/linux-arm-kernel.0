From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Jan 2015 11:20:32 +0100
Subject: [PATCH RESEND v15 07/10] KVM: arm: page logging 2nd stage fault
 handling
In-Reply-To: <54B6F753.8000101@samsung.com>
References: <1420863441-32592-1-git-send-email-m.smarduch@samsung.com>
 <20150111140003.GA2722@cbox> <54B3F5D7.4010501@samsung.com>
 <20150112174927.GM3868@cbox> <54B5A6E7.6090904@samsung.com>
 <20150114103233.GI26222@cbox> <54B6F753.8000101@samsung.com>
Message-ID: <20150115102032.GN26222@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 03:10:11PM -0800, Mario Smarduch wrote:
> On 01/14/2015 02:32 AM, Christoffer Dall wrote:
> > On Tue, Jan 13, 2015 at 03:14:47PM -0800, Mario Smarduch wrote:
> > 
> > [...]
> > 
> >>>>>
> >>>>>
> >>>>> What I meant last time around concerning user_mem_abort was more
> >>>>> something like this:
> >>>>>
> >>>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >>>>> index 1dc9778..38ea58e 100644
> >>>>> --- a/arch/arm/kvm/mmu.c
> >>>>> +++ b/arch/arm/kvm/mmu.c
> >>>>> @@ -935,7 +935,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>>>>  		return -EFAULT;
> >>>>>  	}
> >>>>>  
> >>>>> -	if (is_vm_hugetlb_page(vma)) {
> >>>>> +	/*
> >>>>> +	 * Writes to pages in a memslot with logging enabled are always logged
> >>>>> +	 * on a singe page-by-page basis.
> >>>>> +	 */
> >>>>> +	if (memslot_is_logging(memslot) && write_fault)
> >>>>> +		force_pte = true;
> >>>>
> >>>> If it's a write you take the pte route and
> >>>> dissolves huge page, if it's a read you reconstruct the
> >>>> THP that seems to yield pretty bad results.
> >>>
> >>> ok, then remove the ' && write_fault' part of the clause.
> >> Hi Christoffer,
> >>  couple comments/questions.
> >>
> >>  setting force_pte here, disables huge pages for
> >> non-writable regions.
> >>
> > 
> 
> Hi Christoffer,
>  another round, although I'll go ahead and post another
> iteration, sorry but as you mentioned this code is
> important.
> 
> > hmmm, by a non-writable region you mean a read-only memslot? Can you set
> > dirty page logging for such one?  That doesn't make much sense to me.
> 
> Come to think of it that's  true.
> 
> It's bit fuzzyy when I was looking at the API for KVM_MEM_LOG_DIRTY_PAGES,
> it appears user space needs to check if region is read-only and set region
> size to 0(qemu). I don't see any checks in kernel to disable logging if
> region is read only and we're enabling dirty page logging. API doesn't say
> anything else. You may be able to enable logging
> for read-only region if you leave region size as is.
> 
> I guess this has been around for quite a while so we
> can just assume read-only slots will have logging disabled.
> 

I'm a bit confused, IIUC we don't make any explicit checks in the code
right now, so either there is some generic code that never sets the
logging flag on a read-only memregion or you can change the
implementation of memslot_is_logging() to return false if the memslot is
read-only.

> > 
> > Note, that if you receive writable == false from gfn_to_pfn_prot() that
> > doesn't mean that the page can never be written to, it just means that
> > the current mapping of the page is not a writable one, you can call that
> > same function again later with write_fault=true, and you either get a
> > writable page back or you simply get an error.
> 
> Yes that's true after studying hva_to_pfn_slow(),
> and __get_user_pages_fast(), a lot of conditions
> handled there.
> 
> > 
> > [...]
> > 
> >>>>>  	if (kvm_is_device_pfn(pfn))
> >>>>>  		mem_type = PAGE_S2_DEVICE;
> >>
> >> If we're not setting the IOMAP flag do we have need
> >> this, since we're forfeiting error checking later
> >> in stage2_set_pte()?
> >>
> > 
> > we still need this, remember the error checking is about
> > cache == NULL, not about the IOMAP flag.  I think I address this in the
> > new proposal below, but please check carefully.
> 
> Ok so mmu notifier may call stage2_set_pte() with
> null cache poiner and intermediate table entries may
> not be there so stage2_get_pud() may return NULL.
> With logging on it won't happen, but just in case
> we check.

yes, to easily catch programming errors in the future, that's why if you
make it a VM_BUG_ON the check won't be compiled unless you have kernel
memory debugging enabled.

> 
> And we'll continue to handle Device faults until
> further notice.
> 

yes.

> > 
> > Take a look at this one:
> 
> Looks good to me, concise.
> 

Thanks,
-Christoffer
