From: shijie.huang@arm.com (Huang Shijie)
Date: Thu, 19 May 2016 09:52:24 +0800
Subject: [PATCH v12 07/10] arm64: kprobes instruction simulation support
In-Reply-To: <1461783185-9056-8-git-send-email-dave.long@linaro.org>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-8-git-send-email-dave.long@linaro.org>
Message-ID: <20160519015222.GA25870@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 02:53:02PM -0400, David Long wrote:
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
> ---
>  arch/arm64/include/asm/insn.h            |   1 +
>  arch/arm64/include/asm/probes.h          |   5 +-
>  arch/arm64/kernel/Makefile               |   3 +-
>  arch/arm64/kernel/insn.c                 |   1 +
>  arch/arm64/kernel/kprobes-arm64.c        |  29 ++++
>  arch/arm64/kernel/kprobes.c              |  32 ++++-
>  arch/arm64/kernel/probes-simulate-insn.c | 218 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/probes-simulate-insn.h |  28 ++++
>  8 files changed, 311 insertions(+), 6 deletions(-)
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
> index 8816de2..43bf6cc 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -37,7 +37,8 @@ arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
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
> index f79e72e..bb2738c 100644
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

For the same codingstyle, we'd better add more "{}" here and below.

thanks
Huang Shijie

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
