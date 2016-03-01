From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 1 Mar 2016 18:04:16 +0000
Subject: [PATCH v10 6/9] arm64: kprobes instruction simulation support
In-Reply-To: <1456801047-29014-7-git-send-email-dave.long@linaro.org>
References: <1456801047-29014-1-git-send-email-dave.long@linaro.org>
 <1456801047-29014-7-git-send-email-dave.long@linaro.org>
Message-ID: <56D5D9A0.9090205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/16 02:57, David Long wrote:
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
> This code also replaces the use of arch/arm/opcodes.c for
> arm_check_condition().

Outdated comment?

> 
> Thanks to Will Cohen for assorted suggested changes.
> 
> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> Signed-off-by: William Cohen <wcohen@redhat.com>
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm64/include/asm/insn.h            |   1 +
>  arch/arm64/include/asm/probes.h          |   5 +-
>  arch/arm64/kernel/Makefile               |   3 +-
>  arch/arm64/kernel/insn.c                 |   1 +
>  arch/arm64/kernel/kprobes-arm64.c        |  29 +++++
>  arch/arm64/kernel/kprobes.c              |  32 +++++-
>  arch/arm64/kernel/probes-simulate-insn.c | 187 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/probes-simulate-insn.h |  28 +++++
>  8 files changed, 280 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/kernel/probes-simulate-insn.c
>  create mode 100644 arch/arm64/kernel/probes-simulate-insn.h
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index b9567a1..26cee10 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -410,6 +410,7 @@ u32 aarch32_insn_mcr_extract_crm(u32 insn);
>  
>  typedef bool (pstate_check_t)(unsigned long);
>  extern pstate_check_t * const opcode_condition_checks[16];
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif	/* __ASM_INSN_H */
> diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
> index c5fcbe6..d524f7d 100644
> --- a/arch/arm64/include/asm/probes.h
> +++ b/arch/arm64/include/asm/probes.h
> @@ -15,11 +15,12 @@
>  #ifndef _ARM_PROBES_H
>  #define _ARM_PROBES_H
>  
> +#include <asm/opcodes.h>
> +
>  struct kprobe;
>  struct arch_specific_insn;
>  
>  typedef u32 kprobe_opcode_t;
> -typedef unsigned long (kprobes_pstate_check_t)(unsigned long);
>  typedef void (kprobes_handler_t) (u32 opcode, long addr, struct pt_regs *);
>  
>  enum pc_restore_type {
> @@ -35,7 +36,7 @@ struct kprobe_pc_restore {
>  /* architecture specific copy of original instruction */
>  struct arch_specific_insn {
>  	kprobe_opcode_t *insn;
> -	kprobes_pstate_check_t *pstate_cc;
> +	pstate_check_t *pstate_cc;
>  	kprobes_handler_t *handler;
>  	/* restore address after step xol */
>  	struct kprobe_pc_restore restore;
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 4efb791..08325e5 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -36,7 +36,8 @@ arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
>  arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>  arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>  arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
> -arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o
> +arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o		\
> +					   probes-simulate-insn.o
>  arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o
>  arm64-obj-$(CONFIG_PCI)			+= pci.o
>  arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index f7f2f95..5a52a88 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -30,6 +30,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/fixmap.h>
> +#include <asm/opcodes.h>
>  #include <asm/insn.h>
>  
>  #define AARCH64_INSN_SF_BIT	BIT(31)
> diff --git a/arch/arm64/kernel/kprobes-arm64.c b/arch/arm64/kernel/kprobes-arm64.c
> index e07727a..487238a 100644
> --- a/arch/arm64/kernel/kprobes-arm64.c
> +++ b/arch/arm64/kernel/kprobes-arm64.c
> @@ -21,6 +21,7 @@
>  #include <asm/sections.h>
>  
>  #include "kprobes-arm64.h"
> +#include "probes-simulate-insn.h"
>  
>  static bool __kprobes aarch64_insn_is_steppable(u32 insn)
>  {
> @@ -62,8 +63,36 @@ arm_probe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>  	 */
>  	if (aarch64_insn_is_steppable(insn))
>  		return INSN_GOOD;
> +
> +	if (aarch64_insn_is_bcond(insn)) {
> +		asi->handler = simulate_b_cond;
> +	} else if (aarch64_insn_is_cbz(insn) ||
> +	    aarch64_insn_is_cbnz(insn)) {
> +		asi->handler = simulate_cbz_cbnz;
> +	} else if (aarch64_insn_is_tbz(insn) ||
> +	    aarch64_insn_is_tbnz(insn)) {
> +		asi->handler = simulate_tbz_tbnz;
> +	} else if (aarch64_insn_is_adr_adrp(insn))
> +		asi->handler = simulate_adr_adrp;
> +	else if (aarch64_insn_is_b(insn) ||
> +	    aarch64_insn_is_bl(insn))
> +		asi->handler = simulate_b_bl;
> +	else if (aarch64_insn_is_br(insn) ||
> +	    aarch64_insn_is_blr(insn) ||
> +	    aarch64_insn_is_ret(insn))
> +		asi->handler = simulate_br_blr_ret;
> +	else if (aarch64_insn_is_ldr_lit(insn))
> +		asi->handler = simulate_ldr_literal;
> +	else if (aarch64_insn_is_ldrsw_lit(insn))
> +		asi->handler = simulate_ldrsw_literal;
>  	else
> +		/*
> +		 * Instruction cannot be stepped out-of-line and we don't
> +		 * (yet) simulate it.
> +		 */
>  		return INSN_REJECTED;
> +
> +	return INSN_GOOD_NO_SLOT;
>  }
>  
>  static bool __kprobes
> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
> index e72dbce..ffc5affd 100644
> --- a/arch/arm64/kernel/kprobes.c
> +++ b/arch/arm64/kernel/kprobes.c
> @@ -40,6 +40,9 @@ void jprobe_return_break(void);
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
> +static void __kprobes
> +post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
> +
>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>  {
>  	/* prepare insn slot */
> @@ -57,6 +60,24 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>  	p->ainsn.restore.type = RESTORE_PC;
>  }
>  
> +static void __kprobes arch_prepare_simulate(struct kprobe *p)
> +{
> +	/* This instructions is not executed xol. No need to adjust the PC */
> +	p->ainsn.restore.addr = 0;
> +	p->ainsn.restore.type = NO_RESTORE;
> +}
> +
> +static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
> +{
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +	if (p->ainsn.handler)
> +		p->ainsn.handler((u32)p->opcode, (long)p->addr, regs);
> +
> +	/* single step simulated, now go for post processing */
> +	post_kprobe_handler(kcb, regs);
> +}
> +
>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  {
>  	unsigned long probe_addr = (unsigned long)p->addr;
> @@ -73,7 +94,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  		return -EINVAL;
>  
>  	case INSN_GOOD_NO_SLOT:	/* insn need simulation */
> -		return -EINVAL;
> +		p->ainsn.insn = NULL;
> +		break;
>  
>  	case INSN_GOOD:	/* instruction uses slot */
>  		p->ainsn.insn = get_insn_slot();
> @@ -83,7 +105,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	};
>  
>  	/* prepare the instruction */
> -	arch_prepare_ss_slot(p);
> +	if (p->ainsn.insn)
> +		arch_prepare_ss_slot(p);
> +	else
> +		arch_prepare_simulate(p);
>  
>  	return 0;
>  }
> @@ -225,7 +250,8 @@ static void __kprobes setup_singlestep(struct kprobe *p,
>  		kernel_enable_single_step(regs);
>  		instruction_pointer(regs) = slot;
>  	} else	{
> -		BUG();
> +		/* insn simulation */
> +		arch_simulate_insn(p, regs);
>  	}
>  }
>  
> diff --git a/arch/arm64/kernel/probes-simulate-insn.c b/arch/arm64/kernel/probes-simulate-insn.c
> new file mode 100644
> index 0000000..4e6e700
> --- /dev/null
> +++ b/arch/arm64/kernel/probes-simulate-insn.c
> @@ -0,0 +1,187 @@
> +/*
> + * arch/arm64/kernel/probes-simulate-insn.c
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
> +
> +#include "probes-simulate-insn.h"
> +
> +#define sign_extend(x, signbit)		\
> +	((x) | (0 - ((x) & (1 << (signbit)))))
> +
> +#define bbl_displacement(insn)		\
> +	sign_extend(((insn) & 0x3ffffff) << 2, 27)
> +
> +#define bcond_displacement(insn)	\
> +	sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
> +
> +#define cbz_displacement(insn)	\
> +	sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
> +
> +#define tbz_displacement(insn)	\
> +	sign_extend(((insn >> 5) & 0x3fff) << 2, 15)
> +
> +#define ldr_displacement(insn)	\
> +	sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
> +
> +
> +static bool __kprobes check_cbz(u32 opcode, struct pt_regs *regs)
> +{
> +	int xn = opcode & 0x1f;
> +
> +	return (opcode & (1 << 31)) ?
> +	    (regs->regs[xn] == 0) : ((regs->regs[xn] & 0xffffffff) == 0);
> +}
> +
> +static bool __kprobes check_cbnz(u32 opcode, struct pt_regs *regs)
> +{
> +	int xn = opcode & 0x1f;
> +
> +	return (opcode & (1 << 31)) ?
> +	    (regs->regs[xn] != 0) : ((regs->regs[xn] & 0xffffffff) != 0);
> +}
> +
> +static bool __kprobes check_tbz(u32 opcode, struct pt_regs *regs)
> +{
> +	int xn = opcode & 0x1f;
> +	int bit_pos = ((opcode & (1 << 31)) >> 26) | ((opcode >> 19) & 0x1f);
> +
> +	return ((regs->regs[xn] >> bit_pos) & 0x1) == 0;
> +}
> +
> +static bool __kprobes check_tbnz(u32 opcode, struct pt_regs *regs)
> +{
> +	int xn = opcode & 0x1f;
> +	int bit_pos = ((opcode & (1 << 31)) >> 26) | ((opcode >> 19) & 0x1f);
> +
> +	return ((regs->regs[xn] >> bit_pos) & 0x1) != 0;
> +}
> +
> +/*
> + * instruction simulation functions
> + */
> +void __kprobes
> +simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	long imm, xn, val;
> +
> +	xn = opcode & 0x1f;
> +	imm = ((opcode >> 3) & 0x1ffffc) | ((opcode >> 29) & 0x3);
> +	imm = sign_extend(imm, 20);
> +	if (opcode & 0x80000000)
> +		val = (imm<<12) + (addr & 0xfffffffffffff000);
> +	else
> +		val = imm + addr;
> +
> +	regs->regs[xn] = val;

What happens when you have something like "adr xzr, blah"? I haven't
found out where you are writing that back yet, but that could be really
fun for SP...

> +
> +	instruction_pointer(regs) += 4;
> +}
> +
> +void __kprobes
> +simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	int disp = bbl_displacement(opcode);
> +
> +	/* Link register is x30 */
> +	if (opcode & (1 << 31))
> +		regs->regs[30] = addr + 4;
> +
> +	instruction_pointer(regs) = addr + disp;
> +}
> +
> +void __kprobes
> +simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	int disp = 4;
> +
> +	if (opcode_condition_checks[opcode & 0xf](regs->pstate & 0xffffffff))
> +		disp = bcond_displacement(opcode);
> +
> +	instruction_pointer(regs) = addr + disp;
> +}
> +
> +void __kprobes
> +simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	int xn = (opcode >> 5) & 0x1f;
> +
> +	/* Link register is x30 */
> +	if (((opcode >> 21) & 0x3) == 1)
> +		regs->regs[30] = addr + 4;
> +
> +	instruction_pointer(regs) = regs->regs[xn];
> +}
> +
> +void __kprobes
> +simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	int disp = 4;
> +
> +	if (opcode & (1 << 24)) {
> +		if (check_cbnz(opcode, regs))
> +			disp = cbz_displacement(opcode);
> +	} else {
> +		if (check_cbz(opcode, regs))
> +			disp = cbz_displacement(opcode);
> +	}
> +	instruction_pointer(regs) = addr + disp;
> +}
> +
> +void __kprobes
> +simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	int disp = 4;
> +
> +	if (opcode & (1 << 24)) {
> +		if (check_tbnz(opcode, regs))
> +			disp = tbz_displacement(opcode);
> +	} else {
> +		if (check_tbz(opcode, regs))
> +			disp = tbz_displacement(opcode);
> +	}
> +	instruction_pointer(regs) = addr + disp;
> +}
> +
> +void __kprobes
> +simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	u64 *load_addr;
> +	int xn = opcode & 0x1f;
> +	int disp = ldr_displacement(opcode);
> +
> +	load_addr = (u64 *) (addr + disp);
> +
> +	if (opcode & (1 << 30))	/* x0-x31 */
> +		regs->regs[xn] = *load_addr;
> +	else			/* w0-w31 */
> +		*(u32 *) (&regs->regs[xn]) = (*(u32 *) (load_addr));

Same here...

> +
> +	instruction_pointer(regs) += 4;
> +}
> +
> +void __kprobes
> +simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	s32 *load_addr;
> +	int xn = opcode & 0x1f;
> +	int disp = ldr_displacement(opcode);
> +
> +	load_addr = (s32 *) (addr + disp);
> +	regs->regs[xn] = *load_addr;

And here.

> +
> +	instruction_pointer(regs) += 4;
> +}
> diff --git a/arch/arm64/kernel/probes-simulate-insn.h b/arch/arm64/kernel/probes-simulate-insn.h
> new file mode 100644
> index 0000000..d6bb9a5
> --- /dev/null
> +++ b/arch/arm64/kernel/probes-simulate-insn.h
> @@ -0,0 +1,28 @@
> +/*
> + * arch/arm64/kernel/probes-simulate-insn.h
> + *
> + * Copyright (C) 2013 Linaro Limited
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
> +#ifndef _ARM_KERNEL_PROBES_SIMULATE_INSN_H
> +#define _ARM_KERNEL_PROBES_SIMULATE_INSN_H
> +
> +void simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs);
> +void simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs);
> +void simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs);
> +void simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs);
> +void simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs);
> +void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
> +void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
> +void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs);
> +
> +#endif /* _ARM_KERNEL_PROBES_SIMULATE_INSN_H */
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
