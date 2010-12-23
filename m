From: filippo.arcidiacono@st.com (Filippo ARCIDIACONO)
Date: Thu, 23 Dec 2010 14:44:11 +0100
Subject: [PATCH 2/2] sh: stackprotector: change the canary value per task
In-Reply-To: <1293111851-7175-1-git-send-email-filippo.arcidiacono@st.com>
References: <1293111851-7175-1-git-send-email-filippo.arcidiacono@st.com>
Message-ID: <1293111851-7175-2-git-send-email-filippo.arcidiacono@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable __stack_chk_guard can be updated with the canary
value stored in the task struct whenever a task switch occurs.
Because the __stack_chk_guard is global, this cannot work on SMP,
where the initial canary is always used.

Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
Reviewed-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/sh/kernel/process_32.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 762a139..e98a981 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -21,6 +21,7 @@
 #include <linux/fs.h>
 #include <linux/ftrace.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/stackprotector.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/system.h>
@@ -221,6 +222,10 @@ __switch_to(struct task_struct *prev, struct task_struct *next)
 {
 	struct thread_struct *next_t = &next->thread;
 
+#if defined CONFIG_CC_STACKPROTECTOR && !defined CONFIG_SMP
+	__stack_chk_guard = next->stack_canary;
+#endif
+
 	unlazy_fpu(prev, task_pt_regs(prev));
 
 	/* we're going to use this soon, after a few expensive things */
-- 
1.5.5.6
