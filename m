From: richard@nod.at (Richard Weinberger)
Date: Sat, 26 May 2012 00:04:29 +0200
Subject: [PATCH 13/20] arm: Do not call try_to_freeze() in do_signal()
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Message-ID: <1337983476-22081-13-git-send-email-richard@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_signal_to_deliver() already calls try_to_freeze(), there is no
need to call it directly.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm/kernel/signal.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 434a1f3..aeebb46 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -10,7 +10,6 @@
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
-#include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 #include <linux/irqflags.h>
@@ -636,9 +635,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		}
 	}
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	/*
 	 * Get the signal to deliver.  When running under ptrace, at this
 	 * point the debugger may change all our registers ...
@@ -678,7 +674,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		return;
 	}
 
- no_signal:
 	if (syscall) {
 		/*
 		 * Handle restarting a different system call.  As above,
-- 
1.7.7.3
