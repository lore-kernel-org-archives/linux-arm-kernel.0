From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Aug 2016 17:25:16 +0100
Subject: [PATCH v15 08/13] arch/arm64: enable task isolation functionality
In-Reply-To: <1471382376-5443-9-git-send-email-cmetcalf@mellanox.com>
References: <1471382376-5443-1-git-send-email-cmetcalf@mellanox.com>
 <1471382376-5443-9-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160826162516.GC15779@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 05:19:31PM -0400, Chris Metcalf wrote:
> In do_notify_resume(), call task_isolation_ready() for
> TIF_TASK_ISOLATION tasks when we are checking the thread-info flags;
> and after we've handled the other work, call task_isolation_enter()
> for such tasks.  To ensure we always call task_isolation_enter() when
> returning to userspace, add _TIF_TASK_ISOLATION to _TIF_WORK_MASK,
> while leaving the old bitmask value as _TIF_WORK_LOOP_MASK to
> check while looping.
> 
> We tweak syscall_trace_enter() slightly to carry the "flags"
> value from current_thread_info()->flags for each of the tests,
> rather than doing a volatile read from memory for each one.  This
> avoids a small overhead for each test, and in particular avoids
> that overhead for TIF_NOHZ when TASK_ISOLATION is not enabled.
> 
> We instrument the smp_send_reschedule() routine so that it checks for
> isolated tasks and generates a suitable warning if we are about
> to disturb one of them in strict or debug mode.
> 
> Finally, report on page faults in task-isolation processes in
> do_page_faults().
> 
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> ---
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/thread_info.h |  5 ++++-
>  arch/arm64/kernel/ptrace.c           | 18 +++++++++++++++---
>  arch/arm64/kernel/signal.c           | 10 ++++++++++
>  arch/arm64/kernel/smp.c              |  2 ++
>  arch/arm64/mm/fault.c                |  8 +++++++-

Not sure when/how this series will be merged (Will already picked patch
07/13 as a general clean-up) but this arm64 patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
