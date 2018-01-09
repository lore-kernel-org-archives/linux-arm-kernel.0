From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Tue, 9 Jan 2018 19:31:21 +0000
Subject: [PATCH v2 7/8] arm64: allow ID map to be extended to 52 bits
In-Reply-To: <a53c8d88-18c3-be49-91a1-5e2ff93b277a@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
 <20171222152307.11252-8-catalin.marinas@arm.com>
 <a53c8d88-18c3-be49-91a1-5e2ff93b277a@arm.com>
Message-ID: <66778278-8b85-90ce-fb55-5bd5e28490a7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/17 16:34, Suzuki K Poulose wrote:
> On 22/12/17 15:23, Catalin Marinas wrote:
>> From: Kristina Martsenko <kristina.martsenko@arm.com>
>>
>> Currently, when using VA_BITS < 48, if the ID map text happens to be
>> placed in physical memory above VA_BITS, we increase the VA size (up to
>> 48) and create a new table level, in order to map in the ID map text.
>> This is okay because the system always supports 48 bits of VA.
>>
>> This patch extends the code such that if the system supports 52 bits of
>> VA, and the ID map text is placed that high up, then we increase the VA
>> size accordingly, up to 52.
>>
>> One difference from the current implementation is that so far the
>> condition of VA_BITS < 48 has meant that the top level table is always
>> "full", with the maximum number of entries, and an extra table level is
>> always needed. Now, when VA_BITS = 48 (and using 64k pages), the top
>> level table is not full, and we simply need to increase the number of
>> entries in it, instead of creating a new table level.
>>
>> Tested-by: Bob Picco <bob.picco@oracle.com>
>> Reviewed-by: Bob Picco <bob.picco@oracle.com>
>> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
>> [catalin.marinas at arm.com: reduce arguments to __create_hyp_mappings()]
>> [catalin.marinas at arm.com: reworked/renamed __cpu_uses_extended_idmap_level()]
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>> ? arch/arm/include/asm/kvm_mmu.h?????? |? 5 +++
>> ? arch/arm64/include/asm/assembler.h?? |? 2 -
>> ? arch/arm64/include/asm/kvm_mmu.h???? |? 7 +++-
>> ? arch/arm64/include/asm/mmu_context.h | 18 +++++++--
>> ? arch/arm64/kernel/head.S???????????? | 76 +++++++++++++++++++++---------------
>> ? arch/arm64/kvm/hyp-init.S??????????? | 17 ++++----
>> ? arch/arm64/mm/mmu.c????????????????? |? 1 +
>> ? virt/kvm/arm/mmu.c?????????????????? | 10 ++++-
>> ? 8 files changed, 87 insertions(+), 49 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index 8dbec683638b..8c5643e2eea4 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -211,6 +211,11 @@ static inline bool __kvm_cpu_uses_extended_idmap(void)
>> ????? return false;
>> ? }
>> ? +static inline unsigned long __kvm_idmap_ptrs_per_pgd(void)
>> +{
>> +??? return PTRS_PER_PGD;
>> +}
>> +
>> ? static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
>> ???????????????????????? pgd_t *hyp_pgd,
>> ???????????????????????? pgd_t *merged_hyp_pgd,
>> diff --git a/arch/arm64/include/asm/assembler.h
>> b/arch/arm64/include/asm/assembler.h
>> index 49ea3def4bd1..942fdb5ef0ad 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -344,10 +344,8 @@ alternative_endif
>> ?? * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
>> ?? */
>> ????? .macro??? tcr_set_idmap_t0sz, valreg, tmpreg
>> -#ifndef CONFIG_ARM64_VA_BITS_48
>> ????? ldr_l??? \tmpreg, idmap_t0sz
>> ????? bfi??? \valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
>> -#endif
>> ????? .endm
>> ? ? /*
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index b3f7b68b042d..8d663ca0d50c 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -273,7 +273,12 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
>> ? ? static inline bool __kvm_cpu_uses_extended_idmap(void)
>> ? {
>> -??? return __cpu_uses_extended_idmap();
>> +??? return __cpu_uses_extended_idmap_table();
>> +}
>> +
>> +static inline unsigned long __kvm_idmap_ptrs_per_pgd(void)
>> +{
>> +??? return idmap_ptrs_per_pgd;
>> ? }
>> ? ? /*
>> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
>> index accc2ff32a0e..7991718890c6 100644
>> --- a/arch/arm64/include/asm/mmu_context.h
>> +++ b/arch/arm64/include/asm/mmu_context.h
>> @@ -63,11 +63,21 @@ static inline void cpu_set_reserved_ttbr0(void)
>> ?? * physical memory, in which case it will be smaller.
>> ?? */
>> ? extern u64 idmap_t0sz;
>> +extern u64 idmap_ptrs_per_pgd;
>> ? -static inline bool __cpu_uses_extended_idmap(void)
>> +static inline bool __cpu_uses_extended_idmap_level(void)
>> ? {
>> -??? return (!IS_ENABLED(CONFIG_ARM64_VA_BITS_48) &&
>> -??????? unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)));
>> +??? return ARM64_HW_PGTABLE_LEVELS((64 - idmap_t0sz)) > CONFIG_PGTABLE_LEVELS;
>> +}
>> +
>> +/*
>> + * True if the extended ID map requires an extra level of translation
>> table
>> + * to be configured.
>> + */
>> +static inline bool __cpu_uses_extended_idmap_table(void)
>> +{
>> +??? return __cpu_uses_extended_idmap_level() &&
>> +??????? (idmap_ptrs_per_pgd == PTRS_PER_PGD);
>> ? }
> 
> As discussed offline, I was talking about changing
> 
> ?__cpu_uses_extended_idmap_table =>? __cpu_uses_extended_idmap_level.
> 
> And the __cpu_uses_extended_idmap() doesn't need any changes. i.e :
> It could look like :
> 
> static inline bool __cpu_uses_extended_idmap(void)
> {
> ????return (!IS_ENABLED(CONFIG_ARM64_VA_BITS_48) &&
> ??????? unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)));
> }

The changes to __cpu_uses_extended_idmap_level (below) look good to me,
but it seems that __cpu_uses_extended_idmap (above) has mistakenly been
changed too. It should look like this, as it was in v1 of this series:

static inline bool __cpu_uses_extended_idmap(void)
{
	return unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS));
}

With the current code, the kernel fails to boot when VA_BITS = 48 and
the idmap is in 52-bit memory.

> 
> static inline bool __cpu_uses_extended_idmap_level(void)
> {
> ????return ARM64_HW_PGTABLE_LEVELS((64 - idmap_t0sz)) > CONFIG_PGTABLE_LEVELS;

(double parentheses?)

Thanks,
Kristina

> }
> 
> And the __kvm_cpu_uses_extended_idmap() above should use the
> 
> __cpu_uses_extended_idmap_level().
> 
> Sorry for the confusion.
> 
> 
> With that:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
