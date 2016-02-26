From: glider@google.com (Alexander Potapenko)
Date: Fri, 26 Feb 2016 13:38:37 +0100
Subject: [PATCH v1] kasan,
 arm64: Unpoison dirty stack frames when resuming from suspend.
Message-ID: <c08aa050cb03e40098775dc8d200f073451c342e.1456489933.git.glider@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before an ARM64 CPU is suspended, the kernel saves the context which will
be used to initialize the register state upon resume. After that and
before the actual execution of the SMC instruction the kernel creates
several stack frames which are never unpoisoned because arm_smccc_smc()
does not return. This may cause false positive stack buffer overflow
reports from KASAN.

The solution is to record the stack pointer value just before the CPU is
suspended, and unpoison the part of stack between the saved value and
the stack pointer upon resume.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/arm64/kernel/suspend.c |  5 +++++
 drivers/firmware/psci.c     |  5 +++++
 include/linux/kasan.h       |  5 +++++
 mm/kasan/kasan.c            | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 1095aa4..1070415 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -1,4 +1,5 @@
 #include <linux/ftrace.h>
+#include <linux/kasan.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
@@ -117,6 +118,10 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		 */
 		if (hw_breakpoint_restore)
 			hw_breakpoint_restore(NULL);
+#ifdef CONFIG_KASAN
+		/* Unpoison the stack above the current frame. */
+		kasan_cpu_resume();
+#endif
 	}
 
 	unpause_graph_tracing();
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index f25cd79..2480189 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -15,6 +15,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
+#include <linux/kasan.h>
 #include <linux/linkage.h>
 #include <linux/of.h>
 #include <linux/pm.h>
@@ -122,6 +123,10 @@ static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
 {
 	struct arm_smccc_res res;
 
+#ifdef CONFIG_KASAN
+	/* Notify KASAN it should unpoison the stack up to this point. */
+	kasan_stack_watermark();
+#endif
 	arm_smccc_smc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
 	return res.a0;
 }
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 4b9f85c..d4fd7a4 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -62,6 +62,11 @@ void kasan_slab_free(struct kmem_cache *s, void *object);
 int kasan_module_alloc(void *addr, size_t size);
 void kasan_free_shadow(const struct vm_struct *vm);
 
+#ifdef CONFIG_ARM64
+void kasan_stack_watermark(void);
+void kasan_cpu_resume(void);
+#endif
+
 #else /* CONFIG_KASAN */
 
 static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index bc0a8d8..6529d345 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -550,3 +550,35 @@ static int __init kasan_memhotplug_init(void)
 
 module_init(kasan_memhotplug_init);
 #endif
+
+#ifdef CONFIG_ARM64
+static DEFINE_PER_CPU(unsigned long, cpu_stack_watermark);
+
+/* Record the stack pointer before the CPU is suspended. The recorded value
+ * will be used upon resume to unpoison the dirty stack frames.
+ */
+void kasan_stack_watermark(void)
+{
+	unsigned long *watermark = this_cpu_ptr(&cpu_stack_watermark);
+
+	*watermark = __builtin_frame_address(0);
+}
+EXPORT_SYMBOL_GPL(kasan_stack_watermark);
+
+void kasan_cpu_resume(void)
+{
+	unsigned long sp = __builtin_frame_address(0);
+	unsigned long *watermark = this_cpu_ptr(&cpu_stack_watermark);
+
+	if (*watermark == 0) {
+		WARN_ON_ONCE(*watermark == 0);
+		*watermark = sp;
+		return;
+	}
+	if (sp > *watermark) {
+		kasan_unpoison_shadow(*watermark, sp - *watermark);
+		*watermark = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(kasan_cpu_resume);
+#endif
-- 
2.7.0.rc3.207.g0ac5344
