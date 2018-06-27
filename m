From: james.morse@arm.com (James Morse)
Date: Wed, 27 Jun 2018 12:23:02 +0100
Subject: [PATCH v2 2/2] arm64/mm: Move {tramp_pg_dir, swapper_pg_dir} to
 .rodata section
In-Reply-To: <82f3bf16-cf3a-9b2d-a7d2-789a4abb0bf2@arm.com>
References: <20180625113921.21854-1-yaojun8558363@gmail.com>
 <20180625113921.21854-3-yaojun8558363@gmail.com>
 <82f3bf16-cf3a-9b2d-a7d2-789a4abb0bf2@arm.com>
Message-ID: <ceb6135a-4e4d-d597-85aa-7639a044d097@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki, Jun,

On 27/06/18 12:07, Suzuki K Poulose wrote:
> On 25/06/18 12:39, Jun Yao wrote:
>> When CONFIG_ARM64_VA_BITS_36/CONFIG_ARM64_VA_BITS_39/
>> CONFIG_ARM64_VA_BITS_42 are selected, a block-mapping can be
>> written to swapper_pg_dir. To defend 'KSMA', we move swapper_pg_dir
>> to .rodata section when these configurations are selected. At the
>> same time, we update swapper_pg_dir by fixmap.

>> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
>> index 2e05bcd944c8..62512ad9c310 100644
>> --- a/arch/arm64/include/asm/pgalloc.h
>> +++ b/arch/arm64/include/asm/pgalloc.h
>> @@ -49,6 +49,22 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t
>> pmdp, pudval_t prot)
>> ? ? static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t
>> *pmdp)
>> ? {
>> +#ifdef CONFIG_ARM64_VA_BITS_39
> 
> Could we please use
> 
> #ifdef __PAGETABLE_PUD_FOLDED ^^

>> @@ -142,6 +158,23 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
>> pte_t *ptep)
>> ????? /*
>> ?????? * The pmd must be loaded with the physical address of the PTE table
>> ?????? */
>> +#if defined(CONFIG_ARM64_VA_BITS_42) || \
>> +??? defined(CONFIG_ARM64_VA_BITS_36)
> 
> and
> 
> #ifdef __PGTABLE_PMD_FOLDED here ^^
> 
> 
>> +#if defined(CONFIG_ARM64_VA_BITS_39) || \
>> +??? defined(CONFIG_ARM64_VA_BITS_36) || \
>> +??? defined(CONFIG_ARM64_VA_BITS_42)
> 
> and
> 
> #ifdef __PGTABLE_PMD_FOLDED ^^ (as it implies
> __PGTABLE_PUD_FOLDED )
> 
> instead ?

Aha, I didn't know these existed. As we are only interested in matching one
level for now, this is even clearer.


Thanks,

James
