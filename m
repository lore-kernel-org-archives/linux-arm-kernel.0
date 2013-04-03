From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed,  3 Apr 2013 18:13:55 +0200
Subject: [PATCH/RFC 2/3] ARM: shmobile: initialise clock early on
 kzm9g-reference
In-Reply-To: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
References: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1365005636-17526-3-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare to enable TWD on kzm9g-reference, clock initialisation has to be
done early. Move it from .init_machine to .init_time stage.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    8 +++++++-
 arch/arm/mach-shmobile/setup-sh73a0.c          |   13 +++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index aefa50d..0f9b276 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -90,6 +90,12 @@ static void __init kzm_init(void)
 #endif
 }
 
+static void __init timer_init(void)
+{
+	sh73a0_clock_init();
+	shmobile_timer_init();
+}
+
 static const char *kzm9g_boards_compat_dt[] __initdata = {
 	"renesas,kzm9g-reference",
 	NULL,
@@ -102,6 +108,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= irqchip_init,
 	.init_machine	= kzm_init,
-	.init_time	= shmobile_timer_init,
+	.init_time	= timer_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 0469e84..8a1bc1c 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -1018,9 +1018,6 @@ void __init sh73a0_add_standard_devices_dt(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
 
-	/* clocks are setup late during boot in the case of DT */
-	sh73a0_clock_init();
-
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table,
@@ -1030,6 +1027,14 @@ void __init sh73a0_add_standard_devices_dt(void)
 	platform_device_register_full(&devinfo);
 }
 
+static void __init add_standard_devices(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	sh73a0_clock_init();
+
+	sh73a0_add_standard_devices_dt();
+}
+
 static const char *sh73a0_boards_compat_dt[] __initdata = {
 	"renesas,sh73a0",
 	NULL,
@@ -1041,7 +1046,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= irqchip_init,
-	.init_machine	= sh73a0_add_standard_devices_dt,
+	.init_machine	= add_standard_devices,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
-- 
1.7.2.5
