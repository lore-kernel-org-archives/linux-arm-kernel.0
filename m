From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:44 +0100
Subject: [PATCH 16/51] ARM: mach-iop33x: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-17-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-iop33x to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-iop33x/Makefile              |    2 +-
 arch/arm/mach-iop33x/include/mach/system.h |    4 ----
 arch/arm/mach-iop33x/reset.c               |   24 ++++++++++++++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-iop33x/reset.c

diff --git a/arch/arm/mach-iop33x/Makefile b/arch/arm/mach-iop33x/Makefile
index 90081d8..5b72c19 100644
--- a/arch/arm/mach-iop33x/Makefile
+++ b/arch/arm/mach-iop33x/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y			:= irq.o uart.o
+obj-y			:= irq.o reset.o uart.o
 obj-m			:=
 obj-n			:=
 obj-			:=
diff --git a/arch/arm/mach-iop33x/include/mach/system.h b/arch/arm/mach-iop33x/include/mach/system.h
index f192a34..df98c56 100644
--- a/arch/arm/mach-iop33x/include/mach/system.h
+++ b/arch/arm/mach-iop33x/include/mach/system.h
@@ -16,8 +16,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	*IOP3XX_PCSR = 0x30;
-
-	/* Jump into ROM at address 0 */
-	cpu_reset(0);
 }
diff --git a/arch/arm/mach-iop33x/reset.c b/arch/arm/mach-iop33x/reset.c
new file mode 100644
index 0000000..9d71166
--- /dev/null
+++ b/arch/arm/mach-iop33x/reset.c
@@ -0,0 +1,24 @@
+/*
+ * arch/arm/mach-iop33x/reset.c
+ */
+
+#include <linux/init.h>
+#include <asm/proc-fns.h>
+#include <asm/system.h>
+#include <asm/hardware/iop3xx.h>
+
+static void iop33x_arch_reset(char mode, const char *cmd)
+{
+	*IOP3XX_PCSR = 0x30;
+
+	/* Jump into ROM at address 0 */
+	cpu_reset(0);
+}
+
+static int __init iop33x_arch_reset_init(void)
+{
+	arm_arch_reset = iop33x_arch_reset;
+	return 0;
+}
+
+arch_initcall(iop33x_arch_reset_init);
-- 
1.7.4.1
