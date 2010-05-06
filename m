From: saeed@marvell.com (Saeed Bishara)
Date: Thu,  6 May 2010 16:12:06 +0300
Subject: [PATCH] [ARM] Dove: platform device registration for the sdio
	interfaces
In-Reply-To: <1273151526-20190-1-git-send-email-saeed@marvell.com>
References: <1273151526-20190-1-git-send-email-saeed@marvell.com>
Message-ID: <1273151526-20190-2-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mach-dove/common.c        |   61 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/common.h        |    2 +
 arch/arm/mach-dove/dove-db-setup.c |    2 +
 3 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 5da2cf4..f7a1258 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -752,6 +752,67 @@ void __init dove_xor1_init(void)
 	platform_device_register(&dove_xor11_channel);
 }
 
+/*****************************************************************************
+ * SDIO
+ ****************************************************************************/
+static u64 sdio_dmamask = DMA_BIT_MASK(32);
+
+static struct resource dove_sdio0_resources[] = {
+	{
+		.start	= DOVE_SDIO0_PHYS_BASE,
+		.end	= DOVE_SDIO0_PHYS_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_DOVE_SDIO0,
+		.end	= IRQ_DOVE_SDIO0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_sdio0 = {
+	.name		= "sdhci-mv",
+	.id		= 0,
+	.dev		= {
+		.dma_mask		= &sdio_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.resource	= dove_sdio0_resources,
+	.num_resources	= ARRAY_SIZE(dove_sdio0_resources),
+};
+
+void __init dove_sdio0_init(void)
+{
+	platform_device_register(&dove_sdio0);
+}
+
+static struct resource dove_sdio1_resources[] = {
+	{
+		.start	= DOVE_SDIO1_PHYS_BASE,
+		.end	= DOVE_SDIO1_PHYS_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_DOVE_SDIO1,
+		.end	= IRQ_DOVE_SDIO1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dove_sdio1 = {
+	.name		= "sdhci-mv",
+	.id		= 1,
+	.dev		= {
+		.dma_mask		= &sdio_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.resource	= dove_sdio1_resources,
+	.num_resources	= ARRAY_SIZE(dove_sdio1_resources),
+};
+
+void __init dove_sdio1_init(void)
+{
+	platform_device_register(&dove_sdio1);
+}
+
 void __init dove_init(void)
 {
 	int tclk;
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index b29e893..a51517c 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -36,5 +36,7 @@ void dove_uart3_init(void);
 void dove_spi0_init(void);
 void dove_spi1_init(void);
 void dove_i2c_init(void);
+void dove_sdio0_init(void);
+void dove_sdio1_init(void);
 
 #endif
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index f2971b7..bef7046 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -82,6 +82,8 @@ static void __init dove_db_init(void)
 	dove_ehci0_init();
 	dove_ehci1_init();
 	dove_sata_init(&dove_db_sata_data);
+	dove_sdio0_init();
+	dove_sdio1_init();
 	dove_spi0_init();
 	dove_spi1_init();
 	dove_uart0_init();
-- 
1.6.0.4
