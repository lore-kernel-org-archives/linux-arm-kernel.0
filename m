From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jul 2012 11:40:46 +0100
Subject: [PATCH] ARM: sys_trace: allow all syscall arguments to be updated via
 ptrace
Message-ID: <1342608046-32585-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prior to syscall invocation, __sys_trace only reloads r0-r3 from the
kernel stack, preventing the debugger from updating arguments 5-7 when
signalled via ptrace.

This patch updates the code to reload r0-r6, updating arguments 5 and 6
on the stack (argument 7 is only used by OABI indirect syscalls and
can remain in a register).

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

This applies on top of my signals branch, which includes Al's restart
changes rebased on top of Russell's audit branch.

Al -- I'm happy to add your S-o-B to this if you like.

 arch/arm/kernel/entry-common.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 2909bbca..978eac5 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -443,7 +443,8 @@ __sys_trace:
 	mov	scno, r0			@ syscall number (possibly new)
 	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
 	cmp	scno, #NR_syscalls		@ check upper syscall limit
-	ldmccia	r1, {r0 - r3}			@ have to reload r0 - r3
+	ldmccia	r1, {r0 - r6}			@ have to reload r0 - r6
+	stmccia	sp, {r4, r5}			@ and update the stack args
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
 	b	2b
 
-- 
1.7.4.1
