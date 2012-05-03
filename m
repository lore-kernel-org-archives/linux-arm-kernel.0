From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 May 2012 18:42:58 +0100
Subject: [PATCH 4/6] ARM: entry: don't bother with syscall tracing on
 ret_from_fork path
In-Reply-To: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
References: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
Message-ID: <1336066980-24000-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ret_from_fork is setup for a freshly spawned child task via copy_thread,
called from copy_process. The latter function clears TIF_SYSCALL_TRACE
and also resets the child task's audit_context to NULL, meaning that
there is little point invoking the system call tracing routines.
Furthermore, getting hold of the syscall number is a complete pain and
it looks like the current code doesn't even bother.

This patch removes the syscall tracing checks from ret_from_fork.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/entry-common.S |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 54ee265..93962cc 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -91,13 +91,7 @@ ENDPROC(ret_to_user)
 ENTRY(ret_from_fork)
 	bl	schedule_tail
 	get_thread_info tsk
-	ldr	r1, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	mov	why, #1
-	tst	r1, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
-	beq	ret_slow_syscall
-	mov	r1, sp
-	mov	r0, #1				@ trace exit [IP = 1]
-	bl	syscall_trace
 	b	ret_slow_syscall
 ENDPROC(ret_from_fork)
 
-- 
1.7.4.1
