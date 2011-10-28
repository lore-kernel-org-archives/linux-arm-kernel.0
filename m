From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:38 +0100
Subject: [PATCH 10/51] ARM: mach-footbridge: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-footbridge to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-footbridge/Makefile              |    2 +-
 arch/arm/mach-footbridge/include/mach/system.h |   46 ----------------
 arch/arm/mach-footbridge/reset.c               |   69 ++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/mach-footbridge/reset.c

diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index 3afb1b2..39821ce 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= common.o dc21285.o dma.o isa-irq.o
+obj-y			:= common.o dc21285.o dma.o isa-irq.o reset.o
 obj-m			:=
 obj-n			:=
 obj-			:=
diff --git a/arch/arm/mach-footbridge/include/mach/system.h b/arch/arm/mach-footbridge/include/mach/system.h
index 0b29315..0c19392 100644
--- a/arch/arm/mach-footbridge/include/mach/system.h
+++ b/arch/arm/mach-footbridge/include/mach/system.h
@@ -20,50 +20,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if (mode == 's') {
-		/*
-		 * Jump into the ROM
-		 */
-		cpu_reset(0x41000000);
-	} else {
-		if (machine_is_netwinder()) {
-			/* open up the SuperIO chip
-			 */
-			outb(0x87, 0x370);
-			outb(0x87, 0x370);
-
-			/* aux function group 1 (logical device 7)
-			 */
-			outb(0x07, 0x370);
-			outb(0x07, 0x371);
-
-			/* set GP16 for WD-TIMER output
-			 */
-			outb(0xe6, 0x370);
-			outb(0x00, 0x371);
-
-			/* set a RED LED and toggle WD_TIMER for rebooting
-			 */
-			outb(0xc4, 0x338);
-		} else {
-			/* 
-			 * Force the watchdog to do a CPU reset.
-			 *
-			 * After making sure that the watchdog is disabled
-			 * (so we can change the timer registers) we first
-			 * enable the timer to autoreload itself.  Next, the
-			 * timer interval is set really short and any
-			 * current interrupt request is cleared (so we can
-			 * see an edge transition).  Finally, TIMER4 is
-			 * enabled as the watchdog.
-			 */
-			*CSR_SA110_CNTL &= ~(1 << 13);
-			*CSR_TIMER4_CNTL = TIMER_CNTL_ENABLE |
-					   TIMER_CNTL_AUTORELOAD |
-					   TIMER_CNTL_DIV16;
-			*CSR_TIMER4_LOAD = 0x2;
-			*CSR_TIMER4_CLR  = 0;
-			*CSR_SA110_CNTL |= (1 << 13);
-		}
-	}
 }
diff --git a/arch/arm/mach-footbridge/reset.c b/arch/arm/mach-footbridge/reset.c
new file mode 100644
index 0000000..f61e559
--- /dev/null
+++ b/arch/arm/mach-footbridge/reset.c
@@ -0,0 +1,69 @@
+/*
+ * arch/arm/mach-footbridge/reset.c
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <asm/hardware/dec21285.h>
+#include <mach/hardware.h>
+#include <asm/leds.h>
+#include <asm/mach-types.h>
+#include <asm/proc-fns.h>
+
+static void footbridge_arch_reset(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		/*
+		 * Jump into the ROM
+		 */
+		cpu_reset(0x41000000);
+	} else {
+		if (machine_is_netwinder()) {
+			/* open up the SuperIO chip
+			 */
+			outb(0x87, 0x370);
+			outb(0x87, 0x370);
+
+			/* aux function group 1 (logical device 7)
+			 */
+			outb(0x07, 0x370);
+			outb(0x07, 0x371);
+
+			/* set GP16 for WD-TIMER output
+			 */
+			outb(0xe6, 0x370);
+			outb(0x00, 0x371);
+
+			/* set a RED LED and toggle WD_TIMER for rebooting
+			 */
+			outb(0xc4, 0x338);
+		} else {
+			/*
+			 * Force the watchdog to do a CPU reset.
+			 *
+			 * After making sure that the watchdog is disabled
+			 * (so we can change the timer registers) we first
+			 * enable the timer to autoreload itself.  Next, the
+			 * timer interval is set really short and any
+			 * current interrupt request is cleared (so we can
+			 * see an edge transition).  Finally, TIMER4 is
+			 * enabled as the watchdog.
+			 */
+			*CSR_SA110_CNTL &= ~(1 << 13);
+			*CSR_TIMER4_CNTL = TIMER_CNTL_ENABLE |
+					   TIMER_CNTL_AUTORELOAD |
+					   TIMER_CNTL_DIV16;
+			*CSR_TIMER4_LOAD = 0x2;
+			*CSR_TIMER4_CLR  = 0;
+			*CSR_SA110_CNTL |= (1 << 13);
+		}
+	}
+}
+
+static int __init footbridge_arch_reset_init(void)
+{
+	arm_arch_reset = footbridge_arch_reset;
+	return 0;
+}
+arch_initcall(footbridge_arch_reset_init);
-- 
1.7.4.1
