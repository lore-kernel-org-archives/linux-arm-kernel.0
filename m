From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:56 +0000
Subject: [RFC PATCH v2 26/41] arm64/sve: Avoid stale user register state after
 SVE access exception
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-27-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when an SVE access exception is taken from userspace,
the FPSIMD state in the task_struct is converted to SVE state and
reloaded as SVE state.

Unfortunately, since we've been executing in userspace there's no
guarantee that the FPSIMD state saved will actually be up to date
with respect to the registers, so updates may be lost.

This patch saves the FPSIMD state back to the task_struct first, to
ensure that the task_struct copy of the data is up to date.

Also, the CPACR handling logic is removed since task_fpsimd_load()
handles it anyway.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 8c18384..4e2d796 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -39,6 +39,7 @@
 
 /* Forward declarations for local functions used by both SVE and FPSIMD */
 static void task_fpsimd_load(struct task_struct *task);
+static void task_fpsimd_save(struct task_struct *task);
 
 /*
  * In order to reduce the number of times the FPSIMD state is needlessly saved
@@ -154,19 +155,14 @@ static void sve_to_fpsimd(struct task_struct *task)
 
 void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 {
-	if (test_and_set_thread_flag(TIF_SVE)) {
-		unsigned long tmp;
-
-		asm ("mrs %0, cpacr_el1" : "=r" (tmp));
-
-		printk(KERN_INFO "%s: Strange, ZEN=%u\n",
-		       __func__, (unsigned int)((tmp >> 16) & 3));
-		BUG();
-	}
-
 	BUG_ON(is_compat_task());
 
+	task_fpsimd_save(current);
+
 	fpsimd_to_sve(current);
+	if (test_and_set_thread_flag(TIF_SVE))
+		BUG(); /* We shouldn't trap if SVE was already enabled! */
+
 	task_fpsimd_load(current);
 }
 
-- 
2.1.4
