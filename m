From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 29 Jun 2017 15:25:49 +0100
Subject: [PATCH 3/3] arm64: ptrace: Fix incorrect get_user() use in
 compat_vfp_set()
In-Reply-To: <1498746379-27340-1-git-send-email-Dave.Martin@arm.com>
References: <1498746379-27340-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1498746379-27340-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that compat_vfp_get() uses the regset API to copy the FPSCR
value out to userspace, compat_vfp_set() looks inconsistent.  In
particular, compat_vfp_set() will fail if called with kbuf != NULL
&& ubuf == NULL (which is valid usage according to the regset API).

This patch fixes compat_vfp_set() to use user_regset_copyin(),
similarly to compat_vfp_get().

This also squashes a sparse warning triggered by the cast that
drops __user when calling get_user().

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/ptrace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 949ab6b..1b38c01 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -935,15 +935,17 @@ static int compat_vfp_set(struct task_struct *target,
 {
 	struct user_fpsimd_state *uregs;
 	compat_ulong_t fpscr;
-	int ret;
+	int ret, vregs_end_pos;
 
 	uregs = &target->thread.fpsimd_state.user_fpsimd;
 
+	vregs_end_pos = VFP_STATE_SIZE - sizeof(compat_ulong_t);
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, uregs, 0,
-				 VFP_STATE_SIZE - sizeof(compat_ulong_t));
+				 vregs_end_pos);
 
 	if (count && !ret) {
-		ret = get_user(fpscr, (compat_ulong_t *)ubuf);
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fpscr,
+					 vregs_end_pos, VFP_STATE_SIZE);
 		if (!ret) {
 			uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
 			uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
-- 
2.1.4
