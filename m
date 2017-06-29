From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 29 Jun 2017 15:25:47 +0100
Subject: [PATCH 1/3] arm64: ptrace: Avoid setting compat FP[SC]R to garbage if
 get_user fails
In-Reply-To: <1498746379-27340-1-git-send-email-Dave.Martin@arm.com>
References: <1498746379-27340-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1498746379-27340-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If get_user() fails when reading the new FPSCR value from userspace
in compat_vfp_get(), then garbage* will be written to the task's
FPSR and FPCR registers.

This patch prevents this by checking the return from get_user()
first.

[*] Actually, zero, due to the behaviour of get_user() on error, but
that's still not what userspace expects.

Fixes: 478fcb2cdb23 ("arm64: Debugging support")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/ptrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 35846f1..4c068dc 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -947,8 +947,10 @@ static int compat_vfp_set(struct task_struct *target,
 
 	if (count && !ret) {
 		ret = get_user(fpscr, (compat_ulong_t *)ubuf);
-		uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
-		uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
+		if (!ret) {
+			uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
+			uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
+		}
 	}
 
 	fpsimd_flush_task_state(target);
-- 
2.1.4
