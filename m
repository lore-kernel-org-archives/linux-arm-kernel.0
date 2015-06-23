From: jistone@redhat.com (Josh Stone)
Date: Mon, 22 Jun 2015 17:08:54 -0700
Subject: [PATCH] ARM: enable_irq before ret_fast_syscall tracing
In-Reply-To: <20150604100625.GI7557@n2100.arm.linux.org.uk>
References: <20150604100625.GI7557@n2100.arm.linux.org.uk>
Message-ID: <1435018134-9653-1-git-send-email-jistone@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When reached via the slow path __sys_trace, __sys_trace_return and its
callees usually have interrupts still enabled.  This is important if any
will schedule, like for a ptrace syscall-exit-stop.

In the rarer case where tracing was not enabled on syscall entry, and
then ret_fast_syscall sees tracing was enabled mid-syscall, then it
also ought to branch to __sys_trace_return with interrupts enabled.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Josh Stone <jistone@redhat.com>
---
 arch/arm/kernel/entry-common.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 4e7f40c577e6..5d8eb11b8571 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -35,7 +35,7 @@ ret_fast_syscall:
 	disable_irq				@ disable interrupts
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	tst	r1, #_TIF_SYSCALL_WORK
-	bne	__sys_trace_return
+	bne	ret_fast_syscall_trace
 	tst	r1, #_TIF_WORK_MASK
 	bne	fast_work_pending
 	asm_trace_hardirqs_on
@@ -45,6 +45,10 @@ ret_fast_syscall:
 	ct_user_enter
 
 	restore_user_regs fast = 1, offset = S_OFF
+
+ret_fast_syscall_trace:
+	enable_irq				@ enable interrupts
+	b	__sys_trace_return
  UNWIND(.fnend		)
 
 /*
-- 
2.4.2
