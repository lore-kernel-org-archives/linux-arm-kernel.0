From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 11 Jun 2015 12:02:45 +0800
Subject: [PATCH] arm64: fix bug for reloading FPSIMD state after CPU hotplug.
Message-ID: <1433995365-6043-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Janet Liu <janet.liu@spreadtrum.com>

Now FPSIMD don't handle HOTPLUG_CPU. This introduces bug after cpu down/up process.

After cpu down/up process, the FPSMID hardware register is default value, not any
process's fpsimd context. when CPU_DEAD set cpu's fpsimd_state to NULL, it will force
to load the fpsimd context for the thread, to avoid the chance to skip to load the context.
If process A is the last user process on CPU N before cpu down, and the first user process
on the same CPU N after cpu up, A's fpsimd_state.cpu is the current cpu id,
and per_cpu(fpsimd_last_state) points A's fpsimd_state, so kernel will not reload the
context during it return to user space.

Signed-off-by: Janet Liu <janet.liu@spreadtrum.com>
Signed-off-by: Xiongshan An <xiongshan.an@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/kernel/fpsimd.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 3dca156..35ef3a2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -23,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/hardirq.h>
+#include <linux/cpu.h>
 
 #include <asm/fpsimd.h>
 #include <asm/cputype.h>
@@ -296,6 +297,36 @@ static void fpsimd_pm_init(void)
 static inline void fpsimd_pm_init(void) { }
 #endif /* CONFIG_CPU_PM */
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int fpsimd_cpu_hotplug_notifier(struct notifier_block *nfb,
+				       unsigned long action,
+				       void *hcpu)
+{
+	int cpu = (long)hcpu;
+
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_DEAD:
+		per_cpu(fpsimd_last_state, cpu) = NULL;
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block fpsimd_cpu_hotplug_notifier_block = {
+	.notifier_call = fpsimd_cpu_hotplug_notifier,
+};
+
+static inline void fpsimd_hotplug_init(void)
+{
+	register_cpu_notifier(&fpsimd_cpu_hotplug_notifier_block);
+}
+
+#else
+static inline void fpsimd_hotplug_init(void) { }
+#endif
+
 /*
  * FP/SIMD support code initialisation.
  */
@@ -315,6 +346,7 @@ static int __init fpsimd_init(void)
 		elf_hwcap |= HWCAP_ASIMD;
 
 	fpsimd_pm_init();
+	fpsimd_hotplug_init();
 
 	return 0;
 }
-- 
1.7.9.5
