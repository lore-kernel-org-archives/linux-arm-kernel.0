From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 10 Dec 2009 19:45:43 +0100
Subject: [PATCH 2/4] MXC: mx31pdk: Add CSPI2 interface support.
In-Reply-To: <1260470547.2141.42.camel@climbing-alby>
References: <1260470224.2141.37.camel@climbing-alby>
	<1260470547.2141.42.camel@climbing-alby>
Message-ID: <1260470743.2141.45.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add second SPI channel registration.

Signed-off-by: Alberto Panizzo <alberto.panizzo@gmail.com>
---
 arch/arm/mach-mx3/mx31pdk.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31pdk.c b/arch/arm/mach-mx3/mx31pdk.c
index ca1fe5d..5771d0e 100644
--- a/arch/arm/mach-mx3/mx31pdk.c
+++ b/arch/arm/mach-mx3/mx31pdk.c
@@ -35,6 +35,7 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/mxc_nand.h>
+#include <mach/spi.h>
 #include "devices.h"
 
 /*!
@@ -52,8 +53,28 @@ static int mx31pdk_pins[] = {
 	MX31_PIN_TXD1__TXD1,
 	MX31_PIN_RXD1__RXD1,
 	IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO),
+	/* SPI 1 */
+	MX31_PIN_CSPI2_SCLK__SCLK,
+	MX31_PIN_CSPI2_MOSI__MOSI,
+	MX31_PIN_CSPI2_MISO__MISO,
+	MX31_PIN_CSPI2_SPI_RDY__SPI_RDY,
+	MX31_PIN_CSPI2_SS0__SS0,
+	MX31_PIN_CSPI2_SS2__SS2, /*CS for MC13783 */
 };
 
+/* SPI */
+
+static int spi1_internal_chipselect[] = {
+	MXC_SPI_CS(0),
+	MXC_SPI_CS(2),
+};
+
+static struct spi_imx_master spi1_pdata = {
+	.chipselect	= spi1_internal_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi1_internal_chipselect),
+};
+
+
 /*
  * NAND Flash
  */
@@ -251,6 +272,7 @@ static void __init mxc_board_init(void)
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_nand_device, &imx31pdk_nand_flash_pdata);
+	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
 
 	if (!mx31pdk_init_expio())
 		platform_device_register(&smsc911x_device);
-- 
1.6.3.3
