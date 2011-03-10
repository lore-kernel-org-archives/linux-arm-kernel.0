From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 10 Mar 2011 11:40:03 +0800
Subject: [PATCH] ARM: fix compiling error due to debug_info change
Message-ID: <1299728403-27486-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC [M]  crypto/xcbc.o
In file included from /opt/git/ubuntu/roc/natty/fs/binfmt_aout.c:32:
/opt/git/ubuntu/roc/natty/arch/arm/include/asm/a.out-core.h: In function ?aout_dump_thread?:
/opt/git/ubuntu/roc/natty/arch/arm/include/asm/a.out-core.h:35: error: ?struct debug_info? has no member named ?bp?
/opt/git/ubuntu/roc/natty/arch/arm/include/asm/a.out-core.h:36: error: ?struct debug_info? has no member named ?bp?
/opt/git/ubuntu/roc/natty/arch/arm/include/asm/a.out-core.h:37: error: ?struct debug_info? has no member named ?bp?
/opt/git/ubuntu/roc/natty/arch/arm/include/asm/a.out-core.h:38: error: ?struct debug_info? has no member named ?bp?
/opt/git/ubuntu/roc/natty/arch/arm/include/asm/a.out-core.h:39: error: ?struct debug_info? has no member named ?nsaved?
make[3]: *** [fs/binfmt_aout.o] Error 1
make[2]: *** [fs] Error 2

This bug was introduced by "ARM: 6668/1: ptrace: remove single-step emulation code" from Will Deacon

memset zero the u_debugreg array and add comments to u_debugreg.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/include/asm/a.out-core.h |    7 ++-----
 arch/arm/include/asm/user.h       |    2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/a.out-core.h b/arch/arm/include/asm/a.out-core.h
index 93d04ac..11549a0 100644
--- a/arch/arm/include/asm/a.out-core.h
+++ b/arch/arm/include/asm/a.out-core.h
@@ -32,11 +32,8 @@ static inline void aout_dump_thread(struct pt_regs *regs, struct user *dump)
 	dump->u_dsize = (tsk->mm->brk - tsk->mm->start_data + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	dump->u_ssize = 0;
 
-	dump->u_debugreg[0] = tsk->thread.debug.bp[0].address;
-	dump->u_debugreg[1] = tsk->thread.debug.bp[1].address;
-	dump->u_debugreg[2] = tsk->thread.debug.bp[0].insn.arm;
-	dump->u_debugreg[3] = tsk->thread.debug.bp[1].insn.arm;
-	dump->u_debugreg[4] = tsk->thread.debug.nsaved;
+	/* struct debug_info was dropped, so set u_debugreg as zero */
+	memset(dump->u_debugreg, 0, sizeof(dump->u_debugreg) * 8);
 
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
1.7.1
