From: richard@nod.at (Richard Weinberger)
Date: Sat, 26 May 2012 00:04:17 +0200
Subject: [PATCH 01/20] arm: Do not call do_signal() with irqs disabled
Message-ID: <1337983476-22081-1-git-send-email-richard@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_signal_to_deliver() calls try_to_freeze() which might sleep.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 4e5fdd9..434a1f3 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -13,6 +13,7 @@
 #include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
+#include <linux/irqflags.h>
 
 #include <asm/elf.h>
 #include <asm/cacheflush.h>
@@ -722,6 +723,8 @@ static void do_signal(struct pt_regs *regs, int syscall)
 asmlinkage void
 do_notify_resume(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 {
+	local_irq_enable();
+
 	if (thread_flags & _TIF_SIGPENDING)
 		do_signal(regs, syscall);
 
-- 
1.7.7.3
