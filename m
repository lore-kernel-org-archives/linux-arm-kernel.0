From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 2 Apr 2013 02:04:54 +0400
Subject: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
Message-ID: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ether clock and platform device for R8A7779 SoC; add a function to register
this device with board-specific platform data.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is atop of the 'next' branch of Simon Horman's renesas.git.

 arch/arm/mach-shmobile/clock-r8a7779.c        |    4 ++-
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    1 
 arch/arm/mach-shmobile/setup-r8a7779.c        |   29 +++++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -93,7 +93,7 @@ static struct clk *main_clks[] = {
 };
 
 enum { MSTP323, MSTP322, MSTP321, MSTP320,
-	MSTP115,
+	MSTP115, MSTP114,
 	MSTP103, MSTP101, MSTP100,
 	MSTP030,
 	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
@@ -107,6 +107,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP321] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP320] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 20, 0), /* SDHI3 */
 	[MSTP115] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1, 15, 0), /* SATA */
+	[MSTP114] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1, 14, 0), /* Ether */
 	[MSTP103] = SH_CLK_MSTP32(&clks_clk, MSTPCR1,  3, 0), /* DU */
 	[MSTP101] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1,  1, 0), /* USB2 */
 	[MSTP100] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1,  0, 0), /* USB0/1 */
@@ -143,6 +144,7 @@ static struct clk_lookup lookups[] = {
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), /* SATA */
 	CLKDEV_DEV_ID("fc600000.sata", &mstp_clks[MSTP115]), /* SATA w/DT */
+	CLKDEV_DEV_ID("sh-eth", &mstp_clks[MSTP114]), /* Ether */
 	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
 	CLKDEV_DEV_ID("ohci-platform.1", &mstp_clks[MSTP101]), /* USB OHCI port2 */
 	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
Index: renesas/arch/arm/mach-shmobile/include/mach/r8a7779.h
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ renesas/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -31,6 +31,7 @@ extern void r8a7779_earlytimer_init(void
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
+extern void r8a7779_add_ether_device(void *pdata);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -1,8 +1,9 @@
 /*
  * r8a7779 processor support
  *
- * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011, 2013  Renesas Solutions Corp.
  * Copyright (C) 2011  Magnus Damm
+ * Copyright (C) 2013  Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -369,6 +370,25 @@ static struct platform_device i2c3_devic
 	.num_resources	= ARRAY_SIZE(rcar_i2c3_res),
 };
 
+/* Ether */
+static struct resource ether_resources[] = {
+	{
+		.start	= 0xfde00000,
+		.end	= 0xfde003ff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= gic_iid(0xb4),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ether_device = {
+	.name		= "sh-eth",
+	.id		= -1,
+	.resource	= ether_resources,
+	.num_resources	= ARRAY_SIZE(ether_resources),
+};
+
 static struct resource sata_resources[] = {
 	[0] = {
 		.name	= "rcar-sata",
@@ -428,6 +448,13 @@ void __init r8a7779_add_standard_devices
 			    ARRAY_SIZE(r8a7779_late_devices));
 }
 
+void __init r8a7779_add_ether_device(void *pdata)
+{
+	ether_device.dev.platform_data = pdata;
+
+	platform_device_register(&ether_device);
+}
+
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak r8a7779_register_twd(void) { }
 
