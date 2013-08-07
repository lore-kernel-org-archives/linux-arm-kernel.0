From: r.sricharan@ti.com (Sricharan R)
Date: Wed, 7 Aug 2013 20:54:48 +0530
Subject: Fwd: [PATCH 05/10] ARM: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <52026637.5040005@ti.com>
References: <1375887551-8442-1-git-send-email-r.sricharan@ti.com>
 <52026637.5040005@ti.com>
Message-ID: <520266C0.60101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 August 2013 08:52 PM, Sricharan R wrote:
> Hi Nicolas,
>
> On Monday 05 August 2013 08:08 PM, Santosh Shilimkar wrote:
>> On Sunday 04 August 2013 01:32 AM, Nicolas Pitre wrote:
>>> On Sat, 3 Aug 2013, Santosh Shilimkar wrote:
>>>
>>>> On Saturday 03 August 2013 10:01 AM, Nicolas Pitre wrote:
>>>>> On Sat, 3 Aug 2013, Sricharan R wrote:
>>>>>
>>>>>> On Saturday 03 August 2013 08:58 AM, Nicolas Pitre wrote:
>>>>>>> ... meaning that, instead of using 0x81 for the stub value on the mov 
>>>>>>> instruction, it only has to be 0x83.  Bits 7 and 0 still act as anchors 
>>>>>>> for the rotation field in the opcode, while bit 1 indicates which value 
>>>>>>> to patch in.
>>>>>>   I started with this kind of augmenting with the immediate operand
>>>>>>   while starting V2. But the problem was, we do the runtime patching twice.
>>>>> Ahhh... Bummer.
>>>>>
>>>> Sorry if it wasn't clear but I thought we discussed why patching is
>>>> done twice.
>>> Yeah, I know the reasons.  I just had forgotten about the effects on the 
>>> anchor bits.
>>>
>> I see.
>>  
>>>> This was purely based on the discussion where RMK suggested to follow 
>>>> that approach to minimize code changes.
>>>>  
>>>> Looks like we need to revisit that now based on Russell's latest
>>>> comment.
>>> Note that my comments on this particular patch are still valid and 
>>> independent from whatever approach is used globally to deal with the 
>>> memory alias.  I do think that the value to patch should be selected 
>>> depending on the opcode's rotation field which makes it compatible with 
>>> a double patching approach as well.
>>>
>> Completely agree.
>>
>> Regards,
>> Santosh
>>
>    So i did the below inlined patch to addresses your comments,
>    as it was valid for both single/double patching approaches.
>
> [PATCH 05/10] ARM: LPAE: Correct virt_to_phys patching for 64 bit physical addresses
>
> The current phys_to_virt patching mechanism works only for 32 bit
> physical addresses and this patch extends the idea for 64bit physical
> addresses.
>
> The 64bit v2p patching mechanism patches the higher 8 bits of physical
> address with a constant using 'mov' instruction and lower 32bits are patched
> using 'add'. While this is correct, in those platforms where the lowmem addressable
> physical memory spawns across 4GB boundary, a carry bit can be produced as a
> result of addition of lower 32bits. This has to be taken in to account and added
> in to the upper. The patched __pv_offset and va are added in lower 32bits, where
> __pv_offset can be in two's complement form when PA_START < VA_START and that can
> result in a false carry bit.
>
> e.g
>     1) PA = 0x80000000; VA = 0xC0000000
>        __pv_offset = PA - VA = 0xC0000000 (2's complement)
>
>     2) PA = 0x2 80000000; VA = 0xC000000
>        __pv_offset = PA - VA = 0x1 C0000000
>
> So adding __pv_offset + VA should never result in a true overflow for (1).
> So in order to differentiate between a true carry, a __pv_offset is extended
> to 64bit and the upper 32bits will have 0xffffffff if __pv_offset is
> 2's complement. So 'mvn #0' is inserted instead of 'mov' while patching
> for the same reason. Since mov, add, sub instruction are to patched
> with different constants inside the same stub, the rotation field
> of the opcode is using to differentiate between them.
>
> So the above examples for v2p translation becomes for VA=0xC0000000,
>     1) PA[63:32] = 0xffffffff
>        PA[31:0] = VA + 0xC0000000 --> results in a carry
>        PA[63:32] = PA[63:32] + carry
>
>        PA[63:0] = 0x0 80000000
>
>     2) PA[63:32] = 0x1
>        PA[31:0] = VA + 0xC0000000 --> results in a carry
>        PA[63:32] = PA[63:32] + carry
>
>        PA[63:0] = 0x2 80000000
>
> The above ideas were suggested by Nicolas Pitre <nico@linaro.org> as
> part of the review of first and second versions of the subject patch.
>
> There is no corresponding change on the phys_to_virt() side, because
> computations on the upper 32-bits would be discarded anyway.
>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/include/asm/memory.h |   35 +++++++++++++++++--
>  arch/arm/kernel/armksyms.c    |    1 +
>  arch/arm/kernel/head.S        |   77 ++++++++++++++++++++++++++---------------
>  arch/arm/kernel/patch.c       |    3 ++
>  4 files changed, 86 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index ff76e12..e2fa269 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -172,9 +172,12 @@
>   * so that all we need to do is modify the 8-bit constant field.
>   */
>  #define __PV_BITS_31_24	0x81000000
> +#define __PV_BITS_7_0	0x81
>  
>  extern phys_addr_t (*arch_virt_to_idmap) (unsigned long x);
> -extern unsigned long __pv_phys_offset;
> +extern u64 __pv_phys_offset;
> +extern u64 __pv_offset;
> +
>  #define PHYS_OFFSET __pv_phys_offset
>  
>  #define __pv_stub(from,to,instr,type)			\
> @@ -186,10 +189,36 @@ extern unsigned long __pv_phys_offset;
>  	: "=r" (to)					\
>  	: "r" (from), "I" (type))
>  
> +#define __pv_stub_mov_hi(t)				\
> +	__asm__ volatile("@ __pv_stub_mov\n"		\
> +	"1:	mov	%R0, %1\n"			\
> +	"	.pushsection .pv_table,\"a\"\n"		\
> +	"	.long	1b\n"				\
> +	"	.popsection\n"				\
> +	: "=r" (t)					\
> +	: "I" (__PV_BITS_7_0))
> +
> +#define __pv_add_carry_stub(x, y)			\
> +	__asm__ volatile("@ __pv_add_carry_stub\n"	\
> +	"1:	adds	%Q0, %1, %2\n"			\
> +	"	adc	%R0, %R0, #0\n"			\
> +	"	.pushsection .pv_table,\"a\"\n"		\
> +	"	.long	1b\n"				\
> +	"	.popsection\n"				\
> +	: "+r" (y)					\
> +	: "r" (x), "I" (__PV_BITS_31_24)		\
> +	: "cc")
> +
>  static inline phys_addr_t __virt_to_phys(unsigned long x)
>  {
> -	unsigned long t;
> -	__pv_stub(x, t, "add", __PV_BITS_31_24);
> +	phys_addr_t t;
> +
> +	if (sizeof(phys_addr_t) == 4) {
> +		__pv_stub(x, t, "add", __PV_BITS_31_24);
> +	} else {
> +		__pv_stub_mov_hi(t);
> +		__pv_add_carry_stub(x, t);
> +	}
>  	return t;
>  }
>  
> diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
> index 60d3b73..1f031dd 100644
> --- a/arch/arm/kernel/armksyms.c
> +++ b/arch/arm/kernel/armksyms.c
> @@ -155,4 +155,5 @@ EXPORT_SYMBOL(__gnu_mcount_nc);
>  
>  #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
>  EXPORT_SYMBOL(__pv_phys_offset);
> +EXPORT_SYMBOL(__pv_offset);
>  #endif
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 45e8935..f9d43ac 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -536,6 +536,14 @@ ENTRY(fixup_smp)
>  	ldmfd	sp!, {r4 - r6, pc}
>  ENDPROC(fixup_smp)
>  
> +#ifdef __ARMEB_
> +#define LOW_OFFSET	0x4
> +#define HIGH_OFFSET	0x0
> +#else
> +#define LOW_OFFSET	0x0
> +#define HIGH_OFFSET	0x4
> +#endif
> +
>  #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
>  
>  /* __fixup_pv_table - patch the stub instructions with the delta between
> @@ -546,17 +554,20 @@ ENDPROC(fixup_smp)
>  	__HEAD
>  __fixup_pv_table:
>  	adr	r0, 1f
> -	ldmia	r0, {r3-r5, r7}
> -	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
> +	ldmia	r0, {r3-r7}
> +	mvn	ip, #0
> +	subs	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
>  	add	r4, r4, r3	@ adjust table start address
>  	add	r5, r5, r3	@ adjust table end address
> -	add	r7, r7, r3	@ adjust __pv_phys_offset address
> -	str	r8, [r7]	@ save computed PHYS_OFFSET to __pv_phys_offset
> +	add	r6, r6, r3	@ adjust __pv_phys_offset address
> +	add	r7, r7, r3	@ adjust __pv_offset address
> +	str	r8, [r6, #LOW_OFFSET]	@ save computed PHYS_OFFSET to __pv_phys_offset
> +	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
>  	mov	r6, r3, lsr #24	@ constant for add/sub instructions
>  	teq	r3, r6, lsl #24 @ must be 16MiB aligned
>  THUMB(	it	ne		@ cross section branch )
>  	bne	__error
> -	str	r6, [r7, #4]	@ save to __pv_offset
> +	str	r3, [r7, #LOW_OFFSET]	@ save to __pv_offset low bits
>  	b	__fixup_a_pv_table
>  ENDPROC(__fixup_pv_table)
>  
> @@ -565,9 +576,16 @@ ENDPROC(__fixup_pv_table)
>  	.long	__pv_table_begin
>  	.long	__pv_table_end
>  2:	.long	__pv_phys_offset
> +	.long	__pv_offset
>  
>  	.text
>  __fixup_a_pv_table:
> +	adr	r0, 4f
> +	ldr	r6, [r0]
> +	add	r6, r6, r3
> +	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
> +	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
> +	mov	r6, r6, lsr #24
>  #ifdef CONFIG_THUMB2_KERNEL
>  	lsls	r6, #24
>  	beq	2f
> @@ -581,49 +599,54 @@ __fixup_a_pv_table:
>  	orr	r6, #0x4000
>  	b	2f
>  1:	add     r7, r3
> +	cmn	r0, #1
> +	moveq	r0, #0
>  	ldrh	ip, [r7, #2]
> -	and	ip, 0x8f00
> -	orr	ip, r6	@ mask in offset bits 31-24
> +	tst	ip, #0x4000
> +	and	ip, #0x8f00
> +	orrne	ip, r6	@ mask in offset bits 31-24
> +	orreq	ip, r0	@ mask in offset bits 7-0
>  	strh	ip, [r7, #2]
> +	bne	2f
> +	ldrh	ip, [r7]
> +	bic	ip, #0x20
> +	cmn	r0, #0x1
> +	orreq	ip, #0x20	@ set bit 5, mov to mvn instruction
> +	strh	ip, [r7]
>  2:	cmp	r4, r5
>  	ldrcc	r7, [r4], #4	@ use branch for delay slot
>  	bcc	1b
>  	bx	lr
>  #else
> -	b	2f
> +	b	3f
>  1:	ldr	ip, [r7, r3]
> -	bic	ip, ip, #0x000000ff
> -	orr	ip, ip, r6	@ mask in offset bits 31-24
> -	str	ip, [r7, r3]
> -2:	cmp	r4, r5
> +	bic	ip, ip, #0xff
> +	tst	ip, #0xf00	@ check the rotation field
> +	orrne	ip, ip, r6	@ mask in offset bits 31-24
> +	bne	2f
> +	bic	ip, ip, #0x400000	@ clear bit 22
> +	cmn	r0, #1
> +	orreq	ip, ip, #0x400000	@ set bit 22, mov to mvn instruction
> +	orrne	ip, ip, r0		@ mask in offset bits 7-0
> +2:	str	ip, [r7, r3]
> +3:	cmp	r4, r5
>  	ldrcc	r7, [r4], #4	@ use branch for delay slot
>  	bcc	1b
>  	mov	pc, lr
>  #endif
>  ENDPROC(__fixup_a_pv_table)
>  
> +4:	.long __pv_offset
> +
>  ENTRY(fixup_pv_table)
> -	stmfd	sp!, {r4 - r7, lr}
> -	ldr	r2, 2f			@ get address of __pv_phys_offset
> +	stmfd	sp!, {r0, r3 - r7, r12, lr}
>  	mov	r3, #0			@ no offset
>  	mov	r4, r0			@ r0 = table start
>  	add	r5, r0, r1		@ r1 = table size
> -	ldr	r6, [r2, #4]		@ get __pv_offset
>  	bl	__fixup_a_pv_table
> -	ldmfd	sp!, {r4 - r7, pc}
> +	ldmfd	sp!, {r0, r3 - r7, r12, pc}
>  ENDPROC(fixup_pv_table)
>  
> -	.align
> -2:	.long	__pv_phys_offset
> -
> -	.data
> -	.globl	__pv_phys_offset
> -	.type	__pv_phys_offset, %object
> -__pv_phys_offset:
> -	.long	0
> -	.size	__pv_phys_offset, . - __pv_phys_offset
> -__pv_offset:
> -	.long	0
>  #endif
>  
>  #include "head-common.S"
> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
> index 07314af..8356312 100644
> --- a/arch/arm/kernel/patch.c
> +++ b/arch/arm/kernel/patch.c
> @@ -8,6 +8,9 @@
>  
>  #include "patch.h"
>  
> +u64 __pv_phys_offset __attribute__((section(".data")));
> +u64 __pv_offset __attribute__((section(".data")));
> +
>  struct patch {
>  	void *addr;
>  	unsigned int insn;
 Also i was little unsure if patch.c was the right place to move the variables.

Regards,
 Sricharan
