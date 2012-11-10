From: keescook@chromium.org (Kees Cook)
Date: Sat, 10 Nov 2012 14:44:44 -0800
Subject: [PATCH 3/4] arch/arm: allow a scno of -1 to not cause a SIGILL
In-Reply-To: <1352587485-18348-1-git-send-email-keescook@chromium.org>
References: <1352587485-18348-1-git-send-email-keescook@chromium.org>
Message-ID: <1352587485-18348-4-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On tracehook-friendly platforms, a system call number of -1 falls
through without running much code or taking much action.

ARM is different. This adds a short-circuit check in the trace path to
avoid any additional work, as suggested by Russell King, to make sure
that ARM behaves the same way as other platforms.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/entry-common.S |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 8355d4b..0bef977 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -448,7 +448,10 @@ __sys_trace:
 	ldmccia	r1, {r0 - r6}			@ have to reload r0 - r6
 	stmccia	sp, {r4, r5}			@ and update the stack args
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
-	b	2b
+	cmp	scno, #-1			@ skip the syscall?
+	bne	2b
+	add	sp, sp, #S_OFF			@ restore stack
+	b	ret_slow_syscall
 
 __sys_trace_return:
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
-- 
1.7.9.5
