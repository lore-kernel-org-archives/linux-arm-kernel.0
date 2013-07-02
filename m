From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 02 Jul 2013 18:27:33 +0900
Subject: [PATCH 01/08] ARM: shmobile: Remove unused EMEV2/KZM9D early console
In-Reply-To: <20130702092725.32066.54861.sendpatchset@w520>
References: <20130702092725.32066.54861.sendpatchset@w520>
Message-ID: <20130702092733.32066.50335.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove EMEV2 early console code from KZM9D and instead
rely on console setup during regular platform device
probe time. This makes the DT code and the KZM9D board
support behave the same.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9d.c        |    2 +-
 arch/arm/mach-shmobile/include/mach/emev2.h |    2 +-
 arch/arm/mach-shmobile/setup-emev2.c        |   24 +++---------------------
 3 files changed, 5 insertions(+), 23 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-kzm9d.c
+++ work/arch/arm/mach-shmobile/board-kzm9d.c	2013-07-01 20:07:13.000000000 +0900
@@ -85,7 +85,7 @@ static const char *kzm9d_boards_compat_d
 DT_MACHINE_START(KZM9D_DT, "kzm9d")
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
-	.init_early	= emev2_add_early_devices,
+	.init_early	= emev2_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= emev2_init_irq,
 	.init_machine	= kzm9d_add_standard_devices,
--- 0001/arch/arm/mach-shmobile/include/mach/emev2.h
+++ work/arch/arm/mach-shmobile/include/mach/emev2.h	2013-07-01 20:06:35.000000000 +0900
@@ -3,7 +3,7 @@
 
 extern void emev2_map_io(void);
 extern void emev2_init_irq(void);
-extern void emev2_add_early_devices(void);
+extern void emev2_init_delay(void);
 extern void emev2_add_standard_devices(void);
 extern void emev2_clock_init(void);
 extern void emev2_set_boot_vector(unsigned long value);
--- 0012/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-07-01 20:08:10.000000000 +0900
@@ -375,14 +375,11 @@ static struct platform_device pmu_device
 	.resource	= pmu_resources,
 };
 
-static struct platform_device *emev2_early_devices[] __initdata = {
+static struct platform_device *emev2_devices[] __initdata = {
 	&uart0_device,
 	&uart1_device,
 	&uart2_device,
 	&uart3_device,
-};
-
-static struct platform_device *emev2_late_devices[] __initdata = {
 	&sti_device,
 	&gio0_device,
 	&gio1_device,
@@ -396,29 +393,14 @@ void __init emev2_add_standard_devices(v
 {
 	emev2_clock_init();
 
-	platform_add_devices(emev2_early_devices,
-			     ARRAY_SIZE(emev2_early_devices));
-
-	platform_add_devices(emev2_late_devices,
-			     ARRAY_SIZE(emev2_late_devices));
+	platform_add_devices(emev2_devices, ARRAY_SIZE(emev2_devices));
 }
 
-static void __init emev2_init_delay(void)
+void __init emev2_init_delay(void)
 {
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
 }
 
-void __init emev2_add_early_devices(void)
-{
-	emev2_init_delay();
-
-	early_platform_add_devices(emev2_early_devices,
-				   ARRAY_SIZE(emev2_early_devices));
-
-	/* setup early console here as well */
-	shmobile_setup_console();
-}
-
 void __init emev2_init_irq(void)
 {
 	void __iomem *gic_dist_base;
