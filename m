From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jul 2016 14:46:55 +0100
Subject: [PATCH v15 08/10] arm64: Add trampoline code for kretprobes
In-Reply-To: <1467995754-32508-9-git-send-email-dave.long@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-9-git-send-email-dave.long@linaro.org>
Message-ID: <20160719134655.GA21256@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 12:35:52PM -0400, David Long wrote:
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/kprobes_trampoline.S
> @@ -0,0 +1,85 @@
> +/*
> + * trampoline entry and return code for kretprobes.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
> +
> +	.text
> +
> +.macro save_all_base_regs
> +	stp x0, x1, [sp, #S_X0]
> +	stp x2, x3, [sp, #S_X2]
> +	stp x4, x5, [sp, #S_X4]
> +	stp x6, x7, [sp, #S_X6]
> +	stp x8, x9, [sp, #S_X8]
> +	stp x10, x11, [sp, #S_X10]
> +	stp x12, x13, [sp, #S_X12]
> +	stp x14, x15, [sp, #S_X14]
> +	stp x16, x17, [sp, #S_X16]
> +	stp x18, x19, [sp, #S_X18]
> +	stp x20, x21, [sp, #S_X20]
> +	stp x22, x23, [sp, #S_X22]
> +	stp x24, x25, [sp, #S_X24]
> +	stp x26, x27, [sp, #S_X26]
> +	stp x28, x29, [sp, #S_X28]
> +	add x0, sp, #S_FRAME_SIZE
> +	stp lr, x0, [sp, #S_LR]
> +/*
> + * Construct a useful saved PSTATE
> + */
> +	mrs x0, nzcv
> +	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
> +	mrs x1, daif
> +	and x1, x1, #(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)

I don't think you need the masking here, the mrs should return the
corresponding 4 bits.

> +	orr x0, x0, x1
> +	mrs x1, CurrentEL
> +	and x1, x1, #(3 << 2)
> +	orr x0, x1, x0
> +	mrs x1, SPSel
> +	and x1, x1, #1

Same here.

> +	orr x0, x1, x0
> +	str x0, [sp, #S_PSTATE]
> +.endm

How is this pstate used, other than the restoring of the condition flag
in the restore_all_base_regs macro? Does a kretprobes handler need
access to them?

Anyway, it's worth doing an stp xzr, x0, [sp, S_PC] so that we
initialise the pc in pt_regs.

> +
> +.macro restore_all_base_regs
> +	ldr x0, [sp, #S_PSTATE]
> +	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
> +	msr nzcv, x0
> +	ldp x0, x1, [sp, #S_X0]
> +	ldp x2, x3, [sp, #S_X2]
> +	ldp x4, x5, [sp, #S_X4]
> +	ldp x6, x7, [sp, #S_X6]
> +	ldp x8, x9, [sp, #S_X8]
> +	ldp x10, x11, [sp, #S_X10]
> +	ldp x12, x13, [sp, #S_X12]
> +	ldp x14, x15, [sp, #S_X14]
> +	ldp x16, x17, [sp, #S_X16]
> +	ldp x18, x19, [sp, #S_X18]
> +	ldp x20, x21, [sp, #S_X20]
> +	ldp x22, x23, [sp, #S_X22]
> +	ldp x24, x25, [sp, #S_X24]
> +	ldp x26, x27, [sp, #S_X26]
> +	ldp x28, x29, [sp, #S_X28]
> +.endm
> +
> +ENTRY(kretprobe_trampoline)
> +
> +	sub sp, sp, #S_FRAME_SIZE
> +
> +	save_all_base_regs
> +
> +	mov x0, sp
> +	bl trampoline_probe_handler
> +	/* Replace trampoline address in lr with actual
> +	   orig_ret_addr return address. */
> +	mov lr, x0
> +
> +	restore_all_base_regs
> +
> +	add sp, sp, #S_FRAME_SIZE
> +
> +	ret
> +
> +ENDPROC(kretprobe_trampoline)

-- 
Catalin
