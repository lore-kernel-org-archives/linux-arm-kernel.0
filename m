From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:14 +0000
Subject: [RFC PATCH 26/29] arm64/sve: Avoid stale user register state after
 SVE access exception
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-27-git-send-email-Dave.Martin@arm.com>
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
index 2e1056e..1750301 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -103,22 +103,18 @@ void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 
 static void task_fpsimd_to_sve(struct task_struct *task);
 static void task_fpsimd_load(struct task_struct *task);
+static void task_fpsimd_save(struct task_struct *task);
 
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
 	task_fpsimd_to_sve(current);
+	if (test_and_set_thread_flag(TIF_SVE))
+		BUG(); /* We shouldn't trap if SVE was already enabled! */
+
 	task_fpsimd_load(current);
 }
 
-- 
2.1.4
