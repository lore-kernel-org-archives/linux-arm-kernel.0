From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Dec 2017 18:34:38 +0000
Subject: [PATCH] arm64: fpsimd: Fix state leakage when migrating after
 sigreturn
Message-ID: <1513362878-8787-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When refactoring the sigreturn code to handle SVE, I changed the
sigreturn implementation to store the new FPSIMD state from the
user sigframe into task_struct before reloading the state into the
CPU regs.  This makes it easier to convert the data for SVE when
needed.

However, it turns out that the fpsimd_state structure passed into
fpsimd_update_current_state is not fully initialised, so assigning
the structure as a whole corrupts current->thread.fpsimd_state.cpu
with uninitialised data.

This means that if the garbage data written to .cpu happens to be a
valid cpu number, and the task is subsequently migrated to the cpu
identified by the that number, and then tries to enter userspace,
the CPU FPSIMD regs will be assumed to be correct for the task and
not reloaded as they should be.  This can result in returning to
userspace with the FPSIMD registers containing data that is stale or
that belongs to another task or to the kernel.

Knowingly handing around a kernel structure that is incompletely
initialised with user data is a potential source of mistakes,
especially across source file boundaries.  To help avoid a repeat
of this issue, this patch adapts the relevant internal API to hand
around the user-accessible subset only: struct user_fpsimd_state.

To avoid future surprises, this patch also converts all uses of
struct fpsimd_state that really only access the user subset, to use
struct user_fpsimd_state.  A few missing consts are added to
function prototypes for good measure.

Thanks to Will for spotting the cause of the bug here.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 8cd969d28fd2 ("arm64/sve: Signal handling support")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This can be applied either on top of Will's point fix, or separately.
The rebase on top should be pretty trivial.

 arch/arm64/include/asm/fpsimd.h | 2 +-
 arch/arm64/kernel/fpsimd.c      | 4 ++--
 arch/arm64/kernel/signal.c      | 7 ++++---
 arch/arm64/kernel/signal32.c    | 5 +++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 74f3439..8857a0f 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -71,7 +71,7 @@ extern void fpsimd_flush_thread(void);
 extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
 extern void fpsimd_restore_current_state(void);
-extern void fpsimd_update_current_state(struct fpsimd_state *state);
+extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void sve_flush_cpu_state(void);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 540a1e0..55fb544 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1036,14 +1036,14 @@ void fpsimd_restore_current_state(void)
  * flag that indicates that the FPSIMD register contents are the most recent
  * FPSIMD state of 'current'
  */
-void fpsimd_update_current_state(struct fpsimd_state *state)
+void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 {
 	if (!system_supports_fpsimd())
 		return;
 
 	local_bh_disable();
 
-	current->thread.fpsimd_state = *state;
+	current->thread.fpsimd_state.user_fpsimd = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
 		fpsimd_to_sve(current);
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index b120111..f60c052 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -178,7 +178,8 @@ static void __user *apply_user_offset(
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
-	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
+	struct user_fpsimd_state const *fpsimd =
+		&current->thread.fpsimd_state.user_fpsimd;
 	int err;
 
 	/* copy the FP and status/control registers */
@@ -195,7 +196,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 
 static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 {
-	struct fpsimd_state fpsimd;
+	struct user_fpsimd_state fpsimd;
 	__u32 magic, size;
 	int err = 0;
 
@@ -266,7 +267,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 {
 	int err;
 	unsigned int vq;
-	struct fpsimd_state fpsimd;
+	struct user_fpsimd_state fpsimd;
 	struct sve_context sve;
 
 	if (__copy_from_user(&sve, user->sve, sizeof(sve)))
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 22711ee..a124140 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -228,7 +228,8 @@ union __fpsimd_vreg {
 
 static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 {
-	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
+	struct user_fpsimd_state const *fpsimd =
+		&current->thread.fpsimd_state.user_fpsimd;
 	compat_ulong_t magic = VFP_MAGIC;
 	compat_ulong_t size = VFP_STORAGE_SIZE;
 	compat_ulong_t fpscr, fpexc;
@@ -277,7 +278,7 @@ static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 
 static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
 {
-	struct fpsimd_state fpsimd;
+	struct user_fpsimd_state fpsimd;
 	compat_ulong_t magic = VFP_MAGIC;
 	compat_ulong_t size = VFP_STORAGE_SIZE;
 	compat_ulong_t fpscr;
-- 
2.1.4
