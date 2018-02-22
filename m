From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 14:00:52 +0000
Subject: [PATCH 4/9] arm64: signal: Don't print anything directly in
 force_signal_inject
In-Reply-To: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
Message-ID: <1519308057-4953-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64_notify_die deals with printing out information regarding unhandled
signals, so there's no need to roll our own code here.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/traps.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b46b5be5bd6d..637ae3702950 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -363,13 +363,6 @@ void force_signal_inject(int signal, int code, unsigned long address)
 		signal = SIGKILL;
 	}
 
-	if (unhandled_signal(current, signal) &&
-	    show_unhandled_signals_ratelimited()) {
-		pr_info("%s[%d]: %s: pc=%08llx\n",
-			current->comm, task_pid_nr(current), desc, regs->pc);
-		dump_instr(KERN_INFO, regs);
-	}
-
 	info.si_signo = signal;
 	info.si_errno = 0;
 	info.si_code  = code;
-- 
2.1.4
