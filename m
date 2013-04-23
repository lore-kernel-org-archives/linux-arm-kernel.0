From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 23 Apr 2013 20:15:59 +0400
Subject: [PATCH v3 1/1] ARM: shmobile: r8a7778: add I2C support
In-Reply-To: <201304232012.57619.sergei.shtylyov@cogentembedded.com>
References: <201304232012.57619.sergei.shtylyov@cogentembedded.com>
Message-ID: <201304232015.59697.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add I2C clocks and platform devices for R8A7778 SoC.
Don't forget to also add the peripheral clock which the I2C driver uses.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
[Sergei: changed the registration function to platform_device_register_simple(),
annotated I2C resources as '__initdata', regrouped MSTPxxx *enum* members, added
the copyright.]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

---
Changes since version 2:
- annotated I2C resources as '__initdata' since they're kmemdup()'ed while
  registering the platform devices anyway;
- refreshed the patch.

Changes since the original posting:
- regrouped MSTPxxx *enum* members;
- resolved reject in the 'clock-r8a7778.c' file, refreshed the patch;
- added an ACK from Kuninori Morimoto.

 arch/arm/mach-shmobile/clock-r8a7778.c |   14 +++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7778.c |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2013  Renesas Solutions Corp.
  * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ * Copyright (C) 2013  Cogent Embedded, Inc.
  *
  * based on r8a7779
  *
@@ -106,7 +107,8 @@ enum {
 	MSTP323, MSTP322, MSTP321,
 	MSTP114,
 	MSTP100,
-	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
+	MSTP030, MSTP029,
+	MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015,
 	MSTP_NR };
 
@@ -116,6 +118,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP321] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP114] = SH_CLK_MSTP32(&p_clk, MSTPCR1, 14, 0), /* Ether */
 	[MSTP100] = SH_CLK_MSTP32(&p_clk, MSTPCR1,  0, 0), /* USB0/1 */
+	[MSTP030] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 30, 0), /* I2C0 */
+	[MSTP029] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 29, 0), /* I2C1 */
+	[MSTP028] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 28, 0), /* I2C2 */
+	[MSTP027] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 27, 0), /* I2C3 */
 	[MSTP026] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 26, 0), /* SCIF0 */
 	[MSTP025] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 25, 0), /* SCIF1 */
 	[MSTP024] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 24, 0), /* SCIF2 */
@@ -127,6 +133,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 };
 
 static struct clk_lookup lookups[] = {
+	CLKDEV_CON_ID("peripheral_clk", &p_clk),
+
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
@@ -134,6 +142,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-eth",	&mstp_clks[MSTP114]), /* Ether */
 	CLKDEV_DEV_ID("ehci-platform", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
 	CLKDEV_DEV_ID("ohci-platform", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
+	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
+	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
+	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP028]), /* I2C2 */
+	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP027]), /* I2C3 */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP024]), /* SCIF2 */
Index: renesas/arch/arm/mach-shmobile/setup-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -95,6 +95,33 @@ static struct sh_timer_config sh_tmu1_pl
 		&sh_tmu##idx##_platform_data,		\
 		sizeof(sh_tmu##idx##_platform_data))
 
+/* I2C */
+static struct resource i2c0_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffc70000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x63)),
+};
+
+static struct resource i2c1_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffc71000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6e)),
+};
+
+static struct resource i2c2_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffc72000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6c)),
+};
+
+static struct resource i2c3_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffc73000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6d)),
+};
+
+#define r8a7778_register_i2c(idx)			\
+	platform_device_register_simple(		\
+		"i2c-rcar", idx,			\
+		i2c##idx##_resources,			\
+		ARRAY_SIZE(i2c##idx##_resources))
+
 /* USB PHY */
 static struct resource usb_phy_resources[] __initdata = {
 	DEFINE_RES_MEM(0xffe70800, 0x100),
@@ -294,6 +321,11 @@ void __init r8a7778_add_standard_devices
 
 	r8a7778_register_tmu(0);
 	r8a7778_register_tmu(1);
+
+	r8a7778_register_i2c(0);
+	r8a7778_register_i2c(1);
+	r8a7778_register_i2c(2);
+	r8a7778_register_i2c(3);
 }
 
 void __init r8a7778_init_late(void)
