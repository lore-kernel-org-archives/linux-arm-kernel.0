From: peng.hao2@zte.com.cn (peng.hao2 at zte.com.cn)
Date: Sat, 10 Mar 2018 11:48:12 +0800 (CST)
Subject: =?UTF-8?B?UmU6IFJlOiBbUEFUQ0hdIEtWTTphcm0vYXJtNjQ6IGRjYWNoZSBuZWVkIGJlIGNvaGVyZW50IHVuY29uZGl0aW9uYWxseQ==?=
Message-ID: <201803101148125935444@zte.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>On 09/03/18 22:15, Peng Hao wrote:
>> For emulation devices just like vga, keeping coherent dcache between
>> guest and host timely is needed.
>> Now the display of vnc-viewer will not update continuously and the
>> patch can fix up.
>> 
>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>> ---
>>  virt/kvm/arm/mmu.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index ec62d1c..4a28395e 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1416,8 +1416,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>              kvm_set_pfn_dirty(pfn);
>>          }
>>  
>> -        if (fault_status != FSC_PERM)
>> -            clean_dcache_guest_page(pfn, PMD_SIZE);
>> +        clean_dcache_guest_page(pfn, PMD_SIZE);
>>  
>>          if (exec_fault) {
>>              new_pmd = kvm_s2pmd_mkexec(new_pmd);
>> @@ -1438,8 +1437,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>              mark_page_dirty(kvm, gfn);
>>          }
>>  
>> -        if (fault_status != FSC_PERM)
>> -            clean_dcache_guest_page(pfn, PAGE_SIZE);
>> +        clean_dcache_guest_page(pfn, PAGE_SIZE);
>>  
>>          if (exec_fault) {
>>              new_pte = kvm_s2pte_mkexec(new_pte);
>> 

>I'm sorry, but I have to NAK this.

>You're papering over the fundamental issue that you're accessing a
>cacheable alias of a non cacheable memory. The architecture is very
>clear about why this doesn't work, and KVM implements the architecture.

I find that I  just encounter the problem after  the commit '15303ba5d1cd9b28d03a980456c0978c0ea3b208 " .
The commit contains "icache invalidation optimizations, improving VM startup time",it changes
from unconditionally calling coherent_cache_guest_page(including dcache handle) to conditionally calling clean_dcache_guest_page.
 I trace the display of vnc abnormally and find it generate data abort in vga
address region with FSC_PERM,and it will not call clean_dcache_guest_page . So I think  should recover to uncontionally calling clean_dcache_guest_page.

Thanks.
>If you want this to work, map your VGA device as cacheable, add cache
>maintenance to QEMU, or use another frame-buffer emulation that doesn't
>require such a gack.

>Thanks,

>    M.
>-- 
>Jazz is not dead. It just smells funny...
