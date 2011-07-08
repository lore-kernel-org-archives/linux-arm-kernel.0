From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 8 Jul 2011 14:59:50 -0300
Subject: [PATCH 2/2] ARM: mach-imx/mx25_3ds: Add FlexCAN support
In-Reply-To: <1310147990-9198-1-git-send-email-fabio.estevam@freescale.com>
References: <1310147990-9198-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1310147990-9198-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx25_3ds.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0519dd7..0253e66 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -133,6 +133,7 @@ comment "MX25 platforms:"
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
 	select SOC_IMX25
+	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 01534bb..d3518b9 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -43,6 +43,8 @@
 
 #include "devices-imx25.h"
 
+#define MX25PDK_CAN_PWDN	IMX_GPIO_NR(4, 6)
+
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -108,6 +110,11 @@ static iomux_v3_cfg_t mx25pdk_pads[] = {
 	/* I2C1 */
 	MX25_PAD_I2C1_CLK__I2C1_CLK,
 	MX25_PAD_I2C1_DAT__I2C1_DAT,
+
+	/* CAN1 */
+	MX25_PAD_GPIO_A__CAN1_TX,
+	MX25_PAD_GPIO_B__CAN1_RX,
+	MX25_PAD_D14__GPIO_4_6,	/* CAN_PWDN */
 };
 
 static const struct fec_platform_data mx25_fec_pdata __initconst = {
@@ -238,6 +245,9 @@ static void __init mx25pdk_init(void)
 
 	imx25_add_sdhci_esdhc_imx(0, &mx25pdk_esdhc_pdata);
 	imx25_add_imx_i2c0(&mx25_3ds_i2c0_data);
+
+	gpio_request_one(MX25PDK_CAN_PWDN, GPIOF_OUT_INIT_LOW, "can-pwdn");
+	imx25_add_flexcan0(NULL);
 }
 
 static void __init mx25pdk_timer_init(void)
-- 
1.7.1
