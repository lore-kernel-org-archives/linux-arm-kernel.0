From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 4 Apr 2013 22:55:46 +0400
Subject: [PATCH v2 2/2] ARM: shmobile: R8A7778: add Ether support
Message-ID: <201304042255.46986.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ether clock and platform device for R8A7778 SoC; add a function to register
this device with board-specific platform data.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is atop of the 'renesas-next-20130404v2' tag of Simon Horman's
'renesas.git'.

Changes since original posting:
- use 'struct sh_eth_plat_data *' as an argument to r8a7778_add_ether_device();
- use platform_device_register_resndata() in r8a7778_add_ether_device().

 arch/arm/mach-shmobile/clock-r8a7778.c        |    3 +++
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    3 +++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   15 +++++++++++++++
 3 files changed, 21 insertions(+)

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
@@ -18,8 +18,11 @@
 #ifndef __ASM_R8A7778_H__
 #define __ASM_R8A7778_H__
 
+#include <linux/sh_eth.h>
+
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
+extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
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
@@ -79,6 +80,12 @@ static struct sh_timer_config sh_tmu1_pl
 	.clocksource_rating	= 200,
 };
 
+/* Ether */
+static struct resource ether_resources[] = {
+	DEFINE_RES_MEM(0xfde00000, 0x400),
+	DEFINE_RES_IRQ(gic_iid(0x89)),
+};
+
 #define r8a7778_register_tmu(idx)			\
 	platform_device_register_resndata(		\
 		&platform_bus, "sh_tmu", idx,		\
@@ -111,6 +118,14 @@ void __init r8a7778_add_standard_devices
 	r8a7778_register_tmu(1);
 }
 
+void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
+{
+	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  pdata, sizeof(*pdata));
+}
+
 static struct renesas_intc_irqpin_config irqpin_platform_data = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
 	.sense_bitfield_width = 2,
