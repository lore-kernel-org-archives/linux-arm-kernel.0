From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:13 +0900
Subject: [PATCH 21/43] ARM: shmobile: sh73a0: Do not use early devices with DT
 reference
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-22-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not initialise any early devices when using the minimal DT reference
code. Only the delay needs to be initialised.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |    2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c        |   24 +++++++++---------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 84dcaa4..44cdecc 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -34,12 +34,12 @@ extern int sh7372_do_idle_sysc(unsigned long sleep_mode);
 extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
 
+extern void sh73a0_init_delay(void);
 extern void sh73a0_init_irq(void);
 extern void sh73a0_init_irq_dt(void);
 extern void sh73a0_map_io(void);
 extern void sh73a0_earlytimer_init(void);
 extern void sh73a0_add_early_devices(void);
-extern void sh73a0_add_early_devices_dt(void);
 extern void sh73a0_add_standard_devices(void);
 extern void sh73a0_add_standard_devices_dt(void);
 extern void sh73a0_clock_init(void);
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 37baa48..2257a91 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -811,7 +811,7 @@ static struct platform_device ipmmu_device = {
 	.num_resources  = ARRAY_SIZE(ipmmu_resources),
 };
 
-static struct platform_device *sh73a0_early_devices_dt[] __initdata = {
+static struct platform_device *sh73a0_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -848,8 +848,8 @@ void __init sh73a0_add_standard_devices(void)
 	/* Clear software reset bit on SY-DMAC module */
 	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
 
-	platform_add_devices(sh73a0_early_devices_dt,
-			    ARRAY_SIZE(sh73a0_early_devices_dt));
+	platform_add_devices(sh73a0_devices_dt,
+			    ARRAY_SIZE(sh73a0_devices_dt));
 	platform_add_devices(sh73a0_early_devices,
 			    ARRAY_SIZE(sh73a0_early_devices));
 	platform_add_devices(sh73a0_late_devices,
@@ -868,8 +868,8 @@ void __init sh73a0_earlytimer_init(void)
 
 void __init sh73a0_add_early_devices(void)
 {
-	early_platform_add_devices(sh73a0_early_devices_dt,
-				   ARRAY_SIZE(sh73a0_early_devices_dt));
+	early_platform_add_devices(sh73a0_devices_dt,
+				   ARRAY_SIZE(sh73a0_devices_dt));
 	early_platform_add_devices(sh73a0_early_devices,
 				   ARRAY_SIZE(sh73a0_early_devices));
 
@@ -879,15 +879,9 @@ void __init sh73a0_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init sh73a0_add_early_devices_dt(void)
+void __init sh73a0_init_delay(void)
 {
 	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
-
-	early_platform_add_devices(sh73a0_early_devices_dt,
-				   ARRAY_SIZE(sh73a0_early_devices_dt));
-
-	/* setup early console here as well */
-	shmobile_setup_console();
 }
 
 static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
@@ -899,8 +893,8 @@ void __init sh73a0_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
-	platform_add_devices(sh73a0_early_devices_dt,
-			     ARRAY_SIZE(sh73a0_early_devices_dt));
+	platform_add_devices(sh73a0_devices_dt,
+			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     sh73a0_auxdata_lookup, NULL);
 }
@@ -913,7 +907,7 @@ static const char *sh73a0_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
-	.init_early	= sh73a0_add_early_devices_dt,
+	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= irqchip_init,
 	.init_machine	= sh73a0_add_standard_devices_dt,
-- 
1.7.10.4
