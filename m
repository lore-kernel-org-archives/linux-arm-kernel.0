From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:07:59 +0100
Subject: [PATCH 04/39] arm/mx2: use cpp magic to create imx-mmc devices
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the source shorter and easier to verify.  While at it switch
to use the SoC-prefixed constants.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |   87 +++++++++++++++---------------------------
 1 files changed, 31 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index b32dfa0..71fd2c5 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -261,63 +261,38 @@ struct platform_device mxc_pwm_device = {
 /*
  * Resource definition for the MXC SDHC
  */
-static struct resource mxc_sdhc1_resources[] = {
-	{
-		.start = SDHC1_BASE_ADDR,
-		.end   = SDHC1_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_SDHC1,
-		.end   = MXC_INT_SDHC1,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start  = DMA_REQ_SDHC1,
-		.end    = DMA_REQ_SDHC1,
-		.flags  = IORESOURCE_DMA,
-	},
-};
-
-static u64 mxc_sdhc1_dmamask = 0xffffffffUL;
-
-struct platform_device mxc_sdhc_device0 = {
-       .name           = "mxc-mmc",
-       .id             = 0,
-       .dev            = {
-               .dma_mask = &mxc_sdhc1_dmamask,
-               .coherent_dma_mask = 0xffffffff,
-       },
-       .num_resources  = ARRAY_SIZE(mxc_sdhc1_resources),
-       .resource       = mxc_sdhc1_resources,
-};
-
-static struct resource mxc_sdhc2_resources[] = {
-	{
-		.start = SDHC2_BASE_ADDR,
-		.end   = SDHC2_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_SDHC2,
-		.end   = MXC_INT_SDHC2,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start  = DMA_REQ_SDHC2,
-		.end    = DMA_REQ_SDHC2,
-		.flags  = IORESOURCE_DMA,
-	},
-};
+#define DEFINE_MXC_MMC_DEVICE(n, baseaddr, irq, dmareq)			\
+	static struct resource mxc_sdhc_resources ## n[] = {		\
+		{							\
+			.start = baseaddr,				\
+			.end = baseaddr + SZ_4K - 1,			\
+			.flags = IORESOURCE_MEM,			\
+		}, {							\
+			.start = irq,					\
+			.end = irq,					\
+			.flags = IORESOURCE_IRQ,			\
+		}, {							\
+			.start = dmareq,				\
+			.end = dmareq,					\
+			.flags = IORESOURCE_DMA,			\
+		},							\
+	};								\
+									\
+	static u64 mxc_sdhc ## n ## _dmamask = 0xffffffffUL;		\
+									\
+	struct platform_device mxc_sdhc_device ## n = {			\
+		.name = "mxc-mmc",					\
+		.id = n,						\
+		.dev = {						\
+			.dma_mask = &mxc_sdhc ## n ## _dmamask,		\
+			.coherent_dma_mask = 0xffffffff,		\
+		},							\
+		.num_resources = ARRAY_SIZE(mxc_sdhc_resources ## n),	\
+		.resource = mxc_sdhc_resources ## n,		\
+	}
 
-static u64 mxc_sdhc2_dmamask = 0xffffffffUL;
-
-struct platform_device mxc_sdhc_device1 = {
-       .name           = "mxc-mmc",
-       .id             = 1,
-       .dev            = {
-               .dma_mask = &mxc_sdhc2_dmamask,
-               .coherent_dma_mask = 0xffffffff,
-       },
-       .num_resources  = ARRAY_SIZE(mxc_sdhc2_resources),
-       .resource       = mxc_sdhc2_resources,
-};
+DEFINE_MXC_MMC_DEVICE(0, MX2x_SDHC1_BASE_ADDR, MX2x_INT_SDHC1, MX2x_DMA_REQ_SDHC1);
+DEFINE_MXC_MMC_DEVICE(1, MX2x_SDHC2_BASE_ADDR, MX2x_INT_SDHC2, MX2x_DMA_REQ_SDHC2);
 
 #ifdef CONFIG_MACH_MX27
 static struct resource otg_resources[] = {
-- 
1.6.6.2
