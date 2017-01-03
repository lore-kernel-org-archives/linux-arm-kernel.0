From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  3 Jan 2017 18:27:01 +0000
Subject: [PATCH] arm64: restore get_current() optimisation
Message-ID: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

My THREAD_INFO_IN_TASK series had an unintended performance regression in
get_current() / current_thread_info(). Could you please take the below as a
fix for the next rc?

Thanks,
Mark.

---->8----
Commit c02433dd6de32f04 ("arm64: split thread_info from task stack")
inverted the relationship between get_current() and
current_thread_info(), with sp_el0 now holding the current task_struct
rather than the current thead_info. The new implementation of
get_current() prevents the compiler from being able to optimize repeated
calls to either, resulting in a noticeable penalty in some
microbenchmarks.

This patch restores the previous optimisation by implementing
get_current() in the same way as our old current_thread_info(), using a
non-volatile asm statement.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/arm64/include/asm/current.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/current.h b/arch/arm64/include/asm/current.h
index f2bcbe2..86c4041 100644
--- a/arch/arm64/include/asm/current.h
+++ b/arch/arm64/include/asm/current.h
@@ -9,9 +9,17 @@
 
 struct task_struct;
 
+/*
+ * We don't use read_sysreg() as we want the compiler to cache the value where
+ * possible.
+ */
 static __always_inline struct task_struct *get_current(void)
 {
-	return (struct task_struct *)read_sysreg(sp_el0);
+	unsigned long sp_el0;
+
+	asm ("mrs %0, sp_el0" : "=r" (sp_el0));
+
+	return (struct task_struct *)sp_el0;
 }
 
 #define current get_current()
-- 
1.9.1
