From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon,  7 Mar 2011 18:31:10 +0800
Subject: [PATCH 1/2] ARM: fix compiling error due to debug_info change
Message-ID: <1299493870-8217-1-git-send-email-bryan.wu@canonical.com>
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

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/include/asm/a.out-core.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/a.out-core.h b/arch/arm/include/asm/a.out-core.h
index 93d04ac..639f5c8 100644
--- a/arch/arm/include/asm/a.out-core.h
+++ b/arch/arm/include/asm/a.out-core.h
@@ -32,12 +32,6 @@ static inline void aout_dump_thread(struct pt_regs *regs, struct user *dump)
 	dump->u_dsize = (tsk->mm->brk - tsk->mm->start_data + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	dump->u_ssize = 0;
 
-	dump->u_debugreg[0] = tsk->thread.debug.bp[0].address;
-	dump->u_debugreg[1] = tsk->thread.debug.bp[1].address;
-	dump->u_debugreg[2] = tsk->thread.debug.bp[0].insn.arm;
-	dump->u_debugreg[3] = tsk->thread.debug.bp[1].insn.arm;
-	dump->u_debugreg[4] = tsk->thread.debug.nsaved;
-
 	if (dump->start_stack < 0x04000000)
 		dump->u_ssize = (0x04000000 - dump->start_stack) >> PAGE_SHIFT;
 
-- 
1.7.1
