From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 11:46:45 +0100
Subject: [RFC PATCH 03/12] ARM: local timers: switch vexpress to standalone
	smp_twd
In-Reply-To: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
References: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1312886814-15627-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Versatile Express platform to the standalone version
of smp_twd.c. Since the timer calibration code requires another
timer to be up and running, the actual initialisation is left
to the late_timer_init hook.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-vexpress/Kconfig    |    1 +
 arch/arm/mach-vexpress/ct-ca9x4.c |   29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 9311484..13f1606 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,6 +5,7 @@ config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 	select CPU_V7
 	select ARM_GIC
+	select ARM_SMP_TWD
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index bfd32f5..7141d73 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -53,9 +53,6 @@ static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 
 static void __init ct_ca9x4_map_io(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = MMIO_P2V(A9_MPCORE_TWD);
-#endif
 	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
@@ -191,9 +188,35 @@ static struct platform_device pmu_device = {
 	.resource	= pmu_resources,
 };
 
+#ifdef CONFIG_ARM_SMP_TWD
+static struct resource ca9x4_twd_resources[] __initdata = {
+	{
+		.start	= A9_MPCORE_TWD,
+		.end	= A9_MPCORE_TWD + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static void __init ca9x4_twd_init(void)
+{
+	int err = twd_timer_register(ca9x4_twd_resources,
+				     ARRAY_SIZE(ca9x4_twd_resources));
+	if (err)
+		pr_err("twd_timer_register failed %d\n", err);
+}
+#else
+#define ca9x4_twd_init	NULL
+#endif
+
 static void __init ct_ca9x4_init_early(void)
 {
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+	late_time_init = ca9x4_twd_init;
 }
 
 static void __init ct_ca9x4_init(void)
-- 
1.7.0.4
