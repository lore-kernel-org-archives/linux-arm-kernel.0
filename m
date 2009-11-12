From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:42:03 +0100
Subject: [PATCH 7/9] i.MX3: Add sound (ssi) resources
In-Reply-To: <1258022525-21078-7-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c |    4 +-
 arch/arm/mach-mx3/devices.c     |   42 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx3/devices.h     |    2 +
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 63be4a7..5068e1d 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -463,8 +463,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "sdma", sdma_clk)
 	_REGISTER_CLOCK(NULL, "spba", spba_clk)
 	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
-	_REGISTER_CLOCK(NULL, "ssi", ssi1_clk)
-	_REGISTER_CLOCK(NULL, "ssi", ssi2_clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
 	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
 	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index f007f22..848b0a9 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -537,6 +537,44 @@ struct platform_device mxc_fec_device = {
 };
 #endif
 
+static struct resource imx_ssi_resources0[] = {
+	{
+		.start	= SSI1_BASE_ADDR,
+		.end	= SSI1_BASE_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= MX31_INT_SSI1,
+		.end	= MX31_INT_SSI1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource imx_ssi_resources1[] = {
+	{
+		.start	= SSI2_BASE_ADDR,
+		.end	= SSI2_BASE_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM
+	}, {
+		.start	= MX31_INT_SSI2,
+		.end	= MX31_INT_SSI2,
+		.flags	= IORESOURCE_IRQ,
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
 static int mx3_devices_init(void)
 {
 	if (cpu_is_mx31()) {
@@ -555,6 +593,10 @@ static int mx3_devices_init(void)
 		mxc_usbh1_resources[0].end = MX35_OTG_BASE_ADDR + 0x5ff;
 		mxc_usbh1_resources[1].start = MXC_INT_USBHS;
 		mxc_usbh1_resources[1].end = MXC_INT_USBHS;
+		imx_ssi_resources0[1].start = MX35_INT_SSI1;
+		imx_ssi_resources0[1].end = MX35_INT_SSI1;
+		imx_ssi_resources1[1].start = MX35_INT_SSI2;
+		imx_ssi_resources1[1].end = MX35_INT_SSI2;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 79f2be4..b31c887 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -23,4 +23,6 @@ extern struct platform_device mxc_rnga_device;
 extern struct platform_device imx_spi_device0;
 extern struct platform_device imx_spi_device1;
 extern struct platform_device imx_spi_device2;
+extern struct platform_device imx_ssi_device0;
+extern struct platform_device imx_ssi_device1;
 
-- 
1.6.5.2
