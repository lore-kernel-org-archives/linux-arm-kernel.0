From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 12 Feb 2014 02:55:24 +0300
Subject: [PATCH] ARM: shmobile: set proper DMA masks for Ether devices
Message-ID: <201402120255.25037.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
ability.  Currently, the code works without DMA masks but in the future, when
support for NETIF_F_HIGHDMA & NETIF_F_SG would be added to the 'sh_eth' driver,
the DMA masks should start to matter...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against 'renesas-devel-v3.14-rc1-20140207' tag in Simon Horman's
'renesas.git' repo... 

 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
 arch/arm/mach-shmobile/board-bockw.c           |   21 ++++++++++++++-------
 arch/arm/mach-shmobile/board-genmai.c          |   19 ++++++++++++++-----
 arch/arm/mach-shmobile/board-koelsch.c         |   16 ++++++++++++----
 arch/arm/mach-shmobile/board-lager.c           |   19 ++++++++++++++-----
 5 files changed, 56 insertions(+), 21 deletions(-)

Index: renesas/arch/arm/mach-shmobile/board-armadillo800eva.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ renesas/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -383,6 +383,8 @@ static struct platform_device sh_eth_dev
 	.id = -1,
 	.dev = {
 		.platform_data = &sh_eth_platdata,
+		.dma_mask = &sh_eth_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource = sh_eth_resources,
 	.num_resources = ARRAY_SIZE(sh_eth_resources),
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
Index: renesas/arch/arm/mach-shmobile/board-koelsch.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
+++ renesas/arch/arm/mach-shmobile/board-koelsch.c
@@ -109,6 +109,17 @@ static const struct resource ether_resou
 	DEFINE_RES_IRQ(gic_spi(162)),
 };
 
+static const struct platform_device_info ether_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "r8a7791-ether",
+	.id		= -1,
+	.res		= ether_resources,
+	.num_res	= ARRAY_SIZE(ether_resources),
+	.data		= &ether_pdata,
+	.size_data	= sizeof(ether_pdata),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 /* LEDS */
 static struct gpio_led koelsch_leds[] = {
 	{
@@ -297,10 +308,7 @@ static void __init koelsch_add_standard_
 				  ARRAY_SIZE(koelsch_pinctrl_map));
 	r8a7791_pinmux_init();
 	r8a7791_add_standard_devices();
-	platform_device_register_resndata(&platform_bus, "r8a7791-ether", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  &ether_pdata, sizeof(ether_pdata));
+	platform_device_register_full(&ether_info);
 	platform_device_register_data(&platform_bus, "leds-gpio", -1,
 				      &koelsch_leds_pdata,
 				      sizeof(koelsch_leds_pdata));
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
@@ -260,6 +261,17 @@ static const struct resource ether_resou
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
@@ -681,10 +693,7 @@ static void __init lager_add_standard_de
 					  mmcif1_resources, ARRAY_SIZE(mmcif1_resources),
 					  &mmcif1_pdata, sizeof(mmcif1_pdata));
 
-	platform_device_register_resndata(&platform_bus, "r8a7790-ether", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  &ether_pdata, sizeof(ether_pdata));
+	platform_device_register_full(&ether_info);
 
 	lager_add_du_device();
 
