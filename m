From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 2 Apr 2013 02:06:51 +0400
Subject: [PATCH 2/2] ARM: shmobile: R8A7778: add Ether support
Message-ID: <201304020206.52313.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ether clock and platform device for R8A7778 SoC; add a function to register
this device with board-specific platform data.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is atop of the 'next' branch of Simon Horman's renesas.git.

 arch/arm/mach-shmobile/clock-r8a7778.c        |    3 +++
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   21 +++++++++++++++++++++
 3 files changed, 25 insertions(+)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -58,11 +58,13 @@ static struct clk *main_clks[] = {
 };
 
 enum {
+	MSTP114,
 	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015,
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP114] = SH_CLK_MSTP32(&clkp, MSTPCR1, 14, 0), /* Ether */
 	[MSTP026] = SH_CLK_MSTP32(&clkp, MSTPCR0, 26, 0), /* SCIF0 */
 	[MSTP025] = SH_CLK_MSTP32(&clkp, MSTPCR0, 25, 0), /* SCIF1 */
 	[MSTP024] = SH_CLK_MSTP32(&clkp, MSTPCR0, 24, 0), /* SCIF2 */
@@ -75,6 +77,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 static struct clk_lookup lookups[] = {
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh-eth",	&mstp_clks[MSTP114]), /* Ether */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP024]), /* SCIF2 */
Index: renesas/arch/arm/mach-shmobile/include/mach/r8a7778.h
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ renesas/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -20,6 +20,7 @@
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
+extern void r8a7778_add_ether_device(void *pdata);
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
Index: renesas/arch/arm/mach-shmobile/setup-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2013  Renesas Solutions Corp.
  * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ * Copyright (C) 2013  Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,6 +79,19 @@ static struct sh_timer_config sh_tmu1_pl
 	.clocksource_rating	= 200,
 };
 
+/* Ether */
+static struct resource ether_resources[] = {
+	DEFINE_RES_MEM(0xfde00000, 0x400),
+	DEFINE_RES_IRQ(gic_iid(0x89)),
+};
+
+static struct platform_device ether_device = {
+	.name		= "sh-eth",
+	.id		= -1,
+	.resource	= ether_resources,
+	.num_resources	= ARRAY_SIZE(ether_resources),
+};
+
 #define PLATFORM_INFO(n, i)					\
 {								\
 	.parent		= &platform_bus,			\
@@ -118,6 +132,13 @@ void __init r8a7778_add_standard_devices
 		platform_device_register_full(&platform_devinfo[i]);
 }
 
+void __init r8a7778_add_ether_device(void *pdata)
+{
+	ether_device.dev.platform_data = pdata;
+
+	platform_device_register(&ether_device);
+}
+
 #define INT2SMSKCR0	0x82288 /* 0xfe782288 */
 #define INT2SMSKCR1	0x8228c /* 0xfe78228c */
 
