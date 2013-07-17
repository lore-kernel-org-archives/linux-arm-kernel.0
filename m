From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:31:57 +0900
Subject: [PATCH 18/22] ARM: shmobile: Remove unused EMEV2/KZM9D early console
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <4146fa8861419ac0d2c3607168339621586f6c03.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove EMEV2 early console code from KZM9D and instead
rely on console setup during regular platform device
probe time. This makes the DT code and the KZM9D board
support behave the same.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9d.c        |    2 +-
 arch/arm/mach-shmobile/include/mach/emev2.h |    2 +-
 arch/arm/mach-shmobile/setup-emev2.c        |   24 +++---------------------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9d.c b/arch/arm/mach-shmobile/board-kzm9d.c
index 4368000..15900f1 100644
--- a/arch/arm/mach-shmobile/board-kzm9d.c
+++ b/arch/arm/mach-shmobile/board-kzm9d.c
@@ -85,7 +85,7 @@ static const char *kzm9d_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(KZM9D_DT, "kzm9d")
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
-	.init_early	= emev2_add_early_devices,
+	.init_early	= emev2_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= emev2_init_irq,
 	.init_machine	= kzm9d_add_standard_devices,
diff --git a/arch/arm/mach-shmobile/include/mach/emev2.h b/arch/arm/mach-shmobile/include/mach/emev2.h
index ac37517..3e0c044 100644
--- a/arch/arm/mach-shmobile/include/mach/emev2.h
+++ b/arch/arm/mach-shmobile/include/mach/emev2.h
@@ -3,7 +3,7 @@
 
 extern void emev2_map_io(void);
 extern void emev2_init_irq(void);
-extern void emev2_add_early_devices(void);
+extern void emev2_init_delay(void);
 extern void emev2_add_standard_devices(void);
 extern void emev2_clock_init(void);
 extern void emev2_set_boot_vector(unsigned long value);
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index b0564ce..f6edd19 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -375,14 +375,11 @@ static struct platform_device pmu_device = {
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
@@ -396,29 +393,14 @@ void __init emev2_add_standard_devices(void)
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
-- 
1.7.10.4
