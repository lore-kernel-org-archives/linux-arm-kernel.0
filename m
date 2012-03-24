From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sat, 24 Mar 2012 14:31:10 +0400
Subject: [PATCH 09/10] um: Properly check all process' threads for a live mm
In-Reply-To: <20120324102609.GA28356@lizard>
References: <20120324102609.GA28356@lizard>
Message-ID: <20120324103110.GI29067@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kill_off_processes() might miss a valid process, this is because
checking for process->mm is not enough. Process' main thread may
exit or detach its mm via use_mm(), but other threads may still
have a valid mm.

To catch this we use find_lock_task_mm(), which walks up all
threads and returns an appropriate task (with task lock held).

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/um/kernel/reboot.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 1411f4e..3d15243 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -6,6 +6,7 @@
 #include "linux/sched.h"
 #include "linux/spinlock.h"
 #include "linux/slab.h"
+#include "linux/oom.h"
 #include "kern_util.h"
 #include "os.h"
 #include "skas.h"
@@ -25,13 +26,13 @@ static void kill_off_processes(void)
 
 		read_lock(&tasklist_lock);
 		for_each_process(p) {
-			task_lock(p);
-			if (!p->mm) {
-				task_unlock(p);
+			struct task_struct *t;
+
+			t = find_lock_task_mm(p);
+			if (!t)
 				continue;
-			}
-			pid = p->mm->context.id.u.pid;
-			task_unlock(p);
+			pid = t->mm->context.id.u.pid;
+			task_unlock(t);
 			os_kill_ptraced_process(pid, 1);
 		}
 		read_unlock(&tasklist_lock);
-- 
1.7.9.2
