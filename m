From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 17 Feb 2013 01:43:35 +0300
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: add SATA support
Message-ID: <201302170143.36052.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add SATA clock and platform device resources on r8a7779 SoC.
Add entry to r8a7779_auxdata_lookup[], so that devm_clk_get() in the driver
still works when we're using the device tree.
 
Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/clock-r8a7779.c |    3 +++
 arch/arm/mach-shmobile/setup-r8a7779.c |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -87,6 +87,7 @@ static struct clk div4_clks[DIV4_NR] = {
 };
 
 enum { MSTP323, MSTP322, MSTP321, MSTP320,
+	MSTP115,
 	MSTP101, MSTP100,
 	MSTP030,
 	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
@@ -99,6 +100,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP322] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 20, 0), /* SDHI3 */
+	[MSTP115] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 15, 0), /* SATA */
 	[MSTP101] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  1, 0), /* USB2 */
 	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  0, 0), /* USB0/1 */
 	[MSTP030] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 30, 0), /* I2C0 */
@@ -156,6 +158,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("peripheral_clk",	&div4_clks[DIV4_P]),
 
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), /* SATA */
 	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
 	CLKDEV_DEV_ID("ohci-platform.1", &mstp_clks[MSTP101]), /* USB OHCI port2 */
 	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -322,6 +322,26 @@ static struct platform_device i2c3_devic
 	.num_resources	= ARRAY_SIZE(rcar_i2c3_res),
 };
 
+static struct resource sata_resources[] = {
+	[0] = {
+		.name	= "rcar-sata",
+		.start	= 0xfc600000,
+		.end	= 0xfc601fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(100),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sata_device = {
+	.name		= "sata_rcar",
+	.id		= -1,
+	.resource	= sata_resources,
+	.num_resources	= ARRAY_SIZE(sata_resources),
+};
+
 static struct platform_device *r8a7779_early_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -338,6 +358,7 @@ static struct platform_device *r8a7779_e
 	&i2c1_device,
 	&i2c2_device,
 	&i2c3_device,
+	&sata_device,
 };
 
 void __init r8a7779_add_standard_devices(void)
@@ -404,6 +425,7 @@ void __init r8a7779_add_early_devices_dt
 }
 
 static const struct of_dev_auxdata r8a7779_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("renesas,rcar-sata", 0xfc600000, "sata_rcar", NULL),
 	{},
 };
 
