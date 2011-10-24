From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:54 -0400
Subject: [PATCH 05/12] ARM: mach-gemini: move special idle code to a
	out-of-line pm_idle hook
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-6-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-gemini/Makefile              |    2 +-
 arch/arm/mach-gemini/idle.c                |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-gemini/include/mach/system.h |   10 ----------
 3 files changed, 29 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/mach-gemini/idle.c

diff --git a/arch/arm/mach-gemini/Makefile b/arch/arm/mach-gemini/Makefile
index c5b24b95a7..7355c0bbcb 100644
--- a/arch/arm/mach-gemini/Makefile
+++ b/arch/arm/mach-gemini/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= irq.o mm.o time.o devices.o gpio.o
+obj-y			:= irq.o mm.o time.o devices.o gpio.o idle.o
 
 # Board-specific support
 obj-$(CONFIG_MACH_NAS4220B)	+= board-nas4220b.o
diff --git a/arch/arm/mach-gemini/idle.c b/arch/arm/mach-gemini/idle.c
new file mode 100644
index 0000000000..0c528f3397
--- /dev/null
+++ b/arch/arm/mach-gemini/idle.c
@@ -0,0 +1,28 @@
+/*
+ * arch/arm/mach-gemini/idle.c
+ */
+
+#include <linux/init.h>
+
+static void gemini_idle(void)
+{
+	/*
+	 * Because of broken hardware we have to enable interrupts or the CPU
+	 * will never wakeup... Acctualy it is not very good to enable
+	 * interrupts first since scheduler can miss a tick, but there is
+	 * no other way around this. Platforms that needs it for power saving
+	 * should call enable_hlt() in init code, since by default it is
+	 * disabled.
+	 */
+	local_irq_enable();
+	cpu_do_idle();
+}
+
+static int __init gemini_idle_init(void)
+{
+	pm_idle = gemini_idle;
+	return 0;
+}
+
+arch_initcall(gemini_idle_init);
+
diff --git a/arch/arm/mach-gemini/include/mach/system.h b/arch/arm/mach-gemini/include/mach/system.h
index 4d9c1f8724..20c1738060 100644
--- a/arch/arm/mach-gemini/include/mach/system.h
+++ b/arch/arm/mach-gemini/include/mach/system.h
@@ -16,16 +16,6 @@
 
 static inline void arch_idle(void)
 {
-	/*
-	 * Because of broken hardware we have to enable interrupts or the CPU
-	 * will never wakeup... Acctualy it is not very good to enable
-	 * interrupts here since scheduler can miss a tick, but there is
-	 * no other way around this. Platforms that needs it for power saving
-	 * should call enable_hlt() in init code, since by default it is
-	 * disabled.
-	 */
-	local_irq_enable();
-	cpu_do_idle();
 }
 
 static inline void arch_reset(char mode, const char *cmd)
-- 
1.7.7.1.431.g10b2a
