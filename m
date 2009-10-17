From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 17 Oct 2009 15:12:58 +0200
Subject: [PATCH 2/4] ARM: MX3: add SPI functions for lilly1131-db
In-Reply-To: <1255785180-18501-2-git-send-email-daniel@caiaq.de>
References: <1255785180-18501-1-git-send-email-daniel@caiaq.de>
	<1255785180-18501-2-git-send-email-daniel@caiaq.de>
Message-ID: <1255785180-18501-3-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the two SPI busses found on the lilly1131 module.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mx31lilly.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lilly.c b/arch/arm/mach-mx3/mx31lilly.c
index e0f4cd2..de69a4e 100644
--- a/arch/arm/mach-mx3/mx31lilly.c
+++ b/arch/arm/mach-mx3/mx31lilly.c
@@ -47,6 +47,7 @@
 #include <mach/board-mx31lilly.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
+#include <mach/spi.h>
 
 #include "devices.h"
 
@@ -247,6 +248,22 @@ static struct platform_device *devices[] __initdata = {
 	&physmap_flash_device,
 };
 
+static int spi_internal_chipselect[] = {
+	MXC_SPI_CS(0),
+	MXC_SPI_CS(1),
+	MXC_SPI_CS(2),
+};
+
+static struct spi_imx_master spi0_pdata = {
+	.chipselect = spi_internal_chipselect,
+	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
+};
+
+static struct spi_imx_master spi1_pdata = {
+	.chipselect = spi_internal_chipselect,
+	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
+};
+
 static int mx31lilly_baseboard;
 core_param(mx31lilly_baseboard, mx31lilly_baseboard, int, 0444);
 
@@ -265,6 +282,26 @@ static void __init mx31lilly_board_init(void)
 
 	mxc_iomux_alloc_pin(MX31_PIN_CS4__CS4, "Ethernet CS");
 
+	/* SPI */
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI1_SCLK__SCLK, "SPI1_CLK");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI1_MOSI__MOSI, "SPI1_TX");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI1_MISO__MISO, "SPI1_RX");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI1_SPI_RDY__SPI_RDY, "SPI1_RDY");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI1_SS0__SS0, "SPI1_SS0");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI1_SS1__SS1, "SPI1_SS1");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI1_SS2__SS2, "SPI1_SS2");
+
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SCLK__SCLK, "SPI2_CLK");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_MOSI__MOSI, "SPI2_TX");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_MISO__MISO, "SPI2_RX");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SPI_RDY__SPI_RDY, "SPI2_RDY");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS0__SS0, "SPI2_SS0");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS1__SS1, "SPI2_SS1");
+	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS2__SS2, "SPI2_SS2");
+
+	mxc_register_device(&imx_spi_device0, &spi0_pdata);
+	mxc_register_device(&imx_spi_device1, &spi1_pdata);
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	/* USB */
-- 
1.6.3.3
