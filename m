From: qiaozhou@asrmicro.com (Qiao Zhou)
Date: Fri, 7 Jul 2017 17:29:34 +0800
Subject: [PATCH V2] arm64: traps: disable irq in die()
Message-ID: <1499419774-14563-1-git-send-email-qiaozhou@asrmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current die(), the irq is disabled for __die() handle, not
including the possible panic() handling. Since the log in __die()
can take several hundreds ms, new irq might come and interrupt
current die().

If the process calling die() holds some critical resource, and some
other process scheduled later also needs it, then it would deadlock.
The first panic will not be executed.

So here disable irq for the whole flow of die().

Signed-off-by: Qiao Zhou <qiaozhou@asrmicro.com>
---
 arch/arm64/kernel/traps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0805b44..2e2ff88 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -274,10 +274,12 @@ static DEFINE_RAW_SPINLOCK(die_lock);
 void die(const char *str, struct pt_regs *regs, int err)
 {
 	int ret;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&die_lock, flags);
 
 	oops_enter();
 
-	raw_spin_lock_irq(&die_lock);
 	console_verbose();
 	bust_spinlocks(1);
 	ret = __die(str, err, regs);
@@ -287,13 +289,15 @@ void die(const char *str, struct pt_regs *regs, int err)
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	raw_spin_unlock_irq(&die_lock);
 	oops_exit();
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
 		panic("Fatal exception");
+
+	raw_spin_unlock_irqrestore(&die_lock, flags);
+
 	if (ret != NOTIFY_STOP)
 		do_exit(SIGSEGV);
 }
-- 
2.7.4
