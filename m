From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Sep 2016 17:10:03 +0100
Subject: [PATCH] arm64: fix dump_backtrace with NULL tsk
In-Reply-To: <57E55117.8080907@arm.com>
References: <1474642587-22416-1-git-send-email-mark.rutland@arm.com>
 <57E55117.8080907@arm.com>
Message-ID: <20160923161003.GC22454@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 04:58:15PM +0100, James Morse wrote:
> Hi Mark,
> 
> On 23/09/16 15:56, Mark Rutland wrote:
> > In some places, dump_backtrace() is called with a NULL tsk parameter,
> > e.g. in bug_handler() in arch/arm64, or indirectly via show_stack() in
> > core code. The expectation is that this is treated as if current were
> > passed instead of NULL.
> > 
> > Commit a80a0eb70c358f8c ("arm64: make irq_stack_ptr more robust") didn't
> > take this into account, and compares tsk against current *before* we
> > check if tsk is NULL.
> > 
> > Due to this, we won't initialise irq_stack_ptr, and when we try to dump
> > the exception regs we may call dump_mem() for memory immediately above
> > the IRQ stack range, rather than for the relevant range on the task
> > stack.
> 
> Bother, I should have spotted that.

FWIW, it certainly wasn't obvious!

I only noticed because I had to vet all the callers for
try_get_task_stack() ... put_task_stack() correctness with
THREAD_INFO_IN_TASK.

> Thanks for catching this!
> 
> Acked-by: James Morse <james.morse@arm.com>

Cheers!
