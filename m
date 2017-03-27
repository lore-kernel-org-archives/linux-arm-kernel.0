From: james.morse@arm.com (James Morse)
Date: Mon, 27 Mar 2017 13:00:56 +0100
Subject: [PATCH] KVM: arm/arm64: Signal SIGBUS when stage2 discovers
 hwpoison memory
In-Reply-To: <87y3vrezjb.fsf@e105922-lin.cambridge.arm.com>
References: <20170315160727.16465-1-james.morse@arm.com>	<20170324183044.GK25903@cbox>
 <87y3vrezjb.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <58D8FEF8.9000205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 27/03/17 12:20, Punit Agrawal wrote:
> Christoffer Dall <cdall@linaro.org> writes:
>> On Wed, Mar 15, 2017 at 04:07:27PM +0000, James Morse wrote:
>>> Once we enable ARCH_SUPPORTS_MEMORY_FAILURE on arm64[0], notifications for
>>> broken memory can call memory_failure() in mm/memory-failure.c to deliver
>>> SIGBUS to any user space process using the page, and notify all the
>>> in-kernel users.
>>>
>>> If the page corresponded with guest memory, KVM will unmap this page
>>> from its stage2 page tables. The user space process that allocated
>>> this memory may have never touched this page in which case it may not
>>> be mapped meaning SIGBUS won't be delivered.
>>>
>>> When this happens KVM discovers pfn == KVM_PFN_ERR_HWPOISON when it
>>> comes to process the stage2 fault.
>>>
>>> Do as x86 does, and deliver the SIGBUS when we discover
>>> KVM_PFN_ERR_HWPOISON. Use the stage2 mapping size as the si_addr_lsb
>>> as this matches the user space mapping size.

>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>>> index 962616fd4ddd..9d1aa294e88f 100644
>>> --- a/arch/arm/kvm/mmu.c
>>> +++ b/arch/arm/kvm/mmu.c
>>> @@ -20,8 +20,10 @@
>>>  #include <linux/kvm_host.h>
>>>  #include <linux/io.h>
>>>  #include <linux/hugetlb.h>
>>> +#include <linux/sched/signal.h>
>>>  #include <trace/events/kvm.h>
>>>  #include <asm/pgalloc.h>
>>> +#include <asm/siginfo.h>
>>>  #include <asm/cacheflush.h>
>>>  #include <asm/kvm_arm.h>
>>>  #include <asm/kvm_mmu.h>
>>> @@ -1237,6 +1239,23 @@ static void coherent_cache_guest_page(struct kvm_vcpu *vcpu, kvm_pfn_t pfn,
>>>  	__coherent_cache_guest_page(vcpu, pfn, size);
>>>  }
>>>  
>>> +static void kvm_send_hwpoison_signal(unsigned long address, bool hugetlb)
>>> +{
>>> +	siginfo_t info;
>>> +
>>> +	info.si_signo   = SIGBUS;
>>> +	info.si_errno   = 0;
>>> +	info.si_code    = BUS_MCEERR_AR;
>>> +	info.si_addr    = (void __user *)address;
>>> +
>>> +	if (hugetlb)
>>> +		info.si_addr_lsb = PMD_SHIFT;
>>> +	else
>>> +		info.si_addr_lsb = PAGE_SHIFT;
>>> +
>>> +	send_sig_info(SIGBUS, &info, current);
>>> +}
>>> +
>>>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>  			  struct kvm_memory_slot *memslot, unsigned long hva,
>>>  			  unsigned long fault_status)
>>> @@ -1306,6 +1325,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>  	smp_rmb();
>>>  
>>>  	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
>>> +	if (pfn == KVM_PFN_ERR_HWPOISON) {
>>> +		kvm_send_hwpoison_signal(hva, hugetlb);
>>
>> The way this is called means that we'll only notify userspace of a huge
>> mapping if userspace is mapping hugetlbfs, and not because the stage2
>> mapping may or may not have used transparent huge pages when the error
>> was discovered.  Is this the desired semantics?

No,


> I think so.
>
> AFAIUI, transparent hugepages are split before being poisoned while all
> the underlying pages of a hugepage are poisoned together, i.e., no
> splitting.

In which case I need to look into this some more!

My thinking was we should report the size that was knocked out of the stage2 to
avoid the guest repeatedly faulting until it has touched every guest-page-size
in the stage2 hole.

Reading the code in that kvm/mmu.c it looked like the mapping sizes would always
be the same as those used by userspace.

If the page was split before KVM could have taken this fault I assumed it would
fault on the page-size mapping and hugetlb would be false. (which is already
wrong for another reason, looks like I grabbed the variable before
transparent_hugepage_adjust() has had a go a it.).


>> Also notice that the hva is not necessarily aligned to the beginning of
>> the huge page, so can we be giving userspace wrong information by
>> pointing in the middle of a huge page and telling it there was an
>> address error in the size of the PMD ?
>>
> 
> I could be reading it wrong but I think we are fine here - the address
> (hva) is the location that faulted. And the lsb indicates the least
> significant bit of the faulting address (See man sigaction(2)). The
> receiver of the signal is expected to use the address and lsb to workout
> the extent of corruption.

kill_proc() in mm/memory-failure.c does this too, but the address is set by
page_address_in_vma() in add_to_kill() of the same file. (I'll chat with Punit
off list.)


> Though I missed a subtlety while reviewing the patch before. The
> reported lsb should be for the userspace hugepage mapping (i.e., hva)
> and not for the stage 2.

I thought these were always supposed to be the same, and using hugetlb was a bug
because I didn't look closely enough at what is_vm_hugetlb_page() does.


> In light of this, I'd like to retract my Reviewed-by tag for this
> version of the patch as I believe we'll need to change the lsb
> reporting.

Sure, lets work out what this should be doing. I'm beginning to suspect x86's
'always page size' was correct to begin with!


Thanks,

James
