From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 24 May 2018 17:56:43 +0100
Subject: [PATCH v11 14/19] arm64/sve: Move sve_pffr() to fpsimd.h and make
 inline
In-Reply-To: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
References: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1527181008-13549-15-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to make sve_save_state()/sve_load_state() more easily
reusable and to get rid of a potential branch on context switch
critical paths, this patch makes sve_pffr() inline and moves it to
fpsimd.h.

<asm/processor.h> must be included in fpsimd.h in order to make
this work, and this creates an #include cycle that is tricky to
avoid without modifying core code, due to the way the PR_SVE_*()
prctl helpers are included in the core prctl implementation.

Instead of breaking the cycle, this patch defers inclusion of
<asm/fpsimd.h> in <asm/processor.h> until the point where it is
actually needed: i.e., immediately before the prctl definitions.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>

---

Changes since v10:

 * Add comment explaining why fpsimd.h is included in a funny place
   in processor.h.
---
 arch/arm64/include/asm/fpsimd.h    | 13 +++++++++++++
 arch/arm64/include/asm/processor.h | 12 +++++++++++-
 arch/arm64/kernel/fpsimd.c         | 12 ------------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index fb60b22..fa92747 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -18,6 +18,8 @@
 
 #include <asm/ptrace.h>
 #include <asm/errno.h>
+#include <asm/processor.h>
+#include <asm/sigcontext.h>
 
 #ifndef __ASSEMBLY__
 
@@ -61,6 +63,17 @@ extern void sve_flush_cpu_state(void);
 /* Maximum VL that SVE VL-agnostic software can transparently support */
 #define SVE_VL_ARCH_MAX 0x100
 
+/* Offset of FFR in the SVE register dump */
+static inline size_t sve_ffr_offset(int vl)
+{
+	return SVE_SIG_FFR_OFFSET(sve_vq_from_vl(vl)) - SVE_SIG_REGS_OFFSET;
+}
+
+static inline void *sve_pffr(struct thread_struct *thread)
+{
+	return (char *)thread->sve_state + sve_ffr_offset(thread->sve_vl);
+}
+
 extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   unsigned long vq_minus_1);
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 9231b87..c99e657 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -40,7 +40,6 @@
 
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
-#include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/lse.h>
 #include <asm/pgtable-hwdef.h>
@@ -247,6 +246,17 @@ void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused);
 void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused);
 void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused);
 
+/*
+ * Not at the top of the file due to a direct #include cycle between
+ * <asm/fpsimd.h> and <asm/processor.h>.  Deferring this #include
+ * ensures that contents of processor.h are visible to fpsimd.h even if
+ * processor.h is included first.
+ *
+ * These prctl helpers are the only things in this file that require
+ * fpsimd.h.  The core code expects them to be in this header.
+ */
+#include <asm/fpsimd.h>
+
 /* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
 #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
 #define SVE_GET_VL()	sve_get_current_vl()
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 842b2ad..e60c3a2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -161,18 +161,6 @@ static void sve_free(struct task_struct *task)
 	__sve_free(task);
 }
 
-
-/* Offset of FFR in the SVE register dump */
-static size_t sve_ffr_offset(int vl)
-{
-	return SVE_SIG_FFR_OFFSET(sve_vq_from_vl(vl)) - SVE_SIG_REGS_OFFSET;
-}
-
-static void *sve_pffr(struct thread_struct *thread)
-{
-	return (char *)thread->sve_state + sve_ffr_offset(thread->sve_vl);
-}
-
 static void change_cpacr(u64 val, u64 mask)
 {
 	u64 cpacr = read_sysreg(CPACR_EL1);
-- 
2.1.4
