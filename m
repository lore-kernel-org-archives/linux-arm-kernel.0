From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 18 Nov 2009 14:41:40 +0100
Subject: [PATCH 3/5] ARM: MX3: add SPI devices for mx31lite
In-Reply-To: <1258551702-8631-2-git-send-email-daniel@caiaq.de>
References: <1258551702-8631-1-git-send-email-daniel@caiaq.de>
	<1258551702-8631-2-git-send-email-daniel@caiaq.de>
Message-ID: <1258551702-8631-3-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some header files were reordered while I was at it.
The only device currently registered is the ATLAS PMIC chip.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mx31lite-db.c |   43 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx3/mx31lite.c    |   36 ++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 45abae1..1ab92f6 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -28,6 +28,8 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/mc13783.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +41,7 @@
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lite.h>
 #include <mach/mmc.h>
+#include <mach/spi.h>
 
 #include "devices.h"
 
@@ -55,6 +58,14 @@ static unsigned int litekit_db_board_pins[] __initdata = {
 	MX31_PIN_RTS1__RTS1,
 	MX31_PIN_TXD1__TXD1,
 	MX31_PIN_RXD1__RXD1,
+	/* SPI 0 */
+	MX31_PIN_CSPI1_SCLK__SCLK,
+	MX31_PIN_CSPI1_MOSI__MOSI,
+	MX31_PIN_CSPI1_MISO__MISO,
+	MX31_PIN_CSPI1_SPI_RDY__SPI_RDY,
+	MX31_PIN_CSPI1_SS0__SS0,
+	MX31_PIN_CSPI1_SS1__SS1,
+	MX31_PIN_CSPI1_SS2__SS2,
 };
 
 /* UART */
@@ -130,6 +141,35 @@ static struct imxmmc_platform_data mmc_pdata = {
 	.exit	   = mxc_mmc1_exit,
 };
 
+/* SPI */
+
+static int spi_internal_chipselect[] = {
+	MXC_SPI_CS(0),
+	MXC_SPI_CS(1),
+	MXC_SPI_CS(2),
+};
+
+static struct spi_imx_master spi0_pdata = {
+	.chipselect	= spi_internal_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
+};
+
+static struct mc13783_platform_data mc13783_pdata __initdata = {
+	.flags  = MC13783_USE_RTC |
+		  MC13783_USE_REGULATOR,
+};
+
+static struct spi_board_info litekit_spi_devs[] __initdata = {
+	{
+		.modalias       = "mc13783",
+		.max_speed_hz   = 1000000,
+		.bus_num	= 1,
+		.chip_select    = 0,
+		.platform_data  = &mc13783_pdata,
+		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+	},
+};
+
 void __init mx31lite_db_init(void)
 {
 	mxc_iomux_setup_multiple_pins(litekit_db_board_pins,
@@ -137,5 +177,8 @@ void __init mx31lite_db_init(void)
 					"development board pins");
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
+	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
+	spi_register_board_info(litekit_spi_devs,
+				ARRAY_SIZE(litekit_spi_devs));
 }
 
diff --git a/arch/arm/mach-mx3/mx31lite.c b/arch/arm/mach-mx3/mx31lite.c
index dc993a8..b8d8ee1 100644
--- a/arch/arm/mach-mx3/mx31lite.c
+++ b/arch/arm/mach-mx3/mx31lite.c
@@ -2,6 +2,7 @@
  *  Copyright (C) 2000 Deep Blue Solutions Ltd
  *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
  *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Copyright (C) 2009 Daniel Mack <daniel@caiaq.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -26,19 +27,22 @@
 #include <linux/gpio.h>
 #include <linux/smsc911x.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <mach/common.h>
 #include <asm/page.h>
 #include <asm/setup.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
 #include <mach/board-mx31lite.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/irqs.h>
 #include <mach/mxc_nand.h>
+#include <mach/spi.h>
+
 #include "devices.h"
 
 /*
@@ -48,6 +52,14 @@
 static unsigned int mx31lite_pins[] = {
 	/* LAN9117 IRQ pin */
 	IOMUX_MODE(MX31_PIN_SFS6, IOMUX_CONFIG_GPIO),
+	/* SPI 1 */
+	MX31_PIN_CSPI2_SCLK__SCLK,
+	MX31_PIN_CSPI2_MOSI__MOSI,
+	MX31_PIN_CSPI2_MISO__MISO,
+	MX31_PIN_CSPI2_SPI_RDY__SPI_RDY,
+	MX31_PIN_CSPI2_SS0__SS0,
+	MX31_PIN_CSPI2_SS1__SS1,
+	MX31_PIN_CSPI2_SS2__SS2,
 };
 
 static struct mxc_nand_platform_data mx31lite_nand_board_info = {
@@ -84,6 +96,25 @@ static struct platform_device smsc911x_device = {
 };
 
 /*
+ * SPI
+ *
+ * The MX13783 is hard-wired on the module, hence the corresponding
+ * bus is registered here and not in the board code, in contrast to
+ * the other SPI bus.
+ */
+
+static int spi_internal_chipselect[] = {
+	MXC_SPI_CS(0),
+	MXC_SPI_CS(1),
+	MXC_SPI_CS(2),
+};
+
+static struct spi_imx_master spi1_pdata = {
+	.chipselect	= spi_internal_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
+};
+
+/*
  * This structure defines the MX31 memory map.
  */
 static struct map_desc mx31lite_io_desc[] __initdata = {
@@ -131,6 +162,7 @@ static void __init mxc_board_init(void)
 				      "mx31lite");
 
 	mxc_register_device(&mxc_nand_device, &mx31lite_nand_board_info);
+	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
 
 	/* SMSC9117 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_SFS6), "sms9117-irq");
-- 
1.6.5.2
