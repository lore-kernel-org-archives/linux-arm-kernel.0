From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 22 Dec 2017 16:57:18 +0000
Subject: [PATCH v2 7/8] arm64: allow ID map to be extended to 52 bits
In-Reply-To: <a53c8d88-18c3-be49-91a1-5e2ff93b277a@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
 <20171222152307.11252-8-catalin.marinas@arm.com>
 <a53c8d88-18c3-be49-91a1-5e2ff93b277a@arm.com>
Message-ID: <2a5bd5c9-55a1-5a29-f032-d24f4ac8d8e1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
>> index accc2ff32a0e..7991718890c6 100644
>> --- a/arch/arm64/include/asm/mmu_context.h
>> +++ b/arch/arm64/include/asm/mmu_context.h
>> @@ -63,11 +63,21 @@ static inline void cpu_set_reserved_ttbr0(void)
>> ?? * physical memory, in which case it will be smaller.
>> ?? */
>> ? extern u64 idmap_t0sz;
>> +extern u64 idmap_ptrs_per_pgd;
>> -static inline bool __cpu_uses_extended_idmap(void)
>> +static inline bool __cpu_uses_extended_idmap_level(void)
>> ? {
>> -??? return (!IS_ENABLED(CONFIG_ARM64_VA_BITS_48) &&
>> -??????? unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)));
>> +??? return ARM64_HW_PGTABLE_LEVELS((64 - idmap_t0sz)) > CONFIG_PGTABLE_LEVELS;
>> +}
>> +
>> +/*
>> + * True if the extended ID map requires an extra level of translation table
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
>  ?__cpu_uses_extended_idmap_table =>? __cpu_uses_extended_idmap_level.
> 
> And the __cpu_uses_extended_idmap() doesn't need any changes. i.e :
> It could look like :
> 
> static inline bool __cpu_uses_extended_idmap_level(void)
> {

Err.. that should be __cpu_uses_extended_idmap(void)
