From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Aug 2015 15:29:45 +0100
Subject: [PATCH v8 4/7] arm64: kprobes instruction simulation support
In-Reply-To: <1439254364-15362-5-git-send-email-dave.long@linaro.org>
References: <1439254364-15362-1-git-send-email-dave.long@linaro.org>
 <1439254364-15362-5-git-send-email-dave.long@linaro.org>
Message-ID: <20150812142945.GF23540@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Tue, Aug 11, 2015 at 01:52:41AM +0100, David Long wrote:
> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> 
> Kprobes needs simulation of instructions that cannot be stepped
> from different memory location, e.g.: those instructions
> that uses PC-relative addressing. In simulation, the behaviour
> of the instruction is implemented using a copy of pt_regs.
> 
> Following instruction catagories are simulated:
>  - All branching instructions(conditional, register, and immediate)
>  - Literal access instructions(load-literal, adr/adrp)
> 
> Conditional execution is limited to branching instructions in
> ARM v8. If conditions at PSTATE do not match the condition fields
> of opcode, the instruction is effectively NOP. Kprobes considers
> this case as 'miss'.
> 
> Thanks to Will Cohen for assorted suggested changes.
> 
> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> Signed-off-by: William Cohen <wcohen@redhat.com>
> Signed-off-by: David A. Long <dave.long@linaro.org>

[...]

> diff --git a/arch/arm64/kernel/probes-condn-check.c b/arch/arm64/kernel/probes-condn-check.c
> new file mode 100644
> index 0000000..e68aa0c
> --- /dev/null
> +++ b/arch/arm64/kernel/probes-condn-check.c
> @@ -0,0 +1,122 @@
> +/*
> + * arch/arm64/kernel/probes-condn-check.c
> + *
> + * Copyright (C) 2013 Linaro Limited
> + *
> + * Copied from: arch/arm/kernel/kprobes-common.c
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
> + * Description:
> + *
> + *  AArch64 and AArch32 shares same conditional(CNZV) flags encoding.
> + *  This file implements conditional check helpers compatible with
> + *  both AArch64 and AArch32 modes. Uprobes on v8 can handle both 32-bit
> + *  & 64-bit user-space instructions, so we abstract the common functions
> + *  in this file. While AArch64 and AArch32 specific instruction handling
> + *  are implemented in separate files, this file contains common bits.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <asm/probes.h>
> +
> +static unsigned long __kprobes __check_eq(unsigned long pstate)
> +{
> +       return pstate & PSR_Z_BIT;
> +}
> +
> +static unsigned long __kprobes __check_ne(unsigned long pstate)
> +{
> +       return (~pstate) & PSR_Z_BIT;
> +}
> +
> +static unsigned long __kprobes __check_cs(unsigned long pstate)
> +{
> +       return pstate & PSR_C_BIT;
> +}
> +
> +static unsigned long __kprobes __check_cc(unsigned long pstate)
> +{
> +       return (~pstate) & PSR_C_BIT;
> +}
> +
> +static unsigned long __kprobes __check_mi(unsigned long pstate)
> +{
> +       return pstate & PSR_N_BIT;
> +}
> +
> +static unsigned long __kprobes __check_pl(unsigned long pstate)
> +{
> +       return (~pstate) & PSR_N_BIT;
> +}
> +
> +static unsigned long __kprobes __check_vs(unsigned long pstate)
> +{
> +       return pstate & PSR_V_BIT;
> +}
> +
> +static unsigned long __kprobes __check_vc(unsigned long pstate)
> +{
> +       return (~pstate) & PSR_V_BIT;
> +}
> +
> +static unsigned long __kprobes __check_hi(unsigned long pstate)
> +{
> +       pstate &= ~(pstate >> 1);       /* PSR_C_BIT &= ~PSR_Z_BIT */
> +       return pstate & PSR_C_BIT;
> +}
> +
> +static unsigned long __kprobes __check_ls(unsigned long pstate)
> +{
> +       pstate &= ~(pstate >> 1);       /* PSR_C_BIT &= ~PSR_Z_BIT */
> +       return (~pstate) & PSR_C_BIT;
> +}
> +
> +static unsigned long __kprobes __check_ge(unsigned long pstate)
> +{
> +       pstate ^= (pstate << 3);        /* PSR_N_BIT ^= PSR_V_BIT */
> +       return (~pstate) & PSR_N_BIT;
> +}
> +
> +static unsigned long __kprobes __check_lt(unsigned long pstate)
> +{
> +       pstate ^= (pstate << 3);        /* PSR_N_BIT ^= PSR_V_BIT */
> +       return pstate & PSR_N_BIT;
> +}
> +
> +static unsigned long __kprobes __check_gt(unsigned long pstate)
> +{
> +       /*PSR_N_BIT ^= PSR_V_BIT */
> +       unsigned long temp = pstate ^ (pstate << 3);
> +
> +       temp |= (pstate << 1);  /*PSR_N_BIT |= PSR_Z_BIT */
> +       return (~temp) & PSR_N_BIT;
> +}
> +
> +static unsigned long __kprobes __check_le(unsigned long pstate)
> +{
> +       /*PSR_N_BIT ^= PSR_V_BIT */
> +       unsigned long temp = pstate ^ (pstate << 3);
> +
> +       temp |= (pstate << 1);  /*PSR_N_BIT |= PSR_Z_BIT */
> +       return temp & PSR_N_BIT;
> +}
> +
> +static unsigned long __kprobes __check_al(unsigned long pstate)
> +{
> +       return true;
> +}
> +
> +kprobes_pstate_check_t * const kprobe_condition_checks[16] = {
> +       &__check_eq, &__check_ne, &__check_cs, &__check_cc,
> +       &__check_mi, &__check_pl, &__check_vs, &__check_vc,
> +       &__check_hi, &__check_ls, &__check_ge, &__check_lt,
> +       &__check_gt, &__check_le, &__check_al, &__check_al
> +};

I *much* prefer this to our current inclusion / compilation of opcode.[ch]
from arch/arm/. Do you think you could put this somewhere like insn.h and
move armv8_deprecated.c over to using it?

Will
