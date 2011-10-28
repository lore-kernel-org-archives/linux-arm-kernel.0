From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:43 +0100
Subject: [PATCH 15/51] ARM: mach-iop32x: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-16-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-iop32x to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-iop32x/Makefile              |    2 +-
 arch/arm/mach-iop32x/include/mach/system.h |   13 -----------
 arch/arm/mach-iop32x/reset.c               |   33 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/mach-iop32x/reset.c

diff --git a/arch/arm/mach-iop32x/Makefile b/arch/arm/mach-iop32x/Makefile
index cfdf8a1..29574bc 100644
--- a/arch/arm/mach-iop32x/Makefile
+++ b/arch/arm/mach-iop32x/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y			:= irq.o
+obj-y			:= irq.o reset.o
 obj-m			:=
 obj-n			:=
 obj-			:=
diff --git a/arch/arm/mach-iop32x/include/mach/system.h b/arch/arm/mach-iop32x/include/mach/system.h
index a4b808f..094714d 100644
--- a/arch/arm/mach-iop32x/include/mach/system.h
+++ b/arch/arm/mach-iop32x/include/mach/system.h
@@ -18,17 +18,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	local_irq_disable();
-
-	if (machine_is_n2100()) {
-		gpio_line_set(N2100_HARDWARE_RESET, GPIO_LOW);
-		gpio_line_config(N2100_HARDWARE_RESET, GPIO_OUT);
-		while (1)
-			;
-	}
-
-	*IOP3XX_PCSR = 0x30;
-
-	/* Jump into ROM at address 0 */
-	cpu_reset(0);
 }
diff --git a/arch/arm/mach-iop32x/reset.c b/arch/arm/mach-iop32x/reset.c
new file mode 100644
index 0000000..3df8dfe
--- /dev/null
+++ b/arch/arm/mach-iop32x/reset.c
@@ -0,0 +1,33 @@
+/*
+ * arch/arm/mach-iop32x/reset.c
+ */
+#include <linux/init.h>
+#include <asm/mach-types.h>
+#include <asm/proc-fns.h>
+#include <asm/system.h>
+#include <asm/hardware/iop3xx.h>
+#include <mach/n2100.h>
+
+static void iop32x_arch_reset(char mode, const char *cmd)
+{
+	local_irq_disable();
+
+	if (machine_is_n2100()) {
+		gpio_line_set(N2100_HARDWARE_RESET, GPIO_LOW);
+		gpio_line_config(N2100_HARDWARE_RESET, GPIO_OUT);
+		while (1)
+			;
+	}
+
+	*IOP3XX_PCSR = 0x30;
+
+	/* Jump into ROM at address 0 */
+	cpu_reset(0);
+}
+
+static int __init iop32x_arch_reset_init(void)
+{
+	arm_arch_reset = iop32x_arch_reset;
+	return 0;
+}
+arch_initcall(iop32x_arch_reset_init);
-- 
1.7.4.1
