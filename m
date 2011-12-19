From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:37 -0500
Subject: [PATCH 08/20] ARM: mach-gemini: move special idle code out of line
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-9-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... and hook it to arm_pm_idle.

Signed-off-by: nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-gemini/Makefile              |    2 +-
 arch/arm/mach-gemini/idle.c                |   29 ++++++++++++++++++++++++++++
 arch/arm/mach-gemini/include/mach/system.h |    9 --------
 arch/arm/mach-gemini/irq.c                 |    4 +-
 4 files changed, 32 insertions(+), 12 deletions(-)
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
index 0000000000..92bbd6bb60
--- /dev/null
+++ b/arch/arm/mach-gemini/idle.c
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-gemini/idle.c
+ */
+
+#include <linux/init.h>
+#include <asm/system.h>
+#include <asm/proc-fns.h>
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
+	arm_pm_idle = gemini_idle;
+	return 0;
+}
+
+arch_initcall(gemini_idle_init);
diff --git a/arch/arm/mach-gemini/include/mach/system.h b/arch/arm/mach-gemini/include/mach/system.h
index 860cff8fb7..1bb2734e73 100644
--- a/arch/arm/mach-gemini/include/mach/system.h
+++ b/arch/arm/mach-gemini/include/mach/system.h
@@ -12,15 +12,6 @@
 
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
 	cpu_do_idle();
 }
 
diff --git a/arch/arm/mach-gemini/irq.c b/arch/arm/mach-gemini/irq.c
index 9485a8fdf8..65bc4f0607 100644
--- a/arch/arm/mach-gemini/irq.c
+++ b/arch/arm/mach-gemini/irq.c
@@ -73,8 +73,8 @@ void __init gemini_init_irq(void)
 	unsigned int i, mode = 0, level = 0;
 
 	/*
-	 * Disable arch_idle() by default since it is buggy
-	 * For more info see arch/arm/mach-gemini/include/mach/system.h
+	 * Disable the idle handler by default since it is buggy
+	 * For more info see arch/arm/mach-gemini/idle.c 
 	 */
 	disable_hlt();
 
-- 
1.7.7.1.431.g10b2a
