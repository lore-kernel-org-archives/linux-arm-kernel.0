From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:28 +0800
Subject: [PATCH 13/13] [ARM] Introduce ARCH_HAS_IDLE_RESET to allow SoC
	specific idle/reset
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-14-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig                 |    3 +++
 arch/arm/include/asm/mach/arch.h |    2 ++
 arch/arm/include/asm/system.h    |    2 ++
 arch/arm/kernel/process.c        |   19 +++++++++++++++++++
 arch/arm/kernel/setup.c          |    7 +++++--
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 708a1e1..a14f066 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -62,6 +62,9 @@ config ARCH_USES_DEFAULT_TIMEX_H
 config ARCH_HAS_RET_TO_USER
 	def_bool n
 
+config ARCH_HAS_IDLE_RESET
+	def_bool n
+
 config GENERIC_CLOCKEVENTS
 	bool
 
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 2191d40..b57998e 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -35,6 +35,8 @@ struct machine_class {
 #ifdef CONFIG_MULTI_IRQ_HANDLER
 	void			(*handle_irq)(struct pt_regs *);
 #endif
+	void			(*idle)(void);
+	void			(*reset)(char, const char *);
 };
 
 struct machine_desc {
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 5f4f480..448b966 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -513,6 +513,8 @@ static inline unsigned long long __cmpxchg64_mb(volatile void *ptr,
 
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
+extern void (*__arch_idle)(void);
+extern void (*__arch_reset)(char, const char *);
 #endif /* __ASSEMBLY__ */
 
 #define arch_align_stack(x) (x)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index acf5e6f..a19ed5c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -51,7 +51,26 @@ extern void setup_mm_for_reboot(char mode);
 
 static volatile int hlt_counter;
 
+#ifndef CONFIG_ARCH_HAS_IDLE_RESET
 #include <mach/system.h>
+#else
+void (*__arch_idle)(void);
+void (*__arch_reset)(void);
+
+static void arch_idle(void)
+{
+	if (__arch_idle)
+		__arch_idle();
+	else
+		cpu_do_idle();
+}
+
+static void arch_reset(char mode, const char *cmd)
+{
+	if (__arch_reset)
+		__arch_reset(mode, cmd);
+}
+#endif
 
 void disable_hlt(void)
 {
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 672a8ec..7fa0c7a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -38,7 +38,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
 #include <asm/tlbflush.h>
-
+#include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
@@ -687,8 +687,11 @@ void __init setup_arch(char **cmdline_p)
 	class = mdesc->class;
 	machine_name = mdesc->name;
 
-	if (class)
+	if (class) {
 		vmalloc_end = class->vmalloc_end;
+		__arch_idle = class->idle;
+		__arch_reset = class->reset;
+	}
 
 	if (mdesc->soft_reboot)
 		reboot_setup("s");
-- 
1.7.1
