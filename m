From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 18 Aug 2011 18:01:52 +0100
Subject: [PATCH v2 1/3] ARM: Make cpu_architecture into a global variable
In-Reply-To: <1313686914-29481-1-git-send-email-dave.martin@linaro.org>
References: <1313686914-29481-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1313686914-29481-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU architecture really should not be changing at runtime, so
make it a global variable instead of a function.

The cpu_architecture() function declared in <asm/system.h> remains
the correct way to read this variable from C code.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/system.h |    3 ++-
 arch/arm/kernel/setup.c       |   20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 832888d..4adf71b 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -57,6 +57,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
 
@@ -104,7 +105,7 @@ struct mm_struct;
 extern void show_pte(struct mm_struct *mm, unsigned long addr);
 extern void __show_regs(struct pt_regs *);
 
-extern int cpu_architecture(void);
+extern int __pure cpu_architecture(void);
 extern void cpu_init(void);
 
 void arm_machine_restart(char mode, const char *cmd);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 70bca64..1f11472 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -29,6 +29,8 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
+#include <linux/bug.h>
+#include <linux/compiler.h>
 
 #include <asm/unified.h>
 #include <asm/cpu.h>
@@ -42,6 +44,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
 #include <asm/tlbflush.h>
+#include <asm/system.h>
 
 #include <asm/prom.h>
 #include <asm/mach/arch.h>
@@ -115,6 +118,13 @@ struct outer_cache_fns outer_cache __read_mostly;
 EXPORT_SYMBOL(outer_cache);
 #endif
 
+/*
+ * Cached cpu_architecture() result for use by assembler code.
+ * C code should use the cpu_architecture() function instead of accessing this
+ * variable directly.
+ */
+int __cpu_architecture __read_mostly = CPU_ARCH_UNKNOWN;
+
 struct stack {
 	u32 irq[3];
 	u32 abt[3];
@@ -210,7 +220,7 @@ static const char *proc_arch[] = {
 	"?(17)",
 };
 
-int cpu_architecture(void)
+static int __get_cpu_architecture(void)
 {
 	int cpu_arch;
 
@@ -243,6 +253,13 @@ int cpu_architecture(void)
 	return cpu_arch;
 }
 
+int __pure cpu_architecture(void)
+{
+	BUG_ON(__cpu_architecture == CPU_ARCH_UNKNOWN);
+
+	return __cpu_architecture;
+}
+
 static int cpu_has_aliasing_icache(unsigned int arch)
 {
 	int aliasing_icache;
@@ -413,6 +430,7 @@ static void __init setup_processor(void)
 	}
 
 	cpu_name = list->cpu_name;
+	__cpu_architecture = __get_cpu_architecture();
 
 #ifdef MULTI_CPU
 	processor = *list->proc;
-- 
1.7.4.1
