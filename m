From: james.morse@arm.com (James Morse)
Date: Fri, 27 Apr 2018 12:23:21 +0100
Subject: [RFC PATCH v2 3/3] arm64: stacktrace: Prevent looping and invalid
 stack transitions
In-Reply-To: <1524503223-17576-4-git-send-email-Dave.Martin@arm.com>
References: <1524503223-17576-1-git-send-email-Dave.Martin@arm.com>
 <1524503223-17576-4-git-send-email-Dave.Martin@arm.com>
Message-ID: <299d9e13-2039-8b83-363f-9a8abe2e4954@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On 23/04/18 18:07, Dave Martin wrote:
> In the event of stack corruption, backtraces may loop indefinitely
> or wander off into memory that is not a valid stack for the context
> being backtraced.
> 
> This patch makes backtracing more robust against stack corruption,
> by taking two things into account:
> 
>  * while staying on the same stack, the frame address must strictly
>    increase from each frame to its ancestor;
> 
>  * when transitioning to another stack, the destination stack must
>    be a stack that has not been visited already.
> 
> on_accessible_stack() is converted to a more expressive helper
> identify_stack() that also tells the caller _which_ stack the task
> appears to be on.  A field stack_id is added to struct stackframe
> to track the result of this for the frame, along with a bitmap
> stacks_used that records which stacks have been visited by the
> backtrace.
> 
> Now that it is easy to check whether two successive frames are on
> the same stack, it becomes straightfowrard to add a check for
> strictly increasing frame address, to avoid looping around the same
> stack: this patch adds that too.
> 
> This patch does not attempt to catch invalid transitions such as
> from the task stack to the IRQ stack.  It turns out that the way
> the overflow stack is used makes this complicated.  Nonetheless,
> the number of frames parsed before the backtracer terminates should
> now be guaranteed to be finite.

Sounds like a good idea, I gave this a quick spin with SDEI...

With this series on top of the SDEI test goo:
[51497.386354] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.17.0-rc2-00023-g144855c44b20-dirty #9721
[51497.386366] Call trace:
[51497.386409]  dump_backtrace+0x0/0x1b8


Without this series:
[275604.647803] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.17.0-rc2-00018-gcf83397e1eaf-dirty #9722
[275604.647814] Call trace:
[275604.647857]  dump_backtrace+0x0/0x190
[275604.647900]  show_stack+0x14/0x20
[275604.647938]  dump_stack+0xac/0xe4
[275604.647972]  __sdei_handler+0x184/0x1d0
[275604.648009]  __sdei_asm_handler+0xbc/0x130
[275604.648050]  cpu_do_idle+0x8/0xc
[275604.648085]  default_idle_call+0x1c/0x38
[275604.648115]  do_idle+0x1bc/0x270
[275604.648147]  cpu_startup_entry+0x24/0x28
[275604.648189]  rest_init+0x24c/0x260
[275604.648226]  start_kernel+0x3b8/0x3cc


(please forgive the timestamps, the FVP thinks its a time machine)


> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index d5718a0..a5e0547 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -75,14 +77,30 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>  
>  	/*
> -	 * Frames created upon entry from EL0 have NULL FP and PC values, so
> -	 * don't bother reporting these. Frames created by __noreturn functions
> -	 * might have a valid FP even if PC is bogus, so only terminate where
> -	 * both are NULL.
> +	 * Terminate when the next frame isn't on any valid stack for
> +	 * tsk.  As a special case, frames created upon entry from EL0
> +	 * have NULL FP and PC values, so will terminate here also.
> +	 * Frames created by __noreturn functions might have a valid FP
> +	 * even if PC is bogus, so only terminate where FP is invalid.
>  	 */
> -	if (!frame->fp && !frame->pc)
> +	if (frame->stack_id == ARM64_STACK_NONE)
>  		return -EINVAL;


> +	/*
> +	 * Reject attempts to recurse back onto a stack that has been
> +	 * visited already:
> +	 */
> +	if (test_bit(frame->stack_id, frame->stacks_used))
> +		return -EINVAL;

Won't this happen for every frame? So we only get one frame per stack.
Could we move this into some special handling for stepping between stacks?


> +
> +	/* Verify forward progress while on the same stack: */
> +	if (frame->stack_id == stack_id) {
> +		if (frame->fp <= fp)
> +			return -EINVAL;
> +	}
> +
> +	set_bit(frame->stack_id, frame->stacks_used);
> +
>  	return 0;
>  }


Thanks,

James
