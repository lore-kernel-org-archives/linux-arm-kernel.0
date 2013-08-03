From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Aug 2013 23:28:09 -0400 (EDT)
Subject: [PATCH v2 4/6] ARM: mm: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <1375289086-5315-5-git-send-email-santosh.shilimkar@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <1375289086-5315-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.LFD.2.03.1308022156120.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Jul 2013, Santosh Shilimkar wrote:

> From: Sricharan R <r.sricharan@ti.com>
> 
> The current phys_to_virt patching mechanism does not work
> for 64 bit physical addressesp. Note that constant used in add/sub
> instructions is encoded in to the last 8 bits of the opcode. So shift
> the _pv_offset constant by 24 to get it in to the correct place.
> 
> The v2p patching mechanism patches the higher 32bits of physical
> address with a constant. While this is correct, in those platforms
> where the lowmem addressable physical memory spawns across 4GB boundary,
> a carry bit can be produced as a result of addition of lower 32bits.
> This has to be taken in to account and added in to the upper. The patched
> __pv_offset and va are added in lower 32bits, where __pv_offset can be
> in two's complement form when PA_START < VA_START and that can result
> in a false carry bit.
> 
> e.g PA = 0x80000000 VA = 0xC0000000
> __pv_offset = PA - VA = 0xC0000000 (2's complement)
> 
> So adding __pv_offset + VA should never result in a true overflow. So in
> order to differentiate between a true carry, a __pv_offset is extended
> to 64bit and the upper 32bits will have 0xffffffff if __pv_offset is
> 2's complement. We are using the same to insert 'mvn #0' instead of
> 'mov' while patching.
> 
> The above idea was suggested by Nicolas Pitre <nico@linaro.org> as
> part of the review of first version of the subject patch.
> 
> There is no corresponding change on the phys_to_virt() side, because
> computations on the upper 32-bits would be discarded anyway.
> 
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> 
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

There are still issues with this patch.

>  arch/arm/include/asm/memory.h |   35 +++++++++++++++++++--
>  arch/arm/kernel/armksyms.c    |    1 +
>  arch/arm/kernel/head.S        |   68 +++++++++++++++++++++++++++++++----------
>  3 files changed, 85 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index d9b96c65..abe879d 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -174,7 +174,9 @@
>  #define __PV_BITS_31_24	0x81000000
>  
>  extern phys_addr_t (*arch_virt_to_idmap) (unsigned long x);
> -extern unsigned long __pv_phys_offset;
> +extern phys_addr_t __pv_phys_offset;
> +extern phys_addr_t __pv_offset;
> +
>  #define PHYS_OFFSET __pv_phys_offset
>  
>  #define __pv_stub(from,to,instr,type)			\
> @@ -186,10 +188,37 @@ extern unsigned long __pv_phys_offset;
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
> +	: "I" (__PV_BITS_31_24))

You should not use __PV_BITS_31_24 here.

Please understand the reason for its usage.  The current code uses 
__PV_BITS_31_24 because we want to use instructions following this 
pattern:

	add	rd, rn, #0xii000000

The encoding of an immediate argument is made of a 8 bit value and a 4 
bit rotation.  So an immediate argument must always be at most 8 bit 
wide and aligned to an even bit position.  The stub value is 
__PV_BITS_31_24 so we have:

	add	rd, rn, #0x81000000

The idea behind this choice of 0x81000000 is to let the assembler 
correctly encode the rotation value into the opcode for us so we only 
have the 8 bit literal value to patch i.e. replacing the 0x81 by the 
actual pv_offset value once shifted right by 24 bits.

And that's why the physical RAM start has to be aligned to a 16MB 
boundary: because we want the difference between phys RAM start and 
PAGE_OFFSET to be represented using bits 31 to 24 only.

Now... here you want to patch a mov opcode where the value being patched 
is the high bits of a physical address.  So far we know this is likely 
to be in the low bits of the high word.  You therefore want a stub 
instruction that reads like:

	mov	rd, 0x000000ii

so the rotation field is appropriately set by the assembler.  

Therefore, using __PV_BITS_31_24 here makes no sense.

> +#define __pv_add_carry_stub(x, y)			\
> +	__asm__ volatile("@ __pv_add_carry_stub\n"	\
> +	"1:	adds	%Q0, %1, %2\n"			\
> +	"2:	adc	%R0, %R0, #0\n"			\
> +	"	.pushsection .pv_table,\"a\"\n"		\
> +	"	.long	1b\n"				\
> +	"	.long	2b\n"				\

Why are you tagging the adc instruction here?  This doesn't need to be 
patched, does it?


> +	"	.popsection\n"				\
> +	: "+r" (y)					\
> +	: "r" (x), "I" (__PV_BITS_31_24)		\
> +	: "cc")
> +
>  static inline phys_addr_t __virt_to_phys(unsigned long x)
>  {
> -	unsigned long t;
> -	__pv_stub(x, t, "add", __PV_BITS_31_24);
> +	phys_addr_t t = 0;

Why do you initialize t to 0 ?

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
> index 9cf6063..aa3b0f7 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -545,17 +545,22 @@ ENDPROC(fixup_smp)
>  	__HEAD
>  __fixup_pv_table:
>  	adr	r0, 1f
> -	ldmia	r0, {r3-r5, r7}
> +	ldmia	r0, {r3-r7}
> +	cmp	r0, r3
> +	mvn	ip, #0
>  	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET

Instead of cmp followed by sub, you could simply use subs.

>  	add	r4, r4, r3	@ adjust table start address
>  	add	r5, r5, r3	@ adjust table end address
> -	add	r7, r7, r3	@ adjust __pv_phys_offset address
> -	str	r8, [r7]	@ save computed PHYS_OFFSET to __pv_phys_offset
> +	add	r6, r6, r3	@ adjust __pv_phys_offset address
> +	add	r7, r7, r3	@ adjust __pv_offset address
> +	str	r8, [r6]	@ save computed PHYS_OFFSET to __pv_phys_offset
> +	strcc	ip, [r7, #4]	@ save to __pv_offset high bits

This is not big endian safe.

>  	mov	r6, r3, lsr #24	@ constant for add/sub instructions
>  	teq	r3, r6, lsl #24 @ must be 16MiB aligned

Remember the reason for the __PV_BITS_31_24 definition above?
It is applied right here.

>  THUMB(	it	ne		@ cross section branch )
>  	bne	__error
> -	str	r6, [r7, #4]	@ save to __pv_offset
> +	lsl	r6, r6, #24

You already have the right value in r3 from above.

And, for non Thumb specific code, we prefer not to use the new mnemonics 
such as lsl in order to allow the kernel to be compilable with old 
binutils.

> +	str	r6, [r7]	@ save to __pv_offset low bits
>  	b	__fixup_a_pv_table
>  ENDPROC(__fixup_pv_table)
>  
> @@ -564,6 +569,7 @@ ENDPROC(__fixup_pv_table)
>  	.long	__pv_table_begin
>  	.long	__pv_table_end
>  2:	.long	__pv_phys_offset
> +	.long	__pv_offset
>  
>  	.text
>  __fixup_a_pv_table:
> @@ -589,27 +595,53 @@ __fixup_a_pv_table:
>  	bcc	1b
>  	bx	lr
>  #else
> -	b	2f
> +	adr	r0, 5f
> +	b	4f
>  1:	ldr	ip, [r7, r3]
> -	bic	ip, ip, #0x000000ff
> -	orr	ip, ip, r6	@ mask in offset bits 31-24
> -	str	ip, [r7, r3]
> -2:	cmp	r4, r5
> +	lsr	r6, ip, #20		@ extract opcode
> +	and	r6, r6, #0x3e
> +	cmp	r6, #0x28		@ check for 'add' instruction
> +	beq	2f
> +	cmp	r6, #0x24		@ check for 'sub' instruction
> +	beq	2f
[...]


blablabla...

Remember when I said the 0x81 immediate could be augmented with 
additional bits to determine what to patch?  Whether you use 0x81000000 
or 0x00000081 in the stub instruction, the opcode will always have 0x81 
in the least significant bits because that's where the 8 bit immediate 
bit field is located.  So instead of doing this opcode determination, 
you could simply test, say, bit 1 instead:

	ldr	ip, [r7, r3]
	tst	ip, #0x2		@ patching high or low value?
	bic	ip, ip, #0x000000ff
	orreq	ip, ip, r6      @ mask in offset bits 31-24 of low word
	orrne	ip, ip, r?	@ mask in offset bits 0-8 of high word
	str	ip, [r7, r3]

... meaning that, instead of using 0x81 for the stub value on the mov 
instruction, it only has to be 0x83.  Bits 7 and 0 still act as anchors 
for the rotation field in the opcode, while bit 1 indicates which value 
to patch in.

> +	cmp	r6, #0x2a		@ check for 'adc' instruction
> +	beq	4f
> +	ldr	r6, [r0]
> +	add	r6, r6, r3
> +	ldr	r6, [r6, #4]
> +	mvn	r11, #0
> +	cmp	r11, r6

You could have used "cmn r6, #1" instead of the above 2 instructions.

> +	and	ip, ip, #0xf000		@ Register encoded in inst
> +	orrne	ip, ip, r6
> +	ldreq	r6, [r0, #0x4]		@ mvn if _pv_offset high bits is 0xffffffff
> +	ldrne	r6, [r0, #0x8]		@ mov otherwise
> +	bic	r6, r6, #0xff
> +	bic	r6, r6, #0xf00
> +	orr	ip, ip, r6

Hmmm.... More blablablabla. I'm not even sure I understand what's going 
on here...

I'm assuming you want to patch the mov, or turn it into a 'mvn rd, #0' 
if the high value is 0xffffffff.  Instead of this complicated code, 
let's have a look at the mov and mvn opcodes:

mov:

31-28 27 26 25 24 23 22 21 20 19-16 15-12 11-0
cond  0  0  I  1  1  0  1  S  SBZ   Rd    shifter_operand

mvn:

31-28 27 26 25 24 23 22 21 20 19-16 15-12 11-0
cond  0  0  I  1  1  1  1  S  SBZ   Rd    shifter_operand

It is very convenient to notice that only bit 22 differs between the 
two. 

So, you have 2 values to prepare for patching:

1) The high bits of the pv_offset low word held in r6 in the current 
   unpatched code, shifted right by 24 bits.

2) The low bits of the pv_offset low word referenced as being held in
   register r? in my example code above.  It doesn't have to be shifted 
   in this case, although the top 24 bits are expected to all be zero.
   But if the high word is equal to 0xffffffff, then we simply have to
   set r? with bit 22 which will have the effect of turning the existing
   mov into an mvn.

That's it!  No need for more complicated code.

Of course the above analisys is valid for ARM mode only.  Thumb mode is 
a bit more complicated and left as an exercice to the reader.

[...]
> @@ -619,10 +651,14 @@ ENDPROC(fixup_pv_table)
>  	.globl	__pv_phys_offset
>  	.type	__pv_phys_offset, %object
>  __pv_phys_offset:
> -	.long	0
> -	.size	__pv_phys_offset, . - __pv_phys_offset
> +	.quad	0
> +
> +	.data
> +	.globl __pv_offset
> +	.type __pv_offset, %object
>  __pv_offset:
> -	.long	0
> +	.quad   0
> +

Those should probably be moved into a C file where the proper size for 
phys_addr_t can be applied.


Nicolas
