From: drew.richardson@arm.com (Drew Richardson)
Date: Tue, 14 Jul 2015 08:45:57 -0400
Subject: [PATCH] ARM: Mark ret_fast_syscall as a function
Message-ID: <1436877957-18127-1-git-send-email-drew.richardson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ret_fast_syscall runs when user space makes a syscall. However it
needs to be marked as such so the ELF information is correct. Before
it was:

   101: 8000f300     0 NOTYPE  LOCAL  DEFAULT    2 ret_fast_syscall

But with this change it correctly shows as:

   101: 8000f300    96 FUNC    LOCAL  DEFAULT    2 ret_fast_syscall

I see this function when using perf to unwind call stacks from kernel
space to user space. Without this change I would need to add some
special case logic when using the vmlinux ELF information.

Signed-off-by: Drew Richardson <drew.richardson@arm.com>
---
 arch/arm/kernel/entry-common.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 92828a1dec80..b48dd4f37f80 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -61,6 +61,7 @@ work_pending:
 	movlt	scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
 	ldmia	sp, {r0 - r6}			@ have to reload r0 - r6
 	b	local_restart			@ ... and off we go
+ENDPROC(ret_fast_syscall)
 
 /*
  * "slow" syscall return path.  "why" tells us if this was a real syscall.
-- 
2.1.4
