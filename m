From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 10 Nov 2015 23:05:03 +0900
Subject: [PATCH v5 5/6] arm64: ftrace: add arch-specific stack tracer
In-Reply-To: <1446792285-1154-6-git-send-email-takahiro.akashi@linaro.org>
References: <1446792285-1154-1-git-send-email-takahiro.akashi@linaro.org>
 <1446792285-1154-6-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <823AA540-A025-4D44-852A-10F4A99A5760@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 6, 2015, at 3:44 PM, AKASHI Takahiro wrote:

Hi Akashi,

> Stack tracer on arm64, check_stack(), is uniqeue in the following
> points:
> * analyze a function prologue of a traced function to estimate a more
>  accurate stack pointer value, replacing naive '<child's fp> + 0x10.'
> * use walk_stackframe(), instead of slurping stack contents as orignal
>  check_stack() does, to identify a stack frame and a stack index (height)
>  for every callsite.
> 
> Regarding a function prologue analyzer, there is no guarantee that we can
> handle all the possible patterns of function prologue as gcc does not use
> any fixed templates to generate them. 'Instruction scheduling' is another
> issue here.
> Nevertheless, the current version will surely cover almost all the cases
> in the kernel image and give us useful information on stack pointers.
> 
> So this patch utilizes a function prologue only for stack tracer, and
> does not affect the behaviors of existing stacktrace functions.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> arch/arm64/include/asm/stacktrace.h |    4 +
> arch/arm64/kernel/ftrace.c          |   64 ++++++++++++
> arch/arm64/kernel/stacktrace.c      |  185 ++++++++++++++++++++++++++++++++++-
> 3 files changed, 250 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index 7318f6d..47b4832 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -25,5 +25,9 @@ struct stackframe {
> extern int unwind_frame(struct stackframe *frame);
> extern void walk_stackframe(struct stackframe *frame,
> 			    int (*fn)(struct stackframe *, void *), void *data);
> +#ifdef CONFIG_STACK_TRACER
> +struct stack_trace;
> +extern void save_stack_trace_sp(struct stack_trace *trace, unsigned long *sp);
> +#endif
> 
> #endif	/* __ASM_STACKTRACE_H */
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 314f82d..46bfe37 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -9,6 +9,7 @@
>  * published by the Free Software Foundation.
>  */
> 
> +#include <linux/bug.h>
> #include <linux/ftrace.h>
> #include <linux/swab.h>
> #include <linux/uaccess.h>
> @@ -16,6 +17,7 @@
> #include <asm/cacheflush.h>
> #include <asm/ftrace.h>
> #include <asm/insn.h>
> +#include <asm/stacktrace.h>
> 
> #ifdef CONFIG_DYNAMIC_FTRACE
> /*
> @@ -173,3 +175,65 @@ int ftrace_disable_ftrace_graph_caller(void)
> }
> #endif /* CONFIG_DYNAMIC_FTRACE */
> #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> +
> +#ifdef CONFIG_STACK_TRACER
> +static unsigned long stack_trace_sp[STACK_TRACE_ENTRIES];
> +static unsigned long raw_stack_trace_max_size;
> +
> +void check_stack(unsigned long ip, unsigned long *stack)
> +{
> +	unsigned long this_size, flags;
> +	unsigned long top;
> +	int i, j;
> +
> +	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
> +	this_size = THREAD_SIZE - this_size;
> +
> +	if (this_size <= raw_stack_trace_max_size)
> +		return;
> +
> +	/* we do not handle an interrupt stack yet */
> +	if (!object_is_on_stack(stack))
> +		return;
> +
> +	local_irq_save(flags);
> +	arch_spin_lock(&max_stack_lock);
> +
> +	/* check again */
> +	if (this_size <= raw_stack_trace_max_size)
> +		goto out;
> +
> +	/* find out stack frames */
> +	stack_trace_max.nr_entries = 0;
> +	stack_trace_max.skip = 0;
> +	save_stack_trace_sp(&stack_trace_max, stack_trace_sp);
> +	stack_trace_max.nr_entries--; /* for the last entry ('-1') */
> +
> +	/* calculate a stack index for each function */
> +	top = ((unsigned long)stack & ~(THREAD_SIZE-1)) + THREAD_SIZE;
> +	for (i = 0; i < stack_trace_max.nr_entries; i++)
> +		stack_trace_index[i] = top - stack_trace_sp[i];
> +	raw_stack_trace_max_size = this_size;
> +
> +	/* Skip over the overhead of the stack tracer itself */
> +	for (i = 0; i < stack_trace_max.nr_entries; i++)
> +		if (stack_trace_max.entries[i] == ip)
> +			break;
> +
> +	stack_trace_max.nr_entries -= i;
> +	for (j = 0; j < stack_trace_max.nr_entries; j++) {
> +		stack_trace_index[j] = stack_trace_index[j + i];
> +		stack_trace_max.entries[j] = stack_trace_max.entries[j + i];
> +	}
> +	stack_trace_max_size = stack_trace_index[0];
> +
> +	if (task_stack_end_corrupted(current)) {
> +		WARN(1, "task stack is corrupted.\n");
> +		stack_trace_print();
> +	}
> +
> + out:
> +	arch_spin_unlock(&max_stack_lock);
> +	local_irq_restore(flags);
> +}
> +#endif /* CONFIG_STACK_TRACER */
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 5fd3477..4ee052a 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -23,6 +23,144 @@
> 
> #include <asm/stacktrace.h>
> 
> +#ifdef CONFIG_STACK_TRACER
> +/*
> + * This function parses a function prologue of a traced function and
> + * determines its stack size.
> + * A return value indicates a location of @pc in a function prologue.
> + * @return value:
> + * <case 1>                       <case 1'>
> + * 1:
> + *     sub sp, sp, #XX            sub sp, sp, #XX
> + * 2:
> + *     stp x29, x30, [sp, #YY]    stp x29, x30, [sp, #--ZZ]!
> + * 3:
> + *     add x29, sp, #YY           mov x29, sp
> + * 0:
> + *
> + * <case 2>
> + * 1:
> + *     stp x29, x30, [sp, #-XX]!
> + * 3:
> + *     mov x29, sp
> + * 0:
> + *
> + * @size: sp offset from calller's sp (XX or XX + ZZ)
> + * @size2: fp offset from new sp (YY or 0)
> + */
> +static int analyze_function_prologue(unsigned long pc,
> +		unsigned long *size, unsigned long *size2)
> +{
> +	unsigned long offset;
> +	u32 *addr, insn;
> +	int pos = -1;
> +	enum aarch64_insn_register src, dst, reg1, reg2, base;
> +	int imm;
> +	enum aarch64_insn_variant variant;
> +	enum aarch64_insn_adsb_type adsb_type;
> +	enum aarch64_insn_ldst_type ldst_type;
> +
> +	*size = *size2 = 0;
> +
> +	if (!pc)
> +		goto out;
> +
> +	if (unlikely(!kallsyms_lookup_size_offset(pc, NULL, &offset)))
> +		goto out;
> +
> +	addr = (u32 *)(pc - offset);
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +	if (addr == (u32 *)ftrace_call)
> +		addr = (u32 *)ftrace_caller;
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +	else if (addr == (u32 *)ftrace_graph_caller)
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +		addr = (u32 *)ftrace_caller;
> +#else
> +		addr = (u32 *)_mcount;
> +#endif
> +#endif
> +#endif
> +
> +	insn = *addr;
> +	pos = 1;
> +
> +	/* analyze a function prologue */
> +	while ((unsigned long)addr < pc) {
> +		if (aarch64_insn_is_branch_imm(insn) ||
> +		    aarch64_insn_is_br(insn) ||
> +		    aarch64_insn_is_blr(insn) ||
> +		    aarch64_insn_is_ret(insn) ||
> +		    aarch64_insn_is_eret(insn))
> +			/* exiting a basic block */
> +			goto out;
> +
> +		if (aarch64_insn_decode_add_sub_imm(insn, &dst, &src,
> +					&imm, &variant, &adsb_type)) {
> +			if ((adsb_type == AARCH64_INSN_ADSB_SUB) &&
> +				(dst == AARCH64_INSN_REG_SP) &&
> +				(src == AARCH64_INSN_REG_SP)) {
> +				/*
> +				 * Starting the following sequence:
> +				 *   sub sp, sp, #xx
> +				 *   stp x29, x30, [sp, #yy]
> +				 *   add x29, sp, #yy
> +				 */
> +				WARN_ON(pos != 1);
> +				pos = 2;
> +				*size += imm;
> +			} else if ((adsb_type == AARCH64_INSN_ADSB_ADD) &&
> +				(dst == AARCH64_INSN_REG_29) &&
> +				(src == AARCH64_INSN_REG_SP)) {
> +				/*
> +				 *   add x29, sp, #yy
> +				 * or
> +				 *   mov x29, sp
> +				 */
> +				WARN_ON(pos != 3);
> +				pos = 0;
> +				*size2 = imm;
> +
> +				break;
> +			}
> +		} else if (aarch64_insn_decode_load_store_pair(insn,
> +					&reg1, &reg2, &base, &imm,
> +					&variant, &ldst_type)) {
> +			if ((ldst_type ==
> +				AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX) &&
> +			    (reg1 == AARCH64_INSN_REG_29) &&
> +			    (reg2 == AARCH64_INSN_REG_30) &&
> +			    (base == AARCH64_INSN_REG_SP)) {
> +				/*
> +				 * Starting the following sequence:
> +				 *   stp x29, x30, [sp, #-xx]!
> +				 *   mov x29, sp
> +				 */
> +				WARN_ON(!((pos == 1) || (pos == 2)));
> +				pos = 3;
> +				*size += -imm;
> +			} else if ((ldst_type ==
> +				AARCH64_INSN_LDST_STORE_PAIR) &&
> +			    (reg1 == AARCH64_INSN_REG_29) &&
> +			    (reg2 == AARCH64_INSN_REG_30) &&
> +			    (base == AARCH64_INSN_REG_SP)) {
> +				/*
> +				 *   stp x29, x30, [sp, #yy]
> +				 */
> +				WARN_ON(pos != 2);
> +				pos = 3;
> +			}
> +		}
> +
> +		addr++;
> +		insn = *addr;
> +	}
> +
> +out:
> +	return pos;
> +}
> +#endif
> +

A small instruction decoder in software!

>From a high level point of view, it makes sense to deal with only three main
cases. Since it is tough to deal with all function prologues in perspective
of computational overhead and implementation complexity, the above change looks
like a pretty good tradeoff. This is what I can say now. I'm also interested
in feedbacks from other folks.

Best Regards
Jungseok Lee
