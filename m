From: hejianet@gmail.com (Jia He)
Date: Thu, 17 May 2018 20:46:50 +0800
Subject: [PATCH] KVM: arm/arm64: add WARN_ON if size is not PAGE_SIZE
 aligned in unmap_stage2_range
In-Reply-To: <698b0355-d430-86b8-cd09-83c6d9e566f8@arm.com>
References: <1526537487-14804-1-git-send-email-hejianet@gmail.com>
 <698b0355-d430-86b8-cd09-83c6d9e566f8@arm.com>
Message-ID: <fbb269c0-e915-a9f2-da3b-5ae3a2b31396@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki

On 5/17/2018 4:17 PM, Suzuki K Poulose Wrote:
> 
> Hi Jia,
> 
> On 17/05/18 07:11, Jia He wrote:
>> I ever met a panic under memory pressure tests(start 20 guests and run
>> memhog in the host).
> 
> Please avoid using "I" in the commit description and preferably stick to
> an objective description.

Thanks for the pointing

> 
>>
>> The root cause might be what I fixed at [1]. But from arm kvm points of
>> view, it would be better we caught the exception earlier and clearer.
>>
>> If the size is not PAGE_SIZE aligned, unmap_stage2_range might unmap the
>> wrong(more or less) page range. Hence it caused the "BUG: Bad page
>> state"
> 
> I don't see why we should ever panic with a "positive" size value. Anyways,
> the unmap requests must be in units of pages. So this check might be useful.
> 
> 

good question,

After further digging, maybe we need to harden the break condition as below?
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 7f6a944..dac9b2e 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -217,7 +217,7 @@ static void unmap_stage2_ptes(struct kvm *kvm, pmd_t *pmd,

                        put_page(virt_to_page(pte));
                }
-       } while (pte++, addr += PAGE_SIZE, addr != end);
+       } while (pte++, addr += PAGE_SIZE, addr < end);

basically verified in my armv8a server

-- 
Cheers,
Jia
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
>>
>> [1] https://lkml.org/lkml/2018/5/3/1042
>>
>> Signed-off-by: jia.he at hxt-semitech.com
>> ---
>> ? virt/kvm/arm/mmu.c | 2 ++
>> ? 1 file changed, 2 insertions(+)
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index 7f6a944..8dac311 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -297,6 +297,8 @@ static void unmap_stage2_range(struct kvm *kvm,
>> phys_addr_t start, u64 size)
>> ????? phys_addr_t next;
>> ? ????? assert_spin_locked(&kvm->mmu_lock);
>> +??? WARN_ON(size & ~PAGE_MASK);
>> +
>> ????? pgd = kvm->arch.pgd + stage2_pgd_index(addr);
>> ????? do {
>> ????????? /*
>>
> 
> 
