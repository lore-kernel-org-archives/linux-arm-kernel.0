From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:48:19 +0900
Subject: [PATCH 03/14] ARM: shmobile: sh7372: Remove ->init_machine() special
 case
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094819.6530.79893.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

No need to special case sh7372 ->init_machine(),
so get rid of undesired clock setup from the
generic long term sh7372 DT support code.

Remove sh7372_add_standard_devices_dt() since
we have no DT reference implementation for sh7372.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 -
 arch/arm/mach-shmobile/setup-sh7372.c        |   12 ------------
 2 files changed, 13 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2013-08-08 15:45:46.000000000 +0900
@@ -64,7 +64,6 @@ extern void sh7372_earlytimer_init(void)
 extern void sh7372_add_early_devices(void);
 extern void sh7372_add_standard_devices(void);
 extern void sh7372_add_early_devices_dt(void);
-extern void sh7372_add_standard_devices_dt(void);
 extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
 extern void sh7372_pm_init(void);
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2013-08-08 15:44:20.000000000 +0900
@@ -1146,17 +1146,6 @@ void __init sh7372_add_early_devices_dt(
 	shmobile_setup_console();
 }
 
-void __init sh7372_add_standard_devices_dt(void)
-{
-	/* clocks are setup late during boot in the case of DT */
-	sh7372_clock_init();
-
-	platform_add_devices(sh7372_early_devices,
-			    ARRAY_SIZE(sh7372_early_devices));
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char *sh7372_boards_compat_dt[] __initdata = {
 	"renesas,sh7372",
 	NULL,
@@ -1168,7 +1157,6 @@ DT_MACHINE_START(SH7372_DT, "Generic SH7
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
-	.init_machine	= sh7372_add_standard_devices_dt,
 	.dt_compat	= sh7372_boards_compat_dt,
 MACHINE_END
 
