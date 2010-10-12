From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 12 Oct 2010 17:01:16 +0200
Subject: [PATCH 2/2] cpuimx51: update board support
In-Reply-To: <1286895676-9407-1-git-send-email-eric@eukrea.com>
References: <1286895676-9407-1-git-send-email-eric@eukrea.com>
Message-ID: <1286895676-9407-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add NAND, SDHC

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/Kconfig                    |    3 +++
 arch/arm/mach-mx5/board-cpuimx51.c           |    9 +++++++++
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |   23 ++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 254b891..a2df9ac 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -31,6 +31,8 @@ config MACH_EUKREA_CPUIMX51
 	bool "Support Eukrea CPUIMX51 module"
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Include support for Eukrea CPUIMX51 platform. This includes
 	  specific configurations for the module and its peripherals.
@@ -43,6 +45,7 @@ choice
 config MACH_EUKREA_MBIMX51_BASEBOARD
 	prompt "Eukrea MBIMX51 development board"
 	bool
+	select IMX_HAVE_PLATFORM_ESDHC
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMX51 evaluation board.
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 61f0510..378f532 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -146,6 +146,13 @@ static struct pad_desc eukrea_cpuimx51_pads[] = {
 	MX51_PAD_USBH1_STP__USBH1_STP,
 };
 
+static const struct mxc_nand_platform_data
+		eukrea_cpuimx51_nand_board_info __initconst = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -239,6 +246,8 @@ static void __init eukrea_cpuimx51_init(void)
 					ARRAY_SIZE(eukrea_cpuimx51_pads));
 
 	imx51_add_imx_uart(0, &uart_pdata);
+	imx51_add_mxc_nand(&eukrea_cpuimx51_nand_board_info);
+
 	gpio_request(CPUIMX51_QUARTA_GPIO, "quarta_irq");
 	gpio_direction_input(CPUIMX51_QUARTA_GPIO);
 	gpio_free(CPUIMX51_QUARTA_GPIO);
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index d0e417c..a2e6e8c 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -113,6 +113,22 @@ static struct pad_desc mbimx51_pads[] = {
 	MX51_PAD_KEY_COL1__KEY_COL1,
 	MX51_PAD_KEY_COL2__KEY_COL2,
 	MX51_PAD_KEY_COL3__KEY_COL3,
+
+	/* SD 1 */
+	MX51_PAD_SD1_CMD__SD1_CMD,
+	MX51_PAD_SD1_CLK__SD1_CLK,
+	MX51_PAD_SD1_DATA0__SD1_DATA0,
+	MX51_PAD_SD1_DATA1__SD1_DATA1,
+	MX51_PAD_SD1_DATA2__SD1_DATA2,
+	MX51_PAD_SD1_DATA3__SD1_DATA3,
+
+	/* SD 2 */
+	MX51_PAD_SD2_CMD__SD2_CMD,
+	MX51_PAD_SD2_CLK__SD2_CLK,
+	MX51_PAD_SD2_DATA0__SD2_DATA0,
+	MX51_PAD_SD2_DATA1__SD2_DATA1,
+	MX51_PAD_SD2_DATA2__SD2_DATA2,
+	MX51_PAD_SD2_DATA3__SD2_DATA3,
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -159,9 +175,11 @@ struct tsc2007_platform_data tsc2007_data = {
 
 static struct i2c_board_info mbimx51_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("tsc2007", 0x48),
+		I2C_BOARD_INFO("tsc2007", 0x49),
 		.irq  = MBIMX51_TSC2007_IRQ,
 		.platform_data = &tsc2007_data,
+	}, {
+		I2C_BOARD_INFO("tlv320aic23", 0x1a),
 	},
 };
 
@@ -198,4 +216,7 @@ void __init eukrea_mbimx51_baseboard_init(void)
 	set_irq_type(MBIMX51_TSC2007_IRQ, IRQF_TRIGGER_FALLING);
 	i2c_register_board_info(1, mbimx51_i2c_devices,
 				ARRAY_SIZE(mbimx51_i2c_devices));
+
+	imx51_add_esdhc(0, NULL);
+	imx51_add_esdhc(1, NULL);
 }
-- 
1.7.0.4
