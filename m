From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 29 Jun 2017 15:25:48 +0100
Subject: [PATCH 2/3] arm64: ptrace: Remove redundant overrun check from
 compat_vfp_set()
In-Reply-To: <1498746379-27340-1-git-send-email-Dave.Martin@arm.com>
References: <1498746379-27340-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1498746379-27340-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

compat_vfp_set() checks for userspace trying to write an excessive
amount of data to the regset.  However this check is conspicuous
for its absence from every other _set() in the arm64 ptrace
implementation.  In fact, the core ptrace_regset() already clamps
userspace's iov_len to the regset size before the individual regset
.{get,set}() methods get called.

This patch removes the redundant check.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/ptrace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4c068dc..949ab6b 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -937,9 +937,6 @@ static int compat_vfp_set(struct task_struct *target,
 	compat_ulong_t fpscr;
 	int ret;
 
-	if (pos + count > VFP_STATE_SIZE)
-		return -EIO;
-
 	uregs = &target->thread.fpsimd_state.user_fpsimd;
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, uregs, 0,
-- 
2.1.4
