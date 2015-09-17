From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 17 Sep 2015 21:36:04 +0900
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <55FA9708.5070200@arm.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <20150916112520.GH28771@arm.com> <55FA9708.5070200@arm.com>
Message-ID: <8C4599C6-E5F8-4527-AAFF-9FEF295526BB@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 17, 2015, at 7:33 PM, James Morse wrote:

Hi James and Will,

> Hi Will,
> 
> On 16/09/15 12:25, Will Deacon wrote:
>> On Sun, Sep 13, 2015 at 03:42:17PM +0100, Jungseok Lee wrote:
>>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>>> index dcd06d1..44839c0 100644
>>> --- a/arch/arm64/include/asm/thread_info.h
>>> +++ b/arch/arm64/include/asm/thread_info.h
>>> @@ -73,8 +73,11 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
>>> 
>>> static inline struct thread_info *current_thread_info(void)
>>> {
>>> -	return (struct thread_info *)
>>> -		(current_stack_pointer & ~(THREAD_SIZE - 1));
>>> +	unsigned long sp_el0;
>>> +
>>> +	asm volatile("mrs %0, sp_el0" : "=r" (sp_el0));
>>> +
>>> +	return (struct thread_info *)(sp_el0 & ~(THREAD_SIZE - 1));
>> 
>> This looks like it will generate worse code than our current implementation,
>> thanks to the asm volatile. Maybe just add something like a global
>> current_stack_pointer_el0?
> 
> Like current_stack_pointer does?:
>> register unsigned long current_stack_pointer_el0 asm ("sp_el0");
> 
> Unfortunately the compiler won't accept this, as it doesn't like the
> register name, it also won't accept instructions in this asm string.
> 
> Dropping the 'volatile' has the desired affect[0]. This would only cause a
> problem over a call to cpu_switch_to(), which writes to sp_el0, but also
> save/restores the callee-saved registers, so they will always be consistent.
> 
> 
> James
> 
> 
> 
> 
> [0] A fictitious example printk:
>> printk("%p%p%u%p", get_fs(), current_thread_info(),
>>       smp_processor_id(), current);
> 
> With this patch compiles to:
> 5f8:   d5384101        mrs     x1, sp_el0
> 5fc:   d5384100        mrs     x0, sp_el0
> 600:   d5384103        mrs     x3, sp_el0
> 604:   d5384104        mrs     x4, sp_el0
> 608:   9272c484        and     x4, x4, #0xffffffffffffc000
> 60c:   9272c463        and     x3, x3, #0xffffffffffffc000
> 610:   9272c421        and     x1, x1, #0xffffffffffffc000
> 614:   aa0403e2        mov     x2, x4
> 618:   90000000        adrp    x0, 0 <do_bad>
> 61c:   f9400884        ldr     x4, [x4,#16]
> 620:   91000000        add     x0, x0, #0x0
> 624:   b9401c63        ldr     w3, [x3,#28]
> 628:   f9400421        ldr     x1, [x1,#8]
> 62c:   94000000        bl      0 <printk>
> 
> Removing the volatile:
> 5e4:   d5384102        mrs     x2, sp_el0
> 5e8:   f9400844        ldr     x4, [x2,#16]
> 5ec:   91000000        add     x0, x0, #0x0
> 5f0:   b9401c43        ldr     w3, [x2,#28]
> 5f4:   f9400441        ldr     x1, [x2,#8]
> 5f8:   94000000        bl      0 <printk>
> 
> 


As Will pointed out, if "worse" means "bigger text size", the change generates
worse codes than current implementation. A data based on System.map is as follows.

GCC version: aarch64-linux-gnu-gcc (Linaro GCC 2014.11) 4.9.3 20141031 (prerelease)

[1] 4.3-rc1 
ffffffc000080000 T _text
ffffffc0007f1524 R _etext

[2] 4.3-rc1 + this patch
ffffffc000080000 T _text
ffffffc0007f8504 R _etext

[3] 4.3-rc1 + this patch + the following hunk
ffffffc000080000 T _text
ffffffc0007ef514 R _etext

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 44839c0..4ab08a1 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -77,7 +77,7 @@ static inline struct thread_info *current_thread_info(void)
 
 	asm volatile("mrs %0, sp_el0" : "=r" (sp_el0));
 
-	return (struct thread_info *)(sp_el0 & ~(THREAD_SIZE - 1));
+	return (struct thread_info *)sp_el0;
 }
 
 #define thread_saved_pc(tsk)	\
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c156540..314ac81 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -88,7 +88,8 @@
 
 	.if	\el == 0
 	mrs	x21, sp_el0
-	get_thread_info \el, tsk		// Ensure MDSCR_EL1.SS is clear,
+	mov	tsk, sp
+	and	tsk, tsk, #~(THREAD_SIZE - 1)	// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 	.else
@@ -105,8 +106,7 @@
 	.if	\el == 0
 	mvn	x21, xzr
 	str	x21, [sp, #S_SYSCALLNO]
-	mov	x25, sp
-	msr	sp_el0, x25
+	msr	sp_el0, tsk
 	.endif
 
 	/*
@@ -165,13 +165,8 @@ alternative_endif
 	eret					// return to kernel
 	.endm
 
-	.macro	get_thread_info, el, rd
-	.if	\el == 0
-	mov	\rd, sp
-	.else
+	.macro	get_thread_info, rd
 	mrs	\rd, sp_el0
-	.endif
-	and	\rd, \rd, #~(THREAD_SIZE - 1)	// bottom of thread stack
 	.endm
 
 	.macro	get_irq_stack
@@ -400,7 +395,7 @@ el1_irq:
 	irq_handler
 
 #ifdef CONFIG_PREEMPT
-	get_thread_info 1, tsk
+	get_thread_info tsk
 	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
 	cbnz	w24, 1f				// preempt count != 0
 	ldr	x0, [tsk, #TI_FLAGS]		// get flags
@@ -636,6 +631,7 @@ ENTRY(cpu_switch_to)
 	ldp	x29, x9, [x8], #16
 	ldr	lr, [x8]
 	mov	sp, x9
+	and	x9, x9, #~(THREAD_SIZE - 1)
 	msr	sp_el0, x9
 	ret
 ENDPROC(cpu_switch_to)
@@ -695,7 +691,7 @@ ENTRY(ret_from_fork)
 	cbz	x19, 1f				// not a kernel thread
 	mov	x0, x20
 	blr	x19
-1:	get_thread_info 1, tsk
+1:	get_thread_info tsk
 	b	ret_to_user
 ENDPROC(ret_from_fork)
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cb13290..213df0b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -442,6 +442,7 @@ __mmap_switched:
 2:
 	adr_l	sp, initial_sp, x4
 	mov	x4, sp
+	and	x4, x4, #~(THREAD_SIZE - 1)
 	msr	sp_el0, x4
 	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
 	str_l	x24, memstart_addr, x6		// Save PHYS_OFFSET
@@ -615,6 +616,7 @@ ENDPROC(secondary_startup)
 ENTRY(__secondary_switched)
 	ldr	x0, [x21]			// get secondary_data.stack
 	mov	sp, x0
+	and	x0, x0, #~(THREAD_SIZE - 1)
 	msr	sp_el0, x0
 	mov	x29, #0
 	b	secondary_start_kernel

If struct thread_info address is directly stored into sp_el0, we can avoid
masking operation in many places. It helps to decrease a kernel text size.
This idea comes from James's comment in v1 patch.

Best Regards
Jungseok Lee
