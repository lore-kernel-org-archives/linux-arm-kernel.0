From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 12 Apr 2013 17:25:25 +0100
Subject: [PATCH v10 1/3] ARM: Add base support for ARMv7-M
In-Reply-To: <1364381692-7955-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1363901310-9474-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1364381692-7955-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1364381692-7955-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <51683575.2000103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

I've just noticed an issue with this patch that we haven't seen because 
we're not using MULTI_CPU, but I *think* if we were to do that things 
wouldn't work out.

On 27/03/13 10:54, Uwe Kleine-K?nig wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>

Aggressive snip...

> index 0000000..b18e3ba
> --- /dev/null
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -0,0 +1,165 @@
> +/*
> + *  linux/arch/arm/mm/proc-v7m.S
> + *
> + *  Copyright (C) 2008 ARM Ltd.
> + *  Copyright (C) 2001 Deep Blue Solutions Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + *  This is the "shell" of the ARMv7-M processor support.
> + */
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +#include <asm/v7m.h>
> +
> +ENTRY(cpu_v7m_proc_init)
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_proc_init)
> +
> +ENTRY(cpu_v7m_proc_fin)
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_proc_fin)
> +
> +/*
> + *     cpu_v7m_reset(loc)
> + *
> + *     Perform a soft reset of the system.  Put the CPU into the
> + *     same state as it would be if it had been reset, and branch
> + *     to what would be the reset vector.
> + *
> + *     - loc   - location to jump to for soft reset
> + */
> +       .align  5
> +ENTRY(cpu_v7m_reset)
> +       mov     pc, r0
> +ENDPROC(cpu_v7m_reset)
> +
> +/*
> + *     cpu_v7m_do_idle()
> + *
> + *     Idle the processor (eg, wait for interrupt).
> + *
> + *     IRQs are already disabled.
> + */
> +ENTRY(cpu_v7m_do_idle)
> +       wfi
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_do_idle)
> +
> +ENTRY(cpu_v7m_dcache_clean_area)
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_dcache_clean_area)
> +
> +/*
> + * There is no MMU, so here is nothing to do.
> + */
> +ENTRY(cpu_v7m_switch_mm)
> +       mov     pc, lr
> +ENDPROC(cpu_v7m_switch_mm)
> +
> +cpu_v7m_name:
> +       .ascii  "ARMv7-M Processor"
> +       .align
> +
> +       .section ".text.init", #alloc, #execinstr
> +
> +/*
> + *     __v7m_setup
> + *
> + *     This should be able to cover all ARMv7-M cores.
> + */
> +__v7m_setup:
> +       @ Configure the vector table base address
> +       ldr     r0, =BASEADDR_V7M_SCB
> +       ldr     r12, =vector_table
> +       str     r12, [r0, V7M_SCB_VTOR]
> +
> +       @ enable UsageFault, BusFault and MemManage fault.
> +       ldr     r5, [r0, #V7M_SCB_SHCSR]
> +       orr     r5, #(V7M_SCB_SHCSR_USGFAULTENA | V7M_SCB_SHCSR_BUSFAULTENA | V7M_SCB_SHCSR_MEMFAULTENA)
> +       str     r5, [r0, #V7M_SCB_SHCSR]
> +
> +       @ Lower the priority of the SVC and PendSV exceptions
> +       mov     r5, #0x80000000
> +       str     r5, [r0, V7M_SCB_SHPR2] @ set SVC priority
> +       mov     r5, #0x00800000
> +       str     r5, [r0, V7M_SCB_SHPR3] @ set PendSV priority
> +
> +       @ SVC to run the kernel in this mode
> +       adr     r1, BSYM(1f)
> +       ldr     r5, [r12, #11 * 4]      @ read the SVC vector entry
> +       str     r1, [r12, #11 * 4]      @ write the temporary SVC vector entry
> +       mov     r6, lr                  @ save LR
> +       mov     r7, sp                  @ save SP
> +       ldr     sp, =__v7m_setup_stack_top
> +       cpsie   i
> +       svc     #0
> +1:     cpsid   i
> +       str     r5, [r12, #11 * 4]      @ restore the original SVC vector entry
> +       mov     lr, r6                  @ restore LR
> +       mov     sp, r7                  @ restore SP
> +
> +       @ Special-purpose control register
> +       mov     r1, #1
> +       msr     control, r1             @ Thread mode has unpriviledged access
> +
> +       @ Configure the System Control Register to ensure 8-byte stack alignment
> +       @ Note the STKALIGN bit is either RW or RAO.
> +       ldr     r12, [r0, V7M_SCB_CCR]  @ system control register
> +       orr     r12, #V7M_SCB_CCR_STKALIGN
> +       str     r12, [r0, V7M_SCB_CCR]
> +       mov     pc, lr
> +ENDPROC(__v7m_setup)
> +
> +       .align  2
> +       .type   v7m_processor_functions, #object
> +ENTRY(v7m_processor_functions)
> +       .word   nommu_early_abort
 > +       .word   cpu_v7m_proc_init
 > +       .word   cpu_v7m_proc_fin

This seems *not* to align with the struct processor defined in

arch/arm/include/asm/proc-fns.h:

...
extern struct processor {
	/* MISC
	 * get data abort address/flags
	 */
	void (*_data_abort)(unsigned long pc);
	/*
	 * Retrieve prefetch fault address
	 */
	unsigned long (*_prefetch_abort)(unsigned long lr);
	/*
	 * Set up any processor specifics
	 */
	void (*_proc_init)(void);
	/*
	 * Disable any processor specifics
	 */
...

So what's the deal? I presume this is because when Catalin originally 
did the very first M3 stuff it happened before this commit:

48d7927bdf Add a prefetch abort handler

And as we weren't using MULTI_CPU nobody noticed the bug when things got 
updated?


Jonny
