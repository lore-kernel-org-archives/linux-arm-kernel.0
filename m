From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Jan 2011 17:32:00 -0600
Subject: [PATCH 4/7] ARM: vexpress: init clocks early and add sp804 clock
In-Reply-To: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
References: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
Message-ID: <1294875123-14086-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move clock initialization to mdesc->init_early and add a clock for
sp804 timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-vexpress/core.h     |    1 +
 arch/arm/mach-vexpress/ct-ca9x4.c |   13 +++++++++----
 arch/arm/mach-vexpress/v2m.c      |   14 ++++++++++++--
 3 files changed, 22 insertions(+), 6 deletions(-)

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
index e628402..db4614c 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -71,8 +71,8 @@ static void __init ct_ca9x4_timer_init(void)
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1));
-	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0);
+	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), NULL);
+	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0, NULL);
 }
 
 static struct sys_timer ct_ca9x4_timer = {
@@ -190,6 +190,12 @@ static struct clk_lookup lookups[] = {
 	},
 };
 
+static void __init ct_ca9x4_init_early(void)
+{
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+	v2m_init_early();
+}
+
 static struct resource pmu_resources[] = {
 	[0] = {
 		.start	= IRQ_CT_CA9X4_PMU_CPU0,
@@ -234,8 +240,6 @@ static void __init ct_ca9x4_init(void)
 	l2x0_init(l2x0_base, 0x00400000, 0xfe0fffff);
 #endif
 
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
 	for (i = 0; i < ARRAY_SIZE(ct_ca9x4_amba_devs); i++)
 		amba_device_register(ct_ca9x4_amba_devs[i], &iomem_resource);
 
@@ -245,6 +249,7 @@ static void __init ct_ca9x4_init(void)
 MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.map_io		= ct_ca9x4_map_io,
+	.init_early	= ct_ca9x4_init_early,
 	.init_irq	= ct_ca9x4_init_irq,
 #if 0
 	.timer		= &ct_ca9x4_timer,
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index a9ed342..e371d99 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -300,6 +300,10 @@ static struct clk osc2_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk sp804_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk dummy_apb_pclk;
 
 static struct clk_lookup v2m_lookups[] = {
@@ -330,9 +334,17 @@ static struct clk_lookup v2m_lookups[] = {
 	}, {	/* CLCD */
 		.dev_id		= "mb:clcd",
 		.clk		= &osc1_clk,
+	}, {	/* SP804 Timer */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
 	},
 };
 
+void __init v2m_init_early(void)
+{
+	clkdev_add_table(v2m_lookups, ARRAY_SIZE(v2m_lookups));
+}
+
 static void v2m_power_off(void)
 {
 	if (v2m_cfg_write(SYS_CFG_SHUTDOWN | SYS_CFG_SITE_MB, 0))
@@ -349,8 +361,6 @@ static int __init v2m_init(void)
 {
 	int i;
 
-	clkdev_add_table(v2m_lookups, ARRAY_SIZE(v2m_lookups));
-
 	platform_device_register(&v2m_pcie_i2c_device);
 	platform_device_register(&v2m_ddc_i2c_device);
 	platform_device_register(&v2m_flash_device);
-- 
1.7.1
