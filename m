From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Dec 2013 08:34:02 +0000
Subject: [RFC PATCH] arm/arm64: KVM: allow the use of THP on 2MB aligned
 memslots
In-Reply-To: <20131213013621.GS2871@cbox>
References: <1386859881-13482-1-git-send-email-marc.zyngier@arm.com>
 <20131213013621.GS2871@cbox>
Message-ID: <65d2a9ecb5ca1475c9ededfeb13d2961@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-13 01:36, Christoffer Dall wrote:
> On Thu, Dec 12, 2013 at 02:51:21PM +0000, Marc Zyngier wrote:
>> The THP code in KVM/ARM is a bit restrictive in not allowing a THP
>> to be used if the VMA is not 2MB aligned. Actually, it is not so 
>> much
>> the VMA that matters, but the associated memslot:
>>
>> A process can perfectly mmap a region with no particular alignment
>> restriction, and then pass a 2MB aligned address to KVM. In this
>> case, KVM will only use this 2MB aligned region, and will ignore
>> the range between vma->vm_start and memslot->userspace_addr.
>>
>> The fix is then to check the alignment of memslot->userspace_addr.
>
> That's more correct, but I'm wondering if it's enough.
>
> What happens if the base_gfn is not aligned to a 2MB region, will we 
> not
> be mapping something completely bogus here?

Indeed. So far, we haven't seen a stupid enough userspace, but I'm sure 
it will happen.

I'll update this patch to also check for the base IPA of the memslot.

Thanks,

         M.
>
>>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/kvm/mmu.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 5809069..cec641a 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -667,14 +667,14 @@ static int user_mem_abort(struct kvm_vcpu 
>> *vcpu, phys_addr_t fault_ipa,
>>  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>>  	} else {
>>  		/*
>> -		 * Pages belonging to VMAs not aligned to the PMD mapping
>> +		 * Pages belonging to memslots not aligned to the PMD mapping
>>  		 * granularity cannot be mapped using block descriptors even
>>  		 * if the pages belong to a THP for the process, because the
>>  		 * stage-2 block descriptor will cover more than a single THP
>>  		 * and we loose atomicity for unmapping, updates, and splits
>>  		 * of the THP or other pages in the stage-2 block range.
>>  		 */
>> -		if (vma->vm_start & ~PMD_MASK)
>> +		if (memslot->userspace_addr & ~PMD_MASK)
>>  			force_pte = true;
>>  	}
>>  	up_read(&current->mm->mmap_sem);
>> --
>> 1.8.2.3
>>
>>

-- 
Fast, cheap, reliable. Pick two.
