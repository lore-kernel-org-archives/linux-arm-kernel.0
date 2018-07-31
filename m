From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 31 Jul 2018 11:17:30 +0100
Subject: [PATCH v5 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <20180730170337.rycf34urt7n2fptq@armageddon.cambridge.arm.com>
References: <1529403502-2843-1-git-send-email-vladimir.murzin@arm.com>
 <1529403502-2843-2-git-send-email-vladimir.murzin@arm.com>
 <20180727113502.3qdbyffuvysva6bz@armageddon.cambridge.arm.com>
 <f3da236e-504d-66ab-19da-9f89eba253f1@arm.com>
 <20180730154209.2tawriqxgxub7paa@armageddon.cambridge.arm.com>
 <16344e26-6cd2-5e55-d34e-fd2a48bef733@arm.com>
 <20180730170337.rycf34urt7n2fptq@armageddon.cambridge.arm.com>
Message-ID: <a6a0ad8a-7962-9775-2924-a6f3b2724bcb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/18 18:03, Catalin Marinas wrote:
> On Mon, Jul 30, 2018 at 05:29:35PM +0100, Robin Murphy wrote:
>> On 30/07/18 16:42, Catalin Marinas wrote:
>>> On Mon, Jul 30, 2018 at 11:08:27AM +0100, Vladimir Murzin wrote:
>>>> On 27/07/18 12:35, Catalin Marinas wrote:
>>>>> On Tue, Jun 19, 2018 at 11:18:20AM +0100, Vladimir Murzin wrote:
>>>>>> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
>>>>>> index 39ec0b8..c506fb7 100644
>>>>>> --- a/arch/arm64/include/asm/mmu_context.h
>>>>>> +++ b/arch/arm64/include/asm/mmu_context.h
>>>>>> @@ -149,6 +149,18 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
>>>>>>   	phys_addr_t pgd_phys = virt_to_phys(pgdp);
>>>>>> +	if (system_supports_cnp() && !WARN_ON(pgdp != lm_alias(swapper_pg_dir))) {
>>>>>> +		/*
>>>>>> +		 * cpu_replace_ttbr1() is used when there's a boot CPU
>>>>>> +		 * up (i.e. cpufeature framework is not up yet) and
>>>>>> +		 * latter only when we enable CNP via cpufeature's
>>>>>> +		 * enable() callback.
>>>>>> +		 * Also we rely on the cpu_hwcap bit being set before
>>>>>> +		 * calling the enable() function.
>>>>>> +		 */
>>>>>> +		pgd_phys |= TTBR_CNP_BIT;
>>>>>> +	}
>>>>>> +
>>>>>>   	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
>>>>>
>>>>> So the above code sets the TTBR_CNP_BIT (bit 0) in pgd_phys and calls
>>>>> the idmap_cpu_replace_ttbr1() with this value. Looking at the latter, it
>>>>> performs a phys_to_ttbr transformation of pgd_phys which masks out the
>>>>> bottom 2 bits when CONFIG_ARM64_PA_BITS_52 is enabled. I think we need
>>>>> to tweak TTBR_BADDR_MASK_52 to start from bit 0.
>>>>
>>>> Something like bellow?
>>>>
>>>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>>>> index 0bcc98d..e0b4b2f 100644
>>>> --- a/arch/arm64/include/asm/assembler.h
>>>> +++ b/arch/arm64/include/asm/assembler.h
>>>> @@ -524,11 +524,10 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>>>>    * 	ttbr:	returns the TTBR value
>>>>    */
>>>>   	.macro	phys_to_ttbr, ttbr, phys
>>>> -#ifdef CONFIG_ARM64_PA_BITS_52
>>>> -	orr	\ttbr, \phys, \phys, lsr #46
>>>> -	and	\ttbr, \ttbr, #TTBR_BADDR_MASK_52
>>>> -#else
>>>>   	mov	\ttbr, \phys
>>>> +#ifdef CONFIG_ARM64_PA_BITS_52
>>>> +	ubfx	\ttbr, \ttbr, #48, #4
>>>> +	orr	\ttbr, \phys, \ttbr, lsl #2
>>>>   #endif
>>>>   	.endm
>>>
>>> This would do, I don't have a better idea on how to write it. But I'd
>>> like a comment to say that this is moving bits 51:48 of the address to
>>> bits 5:2 of TTBR_ELx.
>>
>> The diff above is *copying* 51:48 into 5:2; it doesn't *move* it like the
>> existing code does. That's pretty crucial, because without the BADDR masking
>> operation it's going to leave the upper address bits in the ASID/VMID field,
>> which looks like a recipe for disaster if the reserved TTBR1 happens to be
>> at a high enough address (at least cpu_switch_mm might just be OK by virtue
>> of using BFI rather than ORR for the ASID).
> 
> Oh, very good point.
> 
>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>> index 1bdeca8..1b9d0e9 100644
>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>> @@ -770,7 +770,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>>>>   #define kc_offset_to_vaddr(o)	((o) | VA_START)
>>>>   #ifdef CONFIG_ARM64_PA_BITS_52
>>>> -#define phys_to_ttbr(addr)	(((addr) | ((addr) >> 46)) & TTBR_BADDR_MASK_52)
>>>> +#define phys_to_ttbr(addr)	((addr) | (((addr) >> 46) & TTBR_BADDR_MASK_52))
>>
>> Ditto - by the look of things, this definitely stands to corrupt the VMID in
>> update_vttbr(). If we really have no choice but to smuggle the CnP value in
>> something which is logically an address, then I think we'd need to handle it
>> more like this:
>>
>> #define TTBR_CNP (1)
>> #define phys_to_ttbr(addr) \
>> ((((addr) | ((addr) >> 46)) & TTBR_BADDR_MASK_52) | (addr & TTBR_CNP))
>>
>> Although in patch #2 we're only applying CnP *after* the BADDR conversion,
>> so is changing this one even necessary? If I've understood the intent
>> correctly, all that might be needed is something like the below (untested,
>> of course).
> 
> Or we could keep phys_to_ttbr() as it is for both the asm and C and
> apply the CNP bit afterwards (as you've already noticed in patch 2). For
> cpu_replace_ttbr1(), we'd also need to change idmap_cpu_replace_ttbr1 to
> actually take the TTBR1_EL1 value directly so that it doesn't have to
> invoke phys_to_ttbr().
> 

Does it represent your idea correctly?

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c506fb7..b6ba2f0 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -147,7 +147,8 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
 	ttbr_replace_func *replace_phys;
 
-	phys_addr_t pgd_phys = virt_to_phys(pgdp);
+	/* phys_to_ttbr() zeros lower 2 bits of ttbr with 52-bit PA */
+	phys_addr_t ttbr1 = phys_to_ttbr(virt_to_phys(pgdp));
 
 	if (system_supports_cnp() && !WARN_ON(pgdp != lm_alias(swapper_pg_dir))) {
 		/*
@@ -158,13 +159,13 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 		 * Also we rely on the cpu_hwcap bit being set before
 		 * calling the enable() function.
 		 */
-		pgd_phys |= TTBR_CNP_BIT;
+		ttbr1 |= TTBR_CNP_BIT;
 	}
 
 	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
 	cpu_install_idmap();
-	replace_phys(pgd_phys);
+	replace_phys(ttbr1);
 	cpu_uninstall_idmap();
 }
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index bde3a3b..2c75b0b 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -190,7 +190,7 @@ ENDPROC(cpu_do_switch_mm)
 .endm
 
 /*
- * void idmap_cpu_replace_ttbr1(phys_addr_t new_pgd)
+ * void idmap_cpu_replace_ttbr1(phys_addr_t ttbr1)
  *
  * This is the low-level counterpart to cpu_replace_ttbr1, and should not be
  * called by anything else. It can only be executed from a TTBR0 mapping.
@@ -200,8 +200,7 @@ ENTRY(idmap_cpu_replace_ttbr1)
 
 	__idmap_cpu_set_reserved_ttbr1 x1, x3
 
-	phys_to_ttbr x3, x0
-	msr	ttbr1_el1, x3
+	msr	ttbr1_el1, x0
 	isb
 
 	restore_daif x2
