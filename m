From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:43 +0100
Subject: [PATCH 05/30] arm: plat-orion: convert the registration of the xor0
 engine to the single driver
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of registering one 'mv_xor_shared' device for the XOR engine,
and then two 'mv_xor' devices for the XOR channels, pass the channels
properties as platform_data for the main 'mv_xor_shared' device.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/common.c |   94 +++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 52 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index b8a688c..800af19 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -636,61 +636,43 @@ static struct resource orion_xor0_shared_resources[] = {
 	}, {
 		.name	= "xor 0 high",
 		.flags	= IORESOURCE_MEM,
+	}, {
+		.name   = "irq channel 0",
+		.flags  = IORESOURCE_IRQ,
+	}, {
+		.name   = "irq channel 1",
+		.flags  = IORESOURCE_IRQ,
 	},
 };
 
-static struct platform_device orion_xor0_shared = {
-	.name		= MV_XOR_SHARED_NAME,
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(orion_xor0_shared_resources),
-	.resource	= orion_xor0_shared_resources,
-};
-
-static struct resource orion_xor00_resources[] = {
-	[0] = {
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct mv_xor_platform_data orion_xor00_data = {
-	.shared		= &orion_xor0_shared,
-	.hw_id		= 0,
-	.pool_size	= PAGE_SIZE,
-};
+static struct platform_device orion_xor0_shared;
 
-static struct platform_device orion_xor00_channel = {
-	.name		= MV_XOR_NAME,
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(orion_xor00_resources),
-	.resource	= orion_xor00_resources,
-	.dev		= {
-		.dma_mask		= &orion_xor_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= &orion_xor00_data,
+static struct mv_xor_platform_data orion_xor0_channels_pdata[2] = {
+	{
+		.shared		= &orion_xor0_shared,
+		.hw_id		= 0,
+		.pool_size	= PAGE_SIZE,
 	},
-};
-
-static struct resource orion_xor01_resources[] = {
-	[0] = {
-		.flags	= IORESOURCE_IRQ,
+	{
+		.shared		= &orion_xor0_shared,
+		.hw_id		= 1,
+		.pool_size	= PAGE_SIZE,
 	},
 };
 
-static struct mv_xor_platform_data orion_xor01_data = {
-	.shared		= &orion_xor0_shared,
-	.hw_id		= 1,
-	.pool_size	= PAGE_SIZE,
+static struct mv_xor_shared_platform_data orion_xor0_pdata = {
+	.channels = orion_xor0_channels_pdata,
 };
 
-static struct platform_device orion_xor01_channel = {
-	.name		= MV_XOR_NAME,
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(orion_xor01_resources),
-	.resource	= orion_xor01_resources,
-	.dev		= {
-		.dma_mask		= &orion_xor_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= &orion_xor01_data,
+static struct platform_device orion_xor0_shared = {
+	.name		= MV_XOR_SHARED_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(orion_xor0_shared_resources),
+	.resource	= orion_xor0_shared_resources,
+	.dev            = {
+		.dma_mask               = &orion_xor_dmamask,
+		.coherent_dma_mask      = DMA_BIT_MASK(64),
+		.platform_data          = &orion_xor0_pdata,
 	},
 };
 
@@ -704,15 +686,23 @@ void __init orion_xor0_init(unsigned long mapbase_low,
 	orion_xor0_shared_resources[1].start = mapbase_high;
 	orion_xor0_shared_resources[1].end = mapbase_high + 0xff;
 
-	orion_xor00_resources[0].start = irq_0;
-	orion_xor00_resources[0].end = irq_0;
-	orion_xor01_resources[0].start = irq_1;
-	orion_xor01_resources[0].end = irq_1;
+	orion_xor0_shared_resources[2].start = irq_0;
+	orion_xor0_shared_resources[2].end = irq_0;
+	orion_xor0_shared_resources[3].start = irq_1;
+	orion_xor0_shared_resources[3].end = irq_1;
 
-	platform_device_register(&orion_xor0_shared);
+	/*
+	 * two engines can't do memset simultaneously, this limitation
+	 * satisfied by removing memset support from one of the engines.
+	 */
+	dma_cap_set(DMA_MEMCPY, orion_xor0_channels_pdata[0].cap_mask);
+	dma_cap_set(DMA_XOR, orion_xor0_channels_pdata[0].cap_mask);
 
-	orion_xor_init_channels(&orion_xor00_data, &orion_xor00_channel,
-				&orion_xor01_data, &orion_xor01_channel);
+	dma_cap_set(DMA_MEMSET, orion_xor0_channels_pdata[1].cap_mask);
+	dma_cap_set(DMA_MEMCPY, orion_xor0_channels_pdata[1].cap_mask);
+	dma_cap_set(DMA_XOR, orion_xor0_channels_pdata[1].cap_mask);
+
+	platform_device_register(&orion_xor0_shared);
 }
 
 /*****************************************************************************
-- 
1.7.9.5
