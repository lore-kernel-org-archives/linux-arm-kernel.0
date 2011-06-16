From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:32 +0100
Subject: [RFC PATCH 04/16] ARM: local timers: move vexpress to
	LOCAL_TIMER_DEVICES/ARM_SMP_TWD
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the vexpress platform (actually the CA9x4 tile) to use
the new arm_smp_twd driver. Add the platform device and register
it as early platform device.

Tested on a VExpress.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-vexpress/Kconfig    |    2 ++
 arch/arm/mach-vexpress/ct-ca9x4.c |   30 ++++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 6f59932..c26a5ec 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -28,6 +28,8 @@ config ARCH_VEXPRESS_CA9X4
 	depends on VEXPRESS_ORIGINAL_MEMORY_MAP
 	select CPU_V7
 	select ARM_GIC
+	select LOCAL_TIMER_DEVICES
+	select ARM_SMP_TWD
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index b06d056..4977e09 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -15,7 +15,6 @@
 #include <asm/hardware/gic.h>
 #include <asm/pmu.h>
 #include <asm/smp_scu.h>
-#include <asm/smp_twd.h>
 
 #include <mach/ct-ca9x4.h>
 
@@ -49,11 +48,32 @@ static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 	},
 };
 
+static struct resource ct_ca9x4_twd_resources[] = {
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
+static struct platform_device ct_ca9x4_twd_device = {
+	.name		= "arm_smp_twd",
+	.id		= -1,
+	.resource	= ct_ca9x4_twd_resources,
+	.num_resources	= ARRAY_SIZE(ct_ca9x4_twd_resources),
+};
+
+static struct platform_device *ct_ca9x4_early_devices[] = {
+	&ct_ca9x4_twd_device,
+};
+
 static void __init ct_ca9x4_map_io(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = MMIO_P2V(A9_MPCORE_TWD);
-#endif
 	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
@@ -192,6 +212,8 @@ static struct platform_device pmu_device = {
 static void __init ct_ca9x4_init_early(void)
 {
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+	early_platform_add_devices(ct_ca9x4_early_devices,
+				   ARRAY_SIZE(ct_ca9x4_early_devices));
 }
 
 static void __init ct_ca9x4_init(void)
-- 
1.7.0.4
