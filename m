From: james.morse@arm.com (James Morse)
Date: Thu, 12 May 2016 16:01:54 +0100
Subject: [PATCH v12 05/10] arm64: Kprobes with single stepping support
In-Reply-To: <1461783185-9056-6-git-send-email-dave.long@linaro.org>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-6-git-send-email-dave.long@linaro.org>
Message-ID: <57349AE2.3060507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David, Sandeepa,

On 27/04/16 19:53, David Long wrote:
> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>

> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
> new file mode 100644
> index 0000000..dfa1b1f
> --- /dev/null
> +++ b/arch/arm64/kernel/kprobes.c
> @@ -0,0 +1,520 @@
> +/*
> + * arch/arm64/kernel/kprobes.c
> + *
> + * Kprobes support for ARM64
> + *
> + * Copyright (C) 2013 Linaro Limited.
> + * Author: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/kprobes.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/stop_machine.h>
> +#include <linux/stringify.h>
> +#include <asm/traps.h>
> +#include <asm/ptrace.h>
> +#include <asm/cacheflush.h>
> +#include <asm/debug-monitors.h>
> +#include <asm/system_misc.h>
> +#include <asm/insn.h>
> +#include <asm/uaccess.h>
> +
> +#include "kprobes-arm64.h"
> +
> +#define MIN_STACK_SIZE(addr)	min((unsigned long)MAX_STACK_SIZE,	\
> +	(unsigned long)current_thread_info() + THREAD_START_SP - (addr))

What if we probe something called on the irq stack?
This needs the on_irq_stack() checks too, the start/end can be found from the
per-cpu irq_stack value.

[ ... ]

> +int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
> +{
> +	struct jprobe *jp = container_of(p, struct jprobe, kp);
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +	long stack_ptr = kernel_stack_pointer(regs);
> +
> +	kcb->jprobe_saved_regs = *regs;
> +	memcpy(kcb->jprobes_stack, (void *)stack_ptr,
> +	       MIN_STACK_SIZE(stack_ptr));

I wonder if we need this stack save/restore?

The comment next to the equivalent code for x86 says:
> gcc assumes that the callee owns the argument space and could overwrite it,
> e.g. tailcall optimization. So, to be absolutely safe we also save and
> restore enough stack bytes to cover the argument area.

On arm64 the first eight arguments are passed in registers, so we might not need
this stack copy. (sparc and powerpc work like this too, their versions of this
function don't copy chunks of the stack).

... then I went looking for functions with >8 arguments...

Looking at the arm64 defconfig dwarf debug data, there are 71 of these that
don't get inlined, picking at random:
> rockchip_clk_register_pll() has 13
> fib_dump_info() has 11
> vma_merge() has 10
> vring_create_virtqueue() has 10
etc...

So we do need this stack copying, so that we can probe these function without
risking the arguments being modified.

It may be worth including a comment to the effect that this stack save/restore
is needed for functions that pass >8 arguments where the pre-handler may change
these values on the stack.


> +	preempt_enable_no_resched();
> +	return 1;
> +}
> +


Thanks,

James
