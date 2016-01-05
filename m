From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Tue, 5 Jan 2016 13:53:03 -0500
Subject: [PATCH 2/2] arm64: factor work_pending state machine to C
In-Reply-To: <1452015215-29506-2-git-send-email-mark.rutland@arm.com>
References: <20160105172106.GA7088@leverpostej>
 <1452015215-29506-2-git-send-email-mark.rutland@arm.com>
Message-ID: <568C110F.3060503@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2016 12:33 PM, Mark Rutland wrote:
> Currently ret_fast_syscall, work_pending, and ret_to_user form an ad-hoc
> state machine that can be difficult to reason about due to duplicated
> code and a large number of branch targets.
>
> This patch factors the common logic out into the existing
> do_notify_resume function, converting the code to C in the process,
> making the code more legible.
>
> This patch tries to mirror the existing behaviour as closely as possible
> while using the usual C control flow primitives. There should be no
> functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland<mark.rutland@arm.com>
> Cc: Catalin Marinas<catalin.marinas@arm.com>
> Cc: Chris Metcalf<cmetcalf@ezchip.com>
> Cc: Will Deacon<will.deacon@arm.com>
> ---
>   arch/arm64/kernel/entry.S  | 24 +++---------------------
>   arch/arm64/kernel/signal.c | 36 ++++++++++++++++++++++++++----------
>   2 files changed, 29 insertions(+), 31 deletions(-)

This looks good, and also makes the task isolation change drop in
very cleanly (relatively speaking).  Since do_notify_resume() is
called unconditionally now, we don't have to worry about fussing
with the bit numbering for the TIF_xxx flags in asm/threadinfo.h, so
that whole part of the patch can be dropped, and the actual
change to do_notify_resume() becomes:

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 3a6c60beadca..00d0ec3a8e60 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -25,6 +25,7 @@
  #include <linux/uaccess.h>
  #include <linux/tracehook.h>
  #include <linux/ratelimit.h>
+#include <linux/isolation.h>
  
  #include <asm/debug-monitors.h>
  #include <asm/elf.h>
@@ -408,7 +409,8 @@ asmlinkage void do_notify_resume(void)
                 local_irq_disable();
  
                 thread_flags = READ_ONCE(current_thread_info()->flags);
-               if (!(thread_flags & _TIF_WORK_MASK))
+               if (!(thread_flags & _TIF_WORK_MASK) &&
+                   task_isolation_ready())
                         break;
  
                 if (thread_flags & _TIF_NEED_RESCHED) {
@@ -428,5 +430,7 @@ asmlinkage void do_notify_resume(void)
  
                 if (thread_flags & _TIF_FOREIGN_FPSTATE)
                         fpsimd_restore_current_state();
+
+               task_isolation_enter();
         }
  }


For the moment I just added your two commits into my task-isolation
tree and pushed it up, but if your changes make it into 4.5 and the
task-isolation series doesn't, I will remove them and rebase on 4.5-rc1
once that's released.  I've similarly staged the arch/tile enablement
changes to go into 4.5 so I can drop them from the task-isolation tree
as well at that point.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
