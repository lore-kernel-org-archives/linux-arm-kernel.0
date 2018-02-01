From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 1 Feb 2018 14:54:10 +0000
Subject: [PATCH v4 3/6] arm: KVM: Invalidate BTB on guest exit for
 Cortex-A12/A17
In-Reply-To: <0cccb2da-7a49-3d05-4bee-405e838a029d@arm.com>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
 <20180201110738.5421-4-marc.zyngier@arm.com>
 <0cccb2da-7a49-3d05-4bee-405e838a029d@arm.com>
Message-ID: <8acfbfb5-06d9-4820-8308-13a0de1caa7c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/18 11:34, Robin Murphy wrote:
> On 01/02/18 11:07, Marc Zyngier wrote:
>> In order to avoid aliasing attacks against the branch predictor,
>> let's invalidate the BTB on guest exit. This is made complicated
>> by the fact that we cannot take a branch before invalidating the
>> BTB.
>>
>> We only apply this to A12 and A17, which are the only two ARM
>> cores on which this useful.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>> ? arch/arm/include/asm/kvm_asm.h |? 2 --
>> ? arch/arm/include/asm/kvm_mmu.h | 18 ++++++++++-
>> ? arch/arm/kvm/hyp/hyp-entry.S?? | 71 
>> ++++++++++++++++++++++++++++++++++++++++--
>> ? 3 files changed, 86 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_asm.h 
>> b/arch/arm/include/asm/kvm_asm.h
>> index 36dd2962a42d..df24ed48977d 100644
>> --- a/arch/arm/include/asm/kvm_asm.h
>> +++ b/arch/arm/include/asm/kvm_asm.h
>> @@ -61,8 +61,6 @@ struct kvm_vcpu;
>> ? extern char __kvm_hyp_init[];
>> ? extern char __kvm_hyp_init_end[];
>> -extern char __kvm_hyp_vector[];
>> -
>> ? extern void __kvm_flush_vm_context(void);
>> ? extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
>> ? extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
>> diff --git a/arch/arm/include/asm/kvm_mmu.h 
>> b/arch/arm/include/asm/kvm_mmu.h
>> index a2d176a308bd..dedd4b8a3fa4 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -37,6 +37,7 @@
>> ? #include <linux/highmem.h>
>> ? #include <asm/cacheflush.h>
>> +#include <asm/cputype.h>
>> ? #include <asm/pgalloc.h>
>> ? #include <asm/stage2_pgtable.h>
>> @@ -228,7 +229,22 @@ static inline unsigned int kvm_get_vmid_bits(void)
>> ? static inline void *kvm_get_hyp_vector(void)
>> ? {
>> -??? return kvm_ksym_ref(__kvm_hyp_vector);
>> +??? switch(read_cpuid_part()) {
>> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>> +??? case ARM_CPU_PART_CORTEX_A12:
>> +??? case ARM_CPU_PART_CORTEX_A17:
>> +??? {
>> +??????? extern char __kvm_hyp_vector_bp_inv[];
> 
> Super-nit: Is there a reason for scoping these declarations so tightly? 
> Fair enough if there's something subtle I'm missing, but if not then 
> it's probably a little more pleasant readability-wise to push them up a 
> step into the function scope.

Ah, I see, declaring this at function scope gets you an unused variable 
warning for HARDEN_BRANCH_PREDICTOR=n. Moving it to file scope above the 
function might be OK (my syntax highlighter still picks it out, but GCC 
shuts up), but maybe the "scope to usage" way has the fewest headaches 
overall, even it it does lead to wacky brackets. Oh well.

Robin.
