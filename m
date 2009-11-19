From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 19 Nov 2009 12:02:08 +0100
Subject: [PATCH 3/6] ARM: MX3: add SPI devices for mx31lite
In-Reply-To: <1258628531-15783-2-git-send-email-daniel@caiaq.de>
References: <1258628531-15783-1-git-send-email-daniel@caiaq.de>
	<1258628531-15783-2-git-send-email-daniel@caiaq.de>
Message-ID: <1258628531-15783-3-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some header files were reordered while I was at it.
The only device currently registered is the ATLAS PMIC (MC13783) chip.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mx31lite-db.c |   24 +++++++++++++++++++
 arch/arm/mach-mx3/mx31lite.c    |   49 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 45abae1..f60cf08 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +40,7 @@
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lite.h>
 #include <mach/mmc.h>
+#include <mach/spi.h>
 
 #include "devices.h"
 
@@ -55,6 +57,14 @@ static unsigned int litekit_db_board_pins[] __initdata = {
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
@@ -130,6 +140,19 @@ static struct imxmmc_platform_data mmc_pdata = {
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
 void __init mx31lite_db_init(void)
 {
 	mxc_iomux_setup_multiple_pins(litekit_db_board_pins,
@@ -137,5 +160,6 @@ void __init mx31lite_db_init(void)
 					"development board pins");
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
+	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
 }
 
diff --git a/arch/arm/mach-mx3/mx31lite.c b/arch/arm/mach-mx3/mx31lite.c
index dc993a8..03762a3 100644
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
@@ -25,20 +26,25 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/smsc911x.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/spi/spi.h>
 
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
@@ -48,6 +54,14 @@
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
@@ -84,6 +98,35 @@ static struct platform_device smsc911x_device = {
 };
 
 /*
+ * SPI
+ *
+ * The MC13783 is the only hard-wired SPI device on the module.
+ */
+
+static int spi_internal_chipselect[] = {
+	MXC_SPI_CS(0),
+};
+
+static struct spi_imx_master spi1_pdata = {
+	.chipselect	= spi_internal_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
+};
+
+static struct mc13783_platform_data mc13783_pdata __initdata = {
+	.flags  = MC13783_USE_RTC |
+		  MC13783_USE_REGULATOR,
+};
+
+static struct spi_board_info mc13783_spi_dev __initdata = {
+	.modalias       = "mc13783",
+	.max_speed_hz   = 1000000,
+	.bus_num	= 1,
+	.chip_select    = 0,
+	.platform_data  = &mc13783_pdata,
+	.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+};
+
+/*
  * This structure defines the MX31 memory map.
  */
 static struct map_desc mx31lite_io_desc[] __initdata = {
@@ -131,6 +174,8 @@ static void __init mxc_board_init(void)
 				      "mx31lite");
 
 	mxc_register_device(&mxc_nand_device, &mx31lite_nand_board_info);
+	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
+	spi_register_board_info(&mc13783_spi_dev, 1);
 
 	/* SMSC9117 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_SFS6), "sms9117-irq");
-- 
1.6.5.2
