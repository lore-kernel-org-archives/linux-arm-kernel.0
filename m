From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 28 Jul 2014 20:38:29 -0700
Subject: [PATCH v4 2/5] x86,entry: Only call user_exit if TIF_NOHZ
In-Reply-To: <cover.1406604806.git.luto@amacapital.net>
References: <cover.1406604806.git.luto@amacapital.net>
Message-ID: <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RCU context tracking code requires that arch code call
user_exit() on any entry into kernel code if TIF_NOHZ is set.  This
patch adds a check for TIF_NOHZ and a comment to the syscall entry
tracing code.

The main purpose of this patch is to make the code easier to follow:
one can read the body of user_exit and of every function it calls
without finding any explanation of why it's called for traced
syscalls but not for untraced syscalls.  This makes it clear when
user_exit() is necessary.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/ptrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 39296d2..bbf338a 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1449,7 +1449,12 @@ long syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret = 0;
 
-	user_exit();
+	/*
+	 * If TIF_NOHZ is set, we are required to call user_exit() before
+	 * doing anything that could touch RCU.
+	 */
+	if (test_thread_flag(TIF_NOHZ))
+		user_exit();
 
 	/*
 	 * If we stepped into a sysenter/syscall insn, it trapped in
-- 
1.9.3
