From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Jun 2016 11:26:22 +0100
Subject: [PATCH 1/5] arm64: Add markers around .text section and create
 sections.h
In-Reply-To: <1464876657-6692-2-git-send-email-james.morse@arm.com>
References: <1464876657-6692-1-git-send-email-james.morse@arm.com>
 <1464876657-6692-2-git-send-email-james.morse@arm.com>
Message-ID: <20160614102622.GA19235@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 03:10:53PM +0100, James Morse wrote:
> During resume from hibernate, memory containing the kernel text is cleaned
> to the PoU. Some parts of the kernel are executed with the MMU off, in
> which case these instructions need to be cleaned to the PoC.
> 
> To aid the cleaning of this text, add markers around the existing section.

The new markers here seem to be around TEXT_TEXT, which covers the
majority of kernel text, not just that which needs to execute with the
MMU off.

I see from the next patch that we'll clean the whole TEXT_TEXT area to
the PoC. It feels odd to be selective about the regions we perform
maintenance on while doing so for the largest mixed bag of instructions.

Could we instead create a new section (e.g. .mmuoff.text), and place the
required functions/data in there? That would avoid having to clean more
than necessary.

> Each time new section markers are added, kernel/vmlinux.ld.S is updated,
> and new extern char __start_foo[] definitions are scattered through the
> tree.
> 
> Create asm/include/sections.h to collect these definitions (and include
> the existing asm-generic version).

Nice cleanup!

It might make more sense to only add sections.h in this patch, and move
the TEXT_TEXT section additions to the next patch where they're going to
be used (so as to keep the review comments together).

Thanks,
Mark.

> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/Kbuild     |  1 -
>  arch/arm64/include/asm/sections.h | 29 +++++++++++++++++++++++++++++
>  arch/arm64/include/asm/traps.h    |  3 +--
>  arch/arm64/include/asm/virt.h     |  5 +----
>  arch/arm64/kernel/alternative.c   |  7 +++----
>  arch/arm64/kernel/hibernate.c     |  6 ------
>  arch/arm64/kernel/vmlinux.lds.S   |  2 ++
>  arch/arm64/kvm/reset.c            |  3 +--
>  8 files changed, 37 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm64/include/asm/sections.h
> 
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index cff532a6744e..50c1f646b704 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -33,7 +33,6 @@ generic-y += poll.h
>  generic-y += preempt.h
>  generic-y += resource.h
>  generic-y += rwsem.h
> -generic-y += sections.h
>  generic-y += segment.h
>  generic-y += sembuf.h
>  generic-y += serial.h
> diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
> new file mode 100644
> index 000000000000..1d9b0149f413
> --- /dev/null
> +++ b/arch/arm64/include/asm/sections.h
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (C) 2016 ARM Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __ASM_SECTIONS_H
> +#define __ASM_SECTIONS_H
> +
> +#include <asm-generic/sections.h>
> +
> +extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
> +extern char __hyp_text_start[], __hyp_text_end[];
> +extern char __idmap_text_start[], __idmap_text_end[];
> +extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
> +extern char __text_text_start[], __text_text_end[];
> +extern char __exception_text_start[], __exception_text_end[];
> +extern char __alt_instructions[], __alt_instructions_end[];
> +
> +#endif /* __ASM_SECTIONS_H */
> diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> index 0cc2f29bf9da..90156c803f11 100644
> --- a/arch/arm64/include/asm/traps.h
> +++ b/arch/arm64/include/asm/traps.h
> @@ -19,6 +19,7 @@
>  #define __ASM_TRAP_H
>  
>  #include <linux/list.h>
> +#include <asm/sections.h>
>  
>  struct pt_regs;
>  
> @@ -52,8 +53,6 @@ static inline int __in_irqentry_text(unsigned long ptr)
>  
>  static inline int in_exception_text(unsigned long ptr)
>  {
> -	extern char __exception_text_start[];
> -	extern char __exception_text_end[];
>  	int in;
>  
>  	in = ptr >= (unsigned long)&__exception_text_start &&
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index dcbcf8dcbefb..b78611157f8b 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -40,6 +40,7 @@
>  #ifndef __ASSEMBLY__
>  
>  #include <asm/ptrace.h>
> +#include <asm/sections.h>
>  
>  /*
>   * __boot_cpu_mode records what mode CPUs were booted in.
> @@ -82,10 +83,6 @@ extern void verify_cpu_run_el(void);
>  static inline void verify_cpu_run_el(void) {}
>  #endif
>  
> -/* The section containing the hypervisor text */
> -extern char __hyp_text_start[];
> -extern char __hyp_text_end[];
> -
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* ! __ASM__VIRT_H */
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index d2ee1b21a10d..4434dabde898 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -25,14 +25,13 @@
>  #include <asm/alternative.h>
>  #include <asm/cpufeature.h>
>  #include <asm/insn.h>
> +#include <asm/sections.h>
>  #include <linux/stop_machine.h>
>  
>  #define __ALT_PTR(a,f)		(u32 *)((void *)&(a)->f + (a)->f)
>  #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
>  #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
>  
> -extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
> -
>  struct alt_region {
>  	struct alt_instr *begin;
>  	struct alt_instr *end;
> @@ -124,8 +123,8 @@ static int __apply_alternatives_multi_stop(void *unused)
>  {
>  	static int patched = 0;
>  	struct alt_region region = {
> -		.begin	= __alt_instructions,
> -		.end	= __alt_instructions_end,
> +		.begin	= (struct alt_instr *)__alt_instructions,
> +		.end	= (struct alt_instr *)__alt_instructions_end,
>  	};
>  
>  	/* We always have a CPU 0 at this point (__init) */
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index f8df75d740f4..56e548fe0386 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -52,12 +52,6 @@ extern int in_suspend;
>  /* Do we need to reset el2? */
>  #define el2_reset_needed() (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
>  
> -/*
> - * Start/end of the hibernate exit code, this must be copied to a 'safe'
> - * location in memory, and executed from there.
> - */
> -extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
> -
>  /* temporary el2 vectors in the __hibernate_exit_text section. */
>  extern char hibernate_el2_vectors[];
>  
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 435e820e898d..6b3d2781a9f2 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -118,7 +118,9 @@ SECTIONS
>  			__exception_text_end = .;
>  			IRQENTRY_TEXT
>  			SOFTIRQENTRY_TEXT
> +			__text_text_start = .;
>  			TEXT_TEXT
> +			__text_text_end = .;
>  			SCHED_TEXT
>  			LOCK_TEXT
>  			HYPERVISOR_TEXT
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index b1ad730e1567..c2d3594dd546 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -32,6 +32,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_coproc.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/sections.h>
>  
>  /*
>   * ARMv8 Reset Values
> @@ -133,8 +134,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	return kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
>  }
>  
> -extern char __hyp_idmap_text_start[];
> -
>  unsigned long kvm_hyp_reset_entry(void)
>  {
>  	if (!__kvm_cpu_uses_extended_idmap()) {
> -- 
> 2.8.0.rc3
> 
