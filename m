From: javier.martin@vista-silicon.com (Javier Martin)
Date: Mon,  7 Mar 2011 13:03:59 +0100
Subject: [PATCH] ARM: imx: Add tlv320aic32x4 board specific code to
	Visstrim_M10.
Message-ID: <1299499439-4466-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/Kconfig                   |    1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

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
index 59716fa..f43e042 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -30,6 +30,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <sound/tlv320aic32x4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -69,6 +70,11 @@ static const int visstrim_m10_pins[] __initconst = {
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
@@ -202,11 +208,26 @@ static struct pca953x_platform_data visstrim_m10_pca9555_pdata = {
 	.invert = 0,
 };
 
+static struct aic32x4_pdata visstrim_m10_aic32x4_pdata = {
+	.power_cfg = AIC32X4_PWR_MICBIAS_2075_LDOIN |
+		     AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE |
+		     AIC32X4_PWR_AIC32X4_LDO_ENABLE |
+		     AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36 |
+		     AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED,
+	.micpga_routing = AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K |
+			 AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K,
+	.swapdacs = false,
+};
+
 static struct i2c_board_info visstrim_m10_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("pca9555", 0x20),
 		.platform_data = &visstrim_m10_pca9555_pdata,
 	},
+	{
+		I2C_BOARD_INFO("tlv320aic32x4", 0x18),
+		.platform_data = &visstrim_m10_aic32x4_pdata,
+	}
 };
 
 /* USB OTG */
@@ -222,6 +243,11 @@ static struct mxc_usbh_platform_data visstrim_m10_usbotg_pdata = {
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
@@ -231,6 +257,7 @@ static void __init visstrim_m10_board_init(void)
 	if (ret)
 		pr_err("Failed to setup pins (%d)\n", ret);
 
+	imx27_add_imx_ssi(0, &visstrim_m10_ssi_pdata);
 	imx27_add_imx_uart0(&uart_pdata);
 
 	i2c_register_board_info(0, visstrim_m10_i2c_devices,
-- 
1.7.0.4
