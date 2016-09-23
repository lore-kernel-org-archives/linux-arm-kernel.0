From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Sep 2016 16:52:51 +0100
Subject: [PATCH] arm64: fix dump_backtrace with NULL tsk
In-Reply-To: <1474642587-22416-1-git-send-email-mark.rutland@arm.com>
References: <1474642587-22416-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160923155250.GA22454@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 03:56:27PM +0100, Mark Rutland wrote:
> In some places, dump_backtrace() is called with a NULL tsk parameter,
> e.g. in bug_handler() in arch/arm64, or indirectly via show_stack() in
> core code. The expectation is that this is treated as if current were
> passed instead of NULL.
> 
> Commit a80a0eb70c358f8c ("arm64: make irq_stack_ptr more robust") didn't
> take this into account, and compares tsk against current *before* we
> check if tsk is NULL.
> 
> Due to this, we won't initialise irq_stack_ptr, and when we try to dump
> the exception regs we may call dump_mem() for memory immediately above
> the IRQ stack range, rather than for the relevant range on the task
> stack.
> 
> This will result in misleading, though should not be otherwise
> problematic. The initial percpu areas (including the IRQ stacks) are
> allocated in the linear map, and dump_mem uses __get_user(), so we
> shouldn't access anything with side-effects, and will handle holes
> safely.
> 
> This patch fixes the issue by handling the NULL tsk case before we do
> anything else with tsk.

Looking again, it seems we have a similar issue in unwind_frame(), at
least when called by profile_pc(). In that case, we'll needlessly bail
out early with -EINVAL.

I'll spin a fix for that in v2...

Thanks,
Mark.
