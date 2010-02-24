From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:00 +0100
Subject: [PATCH 05/39] arm/mx2: use cpp magic to create imx-ssi devices
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the source shorter and easier to verify.  While at it switch
to use the SoC-prefixed constants.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |  107 +++++++++++++------------------------------
 1 files changed, 32 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index 71fd2c5..bed0fdb 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -387,83 +387,40 @@ struct platform_device mxc_usbh2 = {
 };
 #endif
 
-static struct resource imx_ssi_resources0[] = {
-	{
-		.start	= SSI1_BASE_ADDR,
-		.end	= SSI1_BASE_ADDR + 0x6F,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MXC_INT_SSI1,
-		.end	= MXC_INT_SSI1,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.name	= "tx0",
-		.start	= DMA_REQ_SSI1_TX0,
-		.end	= DMA_REQ_SSI1_TX0,
-		.flags	= IORESOURCE_DMA,
-	}, {
-		.name	= "rx0",
-		.start	= DMA_REQ_SSI1_RX0,
-		.end	= DMA_REQ_SSI1_RX0,
-		.flags	= IORESOURCE_DMA,
-	}, {
-		.name	= "tx1",
-		.start	= DMA_REQ_SSI1_TX1,
-		.end	= DMA_REQ_SSI1_TX1,
-		.flags	= IORESOURCE_DMA,
-	}, {
-		.name	= "rx1",
-		.start	= DMA_REQ_SSI1_RX1,
-		.end	= DMA_REQ_SSI1_RX1,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct resource imx_ssi_resources1[] = {
-	{
-		.start	= SSI2_BASE_ADDR,
-		.end	= SSI2_BASE_ADDR + 0x6F,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MXC_INT_SSI2,
-		.end	= MXC_INT_SSI2,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.name	= "tx0",
-		.start	= DMA_REQ_SSI2_TX0,
-		.end	= DMA_REQ_SSI2_TX0,
-		.flags	= IORESOURCE_DMA,
-	}, {
-		.name	= "rx0",
-		.start	= DMA_REQ_SSI2_RX0,
-		.end	= DMA_REQ_SSI2_RX0,
-		.flags	= IORESOURCE_DMA,
-	}, {
-		.name	= "tx1",
-		.start	= DMA_REQ_SSI2_TX1,
-		.end	= DMA_REQ_SSI2_TX1,
-		.flags	= IORESOURCE_DMA,
-	}, {
-		.name	= "rx1",
-		.start	= DMA_REQ_SSI2_RX1,
-		.end	= DMA_REQ_SSI2_RX1,
-		.flags	= IORESOURCE_DMA,
-	},
-};
+#define DEFINE_IMX_SSI_DMARES(_name, ssin, suffix)			\
+	{								\
+		.name = _name,						\
+		.start = MX2x_DMA_REQ_SSI ## ssin ## _ ## suffix,	\
+		.end = MX2x_DMA_REQ_SSI ## ssin ## _ ## suffix,		\
+		.flags = IORESOURCE_DMA,				\
+	}
 
-struct platform_device imx_ssi_device0 = {
-	.name = "imx-ssi",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(imx_ssi_resources0),
-	.resource = imx_ssi_resources0,
-};
+#define DEFINE_IMX_SSI_DEVICE(n, ssin, baseaddr, irq)			\
+	static struct resource imx_ssi_resources ## n[] = {		\
+		{							\
+			.start = MX2x_SSI ## ssin ## _BASE_ADDR,	\
+			.end = MX2x_SSI ## ssin ## _BASE_ADDR + 0x6f,	\
+			.flags = IORESOURCE_MEM,			\
+		}, {							\
+			.start = MX2x_INT_SSI1,				\
+			.end = MX2x_INT_SSI1,				\
+			.flags = IORESOURCE_IRQ,			\
+		},							\
+		DEFINE_IMX_SSI_DMARES("tx0", ssin, TX0),		\
+		DEFINE_IMX_SSI_DMARES("rx0", ssin, RX0),		\
+		DEFINE_IMX_SSI_DMARES("tx1", ssin, TX1),		\
+		DEFINE_IMX_SSI_DMARES("rx1", ssin, RX1),		\
+	};								\
+									\
+	struct platform_device imx_ssi_device ## n = {			\
+		.name = "imx-ssi",					\
+		.id = n,						\
+		.num_resources = ARRAY_SIZE(imx_ssi_resources ## n),	\
+		.resource = imx_ssi_resources ## n,			\
+	}
 
-struct platform_device imx_ssi_device1 = {
-	.name = "imx-ssi",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(imx_ssi_resources1),
-	.resource = imx_ssi_resources1,
-};
+DEFINE_IMX_SSI_DEVICE(0, 1, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
+DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 
 /* GPIO port description */
 static struct mxc_gpio_port imx_gpio_ports[] = {
-- 
1.6.6.2
