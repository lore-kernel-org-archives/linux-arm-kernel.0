From: michael.weiser@gmx.de (Michael Weiser)
Date: Mon, 22 Jan 2018 22:20:25 +0100
Subject: [PATCH 1/2] arm64: Remove unimplemented syscall log message
In-Reply-To: <20180122212026.26262-1-michael.weiser@gmx.de>
References: <20180122212026.26262-1-michael.weiser@gmx.de>
Message-ID: <20180122212026.26262-2-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stop printing a (ratelimited) kernel message for each instance of an
unimplemented syscall being called. Userland making an unimplemented
syscall is not necessarily misbehaviour and to be expected with a
current userland running on an older kernel. Also, the current message
looks scary to users but does not actually indicate a real problem nor
help them narrow down the cause. Just rely on sys_ni_syscall() to return
-ENOSYS.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
---
 arch/arm64/kernel/traps.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index bbb0fde2780e..0ef28b7f6aa7 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -526,14 +526,6 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 	}
 #endif
 
-	if (show_unhandled_signals_ratelimited()) {
-		pr_info("%s[%d]: syscall %d\n", current->comm,
-			task_pid_nr(current), regs->syscallno);
-		dump_instr("", regs);
-		if (user_mode(regs))
-			__show_regs(regs);
-	}
-
 	return sys_ni_syscall();
 }
 
-- 
2.16.0
