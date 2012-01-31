From: tixy@yxit.co.uk (Tixy)
Date: Tue, 31 Jan 2012 18:32:53 +0000
Subject: [PATCHv2 4/6] ARM: extract out code patch function from kprobes
In-Reply-To: <1327757725-10114-5-git-send-email-rabin@rab.in>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-5-git-send-email-rabin@rab.in>
Message-ID: <1328034773.2464.12.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-01-28 at 19:05 +0530, Rabin Vincent wrote:
> Extract out the code patching code from kprobes so that it can be used
> from the jump label code.  Additionally, the separated code:
> 
>  - Uses the IS_ENABLED() macros instead of the #ifdefs for THUMB2
>    support
> 
>  - Unifies the two separate functions in kprobes, providing one function
>    that uses stop_machine() internally, and one that can be called from
>    stop_machine() directly
> 
>  - Patches the text on all CPUs only on processors requiring software
>    broadcasting of cache operations
> 
> Cc: Jon Medhurst <tixy@yxit.co.uk>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Tested-by: Jon Medhurst <tixy@yxit.co.uk>

I haven't tested on a big endian machine, but from code review, Dave's
suggested change to __patch_text() looks like it is needed...
http://lists.arm.linux.org.uk/lurker/message/20120130.170006.8dea4fe6.en.html

With this change, these kprobes patches are
Acked-by: Jon Medhurst <tixy@yxit.co.uk>


> ---
>  arch/arm/kernel/Makefile  |    3 +-
>  arch/arm/kernel/kprobes.c |   86 ++++++++++++--------------------------------
>  arch/arm/kernel/patch.c   |   73 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/patch.h   |    7 ++++
>  4 files changed, 106 insertions(+), 63 deletions(-)
>  create mode 100644 arch/arm/kernel/patch.c
>  create mode 100644 arch/arm/kernel/patch.h
> 
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index dd3d5f1..8c63ee8 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -8,6 +8,7 @@ AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_ftrace.o = -pg
>  CFLAGS_REMOVE_insn.o = -pg
> +CFLAGS_REMOVE_patch.o = -pg
>  endif
>  
>  CFLAGS_REMOVE_return_address.o = -pg
> @@ -38,7 +39,7 @@ obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o
>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o
>  obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
> -obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-common.o
> +obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-common.o patch.o
>  ifdef CONFIG_THUMB2_KERNEL
>  obj-$(CONFIG_KPROBES)		+= kprobes-thumb.o
>  else
> diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
> index 129c116..ab1869d 100644
> --- a/arch/arm/kernel/kprobes.c
> +++ b/arch/arm/kernel/kprobes.c
> @@ -29,6 +29,7 @@
>  #include <asm/cacheflush.h>
>  
>  #include "kprobes.h"
> +#include "patch.h"
>  
>  #define MIN_STACK_SIZE(addr) 				\
>  	min((unsigned long)MAX_STACK_SIZE,		\
> @@ -103,57 +104,33 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_THUMB2_KERNEL
> -
> -/*
> - * For a 32-bit Thumb breakpoint spanning two memory words we need to take
> - * special precautions to insert the breakpoint atomically, especially on SMP
> - * systems. This is achieved by calling this arming function using stop_machine.
> - */
> -static int __kprobes set_t32_breakpoint(void *addr)
> -{
> -	((u16 *)addr)[0] = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION >> 16;
> -	((u16 *)addr)[1] = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION & 0xffff;
> -	flush_insns(addr, 2*sizeof(u16));
> -	return 0;
> -}
> -
>  void __kprobes arch_arm_kprobe(struct kprobe *p)
>  {
> -	uintptr_t addr = (uintptr_t)p->addr & ~1; /* Remove any Thumb flag */
> -
> -	if (!is_wide_instruction(p->opcode)) {
> -		*(u16 *)addr = KPROBE_THUMB16_BREAKPOINT_INSTRUCTION;
> -		flush_insns(addr, sizeof(u16));
> -	} else if (addr & 2) {
> -		/* A 32-bit instruction spanning two words needs special care */
> -		stop_machine(set_t32_breakpoint, (void *)addr, &cpu_online_map);
> +	unsigned int brkp;
> +	void *addr;
> +
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +		/* Remove any Thumb flag */
> +		addr = (void *)((uintptr_t)p->addr & ~1);
> +
> +		if (is_wide_instruction(p->opcode))
> +			brkp = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION;
> +		else
> +			brkp = KPROBE_THUMB16_BREAKPOINT_INSTRUCTION;
>  	} else {
> -		/* Word aligned 32-bit instruction can be written atomically */
> -		u32 bkp = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION;
> -#ifndef __ARMEB__ /* Swap halfwords for little-endian */
> -		bkp = (bkp >> 16) | (bkp << 16);
> -#endif
> -		*(u32 *)addr = bkp;
> -		flush_insns(addr, sizeof(u32));
> -	}
> -}
> +		kprobe_opcode_t insn = p->opcode;
>  
> -#else /* !CONFIG_THUMB2_KERNEL */
> +		addr = p->addr;
> +		brkp = KPROBE_ARM_BREAKPOINT_INSTRUCTION;
>  
> -void __kprobes arch_arm_kprobe(struct kprobe *p)
> -{
> -	kprobe_opcode_t insn = p->opcode;
> -	kprobe_opcode_t brkp = KPROBE_ARM_BREAKPOINT_INSTRUCTION;
> -	if (insn >= 0xe0000000)
> -		brkp |= 0xe0000000;  /* Unconditional instruction */
> -	else
> -		brkp |= insn & 0xf0000000;  /* Copy condition from insn */
> -	*p->addr = brkp;
> -	flush_insns(p->addr, sizeof(p->addr[0]));
> -}
> +		if (insn >= 0xe0000000)
> +			brkp |= 0xe0000000;  /* Unconditional instruction */
> +		else
> +			brkp |= insn & 0xf0000000;  /* Copy condition from insn */
> +	}
>  
> -#endif /* !CONFIG_THUMB2_KERNEL */
> +	patch_text(addr, brkp);
> +}
>  
>  /*
>   * The actual disarming is done here on each CPU and synchronized using
> @@ -166,25 +143,10 @@ void __kprobes arch_arm_kprobe(struct kprobe *p)
>  int __kprobes __arch_disarm_kprobe(void *p)
>  {
>  	struct kprobe *kp = p;
> -#ifdef CONFIG_THUMB2_KERNEL
> -	u16 *addr = (u16 *)((uintptr_t)kp->addr & ~1);
> -	kprobe_opcode_t insn = kp->opcode;
> -	unsigned int len;
> +	void *addr = (void *)((uintptr_t)kp->addr & ~1);
>  
> -	if (is_wide_instruction(insn)) {
> -		((u16 *)addr)[0] = insn>>16;
> -		((u16 *)addr)[1] = insn;
> -		len = 2*sizeof(u16);
> -	} else {
> -		((u16 *)addr)[0] = insn;
> -		len = sizeof(u16);
> -	}
> -	flush_insns(addr, len);
> +	__patch_text(addr, kp->opcode);
>  
> -#else /* !CONFIG_THUMB2_KERNEL */
> -	*kp->addr = kp->opcode;
> -	flush_insns(kp->addr, sizeof(kp->addr[0]));
> -#endif
>  	return 0;
>  }
>  
> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
> new file mode 100644
> index 0000000..30eff23
> --- /dev/null
> +++ b/arch/arm/kernel/patch.c
> @@ -0,0 +1,73 @@
> +#include <linux/kernel.h>
> +#include <linux/kprobes.h>
> +#include <linux/stop_machine.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/smp_plat.h>
> +#include <asm/opcodes.h>
> +
> +#include "patch.h"
> +
> +struct patch {
> +	void *addr;
> +	unsigned int insn;
> +};
> +
> +void __kprobes __patch_text(void *addr, unsigned int insn)
> +{
> +	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
> +	int size;
> +
> +	if (thumb2 && __opcode_is_thumb16(insn)) {
> +		*(u16 *)addr = __opcode_to_mem_thumb16(insn);
> +		size = sizeof(u16);
> +	} else if (thumb2 && ((uintptr_t)addr & 2)) {
> +		u16 *addrh = addr;
> +
> +		addrh[0] = __opcode_thumb32_first(insn);
> +		addrh[1] = __opcode_thumb32_second(insn);
> +
> +		size = sizeof(u32);
> +	} else {
> +		if (thumb2)
> +			insn = __opcode_to_mem_thumb32(insn);
> +		else
> +			insn = __opcode_to_mem_arm(insn);
> +
> +		*(u32 *)addr = insn;
> +		size = sizeof(u32);
> +	}
> +
> +	flush_icache_range((uintptr_t)(addr),
> +			   (uintptr_t)(addr) + size);
> +}
> +
> +static int __kprobes patch_text_stop_machine(void *data)
> +{
> +	struct patch *patch = data;
> +
> +	__patch_text(patch->addr, patch->insn);
> +
> +	return 0;
> +}
> +
> +void __kprobes patch_text(void *addr, unsigned int insn)
> +{
> +	struct patch patch = {
> +		.addr = addr,
> +		.insn = insn,
> +	};
> +
> +	if (cache_ops_need_broadcast()) {
> +		stop_machine(patch_text_stop_machine, &patch, cpu_online_mask);
> +	} else {
> +		bool straddles_word = IS_ENABLED(CONFIG_THUMB2_KERNEL)
> +				      && __opcode_is_thumb32(insn)
> +				      && ((uintptr_t)addr & 2);
> +
> +		if (straddles_word)
> +			stop_machine(patch_text_stop_machine, &patch, NULL);
> +		else
> +			__patch_text(addr, insn);
> +	}
> +}
> diff --git a/arch/arm/kernel/patch.h b/arch/arm/kernel/patch.h
> new file mode 100644
> index 0000000..b4731f2
> --- /dev/null
> +++ b/arch/arm/kernel/patch.h
> @@ -0,0 +1,7 @@
> +#ifndef _ARM_KERNEL_PATCH_H
> +#define _ARM_KERNEL_PATCH_H
> +
> +void patch_text(void *addr, unsigned int insn);
> +void __patch_text(void *addr, unsigned int insn);
> +
> +#endif
