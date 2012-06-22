From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:07:02 +0100
Subject: [RFC PATCH 4/8] ARM: entry: don't bother with syscall tracing on
 ret_from_fork path
In-Reply-To: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
References: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1340377626-17075-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ret_from_fork is setup for a freshly spawned child task via copy_thread,
called from copy_process. The latter function clears TIF_SYSCALL_TRACE
and also resets the child task's audit_context to NULL, meaning that
there is little point invoking the system call tracing routines.
Furthermore, getting hold of the syscall number is a complete pain and
it looks like the current code doesn't even bother.

This patch removes the syscall tracing checks from ret_from_fork.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/entry-common.S |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 4afed88..10911c9 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -95,13 +95,7 @@ ENDPROC(ret_to_user)
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
