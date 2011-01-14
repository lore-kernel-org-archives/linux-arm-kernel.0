From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 14 Jan 2011 17:48:03 +0800
Subject: [PATCH v2 1/2] arm: mx50_rdp: add fec support
Message-ID: <1294998484-32361-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-mx5/Kconfig                |    1 +
 arch/arm/mach-mx5/board-mx50_rdp.c       |   22 ++++++++++++++++++++--
 arch/arm/mach-mx5/devices-mx50.h         |    5 +++++
 arch/arm/plat-mxc/devices/platform-fec.c |    5 +++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index f2f0731..64d2bf9 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -142,6 +142,7 @@ config MACH_MX50_RDP
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select IMX_HAVE_PLATFORM_FEC
 	help
 	  Include support for MX50 reference design platform (RDP) board. This
 	  includes specific configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
index fd32e4c..884c003 100644
--- a/arch/arm/mach-mx5/board-mx50_rdp.c
+++ b/arch/arm/mach-mx5/board-mx50_rdp.c
@@ -37,6 +37,9 @@
 
 #include "devices-mx50.h"
 
+#define FEC_EN		IMX_GPIO_NR(6, 23)
+#define FEC_RESET_B	IMX_GPIO_NR(4, 12)
+
 static iomux_v3_cfg_t mx50_rdp_pads[] __initdata = {
 	/* SD1 */
 	MX50_PAD_ECSPI2_SS0__GPIO_4_19,
@@ -102,7 +105,7 @@ static iomux_v3_cfg_t mx50_rdp_pads[] __initdata = {
 	MX50_PAD_I2C3_SCL__USBOTG_OC,
 
 	MX50_PAD_SSI_RXC__FEC_MDIO,
-	MX50_PAD_SSI_RXC__FEC_MDIO,
+	MX50_PAD_SSI_RXFS__FEC_MDC,
 	MX50_PAD_DISP_D0__FEC_TXCLK,
 	MX50_PAD_DISP_D1__FEC_RX_ER,
 	MX50_PAD_DISP_D2__FEC_RX_DV,
@@ -111,7 +114,6 @@ static iomux_v3_cfg_t mx50_rdp_pads[] __initdata = {
 	MX50_PAD_DISP_D5__FEC_TX_EN,
 	MX50_PAD_DISP_D6__FEC_TXD1,
 	MX50_PAD_DISP_D7__FEC_TXD0,
-	MX50_PAD_SSI_RXFS__FEC_MDC,
 	MX50_PAD_I2C3_SDA__GPIO_6_23,
 	MX50_PAD_ECSPI1_SCLK__GPIO_4_12,
 
@@ -168,6 +170,20 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
+static const struct fec_platform_data fec_data __initconst = {
+	.phy = PHY_INTERFACE_MODE_RMII,
+};
+
+static inline void mx50_rdp_fec_reset(void)
+{
+	gpio_request(FEC_EN, "fec-en");
+	gpio_direction_output(FEC_EN, 0);
+	gpio_request(FEC_RESET_B, "fec-reset_b");
+	gpio_direction_output(FEC_RESET_B, 0);
+	msleep(1);
+	gpio_set_value(FEC_RESET_B, 1);
+}
+
 /*
  * Board specific initialization.
  */
@@ -178,6 +194,8 @@ static void __init mx50_rdp_board_init(void)
 
 	imx50_add_imx_uart(0, &uart_pdata);
 	imx50_add_imx_uart(1, &uart_pdata);
+	mx50_rdp_fec_reset();
+	imx50_add_fec(&fec_data);
 }
 
 static void __init mx50_rdp_timer_init(void)
diff --git a/arch/arm/mach-mx5/devices-mx50.h b/arch/arm/mach-mx5/devices-mx50.h
index 98ab074..e1093db 100644
--- a/arch/arm/mach-mx5/devices-mx50.h
+++ b/arch/arm/mach-mx5/devices-mx50.h
@@ -24,3 +24,8 @@
 extern const struct imx_imx_uart_1irq_data imx50_imx_uart_data[] __initconst;
 #define imx50_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx50_imx_uart_data[id], pdata)
+
+extern const struct imx_fec_data imx50_fec_data __initconst;
+#define imx50_add_fec(pdata)	\
+	imx_add_fec(&imx50_fec_data, pdata)
+
diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
index b50c351..4f52996 100644
--- a/arch/arm/plat-mxc/devices/platform-fec.c
+++ b/arch/arm/plat-mxc/devices/platform-fec.c
@@ -31,6 +31,11 @@ const struct imx_fec_data imx35_fec_data __initconst =
 	imx_fec_data_entry_single(MX35);
 #endif
 
+#ifdef CONFIG_SOC_IMX50
+const struct imx_fec_data imx50_fec_data __initconst =
+	imx_fec_data_entry_single(MX50);
+#endif
+
 #ifdef CONFIG_SOC_IMX51
 const struct imx_fec_data imx51_fec_data __initconst =
 	imx_fec_data_entry_single(MX51);
-- 
1.6.3.3
