From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:47:07 +0000
Subject: [PATCH 04/11] ARM: vexpress: use new init_early for clock tree and
	sched_clock init
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSBn-0003p5-8C@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the clock tree and our sched_clock() early.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-vexpress/core.h     |    1 +
 arch/arm/mach-vexpress/ct-ca9x4.c |   10 ++++++++--
 arch/arm/mach-vexpress/v2m.c      |    6 ++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index 362780d..e0312a1 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -21,4 +21,5 @@ struct amba_device name##_device = {		\
 struct map_desc;
 
 void v2m_map_io(struct map_desc *tile, size_t num);
+void v2m_init_early(void);
 extern struct sys_timer v2m_timer;
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 27baed1..ff48ebc 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -180,6 +180,13 @@ static struct platform_device pmu_device = {
 	.resource	= pmu_resources,
 };
 
+static void __init ct_ca9x4_init_early(void)
+{
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	v2m_init_early();
+}
+
 static void __init ct_ca9x4_init(void)
 {
 	int i;
@@ -194,8 +201,6 @@ static void __init ct_ca9x4_init(void)
 	l2x0_init(l2x0_base, 0x00400000, 0xfe0fffff);
 #endif
 
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
 	for (i = 0; i < ARRAY_SIZE(ct_ca9x4_amba_devs); i++)
 		amba_device_register(ct_ca9x4_amba_devs[i], &iomem_resource);
 
@@ -206,6 +211,7 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.map_io		= ct_ca9x4_map_io,
 	.init_irq	= ct_ca9x4_init_irq,
+	.init_early	= ct_ca9x4_init_early,
 #if 0
 	.timer		= &ct_ca9x4_timer,
 #else
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index f35d646..63ef663 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -49,13 +49,15 @@ void __init v2m_map_io(struct map_desc *tile, size_t num)
 	iotable_init(tile, num);
 }
 
+void __init v2m_init_early(void)
+{
+	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
+}
 
 static void __init v2m_timer_init(void)
 {
 	u32 scctrl;
 
-	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
-
 	/* Select 1MHz TIMCLK as the reference clock for SP804 timers */
 	scctrl = readl(MMIO_P2V(V2M_SYSCTL + SCCTRL));
 	scctrl |= SCCTRL_TIMEREN0SEL_TIMCLK;
-- 
1.6.2.5
