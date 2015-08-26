From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Aug 2015 15:12:24 -0700
Subject: [PATCH v2] arm: kgdb: Fix registers on sleeping tasks
In-Reply-To: <1440606038-14816-1-git-send-email-dianders@chromium.org>
References: <1440606038-14816-1-git-send-email-dianders@chromium.org>
Message-ID: <20150826221224.GT19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26, Douglas Anderson wrote:
> From: Doug Anderson <dianders@chromium.org>
> 
> Dumping registers from other sleeping tasks in KGDB was totally
> failing for me.  All registers were reported as 0 in many cases.
> 
> The code was using task_pt_regs(task) to try to get other thread
> registers.  This doesn't appear to be the right place to look.  From
> my tests, I saw non-zero values in this structure when we were looking
> at a kernel thread that had a userspace task associated with it, but
> it contained the register values from the userspace task.  So even in
> the cases where registers weren't reported as 0 we were still not
> showing the right thing.
> 
> Instead of using task_pt_regs(task) let's use task_thread_info(task).
> This is the same place that is referred to when doing a dump of all
> sleeping task stacks (kdb_show_stack() -> show_stack() ->
> dump_backtrace() -> unwind_backtrace() -> thread_saved_sp()).
> 
> As further evidence that this is the right thing to do, you can find
> the following comment in "gdbstub.c" right before it calls
> sleeping_thread_to_gdb_regs():
>   Pull stuff saved during switch_to; nothing else is accessible (or
>   even particularly relevant).  This should be enough for a stack
>   trace.
> ...and if you look at switch_to() it only saves r4-r11, sp and lr.
> Those are the same registers that I'm getting out of the
> task_thread_info().
> 
> With this change you can use "info thread" to see all tasks in the
> kernel and you can switch to other tasks and examine them in gdb.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Works for me.

Tested-by: Stephen Boyd <sboyd@codeurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
