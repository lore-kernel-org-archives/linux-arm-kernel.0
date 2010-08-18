From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 18 Aug 2010 18:22:59 +0200
Subject: [PATCH|RESEND 2/2] mx35_3ds: add NAND flash
In-Reply-To: <1282146406-2901-3-git-send-email-m.grzeschik@pengutronix.de>
References: <1282146406-2901-3-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1282148579-9212-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

The mx35_3ds comes with 2 GiByte NAND flash, register mxc_nand_device to
access it.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig         |    1 +
 arch/arm/mach-mx3/mach-mx35_3ds.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 486c05d..5cee1a5 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -141,6 +141,7 @@ config MACH_MX35_3DS
 	bool "Support MX35PDK platform"
 	select ARCH_MX35
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	default n
 	help
 	  Include support for MX35PDK platform. This includes specific
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 73149b8..b3629e7 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -66,6 +66,12 @@ static struct platform_device mx35pdk_flash = {
 	.num_resources = 1,
 };
 
+static const struct mxc_nand_platform_data mx35pdk_nand_board_info __initconst = {
+	.width = 1,
+	.hw_ecc = 1,
+	.flash_bbt = 1,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&mxc_fec_device,
 	&mx35pdk_flash,
@@ -119,6 +125,8 @@ static void __init mxc_board_init(void)
 	imx35_add_imx_uart0(&uart_pdata);
 
 	mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+
+	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
 }
 
 static void __init mx35pdk_timer_init(void)
-- 
1.7.1
