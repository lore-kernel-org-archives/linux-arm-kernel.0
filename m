From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:24 +0900
Subject: [PATCH 12/16] ARM: shmobile: Koelsch: set proper DMA masks for Ether
 device
In-Reply-To: <cover.1392960310.git.horms+renesas@verge.net.au>
References: <cover.1392960310.git.horms+renesas@verge.net.au>
Message-ID: <379bfd7134bccccf58962b39e504bd639a5e75b2.1392960310.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
ability.

Currently, the code works without DMA masks but as we would have to enable
CONFIG_HIGHMEM to access the full board memory in the future, when support for
NETIF_F_SG would be added to the 'sh_eth' driver as well, the correct DMA masks
should start to matter...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 893d47c..5a034ff 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -2,8 +2,9 @@
  * Koelsch board support
  *
  * Copyright (C) 2013  Renesas Electronics Corporation
- * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013-2014  Renesas Solutions Corp.
  * Copyright (C) 2013  Magnus Damm
+ * Copyright (C) 2014  Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -116,6 +117,17 @@ static const struct resource ether_resources[] __initconst = {
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
@@ -426,10 +438,7 @@ static void __init koelsch_add_standard_devices(void)
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
-- 
1.8.5.2
