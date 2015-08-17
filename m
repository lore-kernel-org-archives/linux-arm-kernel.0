From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 17 Aug 2015 13:50:57 +0900
Subject: [RFC v2 0/4] arm64: ftrace: fix incorrect output from stack tracer
In-Reply-To: <50B298B0-1978-471B-BCE7-BC433E9993C1@gmail.com>
References: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
 <50B298B0-1978-471B-BCE7-BC433E9993C1@gmail.com>
Message-ID: <55D16831.5080605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 08/11/2015 11:52 PM, Jungseok Lee wrote:
> On Aug 4, 2015, at 4:44 PM, AKASHI Takahiro wrote:
>
> Hi Akashi,
>
>> See the following threads [1],[2] for the background.
>>
>> With this patch series, I'm trying to fix several problems I noticed
>> with stack tracer on arm64. But it is rather experimental, and there still
>> remained are several issues.
>>
>> Patch #1 modifies ftrace framework so that we can provide arm64-specific
>> stack tracer later.
>> (Well, I know there is some room for further refactoring, but this is
>> just a prototype code.)
>> Patch #2 implements this arch_check_stack() using unwind_stackframe() to
>> traverse stack frames and identify a stack index for each traced function.
>> Patch #3 addresses an issue that stack tracer doesn't work well in
>> conjuction with function graph tracer.
>> Patch #4 addresses an issue that unwind_stackframe() misses a function
>> that is the one when an exception happens by setting up a stack frame
>> for exception handler.
>>
>> See below for the result with those patches.
>> Issues include:
>> a) Size of gic_handle_irq() is 48 (#13), but should be 64.
>> b) We cannot identify a location of function which is being returned
>>    and hooked temporarily by return_to_handler() (#18)
>> c) A meaningless entry (#62) as well as a bogus size for the first
>>    function, el0_svc (#61)
>> d) Size doesn't contain a function's "dynamically allocated local
>>    variables," if any, but instead is sumed up in child's size.
>>    (See details in [3].)
>>
>> I'm afraid that we cannot fix issue b) unless we can do *atomically*
>> push/pop a return adress in current->ret_stack[], increment/decrement
>> current->curr_ret_stack and restore lr register.
>>
>> We will be able to fix issue d) once we know all the locations in
>> the list, including b).
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html
>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355920.html
>> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358034.html
>
> I hope I'm not too late..

I was on vacation last week.

> This series looks written on top of the hunk in the end of this reply.
>
> I've strongly agreed with your opinion as digging out this issue. We need to analyse
> the first instruction of each function, "stp x29, x30, [sp, #val]!", in order to
> solve this problem clearly.

As far as I notice, the following is not the only prologue:
   stp  x29,x30, [sp,#-xx]!
   mov  x29,sp
but some functions may have another one like:
   sub  sp, sp, #xx
   stp  x29,x30, [sp, #16]
   add  x29,sp, #16
Even worse, I see some variant, for example in trace_graph_entry(),
   adrp x2, 0x...
   stp  x29,x30,[sp,#-xx]!
   add  x4, x2, #..
   mov  x29,x30

So parsing the function prologue perfectly is a bit more complicated than imagined.
I'm now asking some gcc guy for more information.

Thanks,
-Takahiro AKASHI

> How about decoding the store-pair instruction? If so, we could record a correct position
> into stack_dump_index. That is, in your ascii art, top-sp0 and top-sp1 are written into
> stack_dump_index[i+1] and stack_dump_index[i] respectively.
>
> sp2     +-------+ <--------- func-2's stackframe
>          |       |
>          |       |
> fp2     +-------+
>          |  fp1  |
>          +-------+ <-- p1 (*p1 == stack_dump_trace[i] == lr1)
>          |  lr1  |
>          +-------+
>          |       |
>          |  func-2's local variables
>          |       |
> sp1     +-------+ <--------- func-1(lr1)'s stackframe
>          |       |             (stack_dump_index[i] = top - p1)
>          |  func-1's dynamic local variables
>          |       |
> fp1     +-------+
>          |  fp0  |
>          +-------+ <-- p0 (*p0 == stack_dump_trace[i+1] == lr0)
>          |  lr0  |
>          +-------+
>          |       |
>          |  func-1's local variables
>          |       |
> sp0     +-------+ <--------- func-0(lr0)'s stackframe
>          |       |             (stack_dump_index[i+1] = top - p0)
>          |       |
>          *-------+ top
>
> Best Regards
> Jungseok Lee
>
> ----8<----
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index c5534fa..2b43e20 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -13,8 +13,9 @@
>
> #include <asm/insn.h>
>
> -#define MCOUNT_ADDR		((unsigned long)_mcount)
> -#define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> +#define MCOUNT_ADDR			((unsigned long)_mcount)
> +#define MCOUNT_INSN_SIZE		AARCH64_INSN_SIZE
> +#define FTRACE_STACK_FRAME_OFFSET	AARCH64_INSN_SIZE
>
> #ifndef __ASSEMBLY__
> #include <linux/compat.h>
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 407991b..9ab67af 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -20,6 +20,7 @@
> #include <linux/sched.h>
> #include <linux/stacktrace.h>
>
> +#include <asm/insn.h>
> #include <asm/stacktrace.h>
>
> /*
> @@ -52,7 +53,7 @@ int notrace unwind_frame(struct stackframe *frame)
> 	 * -4 here because we care about the PC at time of bl,
> 	 * not where the return will go.
> 	 */
> -	frame->pc = *(unsigned long *)(fp + 8) - 4;
> +	frame->pc = *(unsigned long *)(fp + 8) - AARCH64_INSN_SIZE;
>
> 	return 0;
> }
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 1da6029..6566201 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -260,6 +260,9 @@ static inline void ftrace_kill(void) { }
> #endif /* CONFIG_FUNCTION_TRACER */
>
> #ifdef CONFIG_STACK_TRACER
> +#ifndef FTRACE_STACK_FRAME_OFFSET
> +#define FTRACE_STACK_FRAME_OFFSET 0
> +#endif
> extern int stack_tracer_enabled;
> int
> stack_trace_sysctl(struct ctl_table *table, int write,
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index b746399..30521ea 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -105,7 +105,7 @@ check_stack(unsigned long ip, unsigned long *stack)
>
> 	/* Skip over the overhead of the stack tracer itself */
> 	for (i = 0; i < max_stack_trace.nr_entries; i++) {
> -		if (stack_dump_trace[i] == ip)
> +		if ((stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET) == ip)
> 			break;
> 	}
>
> @@ -133,7 +133,8 @@ check_stack(unsigned long ip, unsigned long *stack)
> 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
> 			if (stack_dump_trace[i] == ULONG_MAX)
> 				break;
> -			if (*p == stack_dump_trace[i]) {
> +			if (*p == (stack_dump_trace[i]
> +					+ FTRACE_STACK_FRAME_OFFSET)) {
> 				stack_dump_trace[x] = stack_dump_trace[i++];
> 				this_size = stack_dump_index[x++] =
> 					(top - p) * sizeof(unsigned long);
> ----8<----
>
