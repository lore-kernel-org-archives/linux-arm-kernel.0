From: james.morse@arm.com (James Morse)
Date: Fri, 09 Oct 2015 15:24:38 +0100
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
Message-ID: <5617CE26.10604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jungseok,

On 07/10/15 16:28, Jungseok Lee wrote:
> Currently, a call trace drops a process stack walk when a separate IRQ
> stack is used. It makes a call trace information much less useful when
> a system gets paniked in interrupt context.

panicked

> This patch addresses the issue with the following schemes:
> 
>   - Store aborted stack frame data
>   - Decide whether another stack walk is needed or not via current sp
>   - Loosen the frame pointer upper bound condition

It may be worth merging this patch with its predecessor - anyone trying to
bisect a problem could land between these two patches, and spend time
debugging the truncated call traces.


> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index 6ea82e8..e5904a1 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -2,13 +2,25 @@
>  #define __ASM_IRQ_H
>  
>  #include <linux/irqchip/arm-gic-acpi.h>
> +#include <asm/stacktrace.h>
>  
>  #include <asm-generic/irq.h>
>  
>  struct irq_stack {
>  	void *stack;
> +	struct stackframe frame;
>  };
>  
> +DECLARE_PER_CPU(struct irq_stack, irq_stacks);

Good idea, storing this in the per-cpu data makes it immune to stack
corruption.


> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 407991b..5124649 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -43,7 +43,27 @@ int notrace unwind_frame(struct stackframe *frame)
>  	low  = frame->sp;
>  	high = ALIGN(low, THREAD_SIZE);
>  
> -	if (fp < low || fp > high - 0x18 || fp & 0xf)
> +	/*
> +	 * A frame pointer would reach an upper bound if a prologue of the
> +	 * first function of call trace looks as follows:
> +	 *
> +	 *	stp     x29, x30, [sp,#-16]!
> +	 *	mov     x29, sp
> +	 *
> +	 * Thus, the upper bound is (top of stack - 0x20) with consideration

The terms 'top' and 'bottom' of the stack are confusing, your 'top' appears
to be the highest address, which is used first, making it the bottom of the
stack.

I would try to use the terms low/est and high/est, in keeping with the
variable names in use here.


> +	 * of a 16-byte empty space in THREAD_START_SP.
> +	 *
> +	 * The value, 0x20, however, does not cover all cases as interrupts
> +	 * are handled using a separate stack. That is, a call trace can start
> +	 * from elx_irq exception vectors. The symbols could not be promoted
> +	 * to candidates for a stack trace under the restriction, 0x20.
> +	 *
> +	 * The scenario is handled without complexity as 1) considering
> +	 * (bottom of stack + THREAD_START_SP) as a dummy frame pointer, the
> +	 * content of which is 0, and 2) allowing the case, which changes
> +	 * the value to 0x10 from 0x20.

Where has 0x20 come from? The old value was 0x18.

My understanding is the highest part of the stack looks like this:
high        [ off-stack ]
high - 0x08 [ left free by THREAD_START_SP ]
high - 0x10 [ left free by THREAD_START_SP ]
high - 0x18 [#1 x30 ]
high - 0x20 [#1 x29 ]

So the condition 'fp > high - 0x18' prevents returning either 'left free'
address, or off-stack-value as a frame. Changing it to 'fp > high - 0x10'
allows the first half of that reserved area to be a valid stack frame.

This change is breaking perf using incantations [0] and [1]:

Before, with just patch 1/2:
                  ---__do_softirq
                     |
                     |--92.95%-- __handle_domain_irq
                     |          __irqentry_text_start
                     |          el1_irq
                     |

After, with both patches:
                 ---__do_softirq
                    |
                    |--83.83%-- __handle_domain_irq
                    |          __irqentry_text_start
                    |          el1_irq
                    |          |
                    |          |--99.39%-- 0x400008040d00000c
                    |           --0.61%-- [...]
                    |

Changing the condition to 'fp >= high - 0x10' fixes this.

I agree it needs documenting, it is quite fiddly - I think Akashi Takahiro
is the expert.


I think unwind_frame() needs to walk the irq stack too. [2] is an example
of perf tracing back to userspace, (and there are patches on the list to
do/fix this), so we need to walk back to the start of the first stack for
the perf accounting to be correct.


> +	 */
> +	if (fp < low || fp > high - 0x10 || fp & 0xf)
>  		return -EINVAL;
>  
>  	frame->sp = fp + 0x10;
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index f93aae5..44b2f828 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -146,6 +146,8 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>  static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  {
>  	struct stackframe frame;
> +	unsigned int cpu = smp_processor_id();

I wonder if there is any case where dump_backtrace() is called on another cpu?

Setting the cpu value from task_thread_info(tsk)->cpu would protect against
this.


> +	bool in_irq = in_irq_stack(cpu);
>  
>  	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
>  
> @@ -170,6 +172,10 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  	}
>  
>  	pr_emerg("Call trace:\n");
> +repeat:
> +	if (in_irq)
> +		pr_emerg("<IRQ>\n");

Do we need these? 'el1_irq()' in the trace is a giveaway...


> +
>  	while (1) {
>  		unsigned long where = frame.pc;
>  		int ret;
> @@ -179,6 +185,13 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  			break;
>  		dump_backtrace_entry(where, frame.sp);
>  	}
> +
> +	if (in_irq) {
> +		frame = per_cpu(irq_stacks, cpu).frame;
> +		in_irq = false;
> +		pr_emerg("<EOI>\n");
> +		goto repeat;
> +	}
>  }
>  
>  void show_stack(struct task_struct *tsk, unsigned long *sp)


Thanks!

James


[0] sudo ./perf record -e mem:<address of __do_softirq()>:x -ag -- sleep 10
[1] sudo ./perf report --call-graph --stdio
[2] http://www.brendangregg.com/FlameGraphs/cpuflamegraphs.html
