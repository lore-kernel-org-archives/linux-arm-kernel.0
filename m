From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:49:30 +0000
Subject: [PATCH 11/11] ARM: integrator: add Integrator/CP sched_clock support
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSE6-0003pX-1O@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Integrator/CP has the 24MHz counter which Versatile and later platforms
also have, which we use for sched_clock support.  Allow this counter to
be used when building a kernel targetting Integrator/CP alone.
Integrator/AP does not have this counter, so we must exclude support
for the Integrator family when this is enabled.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/integrator_cp.c |    7 +++++++
 arch/arm/plat-versatile/Kconfig          |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 05da36f..9e3ce26 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -44,6 +44,7 @@
 
 #include <plat/clcd.h>
 #include <plat/fpga-irq.h>
+#include <plat/sched_clock.h>
 
 #include "common.h"
 
@@ -440,11 +441,17 @@ static struct amba_device *amba_devs[] __initdata = {
 	&clcd_device,
 };
 
+#define REFCOUNTER (__io_address(INTEGRATOR_HDR_BASE) + 0x28)
+
 static void __init intcp_init_early(void)
 {
 	clkdev_add_table(cp_lookups, ARRAY_SIZE(cp_lookups));
 
 	integrator_init_early();
+
+#ifdef CONFIG_PLAT_VERSATILE_SCHED_CLOCK
+	versatile_sched_clock_init(REFCOUNTER, 24000000);
+#endif
 }
 
 static void __init intcp_init(void)
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 0b27500..52353be 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -11,7 +11,7 @@ config PLAT_VERSATILE_LEDS
 	depends on ARCH_REALVIEW || ARCH_VERSATILE
 
 config PLAT_VERSATILE_SCHED_CLOCK
-	def_bool y if !ARCH_INTEGRATOR
+	def_bool y if !ARCH_INTEGRATOR_AP
 	select HAVE_SCHED_CLOCK
 
 endif
-- 
1.6.2.5
