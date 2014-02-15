From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 15 Feb 2014 04:30:20 +0300
Subject: [PATCH 3/5] ARM: shmobile: Lager: set proper DMA masks for Ether
 device
In-Reply-To: <201402150424.30954.sergei.shtylyov@cogentembedded.com>
References: <201402150424.30954.sergei.shtylyov@cogentembedded.com>
Message-ID: <201402150430.20874.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
ability.

Currently, the code works without DMA masks but as we would have to enable
CONFIG_HIGHMEM to access the full board memory in the future, when support for
NETIF_F_SG would be added to the 'sh_eth' driver as well, the correct DMA masks
should start to matter...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-lager.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

Index: renesas/arch/arm/mach-shmobile/board-lager.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-lager.c
+++ renesas/arch/arm/mach-shmobile/board-lager.c
@@ -1,8 +1,9 @@
 /*
  * Lager board support
  *
- * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013-2014  Renesas Solutions Corp.
  * Copyright (C) 2013  Magnus Damm
+ * Copyright (C) 2014  Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -275,6 +276,17 @@ static const struct resource ether_resou
 	DEFINE_RES_IRQ(gic_spi(162)),
 };
 
+static const struct platform_device_info ether_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "r8a7790-ether",
+	.id		= -1,
+	.res		= ether_resources,
+	.num_res	= ARRAY_SIZE(ether_resources),
+	.data		= &ether_pdata,
+	.size_data	= sizeof(ether_pdata),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 /* SPI Flash memory (Spansion S25FL512SAGMFIG11 64Mb) */
 static struct mtd_partition spi_flash_part[] = {
 	/* Reserved for user loader program, read-only */
@@ -743,10 +755,7 @@ static void __init lager_add_standard_de
 					  mmcif1_resources, ARRAY_SIZE(mmcif1_resources),
 					  &mmcif1_pdata, sizeof(mmcif1_pdata));
 
-	platform_device_register_resndata(&platform_bus, "r8a7790-ether", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  &ether_pdata, sizeof(ether_pdata));
+	platform_device_register_full(&ether_info);
 
 	lager_add_du_device();
 
