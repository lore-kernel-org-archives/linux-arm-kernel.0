From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 1 Mar 2011 16:59:48 -0300
Subject: [PATCH 5/5] ARM: mx53_smd: Add I2C support
In-Reply-To: <1299009588-8783-4-git-send-email-fabio.estevam@freescale.com>
References: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
	<1299009588-8783-2-git-send-email-fabio.estevam@freescale.com>
	<1299009588-8783-3-git-send-email-fabio.estevam@freescale.com>
	<1299009588-8783-4-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1299009588-8783-5-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index f065a0d..b916d0d 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -151,6 +151,7 @@ config MACH_MX53_SMD
 	bool "Support MX53 SMD platforms"
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for MX53 SMD platform. This includes specific
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index 8a8694c..5eb1638 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -51,6 +51,9 @@ static iomux_v3_cfg_t mx53_smd_pads[] = {
 	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
 	MX53_PAD_PATA_DA_1__UART3_CTS,
 	MX53_PAD_PATA_DA_2__UART3_RTS,
+	/* I2C1 */
+	MX53_PAD_CSI0_DAT8__I2C1_SDA,
+	MX53_PAD_CSI0_DAT9__I2C1_SCL,
 };
 
 static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
@@ -83,6 +86,10 @@ static struct fec_platform_data mx53_smd_fec_data = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
+static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
+	.bitrate = 100000,
+};
+
 static void __init mx53_smd_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_smd_pads,
@@ -91,6 +98,7 @@ static void __init mx53_smd_board_init(void)
 	mx53_smd_fec_reset();
 	imx53_add_fec(&mx53_smd_fec_data);
 	imx53_add_imx2_wdt(0, NULL);
+	imx53_add_imx_i2c(0, &mx53_smd_i2c_data);
 }
 
 static void __init mx53_smd_timer_init(void)
-- 
1.6.0.4
