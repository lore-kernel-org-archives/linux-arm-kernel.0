From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:38:59 +0000
Subject: [RFC PATCH 11/29] arm64/sve: Expand task_struct for Scalable Vector
 Extension state
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-12-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch expands task_struct to accommodate the Scalable Vector
Extension state.

The extra space is not used for anything yet.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/fpsimd.h | 12 +++++++
 arch/arm64/kernel/fpsimd.c      | 71 ++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/process.c     |  2 +-
 arch/arm64/kernel/setup.c       |  3 ++
 5 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cd6c846..e8d04dd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -19,6 +19,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 92f45ee..1c41259 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -51,6 +51,15 @@ struct fpsimd_partial_state {
 	__uint128_t	vregs[32];
 };
 
+/*
+ * Scalable Vector Extension state structure template.
+ * The layout is vector length dependent, with vector length = vl * 16 bytes.
+ */
+#define fpsimd_sve_state(vl) {		\
+	__uint128_t	zregs[32][vl];		\
+	u16		pregs[16][vl];		\
+	u16		ffr[vl];		\
+}
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /* Masks for extracting the FPSR and FPCR from the FPSCR */
@@ -81,8 +90,11 @@ extern void fpsimd_save_partial_state(struct fpsimd_partial_state *state,
 				      u32 num_regs);
 extern void fpsimd_load_partial_state(struct fpsimd_partial_state *state);
 
+extern void __init fpsimd_init_task_struct_size(void);
+
 extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr);
+extern unsigned int sve_get_vl(void);
 
 #endif
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 394c61d..05eca45 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -26,6 +26,7 @@
 #include <linux/hardirq.h>
 
 #include <asm/fpsimd.h>
+#include <asm/cpufeature.h>
 #include <asm/cputype.h>
 
 #define FPEXC_IOF	(1 << 0)
@@ -125,6 +126,47 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 	send_sig_info(SIGFPE, &info, current);
 }
 
+#ifdef CONFIG_ARM64_SVE
+
+static void *__task_sve_state(struct task_struct *task)
+{
+	return (char *)task + ALIGN(sizeof(*task), 16);
+}
+
+static void *__task_pffr(struct task_struct *task)
+{
+	unsigned int vl = sve_get_vl();
+
+	BUG_ON(vl % 16);
+	return (char *)__task_sve_state(task) + 34 * vl;
+}
+
+#else /* !CONFIG_ARM64_SVE */
+
+/* Turn any non-optimised out attempts to use these into a link error: */
+extern void *__task_sve_state(struct task_struct *task);
+extern void *__task_pffr(struct task_struct *task);
+
+#endif /* !CONFIG_ARM64_SVE */
+
+static void task_fpsimd_load(struct task_struct *task)
+{
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE))
+		sve_load_state(__task_pffr(task),
+			       &task->thread.fpsimd_state.fpsr);
+	else
+		fpsimd_load_state(&task->thread.fpsimd_state);
+}
+
+static void task_fpsimd_save(struct task_struct *task)
+{
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE))
+		sve_save_state(__task_pffr(task),
+			       &task->thread.fpsimd_state.fpsr);
+	else
+		fpsimd_save_state(&task->thread.fpsimd_state);
+}
+
 void fpsimd_thread_switch(struct task_struct *next)
 {
 	/*
@@ -157,8 +199,20 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 void fpsimd_flush_thread(void)
 {
-	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 	fpsimd_flush_task_state(current);
+
+	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
+		BUG_ON((char *)__task_sve_state(current) < (char *)current);
+		BUG_ON(arch_task_struct_size <
+		       ((char *)__task_sve_state(current) - (char *)current));
+
+		memset(__task_sve_state(current), 0,
+		       arch_task_struct_size -
+		       ((char *)__task_sve_state(current) - (char *)current));
+	}
+
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
@@ -315,6 +369,21 @@ static inline void fpsimd_hotplug_init(void)
 static inline void fpsimd_hotplug_init(void) { }
 #endif
 
+void __init fpsimd_init_task_struct_size(void)
+{
+	arch_task_struct_size = sizeof(struct task_struct);
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	    ((read_cpuid(ID_AA64PFR0_EL1) >> ID_AA64PFR0_SVE_SHIFT)
+	     & 0xf) == 1) {
+		arch_task_struct_size = sizeof(struct task_struct) +
+			35 * sve_get_vl();
+
+		pr_info("SVE: enabled with maximum %u bits per vector\n",
+			sve_get_vl() * 8);
+	}
+}
+
 /*
  * FP/SIMD support code initialisation.
  */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 01753cd..7e19c3c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -242,7 +242,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	if (current->mm)
 		fpsimd_preserve_current_state();
-	*dst = *src;
+	memcpy(dst, src, arch_task_struct_size);
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f534f49..f0f551e 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -234,6 +234,9 @@ void __init setup_arch(char **cmdline_p)
 	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
 
 	sprintf(init_utsname()->machine, UTS_MACHINE);
+
+	fpsimd_init_task_struct_size();
+
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
-- 
2.1.4
