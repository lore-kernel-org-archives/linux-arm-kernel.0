From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 15 Feb 2014 04:28:43 +0300
Subject: [PATCH 2/5] ARM: shmobile: BOCK-W: set proper DMA masks for Ether
 device
In-Reply-To: <201402150424.30954.sergei.shtylyov@cogentembedded.com>
References: <201402150424.30954.sergei.shtylyov@cogentembedded.com>
Message-ID: <201402150428.44268.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
ability.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-bockw.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -1,9 +1,9 @@
 /*
  * Bock-W board support
  *
- * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013-2014  Renesas Solutions Corp.
  * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- * Copyright (C) 2013  Cogent Embedded, Inc.
+ * Copyright (C) 2013-2014  Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -235,6 +235,17 @@ static struct sh_eth_plat_data ether_pla
 	.no_ether_link	= 1,
 };
 
+static struct platform_device_info ether_info __initdata = {
+	.parent		= &platform_bus,
+	.name		= "r8a777x-ether",
+	.id		= -1,
+	.res		= ether_resources,
+	.num_res	= ARRAY_SIZE(ether_resources),
+	.data		= &ether_platform_data,
+	.size_data	= sizeof(ether_platform_data),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 /* I2C */
 static struct i2c_board_info i2c0_devices[] = {
 	{
@@ -592,11 +603,7 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 
-	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  &ether_platform_data,
-					  sizeof(ether_platform_data));
+	platform_device_register_full(&ether_info);
 
 	platform_device_register_full(&vin0_info);
 	/* VIN1 has a pin conflict with Ether */
