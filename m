From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Apr 2018 11:58:14 +0100
Subject: [RFC PATCH 3/3] arm64: stacktrace: Prevent looping and invalid
 stack transitions
In-Reply-To: <1524221179-19473-4-git-send-email-Dave.Martin@arm.com>
References: <1524221179-19473-1-git-send-email-Dave.Martin@arm.com>
 <1524221179-19473-4-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180420105814.a7ntoqslbsgzluia@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 11:46:19AM +0100, Dave Martin wrote:
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
>  * when transitioning to another stack, the set of valid stacks for
>    the context forms a strict hierarchy (e.g., a frame on the task
>    stack cannot have an ancestor frame on the IRQ stack because
>    task context cannot preempt IRQ handlers etc.)
> 
> on_accessible_stack() is converted to a more expressive helper
> identify_stack() that also tells the caller _which_ stack the task
> appears to be on.  The stack identifier is represented by an enum
> sorted into the correct order for checking stack transition
> validity by a simple numeric comparison.  A field stack_id is added
> to struct stackframe to track the result of this for the frame.
> 
> Now that it is easy to check whether two successive frames are on
> the same stack, it is easy to add a check for strictly increasing
> frame address, to avoid looping around the same stack.
> 
> Now that frames can be mapped to a strict lexical order on the
> stack id and frame address, forward progress should be guaranteed.
> 
> Backtracing now terminates whenever the next frame violates this
> order, with kernel entry (with fp == 0 && pc == 0) as a special
> case of this.
> 
> Reported-by: Ji Zhang <ji.zhang@mediatek.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> The assumption that we can place the possible stacks (task, IRQ,
> overflow, SDEI) in a strict order is based on a quick review of
> entry.S, but I may have this wrong... in which case the approach
> proposed in this patch may need tweaking (or may not work at all).

We have a partial ordering where we can transition between stacks:

	task -> irq -> {overflow,sdei}

The only problem that I'm aware of is that you could go either way:

	overflow -> sdei
	sdei -> overflow

In either case, there's a fatal error, and it would be very nice to get
the most reliable stacktrace possible rather than terminating early.

The only way I'd thought to avoid that was to keep track of the last SP
we saw per-stack to avoid a lexical ordering, e.g.

struct stackframe {

	...

	/* assume we init these to 0 before unwinding */
	unsigned long last_task_fp;
	unsigned long last_irq_fp;
	unsigned long last_ovf_fp;
	unsigned long last_sdei_fp;
};

... and corresponding when we unwind a frame, do something like:

	if (on_task_stack(task, sp) {
		if (sp < frame->last_task_fp)
			<fail>
		frame->last_task_fp = sp;
	} else if (on_irq_stack(sp)) {
		if (sp < frame->last_irq_fp)
			<fail>
		frame->last_irq_fp = sp;
	} else (...) {
		...
	}
			
Thanks,
Mark.
