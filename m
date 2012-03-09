From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Fri,  9 Mar 2012 15:55:16 +0100
Subject: [PATCH 4/4] imx31pdk: Add sound support
In-Reply-To: <1331304916-4724-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-4-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1331304916-4724-5-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx31_3ds.c |   40 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 2c60f63..61084f2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -468,6 +468,7 @@ config MACH_MX31_3DS
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 4d1aab1..a00efda 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -41,6 +41,8 @@
 #include <mach/iomux-mx3.h>
 #include <mach/3ds_debugboard.h>
 #include <mach/ulpi.h>
+#include <mach/audmux.h>
+#include <mach/ssi.h>
 
 #include "devices-imx31.h"
 
@@ -156,6 +158,11 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_CSI_VSYNC__CSI_VSYNC,
 	MX31_PIN_CSI_D5__GPIO3_5, /* CMOS PWDN */
 	IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_GPIO), /* CMOS reset */
+	/* SSI */
+	MX31_PIN_STXD4__STXD4,
+	MX31_PIN_SRXD4__SRXD4,
+	MX31_PIN_SCK4__SCK4,
+	MX31_PIN_SFS4__SFS4,
 };
 
 /*
@@ -488,12 +495,23 @@ static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 };
 
 /* MC13783 */
+static struct mc13xxx_codec_platform_data mx31pdk_codec = {
+	.dac_ssi_port = MC13783_SSI1_PORT,
+	.adc_ssi_port = MC13783_SSI1_PORT,
+};
+
 static struct mc13xxx_platform_data mc13783_pdata = {
 	.regulators = {
 		.regulators = mx31_3ds_regulators,
 		.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
 	},
-	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC,
+	.codec = &mx31pdk_codec,
+	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC |
+		MC13XXX_USE_CODEC,
+};
+
+static struct imx_ssi_platform_data mx31pdk_ssi_pdata = {
+	.flags = IMX_SSI_DMA | IMX_SSI_NET,
 };
 
 /* SPI */
@@ -694,6 +712,24 @@ static void __init mx31_3ds_init(void)
 	mxc_iomux_setup_multiple_pins(mx31_3ds_pins, ARRAY_SIZE(mx31_3ds_pins),
 				      "mx31_3ds");
 
+	mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT4_SSI_PINS_4,
+		MXC_AUDMUX_V2_PTCR_SYN,
+		MXC_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0) |
+		MXC_AUDMUX_V2_PDCR_MODE(1) |
+		MXC_AUDMUX_V2_PDCR_INMMASK(0xfc));
+
+	mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0,
+		MXC_AUDMUX_V2_PTCR_SYN |
+		MXC_AUDMUX_V2_PTCR_TFSDIR |
+		MXC_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+		MXC_AUDMUX_V2_PTCR_TCLKDIR |
+		MXC_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+		MXC_AUDMUX_V2_PTCR_RFSDIR |
+		MXC_AUDMUX_V2_PTCR_RFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+		MXC_AUDMUX_V2_PTCR_RCLKDIR |
+		MXC_AUDMUX_V2_PTCR_RCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4),
+		MXC_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT4_SSI_PINS_4));
+
 	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);
 
@@ -741,6 +777,8 @@ static void __init mx31_3ds_init(void)
 	}
 
 	mx31_3ds_init_camera();
+
+	imx31_add_imx_ssi(0, &mx31pdk_ssi_pdata);
 }
 
 static void __init mx31_3ds_timer_init(void)
-- 
1.6.3.3
