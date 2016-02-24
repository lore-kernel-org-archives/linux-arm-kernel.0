From: per.hallsmark@windriver.com (per.hallsmark at windriver.com)
Date: Wed, 24 Feb 2016 15:54:59 +0100
Subject: [PATCH] arm64: ni_syscall should be similar to other archs
Message-ID: <1456325699-25849-1-git-send-email-per.hallsmark@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Hallsmark <per.hallsmark@windriver.com>

Today arm64 have it's own variant when a userspace app is doing a
non-implemented syscall in that it dumps on console process name,
registers and such. This makes a different behaviour on arm64 than
on all other archs.

This patch propose to get inline with other archs.

If we want to have a note on console, syslog or so when doing a
nonimplemented syscall, it would be better to add a variable
show_nonimplemented_syscalls and sense on it in the generic
kernel/sys_ni.c::sys_ni_syscall() which could dump info (and then
it would be generic for all archs). But that is another discussion
alltogether, lets first synchronize the archs to behave similar.

Signed-off-by: Per Hallsmark <per.hallsmark@windriver.com>
---
 arch/arm64/kernel/traps.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cbedd72..980ff63 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -403,14 +403,6 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 	}
 #endif
 
-	if (show_unhandled_signals_ratelimited()) {
-		pr_info("%s[%d]: syscall %d\n", current->comm,
-			task_pid_nr(current), (int)regs->syscallno);
-		dump_instr("", regs);
-		if (user_mode(regs))
-			__show_regs(regs);
-	}
-
 	return sys_ni_syscall();
 }
 
-- 
2.5.0
