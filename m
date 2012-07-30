From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jul 2012 14:36:19 +0100
Subject: [PATCH] Fix undefined instruction exception handling
In-Reply-To: <20120730112607.GD15195@mudshark.cambridge.arm.com>
References: <20120729182236.GG6802@n2100.arm.linux.org.uk>
 <20120730112607.GD15195@mudshark.cambridge.arm.com>
Message-ID: <20120730133619.GH6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 12:26:07PM +0100, Will Deacon wrote:
> >  __und_svc:
> >  #ifdef CONFIG_KPROBES
> > @@ -261,7 +274,7 @@ ENDPROC(__irq_svc)
> >  	@
> >  	@  r0 - instruction
> >  	@
> > -#ifndef	CONFIG_THUMB2_KERNEL
> > +#ifndef CONFIG_THUMB2_KERNEL
> >  	ldr	r0, [r4, #-4]
> >  #else
> >  	ldrh	r0, [r4, #-2]			@ Thumb instruction at LR - 2
> > @@ -269,17 +282,24 @@ ENDPROC(__irq_svc)
> >  	ldrhhs	r9, [r4]			@ bottom 16 bits
> >  	orrhs	r0, r9, r0, lsl #16
> 
> Do we not need an addhs r4, r4, #2 here?

And we'd need to store it back into the pt_regs struct.

> 
> >  #endif
> > -	adr	r9, BSYM(1f)
> > +	adr	r9, BSYM(__und_svc_finish)
> >  	mov	r2, r4
> >  	bl	call_fpe
> 
> ...otherwise the fp handler invoked by call_fpe will get confused and corrupt
> the saved PC value. I suppose this might not matter at the moment, given that
> we don't use FP in the kernel, but in that case a comment might be useful.
> 
> > +	ldr	r5, [sp, #S_PSR]
> >  	mov	r0, sp				@ struct pt_regs *regs
> > -	bl	do_undefinstr
> > +	mov	r1, #4				@ PC correction to apply
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +	tst	r5, #PSR_T_BIT
> > +	movne	r1, #2
> > +#endifi
> 
> If we fixup r4 above, I think we should set r1 depending on the instruction
> size, like we do for userspace.

Actually, we end up with all instructions that use the call_fpe path being
32-bit, so if we correct it as I mention above, everything just works.

> > diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
> > index 4fa9903..4f9ca8d 100644
> > --- a/arch/arm/vfp/entry.S
> > +++ b/arch/arm/vfp/entry.S
> > @@ -19,6 +19,15 @@
> >  #include <asm/vfpmacros.h>
> >  #include "../kernel/entry-header.S"
> >  
> > +@ VFP entry point.
> > +@
> > +@  r0  = instruction opcode (32-bit ARM or two 16-bit Thumb)
> > +@  r2  = PC value to resume execution after successful emulation
> > +@  r9  = normal "successful" return address
> > +@  r10 = this threads thread_info structure
> > +@  lr  = unrecognised instruction return address
> > +@  IRQs disabled.
> > +@
> 
> There's a similar comment a few lines above from this one which is now
> contradictory -- can we just replace the old one with the new, correct one?

I've just deleted the old one.

New patch below.

 arch/arm/kernel/entry-armv.S |  111 +++++++++++++++++++++++++++---------------
 arch/arm/kernel/traps.c      |    8 ---
 arch/arm/vfp/entry.S         |   16 +++---
 arch/arm/vfp/vfphw.S         |   19 ++++---
 4 files changed, 92 insertions(+), 62 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 0d1851c..5a4503c 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -244,6 +244,19 @@ svc_preempt:
 	b	1b
 #endif
 
+__und_fault:
+	@ Correct the PC such that it is pointing at the instruction
+	@ which caused the fault.  If the faulting instruction was ARM
+	@ the PC will be pointing at the next instruction, and have to
+	@ subtract 4.  Otherwise, it is Thumb, and the PC will be
+	@ pointing at the second half of the Thumb instruction.  We
+	@ have to subtract 2.
+	ldr	r2, [r0, #S_PC]
+	sub	r2, r2, r1
+	str	r2, [r0, #S_PC]
+	b	do_undefinstr
+ENDPROC(__und_fault)
+
 	.align	5
 __und_svc:
 #ifdef CONFIG_KPROBES
@@ -261,25 +274,32 @@ __und_svc:
 	@
 	@  r0 - instruction
 	@
-#ifndef	CONFIG_THUMB2_KERNEL
+#ifndef CONFIG_THUMB2_KERNEL
 	ldr	r0, [r4, #-4]
 #else
+	mov	r1, #2
 	ldrh	r0, [r4, #-2]			@ Thumb instruction at LR - 2
 	cmp	r0, #0xe800			@ 32-bit instruction if xx >= 0
-	ldrhhs	r9, [r4]			@ bottom 16 bits
-	orrhs	r0, r9, r0, lsl #16
+	blo	__und_svc_fault
+	ldrh	r9, [r4]			@ bottom 16 bits
+	add	r4, r4, #2
+	str	r4, [sp, #S_PSR]
+	orr	r0, r9, r0, lsl #16
 #endif
-	adr	r9, BSYM(1f)
+	adr	r9, BSYM(__und_svc_finish)
 	mov	r2, r4
 	bl	call_fpe
 
+	mov	r1, #4				@ PC correction to apply
+__und_svc_fault:
 	mov	r0, sp				@ struct pt_regs *regs
-	bl	do_undefinstr
+	bl	__und_fault
 
 	@
 	@ IRQs off again before pulling preserved data off the stack
 	@
-1:	disable_irq_notrace
+__und_svc_finish:
+	disable_irq_notrace
 
 	@
 	@ restore SPSR and restart the instruction
@@ -423,25 +443,33 @@ __und_usr:
 	mov	r2, r4
 	mov	r3, r5
 
+	@ r2 = regs->ARM_pc, which is either 2 or 4 bytes ahead of the
+	@      faulting instruction depending on Thumb mode.
+	@ r3 = regs->ARM_cpsr
 	@
-	@ fall through to the emulation code, which returns using r9 if
-	@ it has emulated the instruction, or the more conventional lr
-	@ if we are to treat this as a real undefined instruction
-	@
-	@  r0 - instruction
+	@ The emulation code returns using r9 if it has emulated the
+	@ instruction, or the more conventional lr if we are to treat
+	@ this as a real undefined instruction
 	@
 	adr	r9, BSYM(ret_from_exception)
-	adr	lr, BSYM(__und_usr_unknown)
+
 	tst	r3, #PSR_T_BIT			@ Thumb mode?
-	itet	eq				@ explicit IT needed for the 1f label
-	subeq	r4, r2, #4			@ ARM instr at LR - 4
-	subne	r4, r2, #2			@ Thumb instr at LR - 2
-1:	ldreqt	r0, [r4]
+	bne	__und_usr_thumb
+	sub	r4, r2, #4			@ ARM instr at LR - 4
+1:	ldrt	r0, [r4]
 #ifdef CONFIG_CPU_ENDIAN_BE8
-	reveq	r0, r0				@ little endian instruction
+	rev	r0, r0				@ little endian instruction
 #endif
-	beq	call_fpe
+	@ r0 = 32-bit ARM instruction which caused the exception
+	@ r2 = PC value for the following instruction (:= regs->ARM_pc)
+	@ r4 = PC value for the faulting instruction
+	@ lr = 32-bit undefined instruction function
+	adr	lr, BSYM(__und_usr_fault_32)
+	b	call_fpe
+
+__und_usr_thumb:
 	@ Thumb instruction
+	sub	r4, r2, #2			@ First half of thumb instr at LR - 2
 #if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7
 /*
  * Thumb-2 instruction handling.  Note that because pre-v6 and >= v6 platforms
@@ -455,7 +483,7 @@ __und_usr:
 	ldr	r5, .LCcpu_architecture
 	ldr	r5, [r5]
 	cmp	r5, #CPU_ARCH_ARMv7
-	blo	__und_usr_unknown
+	blo	__und_usr_fault_16		@ 16bit undefined instruction
 /*
  * The following code won't get run unless the running CPU really is v7, so
  * coding round the lack of ldrht on older arches is pointless.  Temporarily
@@ -463,15 +491,18 @@ __und_usr:
  */
 	.arch	armv6t2
 #endif
-2:
- ARM(	ldrht	r5, [r4], #2	)
- THUMB(	ldrht	r5, [r4]	)
- THUMB(	add	r4, r4, #2	)
+2:	ldrht	r5, [r4]
 	cmp	r5, #0xe800			@ 32bit instruction if xx != 0
-	blo	__und_usr_unknown
-3:	ldrht	r0, [r4]
+	blo	__und_usr_fault_16		@ 16bit undefined instruction
+3:	ldrht	r0, [r2]
 	add	r2, r2, #2			@ r2 is PC + 2, make it PC + 4
+	str	r2, [sp, #S_PC]			@ it's a 2x16bit instr, update
 	orr	r0, r0, r5, lsl #16
+	adr	lr, BSYM(__und_usr_fault_32)
+	@ r0 = the two 16-bit Thumb instructions which caused the exception
+	@ r2 = PC value for the following Thumb instruction (:= regs->ARM_pc)
+	@ r4 = PC value for the first 16-bit Thumb instruction
+	@ lr = 32bit undefined instruction function
 
 #if __LINUX_ARM_ARCH__ < 7
 /* If the target arch was overridden, change it back: */
@@ -482,17 +513,13 @@ __und_usr:
 #endif
 #endif /* __LINUX_ARM_ARCH__ < 7 */
 #else /* !(CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7) */
-	b	__und_usr_unknown
+	b	__und_usr_fault_16
 #endif
- UNWIND(.fnend		)
+ UNWIND(.fnend)
 ENDPROC(__und_usr)
 
-	@
-	@ fallthrough to call_fpe
-	@
-
 /*
- * The out of line fixup for the ldrt above.
+ * The out of line fixup for the ldrt instructions above.
  */
 	.pushsection .fixup, "ax"
 	.align	2
@@ -524,11 +551,12 @@ ENDPROC(__und_usr)
  * NEON handler code.
  *
  * Emulators may wish to make use of the following registers:
- *  r0  = instruction opcode.
- *  r2  = PC+4
+ *  r0  = instruction opcode (32-bit ARM or two 16-bit Thumb)
+ *  r2  = PC value to resume execution after successful emulation
  *  r9  = normal "successful" return address
- *  r10 = this threads thread_info structure.
+ *  r10 = this threads thread_info structure
  *  lr  = unrecognised instruction return address
+ * IRQs disabled, FIQs enabled.
  */
 	@
 	@ Fall-through from Thumb-2 __und_usr
@@ -659,12 +687,17 @@ ENTRY(no_fp)
 	mov	pc, lr
 ENDPROC(no_fp)
 
-__und_usr_unknown:
-	enable_irq
+__und_usr_fault_32:
+	mov	r1, #4
+	b	1f
+__und_usr_fault_16:
+	mov	r1, #2
+1:	enable_irq
 	mov	r0, sp
 	adr	lr, BSYM(ret_from_exception)
-	b	do_undefinstr
-ENDPROC(__und_usr_unknown)
+	b	__und_fault
+ENDPROC(__und_usr_fault_32)
+ENDPROC(__und_usr_fault_16)
 
 	.align	5
 __pabt_usr:
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 8b97d73..7978d4f 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -402,18 +402,10 @@ static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 
 asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 {
-	unsigned int correction = thumb_mode(regs) ? 2 : 4;
 	unsigned int instr;
 	siginfo_t info;
 	void __user *pc;
 
-	/*
-	 * According to the ARM ARM, PC is 2 or 4 bytes ahead,
-	 * depending whether we're in Thumb mode or not.
-	 * Correct this offset.
-	 */
-	regs->ARM_pc -= correction;
-
 	pc = (void __user *)instruction_pointer(regs);
 
 	if (processor_mode(regs) == SVC_MODE) {
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 4fa9903..cc926c9 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -7,18 +7,20 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * Basic entry code, called from the kernel's undefined instruction trap.
- *  r0  = faulted instruction
- *  r5  = faulted PC+4
- *  r9  = successful return
- *  r10 = thread_info structure
- *  lr  = failure return
  */
 #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
 #include "../kernel/entry-header.S"
 
+@ VFP entry point.
+@
+@  r0  = instruction opcode (32-bit ARM or two 16-bit Thumb)
+@  r2  = PC value to resume execution after successful emulation
+@  r9  = normal "successful" return address
+@  r10 = this threads thread_info structure
+@  lr  = unrecognised instruction return address
+@  IRQs disabled.
+@
 ENTRY(do_vfp)
 #ifdef CONFIG_PREEMPT
 	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 2d30c7f..3a0efaa 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -61,13 +61,13 @@
 
 @ VFP hardware support entry point.
 @
-@  r0  = faulted instruction
-@  r2  = faulted PC+4
-@  r9  = successful return
+@  r0  = instruction opcode (32-bit ARM or two 16-bit Thumb)
+@  r2  = PC value to resume execution after successful emulation
+@  r9  = normal "successful" return address
 @  r10 = vfp_state union
 @  r11 = CPU number
-@  lr  = failure return
-
+@  lr  = unrecognised instruction return address
+@  IRQs enabled.
 ENTRY(vfp_support_entry)
 	DBGSTR3	"instr %08x pc %08x state %p", r0, r2, r10
 
@@ -161,9 +161,12 @@ vfp_hw_state_valid:
 					@ exception before retrying branch
 					@ out before setting an FPEXC that
 					@ stops us reading stuff
-	VFPFMXR	FPEXC, r1		@ restore FPEXC last
-	sub	r2, r2, #4
-	str	r2, [sp, #S_PC]		@ retry the instruction
+	VFPFMXR	FPEXC, r1		@ Restore FPEXC last
+	sub	r2, r2, #4		@ Retry current instruction - if Thumb
+	str	r2, [sp, #S_PC]		@ mode it's two 16-bit instructions,
+					@ else it's one 32-bit instruction, so
+					@ always subtract 4 from the following
+					@ instruction address.
 #ifdef CONFIG_PREEMPT
 	get_thread_info	r10
 	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
