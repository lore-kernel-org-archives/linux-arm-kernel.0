From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:52 -0400
Subject: [PATCH 03/12] ARM: mach-clps711x: move special idle code to a
	out-of-line pm_idle hook
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-4-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-clps711x/Makefile              |    2 +-
 arch/arm/mach-clps711x/idle.c                |   25 +++++++++++++++++++++++++
 arch/arm/mach-clps711x/include/mach/system.h |    5 +----
 3 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-clps711x/idle.c

diff --git a/arch/arm/mach-clps711x/Makefile b/arch/arm/mach-clps711x/Makefile
index 4a197315f0..ce49afd60e 100644
--- a/arch/arm/mach-clps711x/Makefile
+++ b/arch/arm/mach-clps711x/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= irq.o mm.o time.o
+obj-y			:= irq.o mm.o time.o idle.o
 obj-m			:=
 obj-n			:=
 obj-			:=
diff --git a/arch/arm/mach-clps711x/idle.c b/arch/arm/mach-clps711x/idle.c
new file mode 100644
index 0000000000..573071ba65
--- /dev/null
+++ b/arch/arm/mach-clps711x/idle.c
@@ -0,0 +1,25 @@
+/*
+ * arch/arm/mach-clps711x/idle.c
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+#include <asm/hardware/clps7111.h>
+
+static void clps711x_idle(void)
+{
+	clps_writel(1, HALT);
+	__asm__ __volatile__(
+	"mov    r0, r0\n\
+	mov     r0, r0");
+}
+
+static int __init clps711x_idle_init(void)
+{
+	pm_idle = clps711x_idle;
+	return 0;
+}
+
+arch_initcall(clps711x_idle_init);
+
diff --git a/arch/arm/mach-clps711x/include/mach/system.h b/arch/arm/mach-clps711x/include/mach/system.h
index f916cd7a47..367edfcef3 100644
--- a/arch/arm/mach-clps711x/include/mach/system.h
+++ b/arch/arm/mach-clps711x/include/mach/system.h
@@ -26,10 +26,7 @@
 
 static inline void arch_idle(void)
 {
-	clps_writel(1, HALT);
-	__asm__ __volatile__(
-	"mov	r0, r0\n\
-	mov	r0, r0");
+	cpu_do_idle();
 }
 
 static inline void arch_reset(char mode, const char *cmd)
-- 
1.7.7.1.431.g10b2a
