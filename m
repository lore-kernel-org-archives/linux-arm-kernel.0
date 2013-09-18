From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Sep 2013 17:12:45 +0100
Subject: [PATCH] ARM: entry: fix tracing of ARM-private syscalls
Message-ID: <1379520765-20778-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 377747c40657 ("ARM: entry: allow ARM-private syscalls to be
restarted") reworked the low-level syscall dispatcher to allow
restarting of ARM-private syscalls. Unfortunately, this relocated the
label used to dispatch a private syscall from the trace path, so that
the invocation would be bypassed altogether!

This causes applications to fail under strace as soon as they rely on
a private syscall (e.g. set_tls):

  set_tls(0xb6fad4c0, 0xb6fadb98, 0xb6fb1050, 0xb6fad4c0, 0xb6fb1050)
      = -1 ENOSYS (Function not implemented)

This patch fixes the label so that we correctly dispatch private
syscalls from the trace path.

Reported-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/entry-common.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 74ad15d1..bc6bd96 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -442,10 +442,10 @@ local_restart:
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
 
 	add	r1, sp, #S_OFF
-	cmp	scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)
+2:	cmp	scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)
 	eor	r0, scno, #__NR_SYSCALL_BASE	@ put OS number back
 	bcs	arm_syscall
-2:	mov	why, #0				@ no longer a real syscall
+	mov	why, #0				@ no longer a real syscall
 	b	sys_ni_syscall			@ not private func
 
 #if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
-- 
1.8.2.2
