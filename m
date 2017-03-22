From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:02 +0000
Subject: [RFC PATCH v2 32/41] arm64/sve: Factor out clearing of tasks' SVE regs
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-33-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch factors out the code that clears a task's SVE regs on
exec(), so that we can reuse it in subsequent patches.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 09d3d23..daceeae 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -105,6 +105,19 @@ void *__sve_state(struct task_struct *task)
 	return (char *)task + ALIGN(sizeof(*task), 16);
 }
 
+static void clear_sve_regs(struct task_struct *task)
+{
+	BUG_ON(task == current && preemptible());
+
+	BUG_ON((char *)__sve_state(task) < (char *)task);
+	BUG_ON(arch_task_struct_size <
+	       ((char *)__sve_state(task) - (char *)task));
+
+	memset(__sve_state(task), 0,
+	       arch_task_struct_size -
+			((char *)__sve_state(task) - (char *)task));
+}
+
 static void *sve_pffr(struct task_struct *task)
 {
 	unsigned int vl = task->thread.sve_vl;
@@ -225,6 +238,7 @@ int sve_get_task_vl(struct task_struct *task)
 
 /* Dummy declarations for usage protected with IS_ENABLED(CONFIG_ARM64_SVE): */
 extern int sve_max_vl;
+extern void clear_sve_regs(struct task_struct *task);
 extern void *sve_pffr(struct task_struct *task);
 extern void fpsimd_to_sve(struct task_struct *task);
 
@@ -372,13 +386,7 @@ void fpsimd_flush_thread(void)
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
-		BUG_ON((char *)__sve_state(current) < (char *)current);
-		BUG_ON(arch_task_struct_size <
-		       ((char *)__sve_state(current) - (char *)current));
-
-		memset(__sve_state(current), 0,
-		       arch_task_struct_size -
-		       ((char *)__sve_state(current) - (char *)current));
+		clear_sve_regs(current);
 
 		/*
 		 * User tasks must have a valid vector length set, but tasks
-- 
2.1.4
