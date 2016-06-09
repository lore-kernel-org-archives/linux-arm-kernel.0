From: james.morse@arm.com (James Morse)
Date: Thu, 09 Jun 2016 15:50:36 +0100
Subject: [PATCH v17 01/13] arm64: Add back cpu reset routines
In-Reply-To: <78ef589316b3f538938324efcbbb0361519c3393.1464974516.git.geoff@infradead.org>
References: <cover.1464974516.git.geoff@infradead.org>
 <78ef589316b3f538938324efcbbb0361519c3393.1464974516.git.geoff@infradead.org>
Message-ID: <5759823C.3070208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 03/06/16 19:13, Geoff Levand wrote:
> Commit 68234df4ea7939f98431aa81113fbdce10c4a84b (arm64: kill flush_cache_all())
> removed the global arm64 routines cpu_reset() and cpu_soft_restart() needed by
> the arm64 kexec and kdump support.  Add simplified versions of those two
> routines back with some changes needed for kexec in the new files cpu_reset.S,
> and cpu_reset.h.
> 
> When a CPU is reset it needs to be put into the exception level it had when it
> entered the kernel. Update cpu_soft_restart() to accept an argument which
> signals if the reset address needs to be entered at EL1 or EL2, and add a
> new hypercall HVC_SOFT_RESTART which is used for the EL2 switch.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>


> diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> new file mode 100644
> index 0000000..c321957
> --- /dev/null
> +++ b/arch/arm64/kernel/cpu-reset.S

> +ENTRY(__cpu_soft_restart)
> +	/* Clear sctlr_el1 flags. */
> +	mrs	x12, sctlr_el1
> +	ldr	x13, =SCTLR_ELx_FLAGS
> +	bic	x12, x12, x13
> +	msr	sctlr_el1, x12
> +	isb
> +
> +	cbz	x0, 1f				// el2_switch?
> +	mov	x0, #HVC_SOFT_RESTART
> +	hvc	#0				// no return
> +
> +1:	mov	x18, x1				// entry
> +	mov	x0, x2				// arg0
> +	mov	x1, x3				// arg1
> +	mov	x2, x4				// arg2
> +	ret	x18

Why ret not br?


> +ENDPROC(__cpu_soft_restart)
> +
> +.popsection
> diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
> new file mode 100644
> index 0000000..5a5ea0a
> --- /dev/null
> +++ b/arch/arm64/kernel/cpu-reset.h
> @@ -0,0 +1,29 @@
> +/*
> + * CPU reset routines
> + *
> + * Copyright (C) 2015 Huawei Futurewei Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _ARM64_CPU_RESET_H
> +#define _ARM64_CPU_RESET_H
> +
> +#include <asm/virt.h>
> +
> +void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
> +	unsigned long arg0, unsigned long arg1, unsigned long arg2);
> +
> +static inline void __noreturn cpu_soft_restart(unsigned long el2_switch,
> +	unsigned long entry, unsigned long arg0, unsigned long arg1,
> +	unsigned long arg2)

What is the last arg for? machine_kexec() passes zero, but
arm64_relocate_new_kernel() never reads this value..


> +{
> +	typeof(__cpu_soft_restart) *restart;
> +	restart = (void *)virt_to_phys(__cpu_soft_restart);
> +	restart(el2_switch, entry, arg0, arg1, arg2);

This confuses me each time I see it, I think it would be clearer if the
'cpu_install_idmap()' call were moved into this function. Any other user of this
function would need to do the same.

By the end of the series, the caller of this has:
> is_kernel_in_hyp_mode() ? 0 : (in_crash_kexec ? 0 : is_hyp_mode_available())
which is difficult to read, I had to write out the values to work it out.

I thinks it makes more sense to move the hyp-aware logic into this
cpu_soft_restart(), obviously kdump still needs a 'skip el2 jump' flag.


> +	unreachable();
> +}
> +
> +#endif
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 8727f44..a129e57 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -71,8 +71,17 @@ el1_sync:
>  	msr	vbar_el2, x1
>  	b	9f
>  
> +2:	cmp	x0, #HVC_SOFT_RESTART
> +	b.ne	3f
> +	mov	x0, x2
> +	mov	x2, x4
> +	mov	x4, x1
> +	mov	x1, x3
> +	blr	x4

blr not branch? If we ever did return from here, wouldn't we run the 'entry'
function again at EL1?


> +	b	9f
> +
>  	/* Someone called kvm_call_hyp() against the hyp-stub... */
> -2:	mov     x0, #ARM_EXCEPTION_HYP_GONE
> +3:	mov	x0, #ARM_EXCEPTION_HYP_GONE
>  
>  9:	eret
>  ENDPROC(el1_sync)
> 

For what its worth:

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
