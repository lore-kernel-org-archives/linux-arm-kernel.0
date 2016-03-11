From: james.morse@arm.com (James Morse)
Date: Fri, 11 Mar 2016 18:07:10 +0000
Subject: [PATCH v11 1/9] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
In-Reply-To: <1457501543-24197-2-git-send-email-dave.long@linaro.org>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-2-git-send-email-dave.long@linaro.org>
Message-ID: <56E3094E.5010906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 09/03/16 05:32, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Add HAVE_REGS_AND_STACK_ACCESS_API feature for arm64.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>

> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index ff7f132..efebf0f 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c

[ ... SNIP ... ]

> +/**
> + * regs_within_kernel_stack() - check the address in the stack
> + * @regs:      pt_regs which contains kernel stack pointer.
> + * @addr:      address which is checked.
> + *
> + * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
> + * If @addr is within the kernel stack, it returns true. If not, returns false.
> + */
> +bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
> +{
> +	return ((addr & ~(THREAD_SIZE - 1))  ==
> +		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));

I'm not sure where this is called from, but if kernel_stack_pointer(regs) could
ever point into an irq_stack you will get the wrong result.

arch/arm64/include/asm/irq.h has 'on_irq_stack(sp, cpu)' which should help,
although you will need to check the bounds of the irq_stack separately.


The horrible details...

>From arch/arm64/kernel/irq.c:20
> /* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned. */
> DEFINE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack)
> __aligned(16);

This was because per-cpu variables can be at-most page aligned.
6cdf9c7ca687 ("arm64: Store struct thread_info in sp_el0") changed
current_thread_info() to work on these weirdly aligned irq_stacks.


Thanks,

James
