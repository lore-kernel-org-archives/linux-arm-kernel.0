From: lkurusa@redhat.com (Levente Kurusa)
Date: Wed, 15 Jul 2015 17:30:50 +0200
Subject: [PATCH] arm: fault.c: fix unhandled page fault message
Message-ID: <1436974250-4999-1-git-send-email-lkurusa@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if the signal was handled using signal(2) the message
would be printed. Fix that by checking whether the signal
is handled.

Signed-off-by: Levente Kurusa <lkurusa@redhat.com>
---
 arch/arm/mm/fault.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 0d629b8..bbf5d73 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -164,8 +164,9 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	struct siginfo si;
 
 #ifdef CONFIG_DEBUG_USER
-	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
-	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
+	if ((((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
+	     ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) &&
+	     unhandled_signal(tsk, sig)) {
 		printk(KERN_DEBUG "%s: unhandled page fault (%d) at 0x%08lx, code 0x%03x\n",
 		       tsk->comm, sig, addr, fsr);
 		show_pte(tsk->mm, addr);
-- 
2.4.3
