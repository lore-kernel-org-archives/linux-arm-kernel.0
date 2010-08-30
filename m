From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:05 +0530
Subject: [PATCH 41/74] ST SPEAr : Adding CAN platform support for SPEAr320 and
	SPEAr1310
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <6e2d66a6206d4f6ec61da685daa359720060d55e.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bhupesh Sharma <bhupesh.sharma@st.com>

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/clock.c                |   32 ++++++++++++++++++++
 arch/arm/mach-spear13xx/include/mach/generic.h |   21 +++++++++++--
 arch/arm/mach-spear13xx/spear1310.c            |   37 ++++++++++++++++++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c        |    6 ++++
 arch/arm/mach-spear3xx/clock.c                 |   16 ++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    2 +
 arch/arm/mach-spear3xx/spear320.c              |   37 ++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c          |    2 +
 8 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 98ba04e..1ee820a 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -803,6 +803,28 @@ static struct clk kbd_clk = {
 	.recalc = &follow_parent,
 };
 
+/* spear1300 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1300
+
+#endif
+
+/* spear1310 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1310
+/* can0 clock */
+static struct clk can0_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* can1 clock */
+static struct clk can1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+#endif
+
 /* array of all spear 13xx clock lookups */
 static struct clk_lookup spear_clk_lookups[] = {
 	/* root clks */
@@ -876,6 +898,16 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{.dev_id = "gpio1",		.clk = &gpio1_clk},
 	{.dev_id = "keyboard",		.clk = &kbd_clk},
 	{.dev_id = "wdt",		.clk = &wdt_clk},
+
+	/* spear1300 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1300
+#endif
+
+	/* spear1310 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1310
+	{.dev_id = "spear_can.0",	.clk = &can0_clk},
+	{.dev_id = "spear_can.1",	.clk = &can1_clk},
+#endif
 };
 
 void __init clk_init(void)
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 18800b0..62d3d9b 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -45,17 +45,32 @@ extern struct platform_device sdhci_device;
 extern struct platform_device smi_device;
 extern struct sys_timer spear13xx_timer;
 
-/* Add spear1300 machine device structure declarations here */
-
 /* Add spear13xx family function declarations here */
 void __init clk_init(void);
 void __init i2c_register_board_devices(void);
 void __init spear_setup_timer(void);
-void __init spear1300_init(void);
 void __init spear13xx_map_io(void);
 void __init spear13xx_init_irq(void);
 void __init spear13xx_init(void);
 void __init nand_mach_init(u32 busw);
 void spear13xx_secondary_startup(void);
 
+/* spear1300 declarations */
+#ifdef CONFIG_MACH_SPEAR1300
+/* Add spear1300 machine function declarations here */
+void __init spear1300_init(void);
+
+#endif /* CONFIG_MACH_SPEAR1300 */
+
+/* spear1310 declarations */
+#ifdef CONFIG_MACH_SPEAR1310
+/* Add spear1310 machine device structure declarations here */
+extern struct platform_device can0_device;
+extern struct platform_device can1_device;
+
+/* Add spear1310 machine function declarations here */
+void __init spear1310_init(void);
+
+#endif /* CONFIG_MACH_SPEAR1310 */
+
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index c3953a9..906ede9 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -18,6 +18,43 @@
 
 /* Add spear1310 specific devices here */
 
+/* CAN device registeration */
+static struct resource can0_resources[] = {
+	{
+		.start = SPEAR1310_CAN0_BASE,
+		.end = SPEAR1310_CAN0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_CCAN0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device can0_device = {
+	.name = "spear_can",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(can0_resources),
+	.resource = can0_resources,
+};
+
+static struct resource can1_resources[] = {
+	{
+		.start = SPEAR1310_CAN1_BASE,
+		.end = SPEAR1310_CAN1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_CCAN1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device can1_device = {
+	.name = "spear_can",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(can1_resources),
+	.resource = can1_resources,
+};
+
 void __init spear1310_init(void)
 {
 	/* call spear13xx family common init function */
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index 7591d89..8b02104 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -27,6 +27,7 @@
 #include <plat/spi.h>
 
 static struct amba_device *amba_devs[] __initdata = {
+	/* spear13xx specific devices */
 	&gpio_device[0],
 	&gpio_device[1],
 	&ssp_device,
@@ -34,6 +35,7 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	/* spear13xx specific devices */
 	&ehci0_device,
 	&ehci1_device,
 	&i2c_device,
@@ -45,6 +47,10 @@ static struct platform_device *plat_devs[] __initdata = {
 	&sdhci_device,
 	&smi_device,
 	&pcie_gadget0_device,
+
+	/* spear1310 specific devices */
+	&can0_device,
+	&can1_device,
 };
 
 /* keyboard specific platform data */
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 2b5d7e1..96a51cc 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -596,6 +596,20 @@ static struct clk uart5_clk = {
 
 /* spear320 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR320
+/* can0 clock */
+static struct clk can0_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* can1 clock */
+static struct clk can1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
 /* i2c1 clock */
 static struct clk i2c1_clk = {
 	.flags = ALWAYS_ENABLED,
@@ -697,6 +711,8 @@ static struct clk_lookup spear_clk_lookups[] = {
 #endif
 	/* spear320 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR320
+	{ .dev_id = "spear_can.0",	.clk = &can0_clk},
+	{ .dev_id = "spear_can.1",	.clk = &can1_clk},
 	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
 	{ .dev_id = "ssp-pl022.1",	.clk = &ssp1_clk},
 	{ .dev_id = "ssp-pl022.2",	.clk = &ssp2_clk},
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 2fc36a8..75c1eef 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -190,6 +190,8 @@ extern struct amba_device clcd_device;
 extern struct amba_device ssp_device[];
 extern struct amba_device uart1_device;
 extern struct amba_device uart2_device;
+extern struct platform_device can0_device;
+extern struct platform_device can1_device;
 extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 3fbb1f6..0c2f4a5 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -480,6 +480,43 @@ static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_count = SPEAR_PLGPIO_COUNT,
 };
 
+/* CAN device registeration */
+static struct resource can0_resources[] = {
+	{
+		.start = SPEAR320_CAN0_BASE,
+		.end = SPEAR320_CAN0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = VIRQ_CANU,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device can0_device = {
+	.name = "spear_can",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(can0_resources),
+	.resource = can0_resources,
+};
+
+static struct resource can1_resources[] = {
+	{
+		.start = SPEAR320_CAN1_BASE,
+		.end = SPEAR320_CAN1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = VIRQ_CANL,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device can1_device = {
+	.name = "spear_can",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(can1_resources),
+	.resource = can1_resources,
+};
+
 /* i2c1 device registeration */
 static struct resource i2c1_resources[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 261c0b0..d55e1b2 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -66,6 +66,8 @@ static struct platform_device *plat_devs[] __initdata = {
 	&smi_device,
 
 	/* spear320 specific devices */
+	&can0_device,
+	&can1_device,
 	&i2c1_device,
 	&plgpio_device,
 	&pwm_device,
-- 
1.7.2.2
