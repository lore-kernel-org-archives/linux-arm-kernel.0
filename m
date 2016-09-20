From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Sep 2016 17:59:46 +0100
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
Message-ID: <20160920165946.GA19353@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On Tue, Aug 02, 2016 at 11:00:09AM +0530, Pratyush Anand wrote:
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -70,6 +70,9 @@
>  #define BRK64_ESR_MASK		0xFFFF
>  #define BRK64_ESR_KPROBES	0x0004
>  #define BRK64_OPCODE_KPROBES	(AARCH64_BREAK_MON | (BRK64_ESR_KPROBES << 5))
> +/* uprobes BRK opcodes with ESR encoding  */
> +#define BRK64_ESR_UPROBES	0x0008
> +#define BRK64_OPCODE_UPROBES	(AARCH64_BREAK_MON | (BRK64_ESR_UPROBES << 5))

You can use 0x0005 as immediate, we don't need individual bits here.

> --- a/arch/arm64/include/asm/probes.h
> +++ b/arch/arm64/include/asm/probes.h
> @@ -35,4 +35,8 @@ struct arch_specific_insn {
>  };
>  #endif
>  
> +#ifdef CONFIG_UPROBES
> +typedef u32 uprobe_opcode_t;
> +#endif

We don't need #ifdef around this typedef. Also, all the other
architectures seem to have this typedef in asm/uprobes.h.

> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -217,6 +217,14 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);
>  
>  #include <asm-generic/ptrace.h>
>  
> +#define procedure_link_pointer(regs)	((regs)->regs[30])
> +
> +static inline void procedure_link_pointer_set(struct pt_regs *regs,
> +					   unsigned long val)
> +{
> +	procedure_link_pointer(regs) = val;
> +}

Do you need these macro and function here? It seems that they are only
used in arch_uretprobe_hijack_return_addr(), so you can just expand them
in there, no need for additional definitions.

> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -109,6 +109,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define TIF_NEED_RESCHED	1
>  #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
>  #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
> +#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */

Nitpick: you can just use 4 until we cover this gap.

> --- /dev/null
> +++ b/arch/arm64/include/asm/uprobes.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (C) 2014-2015 Pratyush Anand <panand@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _ASM_UPROBES_H
> +#define _ASM_UPROBES_H
> +
> +#include <asm/debug-monitors.h>
> +#include <asm/insn.h>
> +#include <asm/probes.h>
> +
> +#define MAX_UINSN_BYTES		AARCH64_INSN_SIZE
> +
> +#define UPROBE_SWBP_INSN	BRK64_OPCODE_UPROBES
> +#define UPROBE_SWBP_INSN_SIZE	4

Nitpick: for consistency, just use AARCH64_INSN_SIZE.

> +#define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
> +
> +struct arch_uprobe_task {
> +	unsigned long saved_fault_code;
> +};
> +
> +struct arch_uprobe {
> +	union {
> +		u8 insn[MAX_UINSN_BYTES];
> +		u8 ixol[MAX_UINSN_BYTES];
> +	};
> +	struct arch_probe_insn api;
> +	bool simulate;
> +};
> +
> +extern void flush_uprobe_xol_access(struct page *page, unsigned long uaddr,
> +		void *kaddr, unsigned long len);

I don't think we need this. It doesn't seem to be used anywhere other
than the arm64 uprobes.c file. So I would rather expose
sync_icache_aliases(), similarly to __sync_icache_dcache().

> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -688,7 +688,8 @@ ret_fast_syscall:
>  	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
>  	and	x2, x1, #_TIF_SYSCALL_WORK
>  	cbnz	x2, ret_fast_syscall_trace
> -	and	x2, x1, #_TIF_WORK_MASK
> +	mov     x2, #_TIF_WORK_MASK
> +	and     x2, x1, x2

Is this needed because _TIF_WORK_MASK cannot work as an immediate value
to 'and'? We could reorder the TIF bits, they are not exposed to user to
have ABI implications.

>  	cbnz	x2, work_pending
>  	enable_step_tsk x1, x2
>  	kernel_exit 0
> @@ -718,7 +719,8 @@ work_resched:
>  ret_to_user:
>  	disable_irq				// disable interrupts
>  	ldr	x1, [tsk, #TI_FLAGS]
> -	and	x2, x1, #_TIF_WORK_MASK
> +	mov     x2, #_TIF_WORK_MASK
> +	and     x2, x1, x2
>  	cbnz	x2, work_pending
>  	enable_step_tsk x1, x2
>  	kernel_exit 0

Same here.

> --- /dev/null
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -0,0 +1,227 @@
> +/*
> + * Copyright (C) 2014-2015 Pratyush Anand <panand@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/highmem.h>
> +#include <linux/ptrace.h>
> +#include <linux/uprobes.h>
> +
> +#include "decode-insn.h"
> +
> +#define UPROBE_INV_FAULT_CODE	UINT_MAX
> +
> +void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> +		void *src, unsigned long len)
> +{
> +	void *xol_page_kaddr = kmap_atomic(page);
> +	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
> +
> +	preempt_disable();

kmap_atomic() already disabled preemption.

> +
> +	/* Initialize the slot */
> +	memcpy(dst, src, len);
> +
> +	/* flush caches (dcache/icache) */
> +	flush_uprobe_xol_access(page, vaddr, dst, len);

Just use sync_icache_aliases() here (once exposed in an arm64 header).

> +
> +	preempt_enable();
> +
> +	kunmap_atomic(xol_page_kaddr);
> +}
> +
> +unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
> +{
> +	return instruction_pointer(regs);
> +}
> +
> +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
> +		unsigned long addr)
> +{
> +	probe_opcode_t insn;
> +
> +	/* TODO: Currently we do not support AARCH32 instruction probing */

Is there a way to check (not necessarily in this file) that we don't
probe 32-bit tasks?

> +	if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
> +		return -EINVAL;
> +
> +	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
> +
> +	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
> +	case INSN_REJECTED:
> +		return -EINVAL;
> +
> +	case INSN_GOOD_NO_SLOT:
> +		auprobe->simulate = true;
> +		break;
> +
> +	case INSN_GOOD:
> +	default:
> +		break;

Nitpick, we don't need case INSN_GOOD as well since default would cover
it (that's unless you want to change default to BUG()).

> +	}
> +
> +	return 0;
> +}
> +
> +int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> +{
> +	struct uprobe_task *utask = current->utask;
> +
> +	/* saved fault code is restored in post_xol */
> +	utask->autask.saved_fault_code = current->thread.fault_code;

Does the current->thread.fault_code has any meaning here? We use it in
the arm64 code when delivering a signal to user but I don't think that's
the case here, we are handling a breakpoint instruction and there isn't
anything that set the fault_code.

> +
> +	/* An invalid fault code between pre/post xol event */
> +	current->thread.fault_code = UPROBE_INV_FAULT_CODE;
> +
> +	/* Instruction point to execute ol */
> +	instruction_pointer_set(regs, utask->xol_vaddr);
> +
> +	user_enable_single_step(current);
> +
> +	return 0;
> +}
> +
> +int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> +{
> +	struct uprobe_task *utask = current->utask;
> +
> +	WARN_ON_ONCE(current->thread.fault_code != UPROBE_INV_FAULT_CODE);
> +
> +	/* restore fault code */
> +	current->thread.fault_code = utask->autask.saved_fault_code;

Same here, I don't think this needs restoring if it wasn't meaningful in
the first place.


-- 
Catalin
