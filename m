From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:44 +0100
Subject: [PATCH 06/30] arm: plat-orion: convert the registration of the xor1
 engine to the single driver
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-7-git-send-email-thomas.petazzoni@free-electrons.com>
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
index 800af19..afbbb97 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -715,61 +715,43 @@ static struct resource orion_xor1_shared_resources[] = {
 	}, {
 		.name	= "xor 1 high",
 		.flags	= IORESOURCE_MEM,
+	}, {
+		.name   = "irq channel 0",
+		.flags  = IORESOURCE_IRQ,
+	}, {
+		.name   = "irq channel 1",
+		.flags  = IORESOURCE_IRQ,
 	},
 };
 
-static struct platform_device orion_xor1_shared = {
-	.name		= MV_XOR_SHARED_NAME,
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(orion_xor1_shared_resources),
-	.resource	= orion_xor1_shared_resources,
-};
-
-static struct resource orion_xor10_resources[] = {
-	[0] = {
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct mv_xor_platform_data orion_xor10_data = {
-	.shared		= &orion_xor1_shared,
-	.hw_id		= 0,
-	.pool_size	= PAGE_SIZE,
-};
+static struct platform_device orion_xor1_shared;
 
-static struct platform_device orion_xor10_channel = {
-	.name		= MV_XOR_NAME,
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(orion_xor10_resources),
-	.resource	= orion_xor10_resources,
-	.dev		= {
-		.dma_mask		= &orion_xor_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= &orion_xor10_data,
+static struct mv_xor_platform_data orion_xor1_channels_pdata[2] = {
+	{
+		.shared		= &orion_xor1_shared,
+		.hw_id		= 0,
+		.pool_size	= PAGE_SIZE,
 	},
-};
-
-static struct resource orion_xor11_resources[] = {
-	[0] = {
-		.flags	= IORESOURCE_IRQ,
+	{
+		.shared		= &orion_xor1_shared,
+		.hw_id		= 1,
+		.pool_size	= PAGE_SIZE,
 	},
 };
 
-static struct mv_xor_platform_data orion_xor11_data = {
-	.shared		= &orion_xor1_shared,
-	.hw_id		= 1,
-	.pool_size	= PAGE_SIZE,
+static struct mv_xor_shared_platform_data orion_xor1_pdata = {
+	.channels = orion_xor1_channels_pdata,
 };
 
-static struct platform_device orion_xor11_channel = {
-	.name		= MV_XOR_NAME,
-	.id		= 3,
-	.num_resources	= ARRAY_SIZE(orion_xor11_resources),
-	.resource	= orion_xor11_resources,
-	.dev		= {
-		.dma_mask		= &orion_xor_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= &orion_xor11_data,
+static struct platform_device orion_xor1_shared = {
+	.name		= MV_XOR_SHARED_NAME,
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(orion_xor1_shared_resources),
+	.resource	= orion_xor1_shared_resources,
+	.dev            = {
+		.dma_mask               = &orion_xor_dmamask,
+		.coherent_dma_mask      = DMA_BIT_MASK(64),
+		.platform_data          = &orion_xor1_pdata,
 	},
 };
 
@@ -783,15 +765,23 @@ void __init orion_xor1_init(unsigned long mapbase_low,
 	orion_xor1_shared_resources[1].start = mapbase_high;
 	orion_xor1_shared_resources[1].end = mapbase_high + 0xff;
 
-	orion_xor10_resources[0].start = irq_0;
-	orion_xor10_resources[0].end = irq_0;
-	orion_xor11_resources[0].start = irq_1;
-	orion_xor11_resources[0].end = irq_1;
+	orion_xor1_shared_resources[2].start = irq_0;
+	orion_xor1_shared_resources[2].end = irq_0;
+	orion_xor1_shared_resources[3].start = irq_1;
+	orion_xor1_shared_resources[3].end = irq_1;
 
-	platform_device_register(&orion_xor1_shared);
+	/*
+	 * two engines can't do memset simultaneously, this limitation
+	 * satisfied by removing memset support from one of the engines.
+	 */
+	dma_cap_set(DMA_MEMCPY, orion_xor1_channels_pdata[0].cap_mask);
+	dma_cap_set(DMA_XOR, orion_xor1_channels_pdata[0].cap_mask);
 
-	orion_xor_init_channels(&orion_xor10_data, &orion_xor10_channel,
-				&orion_xor11_data, &orion_xor11_channel);
+	dma_cap_set(DMA_MEMSET, orion_xor1_channels_pdata[1].cap_mask);
+	dma_cap_set(DMA_MEMCPY, orion_xor1_channels_pdata[1].cap_mask);
+	dma_cap_set(DMA_XOR, orion_xor1_channels_pdata[1].cap_mask);
+
+	platform_device_register(&orion_xor1_shared);
 }
 
 /*****************************************************************************
-- 
1.7.9.5
