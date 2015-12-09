From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Dec 2015 13:45:41 +0000
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <1449226948-14251-4-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-4-git-send-email-james.morse@arm.com>
Message-ID: <20151209134541.GH9303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Fri, Dec 04, 2015 at 11:02:27AM +0000, James Morse wrote:
> entry.S is modified to switch to the per_cpu irq_stack during el{0,1}_irq.
> irq_count is used to detect recursive interrupts on the irq_stack, it is
> updated late by do_softirq_own_stack(), when called on the irq_stack, before
> __do_softirq() re-enables interrupts to process softirqs.
> 
> do_softirq_own_stack() is added by this patch, but does not yet switch
> stack.
> 
> This patch adds the dummy stack frame and data needed by the previous
> stack tracing patches.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/irq.h |  2 ++
>  arch/arm64/kernel/entry.S    | 42 ++++++++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/irq.c      | 38 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index e2f3f135a3bc..fa2a8d0e4792 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -11,6 +11,8 @@
>  #include <asm-generic/irq.h>
>  #include <asm/thread_info.h>
>  
> +#define __ARCH_HAS_DO_SOFTIRQ
> +
>  struct pt_regs;
>  
>  DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index fc87373d3f88..81cc5380977d 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -27,6 +27,7 @@
>  #include <asm/cpufeature.h>
>  #include <asm/errno.h>
>  #include <asm/esr.h>
> +#include <asm/irq.h>
>  #include <asm/thread_info.h>
>  #include <asm/unistd.h>
>  
> @@ -175,6 +176,42 @@ alternative_endif
>  	mrs	\rd, sp_el0
>  	.endm
>  
> +	.macro	irq_stack_entry, dummy_lr
> +	mov	x19, sp			// preserve the original sp
> +
> +	adr_l	x25, irq_stack
> +	mrs	x26, tpidr_el1
> +	add	x25, x25, x26

Perhaps we could add a macro to assembler.h to correspond to __my_cpu_offset
in percpu.h?

> +
> +	/*
> +	 * Check the lowest address on irq_stack for the irq_count value,
> +	 * incremented by do_softirq_own_stack if we have re-enabled irqs
> +	 * while on the irq_stack.
> +	 */
> +	ldr	x26, [x25]
> +	cbnz	x26, 9998f		// recursive use?
> +
> +	/* switch to the irq stack */
> +	mov	x26, #IRQ_STACK_START_SP
> +	add	x26, x25, x26
> +	mov	sp, x26
> +
> +	/* Add a dummy stack frame */
> +	stp     x29, \dummy_lr, [sp, #-16]!           // dummy stack frame
> +	mov	x29, sp
> +	stp     xzr, x19, [sp, #-16]!

Hmm. I'm not sure we necessarily want to push a frame when the interrupt
was taken from userspace. The unwinder will either explode (which should
be fixed separately) or truncate the walk anyway.

If we changed this so that we only push a frame when taking an interrupt
from EL1, could we then avoid pushing x19 as well and get the unwinder
to walk back through the pushed fp like it usually would?

For the case where we've come from EL0, we want to zero fp. I don't
*think* we need to push anything at all.

Thoughts?

Will
