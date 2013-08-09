From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:48:09 +0900
Subject: [PATCH 02/14] ARM: shmobile: r8a7740: Remove ->init_machine() special
 case
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094809.6530.49246.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

No need to special case r8a7740 ->init_machine(),
so get rid of undesired clock setup from the
generic long term r8a7740 DT support code.

Rework the code to let r8a7740_add_dt_devices()
act like other SoCs and make the board DT
reference code setup clocks for us.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    4 +++-
 arch/arm/mach-shmobile/include/mach/r8a7740.h            |    2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c                   |   11 +----------
 3 files changed, 5 insertions(+), 12 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ work/arch/arm/mach-shmobile/board-armadillo800eva-reference.c	2013-08-08 15:37:27.000000000 +0900
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <linux/of_platform.h>
 #include <mach/common.h>
 #include <mach/r8a7740.h>
 #include <asm/mach/arch.h>
@@ -168,7 +169,8 @@ static void __init eva_init(void)
 	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
 #endif
 
-	r8a7740_add_standard_devices_dt();
+	r8a7740_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	r8a7740_pm_init();
 }
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7740.h	2013-08-08 15:33:40.000000000 +0900
@@ -52,7 +52,7 @@ extern void r8a7740_init_irq_of(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
 extern void r8a7740_add_standard_devices(void);
-extern void r8a7740_add_standard_devices_dt(void);
+extern void r8a7740_add_dt_devices(void);
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2013-08-08 15:37:11.000000000 +0900
@@ -26,7 +26,6 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/platform_device.h>
-#include <linux/of_platform.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
@@ -1009,11 +1008,10 @@ void __init r8a7740_add_early_devices_dt
 	shmobile_setup_console();
 }
 
-void __init r8a7740_add_standard_devices_dt(void)
+void __init r8a7740_add_dt_devices(void)
 {
 	platform_add_devices(r8a7740_devices_dt,
 			    ARRAY_SIZE(r8a7740_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 void __init r8a7740_init_delay(void)
@@ -1051,12 +1049,6 @@ void __init r8a7740_init_irq_of(void)
 	iounmap(pfc_inta_ctrl);
 }
 
-static void __init r8a7740_generic_init(void)
-{
-	r8a7740_clock_init(0);
-	r8a7740_add_standard_devices_dt();
-}
-
 static const char *r8a7740_boards_compat_dt[] __initdata = {
 	"renesas,r8a7740",
 	NULL,
@@ -1066,7 +1058,6 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
-	.init_machine	= r8a7740_generic_init,
 	.dt_compat	= r8a7740_boards_compat_dt,
 MACHINE_END
 
