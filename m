From: james.morse@arm.com (James Morse)
Date: Tue, 12 Sep 2017 10:54:28 +0100
Subject: [PATCH v2] arm64: fix unwind_frame() for filtered out fn for
 function graph tracing
In-Reply-To: <3c175a7a1f7c2e08098f6d5e84dc247ce94846d2.1504244801.git.panand@redhat.com>
References: <3c175a7a1f7c2e08098f6d5e84dc247ce94846d2.1504244801.git.panand@redhat.com>
Message-ID: <59B7AED4.1070106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 01/09/17 06:48, Pratyush Anand wrote:
> do_task_stat() calls get_wchan(), which further does unbind_frame().
> unbind_frame() restores frame->pc to original value in case function
> graph tracer has modified a return address (LR) in a stack frame to hook
> a function return. However, if function graph tracer has hit a filtered
> function, then we can't unwind it as ftrace_push_return_trace() has
> biased the index(frame->graph) with a 'huge negative'
> offset(-FTRACE_NOTRACE_DEPTH).
> 
> Moreover, arm64 stack walker defines index(frame->graph) as unsigned
> int, which can not compare a -ve number.
> 
> Similar problem we can have with calling of walk_stackframe() from
> save_stack_trace_tsk() or dump_backtrace().
> 
> This patch fixes unwind_frame() to test the index for -ve value and
> restore index accordingly before we can restore frame->pc.

I've just spotted arm64's profile_pc, which does this:
>From arch/arm64/kernel/time.c:profile_pc():
> #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> 	frame.graph = -1; /* no task info */
> #endif

Is this another elaborate way of hitting this problem?

I guess the options are skip any return-address restore in the unwinder if
frame.graph is -1. (and profile_pc may have a bug here). Or, put
current->curr_ret_stack in there.

profile_pc() always passes tsk=NULL, so the unwinder assumes its current...
kernel/profile.c pulls the pt_regs from a per-cpu irq_regs variable, that is
updated by handle_IPI ... so it looks like this should always be current...


Thanks,

James


> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 09d37d66b630..4c47147d0554 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -75,6 +75,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	if (tsk->ret_stack &&
>  			(frame->pc == (unsigned long)return_to_handler)) {
> +		if (frame->graph < 0)
> +			frame->graph += FTRACE_NOTRACE_DEPTH;
> +
>  		/*
>  		 * This is a case where function graph tracer has
>  		 * modified a return address (LR) in a stack frame
> 
