From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Tue, 5 Dec 2017 14:19:07 +0000
Subject: [PATCH 06/11] change memory_is_poisoned_16 for aligned error
In-Reply-To: <20171019125133.GA20805@n2100.armlinux.org.uk>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-7-liuwenliang@huawei.com>
 <20171011162345.f601c29d12c81af85bf38565@linux-foundation.org>
 <CACT4Y+Ym3kq5RZ-4F=f97bvT2pNpzDf0kerf6tebzLOY_crR8Q@mail.gmail.com>
 <B8AC3E80E903784988AB3003E3E97330B2528234@dggemm510-mbs.china.huawei.com>
 <20171019125133.GA20805@n2100.armlinux.org.uk>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C006EF9B@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 23, 2017  20:30  Russell King - ARM Linux [mailto:linux at armlinux.org.uk]  wrote:
>On Thu, Oct 12, 2017 at 11:27:40AM +0000, Liuwenliang (Lamb) wrote:
>> >> - I don't understand why this is necessary.  memory_is_poisoned_16()
>> >>   already handles unaligned addresses?
>> >>
>> >> - If it's needed on ARM then presumably it will be needed on other
>> >>   architectures, so CONFIG_ARM is insufficiently general.
>> >>
>> >> - If the present memory_is_poisoned_16() indeed doesn't work on ARM,
>> >>   it would be better to generalize/fix it in some fashion rather than
>> >>   creating a new variant of the function.
>>
>>
>> >Yes, I think it will be better to fix the current function rather then
>> >have 2 slightly different copies with ifdef's.
>> >Will something along these lines work for arm? 16-byte accesses are
>> >not too common, so it should not be a performance problem. And
>> >probably modern compilers can turn 2 1-byte checks into a 2-byte check
>> >where safe (x86).
>>
>> >static __always_inline bool memory_is_poisoned_16(unsigned long addr)
>> >{
>> >        u8 *shadow_addr = (u8 *)kasan_mem_to_shadow((void *)addr);
>> >
>> >        if (shadow_addr[0] || shadow_addr[1])
>> >                return true;
>> >        /* Unaligned 16-bytes access maps into 3 shadow bytes. */
>> >        if (unlikely(!IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
>> >                return memory_is_poisoned_1(addr + 15);
>> >        return false;
>> >}
>>
>> Thanks for Andrew Morton and Dmitry Vyukov's review.
>> If the parameter addr=0xc0000008, now in function:
>> static __always_inline bool memory_is_poisoned_16(unsigned long addr)
>> {
>>  ---     //shadow_addr = (u16 *)(KASAN_OFFSET+0x18000001(=0xc0000008>>3)) is not
>>  ---     // unsigned by 2 bytes.
>>         u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);
>>
>>         /* Unaligned 16-bytes access maps into 3 shadow bytes. */
>>         if (unlikely(!IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
>>                 return *shadow_addr || memory_is_poisoned_1(addr + 15);
>> ----      //here is going to be error on arm, specially when kernel has not finished yet.
>> ----      //Because the unsigned accessing cause DataAbort Exception which is not
>> ----      //initialized when kernel is starting.
>>         return *shadow_addr;
>> }
>>
>> I also think it is better to fix this problem.

>What about using get_unaligned() ?

Thanks for your review.

I think it is good idea to use get_unaligned. But ARMv7 support CONFIG_ HAVE_EFFICIENT_UNALIGNED_ACCESS
(arch/arm/Kconfig : select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU).
So on ARMv7, the code:
u16 *shadow_addr = get_unaligned((u16 *)kasan_mem_to_shadow((void *)addr));
equals the code:000
u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);

On ARMv7, if SCRLR.A is 0, unaligned access is OK.  Here is the description comes from ARM(r) Architecture Reference
Manual ARMv7-A and ARMv7-R edition :

A3.2.1 Unaligned data access
An ARMv7 implementation must support unaligned data accesses by some load and store instructions, as
Table A3-1 shows. Software can set the SCTLR.A bit to control whether a misaligned access by one of these
instructions causes an Alignment fault Data abort exception.

Table A3-1 Alignment requirements of load/store instructions
Instructions                     Alignment check             SCTLR.A is 0        SCTLR.A is 1

LDRB, LDREXB, LDRBT,
LDRSB, LDRSBT, STRB,             None                       -                -
STREXB, STRBT, SWPB, 
TBB 

LDRH, LDRHT, LDRSH, 
LDRSHT, STRH, STRHT,            Halfword                    Unaligned access    Alignment fault
TBH 

LDREXH, STREXH                Halfword                    Alignment fault      Alignment fault

LDR, LDRT, STR, STRT
PUSH, encodings T3 and A2 only     Word                      Unaligned access     Alignment fault
POP, encodings T3 and A2 only

LDREX, STREX                    Word                     Alignment fault       Alignment fault

LDREXD, STREXD                 Doubleword                Alignment fault       Alignment fault

All forms of LDM and STM,
LDRD, RFE, SRS, STRD, SWP
PUSH, except for encodings 
T3 and A2                       Word                      Alignment fault       Alignment fault
POP, except for encodings 
T3 and A2

LDC, LDC2, STC, STC2             Word                      Alignment fault       Alignment fault

VLDM, VLDR, VPOP,
 VPUSH, VSTM, VSTR             Word                      Alignment fault       Alignment fault

VLD1, VLD2, VLD3, VLD4,
 VST1, VST2, VST3, VST4,          Element size                Unaligned access     Alignment fault
 all with standard alignmenta      

VLD1, VLD2, VLD3, VLD4, 
VST1, VST2, VST3, VST4,           As specified by@<align>       Alignment fault       Alignment fault  
all with @<align> specifieda


On ARMv7, the following code can guarantee that if SCRLR.A is 0:
__enable_mmu:
#if defined(CONFIG_ALIGNMENT_TRAP) && __LINUX_ARM_ARCH__ < 6
	orr	r0, r0, #CR_A
#else
	bic	r0, r0, #CR_A         //clear CR_A
#endif
#ifdef CONFIG_CPU_DCACHE_DISABLE
	bic	r0, r0, #CR_C
#endif
#ifdef CONFIG_CPU_BPREDICT_DISABLE
	bic	r0, r0, #CR_Z
#endif
#ifdef CONFIG_CPU_ICACHE_DISABLE
	bic	r0, r0, #CR_I
#endif
#ifdef CONFIG_ARM_LPAE
	mcrr	p15, 0, r4, r5, c2		@ load TTBR0
#else
	mov	r5, #DACR_INIT
	mcr	p15, 0, r5, c3, c0, 0		@ load domain access register
	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
#endif
	b	__turn_mmu_on
ENDPROC(__enable_mmu)

/*
 * Enable the MMU.  This completely changes the structure of the visible
 * memory space.  You will not be able to trace execution through this.
 * If you have an enquiry about this, *please* check the linux-arm-kernel
 * mailing list archives BEFORE sending another post to the list.
 *
 *  r0  = cp#15 control register
 *  r1  = machine ID
 *  r2  = atags or dtb pointer
 *  r9  = processor ID
 *  r13 = *virtual* address to jump to upon completion
 *
 * other registers depend on the function called upon completion
 */
	.align	5
	.pushsection	.idmap.text, "ax"
ENTRY(__turn_mmu_on)
	mov	r0, r0
	instr_sync
	mcr	p15, 0, r0, c1, c0, 0		@ write control reg   //here set SCTLR=r0 
	mrc	p15, 0, r3, c0, c0, 0		@ read id reg
	instr_sync
	mov	r3, r3
	mov	r3, r13
	ret	r3
__turn_mmu_on_end:
ENDPROC(__turn_mmu_on)

So the following code is OK:
static __always_inline bool memory_is_poisoned_16(unsigned long addr)
{
-	u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);
+	u16 *shadow_addr = get_unaligned( (u16 *)kasan_mem_to_shadow((void *)addr)); 

	/* Unaligned 16-bytes access maps into 3 shadow bytes. */
	if (unlikely(!IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
		return *shadow_addr || memory_is_poisoned_1(addr + 15);

	return *shadow_addr;
}

A very good suggestion, Thanks.
