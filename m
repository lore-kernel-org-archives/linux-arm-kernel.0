From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 12 Jan 2017 11:26:03 +0000
Subject: [RFC PATCH 04/10] arm64/sve: Factor out clearing of tasks' SVE regs
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1484220369-23970-5-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch factors out the code that clears a task's SVE regs on
exec(), so that we can reuse it in subsequent patches.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ab2bb62..54d7ed0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -260,6 +260,19 @@ void fpsimd_thread_switch(struct task_struct *next)
 	}
 }
 
+static void clear_sve_regs(struct task_struct *task)
+{
+	BUG_ON(task == current && preemptible());
+
+	BUG_ON((char *)__task_sve_state(task) < (char *)task);
+	BUG_ON(arch_task_struct_size <
+	       ((char *)__task_sve_state(task) - (char *)task));
+
+	memset(__task_sve_state(task), 0,
+	       arch_task_struct_size -
+	       ((char *)__task_sve_state(task) - (char *)task));
+}
+
 void fpsimd_flush_thread(void)
 {
 	if (!system_supports_fpsimd())
@@ -272,13 +285,7 @@ void fpsimd_flush_thread(void)
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
-		BUG_ON((char *)__task_sve_state(current) < (char *)current);
-		BUG_ON(arch_task_struct_size <
-		       ((char *)__task_sve_state(current) - (char *)current));
-
-		memset(__task_sve_state(current), 0,
-		       arch_task_struct_size -
-		       ((char *)__task_sve_state(current) - (char *)current));
+		clear_sve_regs(current);
 
 		/*
 		 * User tasks must have a valid vector length set, but tasks
-- 
2.1.4
