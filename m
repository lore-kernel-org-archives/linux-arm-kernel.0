From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Mar 2011 10:57:52 +0000
Subject: [PATCH] ARM: aout-core: zero thread debug registers in a.out core dump
Message-ID: <1299581872-18098-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The removal of the single-step emulation from ptrace on ARM means that
thread_struct no longer has software breakpoint fields in its debug
member.

This patch fixes the a.out core dump code so that the debug registers
are zeroed rather than trying to copy from non-existent fields.

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Reported-by: Bryan Wu <bryan.wu@canonical.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Hi Bryan,

Feel free to upgrade your tag on this (signed-off / acked) since this is
clearly based on the patch you posted yesterday. I'd like to get this to
Russell ASAP so that we don't get a build-breaker in the near future.

Cheers,

Will

 arch/arm/include/asm/a.out-core.h |    6 +-----
 arch/arm/include/asm/user.h       |    2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/a.out-core.h b/arch/arm/include/asm/a.out-core.h
index 93d04ac..92f10cb 100644
--- a/arch/arm/include/asm/a.out-core.h
+++ b/arch/arm/include/asm/a.out-core.h
@@ -32,11 +32,7 @@ static inline void aout_dump_thread(struct pt_regs *regs, struct user *dump)
 	dump->u_dsize = (tsk->mm->brk - tsk->mm->start_data + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	dump->u_ssize = 0;
 
-	dump->u_debugreg[0] = tsk->thread.debug.bp[0].address;
-	dump->u_debugreg[1] = tsk->thread.debug.bp[1].address;
-	dump->u_debugreg[2] = tsk->thread.debug.bp[0].insn.arm;
-	dump->u_debugreg[3] = tsk->thread.debug.bp[1].insn.arm;
-	dump->u_debugreg[4] = tsk->thread.debug.nsaved;
+	memset(dump->u_debugreg, 0, sizeof(dump->u_debugreg));
 
 	if (dump->start_stack < 0x04000000)
 		dump->u_ssize = (0x04000000 - dump->start_stack) >> PAGE_SHIFT;
diff --git a/arch/arm/include/asm/user.h b/arch/arm/include/asm/user.h
index 05ac4b0..35917b3 100644
--- a/arch/arm/include/asm/user.h
+++ b/arch/arm/include/asm/user.h
@@ -71,7 +71,7 @@ struct user{
 				/* the registers. */
   unsigned long magic;		/* To uniquely identify a core file */
   char u_comm[32];		/* User command that was responsible */
-  int u_debugreg[8];
+  int u_debugreg[8];		/* No longer used */
   struct user_fp u_fp;		/* FP state */
   struct user_fp_struct * u_fp0;/* Used by gdb to help find the values for */
   				/* the FP registers. */
-- 
1.7.0.4
