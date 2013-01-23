From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 23 Jan 2013 17:53:28 +0100 (CET)
Subject: [PATCH] ARM: shmobile: fix armadillo800eva clock initialisation in
 reference DT set up
Message-ID: <Pine.LNX.4.64.1301231746190.26301@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock configuration on armadillo800eva in reference DT set up must be the
same, as in the board-code case: the clock tree and oscillator frequencies
have to be fixed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This goes on top of my DT/mmc/pinctrl patch-series from today, which in 
turn is based on Simon's (no longer existing) pfc4 branch.

 .../board-armadillo800eva-reference.c              |   56 +++++++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7740.c             |   13 +++--
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index f929931..92d7106 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -25,11 +25,13 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <mach/common.h>
 #include <mach/r8a7740.h>
+#include <asm/mach/time.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
 
@@ -102,6 +104,41 @@
  * # amixer set "Headphone" 50
  */
 
+static void __init eva_clock_init(void)
+{
+	struct clk *system	= clk_get(NULL, "system_clk");
+	struct clk *xtal1	= clk_get(NULL, "extal1");
+	struct clk *usb24s	= clk_get(NULL, "usb24s");
+	struct clk *fsibck	= clk_get(NULL, "fsibck");
+
+	if (IS_ERR(system)	||
+	    IS_ERR(xtal1)	||
+	    IS_ERR(usb24s)	||
+	    IS_ERR(fsibck)) {
+		pr_err("armadillo800eva board clock init failed\n");
+		goto clock_error;
+	}
+
+	/* armadillo 800 eva extal1 is 24MHz */
+	clk_set_rate(xtal1, 24000000);
+
+	/* usb24s use extal1 (= system) clock (= 24MHz) */
+	clk_set_parent(usb24s, system);
+
+	/* FSIBCK is 12.288MHz, and it is parent of FSI-B */
+	clk_set_rate(fsibck, 12288000);
+
+clock_error:
+	if (!IS_ERR(system))
+		clk_put(system);
+	if (!IS_ERR(xtal1))
+		clk_put(xtal1);
+	if (!IS_ERR(usb24s))
+		clk_put(usb24s);
+	if (!IS_ERR(fsibck))
+		clk_put(fsibck);
+}
+
 /*
  * board init
  */
@@ -145,6 +182,23 @@ static void __init eva_init(void)
 #endif
 }
 
+static void __init eva_earlytimer_init(void)
+{
+	r8a7740_clock_init(MD_CK0 | MD_CK2);
+	shmobile_earlytimer_init();
+
+	/* the rate of extal1 clock must be set before late_time_init */
+	eva_clock_init();
+}
+
+static void __init eva_add_early_devices(void)
+{
+	r8a7740_add_early_devices_dt();
+
+	/* override timer setup with board-specific code */
+	shmobile_timer.init = eva_earlytimer_init;
+}
+
 #define RESCNT2 IOMEM(0xe6188020)
 static void eva_restart(char mode, const char *cmd)
 {
@@ -159,7 +213,7 @@ static const char *eva_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_add_early_devices_dt,
+	.init_early	= eva_add_early_devices,
 	.init_irq	= r8a7740_init_irq_of,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.handle_irq	= shmobile_handle_irq_intc,
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 9fe7ca8..cb5aa31 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -861,9 +861,6 @@ static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
 
 void __init r8a7740_add_standard_devices_dt(void)
 {
-	/* clocks are setup late during boot in the case of DT */
-	r8a7740_clock_init(0);
-
 	platform_add_devices(r8a7740_early_devices,
 			    ARRAY_SIZE(r8a7740_early_devices));
 
@@ -871,6 +868,14 @@ void __init r8a7740_add_standard_devices_dt(void)
 			     r8a7740_auxdata_lookup, NULL);
 }
 
+static void __init add_standard_devices(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	r8a7740_clock_init(0);
+
+	r8a7740_add_standard_devices_dt();
+}
+
 static const char *r8a7740_boards_compat_dt[] __initdata = {
 	"renesas,r8a7740",
 	NULL,
@@ -881,7 +886,7 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.init_early	= r8a7740_add_early_devices_dt,
 	.init_irq	= r8a7740_init_irq_of,
 	.handle_irq	= shmobile_handle_irq_intc,
-	.init_machine	= r8a7740_add_standard_devices_dt,
+	.init_machine	= add_standard_devices,
 	.timer		= &shmobile_timer,
 	.dt_compat	= r8a7740_boards_compat_dt,
 MACHINE_END
-- 
1.7.2.5
