From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 11:56:06 +0900
Subject: [PATCH 1/5] ARM: shmobile: r8a7779: Do not use early devices with DT
 reference
In-Reply-To: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
References: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1361242570-8867-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not initialise any early devices when using the minimal DT reference
code. Only the delay needs to be initialised.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c       |   25 +++++++++----------------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 84dcaa4..98aecdf 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -58,12 +58,12 @@ extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
 
+extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq(void);
 extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
-extern void r8a7779_add_early_devices_dt(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_clock_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 922dd4d..b1f7a45 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -322,7 +322,7 @@ static struct platform_device i2c3_device = {
 	.num_resources	= ARRAY_SIZE(rcar_i2c3_res),
 };
 
-static struct platform_device *r8a7779_early_devices_dt[] __initdata = {
+static struct platform_device *r8a7779_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -350,8 +350,8 @@ void __init r8a7779_add_standard_devices(void)
 
 	r8a7779_init_pm_domains();
 
-	platform_add_devices(r8a7779_early_devices_dt,
-			    ARRAY_SIZE(r8a7779_early_devices_dt));
+	platform_add_devices(r8a7779_devices_dt,
+			    ARRAY_SIZE(r8a7779_devices_dt));
 	platform_add_devices(r8a7779_early_devices,
 			    ARRAY_SIZE(r8a7779_early_devices));
 }
@@ -368,8 +368,8 @@ void __init r8a7779_earlytimer_init(void)
 
 void __init r8a7779_add_early_devices(void)
 {
-	early_platform_add_devices(r8a7779_early_devices_dt,
-				   ARRAY_SIZE(r8a7779_early_devices_dt));
+	early_platform_add_devices(r8a7779_devices_dt,
+				   ARRAY_SIZE(r8a7779_devices_dt));
 	early_platform_add_devices(r8a7779_early_devices,
 				   ARRAY_SIZE(r8a7779_early_devices));
 
@@ -391,16 +391,9 @@ void __init r8a7779_add_early_devices(void)
 }
 
 #ifdef CONFIG_USE_OF
-void __init r8a7779_add_early_devices_dt(void)
+void __init r8a7779_init_delay(void)
 {
 	shmobile_setup_delay(1000, 2, 4); /* Cortex-A9 @ 1000MHz */
-
-	early_platform_add_devices(r8a7779_early_devices_dt,
-				   ARRAY_SIZE(r8a7779_early_devices_dt));
-
-	/* Early serial console setup is not included here.
-	 * See comment in r8a7779_add_early_devices().
-	 */
 }
 
 static const struct of_dev_auxdata r8a7779_auxdata_lookup[] __initconst = {
@@ -412,8 +405,8 @@ void __init r8a7779_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	r8a7779_clock_init();
 
-	platform_add_devices(r8a7779_early_devices_dt,
-			    ARRAY_SIZE(r8a7779_early_devices_dt));
+	platform_add_devices(r8a7779_devices_dt,
+			     ARRAY_SIZE(r8a7779_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     r8a7779_auxdata_lookup, NULL);
 }
@@ -425,7 +418,7 @@ static const char *r8a7779_compat_dt[] __initdata = {
 
 DT_MACHINE_START(SH73A0_DT, "Generic R8A7779 (Flattened Device Tree)")
 	.map_io		= r8a7779_map_io,
-	.init_early	= r8a7779_add_early_devices_dt,
+	.init_early	= r8a7779_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= r8a7779_add_standard_devices_dt,
-- 
1.7.10.4
