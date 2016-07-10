From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 10 Jul 2016 18:51:27 -0400
Subject: [PATCH v15 07/10] arm64: kprobes instruction simulation support
In-Reply-To: <1467995754-32508-8-git-send-email-dave.long@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-8-git-send-email-dave.long@linaro.org>
Message-ID: <CAP=VYLp4j8DWAXWS9Dj_EkhTXwUvBZhfyUzGT640ewq+Z4-NZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 8, 2016 at 12:35 PM, David Long <dave.long@linaro.org> wrote:
> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>
> Kprobes needs simulation of instructions that cannot be stepped
> from a different memory location, e.g.: those instructions
> that uses PC-relative addressing. In simulation, the behaviour
> of the instruction is implemented using a copy of pt_regs.
>
> The following instruction categories are simulated:
>  - All branching instructions(conditional, register, and immediate)
>  - Literal access instructions(load-literal, adr/adrp)
>
> Conditional execution is limited to branching instructions in
> ARM v8. If conditions at PSTATE do not match the condition fields
> of opcode, the instruction is effectively NOP.
>
> Thanks to Will Cohen for assorted suggested changes.
>
> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> Signed-off-by: William Cohen <wcohen@redhat.com>
> Signed-off-by: David A. Long <dave.long@linaro.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm64/include/asm/probes.h          |   5 +-
>  arch/arm64/kernel/insn.c                 |   1 +
>  arch/arm64/kernel/probes/Makefile        |   3 +-
>  arch/arm64/kernel/probes/decode-insn.c   |  33 ++++-
>  arch/arm64/kernel/probes/decode-insn.h   |   1 +
>  arch/arm64/kernel/probes/kprobes.c       |  53 ++++++--
>  arch/arm64/kernel/probes/simulate-insn.c | 218 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/probes/simulate-insn.h |  28 ++++
>  8 files changed, 327 insertions(+), 15 deletions(-)
>  create mode 100644 arch/arm64/kernel/probes/simulate-insn.c
>  create mode 100644 arch/arm64/kernel/probes/simulate-insn.h
>
>

[...]

> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> new file mode 100644
> index 0000000..429c333
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> @@ -0,0 +1,218 @@
> +/*
> + * arch/arm64/kernel/probes/simulate-insn.c
> + *
> + * Copyright (C) 2013 Linaro Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/kprobes.h>
> +#include <linux/module.h>

Maybe I missed something, but I don't see anything modular about this
code, so why include this?

Paul.
--

> +
> +#include "simulate-insn.h"
> +
> +#define sign_extend(x, signbit)                \
> +       ((x) | (0 - ((x) & (1 << (signbit)))))
> +
> +#define bbl_displacement(insn)         \
> +       sign_extend(((insn) & 0x3ffffff) << 2, 27)
> +
> +#define bcond_displacement(insn)       \
> +       sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
 > +       disp = ldr_displacement(opcode);
> +       load_addr = (s32 *) (addr + disp);
> +
> +       set_x_reg(regs, xn, *load_addr);
> +
> +       instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> +}
