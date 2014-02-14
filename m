From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Feb 2014 11:35:15 -0800
Subject: [PATCH] ARM64: unwind: Fix PC calculation
Message-ID: <1392406515-27835-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The frame PC value in the unwind code used to just take the saved LR
value and use that.  That's incorrect as a stack trace, since it shows
the return path stack, not the call path stack.

In particular, it shows faulty information in case the bl is done as
the very last instruction of one label, since the return point will be
in the next label. That can easily be seen with tail calls to panic(),
which is marked __noreturn and thus doesn't have anything useful after it.

Easiest here is to just correct the unwind code and do a -4, to get the
actual call site for the backtrace instead of the return site.

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: stable at vger.kernel.org

---
 arch/arm64/kernel/stacktrace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index c3b6c63..463a757 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -48,7 +48,11 @@ int unwind_frame(struct stackframe *frame)
 
 	frame->sp = fp + 0x10;
 	frame->fp = *(unsigned long *)(fp);
-	frame->pc = *(unsigned long *)(fp + 8);
+	/*
+	 * -4 here because we care about the PC at time of bl,
+	 * not where the return will go.
+	 */
+	frame->pc = *(unsigned long *)(fp + 8) - 4;
 
 	return 0;
 }
-- 
1.7.10.4
