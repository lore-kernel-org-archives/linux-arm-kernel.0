From: javier.martin@vista-silicon.com (Javier Martin)
Date: Fri, 25 Feb 2011 14:42:50 +0100
Subject: [PATCH 4/4] ARM: Add SSI and aic3204 code to Visstrim_M10 boards.
In-Reply-To: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
References: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1298641370-17461-4-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visstrim_M10 boards have an TI tlv320aic3204 codec
attached to SSI1.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/Kconfig                   |    1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 197f9e2..4d01d8c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -168,6 +168,7 @@ config MACH_IMX27_VISSTRIM_M10
 	bool "Vista Silicon i.MX27 Visstrim_m10"
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	help
 	  Include support for Visstrim_m10 platform and its different variants.
 	  This includes specific configurations for the board and its
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 59716fa..b346484 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -69,6 +69,11 @@ static const int visstrim_m10_pins[] __initconst = {
 	PD15_AOUT_FEC_COL,
 	PD16_AIN_FEC_TX_ER,
 	PF23_AIN_FEC_TX_EN,
+	/* SSI1 */
+	PC20_PF_SSI1_FS,
+	PC21_PF_SSI1_RXD,
+	PC22_PF_SSI1_TXD,
+	PC23_PF_SSI1_CLK,
 	/* SDHC1 */
 	PE18_PF_SD1_D0,
 	PE19_PF_SD1_D1,
@@ -207,6 +212,9 @@ static struct i2c_board_info visstrim_m10_i2c_devices[] = {
 		I2C_BOARD_INFO("pca9555", 0x20),
 		.platform_data = &visstrim_m10_pca9555_pdata,
 	},
+	{
+		I2C_BOARD_INFO("tlv320aic32x4", 0x18),
+	}
 };
 
 /* USB OTG */
@@ -222,6 +230,11 @@ static struct mxc_usbh_platform_data visstrim_m10_usbotg_pdata = {
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
+/* SSI */
+static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
+	.flags			= IMX_SSI_DMA | IMX_SSI_SYN,
+};
+
 static void __init visstrim_m10_board_init(void)
 {
 	int ret;
@@ -231,6 +244,7 @@ static void __init visstrim_m10_board_init(void)
 	if (ret)
 		pr_err("Failed to setup pins (%d)\n", ret);
 
+	imx27_add_imx_ssi(0, &visstrim_m10_ssi_pdata);
 	imx27_add_imx_uart0(&uart_pdata);
 
 	i2c_register_board_info(0, visstrim_m10_i2c_devices,
-- 
1.7.0.4
