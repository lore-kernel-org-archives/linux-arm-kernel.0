From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Tue, 23 Mar 2010 19:49:35 +0100
Subject: [PATCH 2/8] MXC: mach-mx31_3ds: Add support for on board NAND Flash.
In-Reply-To: <1269370017.3276.165.camel@realization>
References: <1269369741.3276.162.camel@realization>
	<1269370017.3276.165.camel@realization>
Message-ID: <1269370175.3276.168.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the using of Bad Block Table is not constantly a good behave
I had made it configurable.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/Kconfig         |    9 +++++++++
 arch/arm/mach-mx3/mach-mx31_3ds.c |   13 +++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 3872af1..9a2911e 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -62,6 +62,15 @@ config MACH_MX31_3DS
 	  Include support for MX31PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_MX31_3DS_MXC_NAND_USE_BBT
+	bool "Make the MXC NAND driver use the in flash Bad Block Table"
+	depends on MACH_MX31_3DS
+	depends on MTD_NAND_MXC
+	help
+	  Enable this if you want that the MXC NAND driver uses the in flash
+	  Bad Block Table to know what blocks are bad instead of scanning the
+	  entire flash looking for bad block markers.
+
 config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
 	select ARCH_MX31
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 4a94c3c..bf1f54a 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -34,6 +34,7 @@
 #include <mach/board-mx31_3ds.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
+#include <mach/mxc_nand.h>
 #include "devices.h"
 
 /*!
@@ -53,6 +54,17 @@ static int mx31_3ds_pins[] = {
 	IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO),
 };
 
+/*
+ * NAND Flash
+ */
+static struct mxc_nand_platform_data imx31_3ds_nand_flash_pdata = {
+	.width		= 1,
+	.hw_ecc		= 1,
+#ifdef MACH_MX31_3DS_MXC_NAND_USE_BBT
+	.flash_bbt	= 1,
+#endif
+};
+
 static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -236,6 +248,7 @@ static void __init mxc_board_init(void)
 				      "mx31_3ds");
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxc_nand_device, &imx31_3ds_nand_flash_pdata);
 
 	if (!mx31_3ds_init_expio())
 		platform_device_register(&smsc911x_device);
-- 
1.6.3.3
