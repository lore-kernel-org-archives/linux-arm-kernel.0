From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Integrator: convert Integrator/CP to use SP804 timer
	support
References: <git-1267729916-6ca45be431733d3c1460cbc8245eb2efe0150fdd@rmk-PC>
Message-ID: <git-1267729916-d812bfe0155031706019561409a54500168b6caf@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The Integrator/CP board has SP804-compatible timer modules, so use
the SP804-compatible code from Versatile and Realview.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/Kconfig         |    1 +
 arch/arm/mach-integrator/integrator_cp.c |   14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index df97d16..27db275 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -11,6 +11,7 @@ config ARCH_INTEGRATOR_AP
 config ARCH_INTEGRATOR_CP
 	bool "Support Integrator/CP platform"
 	select ARCH_CINTEGRATOR
+	select ARM_TIMER_SP804
 	help
 	  Include support for the ARM(R) Integrator CP platform.
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index a9ab8fd..a7575c4 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -29,6 +29,7 @@
 #include <asm/irq.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
+#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <mach/cm.h>
@@ -40,6 +41,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
+#include <plat/timer-sp.h>
+
 #include "common.h"
 
 #define INTCP_PA_FLASH_BASE		0x24000000
@@ -569,11 +572,18 @@ static void __init intcp_init(void)
 	}
 }
 
-#define TIMER_CTRL_IE	(1 << 5)			/* Interrupt Enable */
+#define TIMER0_VA_BASE __io_address(INTEGRATOR_TIMER0_BASE)
+#define TIMER1_VA_BASE __io_address(INTEGRATOR_TIMER1_BASE)
+#define TIMER2_VA_BASE __io_address(INTEGRATOR_TIMER2_BASE)
 
 static void __init intcp_timer_init(void)
 {
-	integrator_time_init(1000, TIMER_CTRL_IE);
+	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
+	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
+	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
+
+	sp804_clocksource_init(TIMER2_VA_BASE);
+	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1);
 }
 
 static struct sys_timer cp_timer = {
