From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:43:20 +0000
Subject: [PATCH 10/41] ARM: restart: footbridge: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6ka-0001XF-KR@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-footbridge/cats-hw.c             |    1 +
 arch/arm/mach-footbridge/common.c              |   27 ++++++++++++
 arch/arm/mach-footbridge/common.h              |    1 +
 arch/arm/mach-footbridge/ebsa285.c             |    1 +
 arch/arm/mach-footbridge/include/mach/system.h |   52 ------------------------
 arch/arm/mach-footbridge/netwinder-hw.c        |   27 ++++++++++++
 arch/arm/mach-footbridge/personal.c            |    1 +
 7 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-footbridge/cats-hw.c b/arch/arm/mach-footbridge/cats-hw.c
index 60b6774..25b4536 100644
--- a/arch/arm/mach-footbridge/cats-hw.c
+++ b/arch/arm/mach-footbridge/cats-hw.c
@@ -91,4 +91,5 @@ MACHINE_START(CATS, "Chalice-CATS")
 	.map_io		= footbridge_map_io,
 	.init_irq	= footbridge_init_irq,
 	.timer		= &isa_timer,
+	.restart	= footbridge_restart,
 MACHINE_END
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 38a44f9..41978ee 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -199,6 +199,33 @@ void __init footbridge_map_io(void)
 		iotable_init(ebsa285_host_io_desc, ARRAY_SIZE(ebsa285_host_io_desc));
 }
 
+void footbridge_restart(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		/* Jump into the ROM */
+		soft_restart(0x41000000);
+	} else {
+		/*
+		 * Force the watchdog to do a CPU reset.
+		 *
+		 * After making sure that the watchdog is disabled
+		 * (so we can change the timer registers) we first
+		 * enable the timer to autoreload itself.  Next, the
+		 * timer interval is set really short and any
+		 * current interrupt request is cleared (so we can
+		 * see an edge transition).  Finally, TIMER4 is
+		 * enabled as the watchdog.
+		 */
+		*CSR_SA110_CNTL &= ~(1 << 13);
+		*CSR_TIMER4_CNTL = TIMER_CNTL_ENABLE |
+				   TIMER_CNTL_AUTORELOAD |
+				   TIMER_CNTL_DIV16;
+		*CSR_TIMER4_LOAD = 0x2;
+		*CSR_TIMER4_CLR  = 0;
+		*CSR_SA110_CNTL |= (1 << 13);
+	}
+}
+
 #ifdef CONFIG_FOOTBRIDGE_ADDIN
 
 static inline unsigned long fb_bus_sdram_offset(void)
diff --git a/arch/arm/mach-footbridge/common.h b/arch/arm/mach-footbridge/common.h
index b05e662..c9767b8 100644
--- a/arch/arm/mach-footbridge/common.h
+++ b/arch/arm/mach-footbridge/common.h
@@ -8,3 +8,4 @@ extern void footbridge_map_io(void);
 extern void footbridge_init_irq(void);
 
 extern void isa_init_irq(unsigned int irq);
+extern void footbridge_restart(char, const char *);
diff --git a/arch/arm/mach-footbridge/ebsa285.c b/arch/arm/mach-footbridge/ebsa285.c
index 012210c..27716a7 100644
--- a/arch/arm/mach-footbridge/ebsa285.c
+++ b/arch/arm/mach-footbridge/ebsa285.c
@@ -21,5 +21,6 @@ MACHINE_START(EBSA285, "EBSA285")
 	.map_io		= footbridge_map_io,
 	.init_irq	= footbridge_init_irq,
 	.timer		= &footbridge_timer,
+	.restart	= footbridge_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-footbridge/include/mach/system.h b/arch/arm/mach-footbridge/include/mach/system.h
index 249f895..794a02c 100644
--- a/arch/arm/mach-footbridge/include/mach/system.h
+++ b/arch/arm/mach-footbridge/include/mach/system.h
@@ -7,12 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/io.h>
-#include <asm/hardware/dec21285.h>
-#include <mach/hardware.h>
-#include <asm/leds.h>
-#include <asm/mach-types.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -20,50 +14,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if (mode == 's') {
-		/*
-		 * Jump into the ROM
-		 */
-		soft_restart(0x41000000);
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
diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index 0d3846f..80a1c5c 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -645,6 +645,32 @@ fixup_netwinder(struct tag *tags, char **cmdline, struct meminfo *mi)
 #endif
 }
 
+static void netwinder_restart(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		/* Jump into the ROM */
+		soft_restart(0x41000000);
+	} else {
+		local_irq_disable();
+		local_fiq_disable();
+
+		/* open up the SuperIO chip */
+		outb(0x87, 0x370);
+		outb(0x87, 0x370);
+
+		/* aux function group 1 (logical device 7) */
+		outb(0x07, 0x370);
+		outb(0x07, 0x371);
+
+		/* set GP16 for WD-TIMER output */
+		outb(0xe6, 0x370);
+		outb(0x00, 0x371);
+
+		/* set a RED LED and toggle WD_TIMER for rebooting */
+		outb(0xc4, 0x338);
+	}
+}
+
 MACHINE_START(NETWINDER, "Rebel-NetWinder")
 	/* Maintainer: Russell King/Rebel.com */
 	.atag_offset	= 0x100,
@@ -656,4 +682,5 @@ MACHINE_START(NETWINDER, "Rebel-NetWinder")
 	.map_io		= footbridge_map_io,
 	.init_irq	= footbridge_init_irq,
 	.timer		= &isa_timer,
+	.restart	= netwinder_restart,
 MACHINE_END
diff --git a/arch/arm/mach-footbridge/personal.c b/arch/arm/mach-footbridge/personal.c
index f41dba3..e1e9990 100644
--- a/arch/arm/mach-footbridge/personal.c
+++ b/arch/arm/mach-footbridge/personal.c
@@ -19,5 +19,6 @@ MACHINE_START(PERSONAL_SERVER, "Compaq-PersonalServer")
 	.map_io		= footbridge_map_io,
 	.init_irq	= footbridge_init_irq,
 	.timer		= &footbridge_timer,
+	.restart	= footbridge_restart,
 MACHINE_END
 
-- 
1.7.4.4
