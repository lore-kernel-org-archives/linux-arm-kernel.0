From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 11 Jun 2015 12:04:32 +0800
Subject: [PATCH] arm64: kernel thread don't need to save fpsimd context.
Message-ID: <1433995472-6170-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Janet Liu <janet.liu@spreadtrum.com>

kernel thread's default fpsimd state is zero. When fork a thread, if parent is kernel thread,
 and save hardware context to parent's fpsimd state, but this hardware context is user
process's context, because kernel thread don't use fpsimd, it will not introduce issue,
it add a little cost.

Signed-off-by: Janet Liu <janet.liu@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/kernel/process.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c6b1f3b..2a46732 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -243,7 +243,8 @@ void release_thread(struct task_struct *dead_task)
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	fpsimd_preserve_current_state();
+	if (current->mm)
+		fpsimd_preserve_current_state();
 	*dst = *src;
 	return 0;
 }
-- 
1.7.9.5
