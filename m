From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 15 Feb 2014 04:37:32 +0300
Subject: [PATCH 5/5] ARM: shmobile: Genmai: set proper DMA masks for Ether
 device
In-Reply-To: <201402150424.30954.sergei.shtylyov@cogentembedded.com>
References: <201402150424.30954.sergei.shtylyov@cogentembedded.com>
Message-ID: <201402150437.32973.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
ability.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-genmai.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

Index: renesas/arch/arm/mach-shmobile/board-genmai.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-genmai.c
+++ renesas/arch/arm/mach-shmobile/board-genmai.c
@@ -1,8 +1,9 @@
 /*
  * Genmai board support
  *
- * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013-2014  Renesas Solutions Corp.
  * Copyright (C) 2013  Magnus Damm
+ * Copyright (C) 2014  Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -43,6 +44,17 @@ static const struct resource ether_resou
 	DEFINE_RES_IRQ(gic_iid(359)),
 };
 
+static const struct platform_device_info ether_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "r7s72100-ether",
+	.id		= -1,
+	.res		= ether_resources,
+	.num_res	= ARRAY_SIZE(ether_resources),
+	.data		= &ether_pdata,
+	.size_data	= sizeof(ether_pdata),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 /* RSPI */
 #define RSPI_RESOURCE(idx, baseaddr, irq)				\
 static const struct resource rspi##idx##_resources[] __initconst = {	\
@@ -82,10 +94,7 @@ static void __init genmai_add_standard_d
 	r7s72100_clock_init();
 	r7s72100_add_dt_devices();
 
-	platform_device_register_resndata(&platform_bus, "r7s72100-ether", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  &ether_pdata, sizeof(ether_pdata));
+	platform_device_register_full(&ether_info);
 
 	r7s72100_register_rspi(0);
 	r7s72100_register_rspi(1);
