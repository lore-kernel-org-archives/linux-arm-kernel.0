From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Dec 2014 09:31:11 +0000
Subject: Help on kvm_tlb_flush_vmid_ipa usage
In-Reply-To: <54935451.6090405@samsung.com>
References: <54932A97.3060103@samsung.com> <54932D1F.5060209@arm.com>
 <54935451.6090405@samsung.com>
Message-ID: <5493F05F.9090002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/14 22:25, Mario Smarduch wrote:
> On 12/18/2014 11:38 AM, Marc Zyngier wrote:
>> On 18/12/14 19:27, Mario Smarduch wrote:
>>> When this function is called IPA address is used. Looking at the HYP
>>> implementation it uses the IPA directly in tlbi instructions. But
>>> reading the TLB maintnance instruction syntax, bit [35:0] should be
>>> set to IPA[47:12]. I traced the source code but don't see the
>>> adjustment. I must be missing something given this function is
>>> fundamental to KVM MMU.
>>
>> Ermmm... Someone (that is, I) needs a brown paper back again.
>>
>> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>> index b72aa9f..a767f6a 100644
>> --- a/arch/arm64/kvm/hyp.S
>> +++ b/arch/arm64/kvm/hyp.S
>> @@ -1014,6 +1014,7 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
>>  	 * Instead, we invalidate Stage-2 for this IPA, and the
>>  	 * whole of Stage-1. Weep...
>>  	 */
>> +	lsr	x1, x1, #12
>>  	tlbi	ipas2e1is, x1
>>  	/*
>>  	 * We have to ensure completion of the invalidation at Stage-2,
>>
>> 	M.
>>
> 
> Hi Marc,
>   fwiw I re-ran the test that halts the host (on foundation
> model) with a guest booted, panic has gone away.
> 
> BUG: Bad page state in process K20nfsserver  pfn:ff818
> page:ffff7c7fc37e4540 count:-3 mapcount:0 mapping:          (null) index:0x0
> flags: 0x0()
> page dumped because: nonzero _count
> Modules linked in:
> CPU: 1 PID: 761 Comm: K20nfsserver Not tainted 3.18.0-rc2+ #55
> Call trace:
> [<ffff800000087244>] dump_backtrace+0x0/0x12c
> [<ffff800000087380>] show_stack+0x10/0x1c
> [<ffff8000003ce804>] dump_stack+0x74/0x98
> [<ffff80000011bdc4>] bad_page+0xdc/0x12c
> [<ffff80000011ecc4>] get_page_from_freelist+0x4b4/0x600
> [<ffff80000011eeec>] __alloc_pages_nodemask+0xdc/0x780
> [<ffff80000011f5a4>] __get_free_pages+0x14/0x5c
> [<ffff80000011f5fc>] get_zeroed_page+0x10/0x1c
> [<ffff8000000903fc>] pgd_alloc+0xc/0x18
> [<ffff8000000a13a0>] mm_init+0xcc/0x12c
> [<ffff8000000a17f8>] mm_alloc+0x44/0x54
> [<ffff800000166cbc>] do_execve+0x1a8/0x49c
> [<ffff8000001671bc>] SyS_execve+0x1c/0x2c
> 

Absolutely amazing that we managed to run for so long with such a bug. I
suppose we rarely update page table entries, and most implementations
don't use split TLBs (where this instruction is useful).

Thanks a lot for reporting this bug, I'll repost a proper fix today.

	M.
-- 
Jazz is not dead. It just smells funny...
