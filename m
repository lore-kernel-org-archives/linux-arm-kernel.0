From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Sep 2015 15:21:14 +0100
Subject: [PATCH 16/22] arm64/debug: Make use of the system wide safe value
In-Reply-To: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442413280-31885-17-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Use the system wide value of ID_AA64DFR0 to make safer decisions

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/hw_breakpoint.h |   14 ++------------
 arch/arm64/kernel/debug-monitors.c     |    6 ++++--
 arch/arm64/kernel/hw_breakpoint.c      |   19 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 4c47cb2..0251768 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -119,6 +119,8 @@ extern int arch_install_hw_breakpoint(struct perf_event *bp);
 extern void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 extern void hw_breakpoint_pmu_read(struct perf_event *bp);
 extern int hw_breakpoint_slots(int type);
+extern int get_num_brps(void);
+extern int get_num_wrps(void);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 extern void hw_breakpoint_thread_switch(struct task_struct *next);
@@ -134,17 +136,5 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
 
 extern struct pmu perf_ops_bp;
 
-/* Determine number of BRP registers available. */
-static inline int get_num_brps(void)
-{
-	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
-}
-
-/* Determine number of WRP registers available. */
-static inline int get_num_wrps(void)
-{
-	return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
-}
-
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_BREAKPOINT_H */
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 9b3b62a..9ca5f77 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -26,14 +26,16 @@
 #include <linux/stat.h>
 #include <linux/uaccess.h>
 
-#include <asm/debug-monitors.h>
+#include <asm/cpufeature.h>
 #include <asm/cputype.h>
+#include <asm/debug-monitors.h>
 #include <asm/system_misc.h>
 
 /* Determine debug architecture. */
 u8 debug_monitors_arch(void)
 {
-	return read_cpuid(ID_AA64DFR0_EL1) & 0xf;
+	return cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
+						ID_AA64DFR0_DEBUGVER_SHIFT);
 }
 
 /*
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index c97040e..1fa0476 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -28,11 +28,12 @@
 #include <linux/ptrace.h>
 #include <linux/smp.h>
 
+#include <asm/cpufeature.h>
+#include <asm/cputype.h>
 #include <asm/current.h>
 #include <asm/debug-monitors.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/traps.h>
-#include <asm/cputype.h>
 #include <asm/system_misc.h>
 
 /* Breakpoint currently in use for each BRP. */
@@ -48,6 +49,22 @@ static DEFINE_PER_CPU(int, stepping_kernel_bp);
 static int core_num_brps;
 static int core_num_wrps;
 
+/* Determine number of BRP registers available. */
+int get_num_brps(void)
+{
+	return 1 +
+	      	cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
+						ID_AA64DFR0_BRPS_SHIFT);
+}
+
+/* Determine number of WRP registers available. */
+int get_num_wrps(void)
+{
+	return 1 +
+	      	cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
+						ID_AA64DFR0_WRPS_SHIFT);
+}
+
 int hw_breakpoint_slots(int type)
 {
 	/*
-- 
1.7.9.5
