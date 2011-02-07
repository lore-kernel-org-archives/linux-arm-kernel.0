From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 7 Feb 2011 15:41:38 +0000 (GMT)
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <mailman.11856.1297088273.1534.linux-arm-kernel@lists.infradead.org>
References: <mailman.11856.1297088273.1534.linux-arm-kernel@lists.infradead.org>
Message-ID: <alpine.DEB.2.00.1102071505370.19751@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Russell's suspend/resume patch is a great way to make the Hibernation code 
generic - and utterly simple. See below.

> diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
> index 6980215..8ec535e 100644
> --- a/arch/arm/include/asm/proc-fns.h
> +++ b/arch/arm/include/asm/proc-fns.h
> @@ -66,6 +66,11 @@ extern struct processor {
> 	 * ignore 'ext'.
> 	 */
> 	void (*set_pte_ext)(pte_t *ptep, pte_t pte, unsigned int ext);
> +
> +	/* Suspend/resume */
> +	unsigned int suspend_size;
> +	void (*do_suspend)(void *);
> +	void (*do_resume)(void *);
> } processor;


These seem to do exactly what the various hibernation patches try to 
perform in __save/__restore_processor_state() - takes a buffer to 
(re)store the world to/from. Having it there allows to ditch the 
hibernation patch monstrosity.


The ARM hibernation patch would then simply become these two files:

arch/arm/include/asm/suspend.h will look like:

=====================================================================
#ifndef __ASM_ARM_SUSPEND_H
#define __ASM_ARM_SUSPEND_H

static inline int arch_prepare_suspend(void) { return 0; }

#define save_processor_state    preempt_disable
#define restore_processor_state preempt_enable

#endif  /* __ASM_ARM_SUSPEND_H */
=====================================================================


and arch/arm/kernel/swsusp.S will be:
=====================================================================
#include <linux/linkage.h>
#include <asm/assembler.h>
#include <asm/asm-offsets.h>
#include <asm/cache.h>
#include <asm/memory.h>
#include <asm/segment.h>
#include <asm/page.h>
#include <asm/ptrace.h>

/*
  * Force arm mode because this uses immediate msr.
  */
.arm

#define	REGS_USR	(0)
#define	REGS_SVC	(REGS_USR + 16 * 4)

ENTRY(swsusp_arch_suspend)
 	ldr	r0, =saved_processor_state	/* wherever that is */
 	mrs	r1, cpsr
 	stm	r0!, {r1}		/* current CPSR */
 	msr	cpsr_c, #SYSTEM_MODE
 	stm	r0!, {r0-r14}		/* user regs */
 	msr	cpsr_c, #SVC_MODE
 	mrs	r2, spsr
 	stm	r0!, {r2, sp, lr}	/* SVC SPSR, SVC regs */
 	msr	cpsr, r1		/* restore original mode */

 	ldr	r1, =procfns
 	mov	lr, pc
 	ldr	pc, [r1, #CPU_DO_SUSPEND]

 	bl	swsusp_save
 	mov	r0, #0
 	ldr	r1, =saved_processor_state
 	ldr	lr, [r1, REGS_SVC + 8]
 	bx	lr
ENDPROC(swsusp_arch_suspend)


ENTRY(swsusp_arch_resume)
/* page copy loop omitted for brevity */
 	msr	cpsr_c, #SYSTEM_MODE
 	ldr	r0, =saved_processor_state
 	ldm	r0!, {r1, sp, lr}	/* first word is CPSR, following are r0/r1 (irrelevant) */
 	msr	cpsr_cxsf, r1
 	ldm	r0!, {r2-r14}
 	msr	cpsr_c, #SVC_MODE
 	ldm	r0!, {r2, sp, lr}
 	msr	spsr_cxsf, r2
 	msr	cpsr_c, r1		/* use CPSR from above */

 	bl	local_flush_tlb_all

 	ldr	r1, =procfns
 	mov	lr, pc
 	ldr	pc, [r1, #CPU_DO_RESUME]
 	mov	r0, #0
 	ldr	r1, =saved_processor_state
 	ldr	lr, [r1, REGS_SVC + 8]
 	bx	lr

ENDPROC(swsusp_arch_resume)
=====================================================================



It'll be a few days before I can test this properly, need to get Russell's 
changes into our (not exactly mainline) local tree first. I'll report on 
the progress.


Thanks !
FrankH.
