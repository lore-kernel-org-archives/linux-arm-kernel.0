From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Feb 2011 18:40:18 +0000
Subject: [PATCH] ARM: ptrace: fix register indexing in GETHBPREGS request
Message-ID: <1298400018-10612-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GETHBPREGS ptrace request incorrectly maps its index argument onto
the thread's saved debug state when the index != 0. This has not yet
been seen from userspace because GDB (the only user of this request)
only reads from register 0.

This patch fixes the indexing.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/ptrace.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index eace844..2bf27f3 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -615,10 +615,10 @@ static int ptrace_gethbpregs(struct task_struct *tsk, long num,
 		while (!(arch_ctrl.len & 0x1))
 			arch_ctrl.len >>= 1;
 
-		if (idx & 0x1)
-			reg = encode_ctrl_reg(arch_ctrl);
-		else
+		if (num & 0x1)
 			reg = bp->attr.bp_addr;
+		else
+			reg = encode_ctrl_reg(arch_ctrl);
 	}
 
 put:
-- 
1.7.0.4
