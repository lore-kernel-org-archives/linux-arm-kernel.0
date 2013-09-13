From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 21:16:36 +0200
Subject: [PATCH] ARM: nomadik: delete FSMC platform data
Message-ID: <1379099796-15912-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have device tree support for setting the NAND timings
for FSMC from the device tree, so delete the last piece of
platform data and auxdata.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi |  1 +
 arch/arm/mach-nomadik/cpu-8815.c           | 22 +---------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 0e543e0..79425e3 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -653,6 +653,7 @@
 		reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
 		clocks = <&hclksmc>;
 		status = "okay";
+		timings = /bits/ 8 <0 0 0 0x10 0x0a 0>;
 
 		partition at 0 {
 		label = "X-Loader(NAND)";
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 7a00506..c6c156e 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -31,7 +31,6 @@
 #include <linux/of_gpio.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/mtd/fsmc.h>
 #include <linux/gpio.h>
 
 #include <asm/mach/arch.h>
@@ -145,17 +144,6 @@ static void __init cpu8815_timer_init_of(void)
 	clocksource_of_init();
 }
 
-static struct fsmc_nand_timings cpu8815_nand_timings = {
-	.thiz	= 0,
-	.thold	= 0x10,
-	.twait	= 0x0A,
-	.tset	= 0,
-};
-
-static struct fsmc_nand_platform_data cpu8815_nand_data = {
-	.nand_timings = &cpu8815_nand_timings,
-};
-
 /*
  * The SMSC911x IRQ is connected to a GPIO pin, but the driver expects
  * to simply request an IRQ passed as a resource. So the GPIO pin needs
@@ -222,21 +210,13 @@ static int __init cpu8815_mmcsd_init(void)
 }
 device_initcall(cpu8815_mmcsd_init);
 
-/* This still waits for a device tree enablement patch */
-static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("stericsson,fsmc-nand", NOMADIK_FSMC_BASE,
-		NULL, &cpu8815_nand_data),
-	{ /* sentinel */ },
-};
-
 static void __init cpu8815_init_of(void)
 {
 #ifdef CONFIG_CACHE_L2X0
 	/* At full speed latency must be >=2, so 0x249 in low bits */
 	l2x0_of_init(0x00730249, 0xfe000fff);
 #endif
-	of_platform_populate(NULL, of_default_bus_match_table,
-			cpu8815_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char * cpu8815_board_compat[] = {
-- 
1.8.1.4
