From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Feb 2012 18:37:09 +0000
Subject: [PATCH] ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU platforms
Message-ID: <1329763029-18220-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 68b7f715 ("nommu: ptrace support") added definitions for
PT_TEXT_ADDR and friends, as well as adding ptrace support for reading
from these magic offsets.

Unfortunately, this has probably never worked, since ptrace_read_user
predicates reading on off < sizeof(struct user), returning -EOI
otherwise.

This patch moves the offset size check until after we have tried to
match it against either a magic value or an offset into pt_regs.

Cc: Paul Brook <paul@codesourcery.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/ptrace.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index e33870f..b68b52b 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -256,7 +256,7 @@ static int ptrace_read_user(struct task_struct *tsk, unsigned long off,
 {
 	unsigned long tmp;
 
-	if (off & 3 || off >= sizeof(struct user))
+	if (off & 3)
 		return -EIO;
 
 	tmp = 0;
@@ -268,6 +268,8 @@ static int ptrace_read_user(struct task_struct *tsk, unsigned long off,
 		tmp = tsk->mm->end_code;
 	else if (off < sizeof(struct pt_regs))
 		tmp = get_user_reg(tsk, off >> 2);
+	else if (off >= sizeof(struct user))
+		return -EIO;
 
 	return put_user(tmp, ret);
 }
-- 
1.7.4.1
