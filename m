From: javi.merino@arm.com (Javi Merino)
Date: Mon, 23 Jan 2012 15:42:24 +0000
Subject: [PATCH] ARM: Print debug info for SIGBUS in user faults
Message-ID: <1327333344-26340-1-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print debug information on user faults for SIGBUS if user_debug = 16
in the kernel command line.

Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 arch/arm/mm/fault.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bb7eac3..40c43a9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -164,7 +164,8 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	struct siginfo si;
 
 #ifdef CONFIG_DEBUG_USER
-	if (user_debug & UDBG_SEGV) {
+	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
+	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
 		printk(KERN_DEBUG "%s: unhandled page fault (%d) at 0x%08lx, code 0x%03x\n",
 		       tsk->comm, sig, addr, fsr);
 		show_pte(tsk->mm, addr);
-- 
1.7.0.4
