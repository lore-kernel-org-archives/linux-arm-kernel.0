From: james.morse@arm.com (James Morse)
Date: Fri, 17 Mar 2017 15:48:46 +0000
Subject: [PATCH] KVM: arm/arm64: Signal SIGBUS when stage2 discovers
 hwpoison memory
In-Reply-To: <87wpbohrj3.fsf@e105922-lin.cambridge.arm.com>
References: <20170315160727.16465-1-james.morse@arm.com>
 <87wpbohrj3.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <58CC055E.50800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punit,

On 17/03/17 15:06, Punit Agrawal wrote:
> James Morse <james.morse@arm.com> writes:
>> Once we enable ARCH_SUPPORTS_MEMORY_FAILURE on arm64[0], notifications for
>> broken memory can call memory_failure() in mm/memory-failure.c to deliver
>> SIGBUS to any user space process using the page, and notify all the
>> in-kernel users.
>>
>> If the page corresponded with guest memory, KVM will unmap this page
>> from its stage2 page tables. The user space process that allocated
>> this memory may have never touched this page in which case it may not
>> be mapped meaning SIGBUS won't be delivered.
>>
>> When this happens KVM discovers pfn == KVM_PFN_ERR_HWPOISON when it
>> comes to process the stage2 fault.
>>
>> Do as x86 does, and deliver the SIGBUS when we discover
>> KVM_PFN_ERR_HWPOISON. Use the stage2 mapping size as the si_addr_lsb
>> as this matches the user space mapping size.

>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 962616fd4ddd..9d1aa294e88f 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -1237,6 +1239,23 @@ static void coherent_cache_guest_page(struct kvm_vcpu *vcpu, kvm_pfn_t pfn,
>>  	__coherent_cache_guest_page(vcpu, pfn, size);
>>  }
>>  
>> +static void kvm_send_hwpoison_signal(unsigned long address, bool hugetlb)
>> +{
>> +	siginfo_t info;
>> +
>> +	info.si_signo   = SIGBUS;
>> +	info.si_errno   = 0;
>> +	info.si_code    = BUS_MCEERR_AR;
>> +	info.si_addr    = (void __user *)address;
>> +
>> +	if (hugetlb)
>> +		info.si_addr_lsb = PMD_SHIFT;
>> +	else
>> +		info.si_addr_lsb = PAGE_SHIFT;
>> +
>> +	send_sig_info(SIGBUS, &info, current);
>> +}

> The changes look good to me. Though in essence as mentioned in the
> commit log we are not doing anything different to x86 here. Worth moving
> kvm_send_hwpoison_signal to an architecture agostic location and using
> it from there?

I had an earlier version that did exactly that, but the x86 version always
reports PAGE_SHIFT as the si_addr_lsb value. I don't know enough about their
version of stage2 to know if that's a bug or an implementation detail, so I
chose not to copy it.


> In any case, FWIW,
> 
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks!

James
