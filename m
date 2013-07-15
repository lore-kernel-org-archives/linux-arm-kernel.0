From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Jul 2013 14:53:42 +0100
Subject: [PATCH] ARM: perf: Implement perf_arch_fetch_caller_regs
In-Reply-To: <1373685434-1581-1-git-send-email-jld@mozilla.com>
References: <1373685434-1581-1-git-send-email-jld@mozilla.com>
Message-ID: <20130715135342.GF10000@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jed,

On Sat, Jul 13, 2013 at 04:17:14AM +0100, Jed Davis wrote:
> We need a perf_arch_fetch_caller_regs for at least some software events
> to be able to get a callchain; even user stacks won't work without
> at least the CPSR bits for non-user-mode (see perf_callchain).  In
> particular, profiling context switches needs this.
> 
> This records the state of the point at which perf_arch_fetch_caller_regs
> is expanded, instead of that function activation's call site, because we
> need SP and PC to be consistent for EHABI unwinding; hopefully nothing
> will be inconvenienced by the extra stack frame.

[...]

> +#ifdef CONFIG_THUMB2_KERNEL
> +#define perf_arch_fetch_caller_regs(regs, ip)				\
> +	do {								\
> +		__u32 _cpsr, _pc;					\
> +		__asm__ __volatile__("str r7, [%[_regs], #(7 * 4)]\n\t" \
> +				     "str r13, [%[_regs], #(13 * 4)]\n\t" \
> +				     "str r14, [%[_regs], #(14 * 4)]\n\t" \

Is this safe? How can we be sure that the registers haven't been clobbered
by the callee before this macro is expanded? For example, you can end up
with the following code:

00000058 <perf_ftrace_function_call>:
  58:   e92d 43f0       stmdb   sp!, {r4, r5, r6, r7, r8, r9, lr}
  5c:   b09b            sub     sp, #108        ; 0x6c
  5e:   ac08            add     r4, sp, #32
  60:   4681            mov     r9, r0
  62:   4688            mov     r8, r1
  64:   4620            mov     r0, r4
  66:   2148            movs    r1, #72 ; 0x48
  68:   f7ff fffe       bl      0 <__memzero>
  6c:   61e7            str     r7, [r4, #28]
  6e:   f8c4 d034       str.w   sp, [r4, #52]   ; 0x34
  72:   f8c4 e038       str.w   lr, [r4, #56]   ; 0x38

but the call to __memzero will have corrupted the lr.

> +				     "mov %[_pc],  r15\n\t"		\
> +				     "mrs %[_cpsr], cpsr\n\t"		\
> +				     : [_cpsr] "=r" (_cpsr),		\
> +				       [_pc] "=r" (_pc)			\
> +				     : [_regs] "r" (&(regs)->uregs)	\

It would be cleaner to pass a separate argument for each register, using the
ARM_rN macros rather than calculating the offset by hand.

Will
