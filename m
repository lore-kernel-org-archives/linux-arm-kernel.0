From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:42:02 +0100
Subject: [PATCH 6/9] i.MX2: Add sound (ssi) resources
In-Reply-To: <1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258022525-21078-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/clock_imx27.c |    4 +-
 arch/arm/mach-mx2/devices.c     |   78 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx2/devices.h     |    3 +-
 3 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
index 4089951..dec1bbc 100644
--- a/arch/arm/mach-mx2/clock_imx27.c
+++ b/arch/arm/mach-mx2/clock_imx27.c
@@ -651,8 +651,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_clk1)
 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk)
 	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK(NULL, "ssi1", ssi1_clk)
-	_REGISTER_CLOCK(NULL, "ssi2", ssi2_clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
 	_REGISTER_CLOCK(NULL, "vpu", vpu_clk)
 	_REGISTER_CLOCK(NULL, "dma", dma_clk)
diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index 50199af..3d398ce 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -530,6 +530,84 @@ struct platform_device mxc_usbh2 = {
 };
 #endif
 
+static struct resource imx_ssi_resources0[] = {
+	{
+		.start	= SSI1_BASE_ADDR,
+		.end	= SSI1_BASE_ADDR + 0x6F,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= MXC_INT_SSI1,
+		.end	= MXC_INT_SSI1,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.name	= "tx0",
+		.start	= DMA_REQ_SSI1_TX0,
+		.end	= DMA_REQ_SSI1_TX0,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "rx0",
+		.start	= DMA_REQ_SSI1_RX0,
+		.end	= DMA_REQ_SSI1_RX0,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "tx1",
+		.start	= DMA_REQ_SSI1_TX1,
+		.end	= DMA_REQ_SSI1_TX1,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "rx1",
+		.start	= DMA_REQ_SSI1_RX1,
+		.end	= DMA_REQ_SSI1_RX1,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct resource imx_ssi_resources1[] = {
+	{
+		.start	= SSI2_BASE_ADDR,
+		.end	= SSI2_BASE_ADDR + 0x6F,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= MXC_INT_SSI2,
+		.end	= MXC_INT_SSI2,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.name	= "tx0",
+		.start	= DMA_REQ_SSI2_TX0,
+		.end	= DMA_REQ_SSI2_TX0,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "rx0",
+		.start	= DMA_REQ_SSI2_RX0,
+		.end	= DMA_REQ_SSI2_RX0,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "tx1",
+		.start	= DMA_REQ_SSI2_TX1,
+		.end	= DMA_REQ_SSI2_TX1,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "rx1",
+		.start	= DMA_REQ_SSI2_RX1,
+		.end	= DMA_REQ_SSI2_RX1,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct platform_device imx_ssi_device0 = {
+	.name = "imx-ssi",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(imx_ssi_resources0),
+	.resource = imx_ssi_resources0,
+};
+
+struct platform_device imx_ssi_device1 = {
+	.name = "imx-ssi",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(imx_ssi_resources1),
+	.resource = imx_ssi_resources1,
+};
+
 /* GPIO port description */
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index d315406..97306aa 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -26,4 +26,5 @@ extern struct platform_device mxc_usbh2;
 extern struct platform_device mxc_spi_device0;
 extern struct platform_device mxc_spi_device1;
 extern struct platform_device mxc_spi_device2;
-
+extern struct platform_device imx_ssi_device0;
+extern struct platform_device imx_ssi_device1;
-- 
1.6.5.2
