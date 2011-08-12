From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 12 Aug 2011 15:04:45 +0800
Subject: [PATCH 2/2] ARM: i.MX53EVK: Add NAND support for i.MX53evk board
In-Reply-To: <1313132685-10440-1-git-send-email-jason.hui@linaro.org>
References: <1313132685-10440-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1313132685-10440-3-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Liu <jason.hui@linaro.org>
---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c |   47 ++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index b4e7c58..7b0b7a2 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -180,6 +180,7 @@ config MACH_MX53_EVK
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	select LEDS_GPIO_REGISTER
 	help
 	  Include support for MX53 EVK platform. This includes specific
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 1b417b0..414bd1a 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -61,6 +61,26 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
 	MX53_PAD_EIM_D19__GPIO3_19,
 	/* LED */
 	MX53_PAD_PATA_DA_1__GPIO7_7,
+
+	/* NAND */
+	MX53_PAD_NANDF_CLE__EMI_NANDF_CLE,
+	MX53_PAD_NANDF_ALE__EMI_NANDF_ALE,
+	MX53_PAD_NANDF_WP_B__EMI_NANDF_WP_B,
+	MX53_PAD_NANDF_WE_B__EMI_NANDF_WE_B,
+	MX53_PAD_NANDF_RE_B__EMI_NANDF_RE_B,
+	MX53_PAD_NANDF_RB0__EMI_NANDF_RB_0,
+	MX53_PAD_NANDF_CS0__EMI_NANDF_CS_0,
+	MX53_PAD_NANDF_CS1__EMI_NANDF_CS_1,
+	MX53_PAD_NANDF_CS2__EMI_NANDF_CS_2,
+	MX53_PAD_NANDF_CS3__EMI_NANDF_CS_3,
+	MX53_PAD_EIM_DA0__EMI_NAND_WEIM_DA_0,
+	MX53_PAD_EIM_DA1__EMI_NAND_WEIM_DA_1,
+	MX53_PAD_EIM_DA2__EMI_NAND_WEIM_DA_2,
+	MX53_PAD_EIM_DA3__EMI_NAND_WEIM_DA_3,
+	MX53_PAD_EIM_DA4__EMI_NAND_WEIM_DA_4,
+	MX53_PAD_EIM_DA5__EMI_NAND_WEIM_DA_5,
+	MX53_PAD_EIM_DA6__EMI_NAND_WEIM_DA_6,
+	MX53_PAD_EIM_DA7__EMI_NAND_WEIM_DA_7,
 };
 
 static const struct imxuart_platform_data mx53_evk_uart_pdata __initconst = {
@@ -131,6 +151,30 @@ static const struct spi_imx_master mx53_evk_spi_data __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
 };
 
+static const struct mxc_nand_platform_data mx53_evk_nand_pdata __initconst = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
+static int mx53_evk_nand_pinmux_init(void)
+{
+	u32 reg;
+	void __iomem *base;
+
+	base = ioremap(MX53_M4IF_BASE_ADDR, SZ_4K);
+	if (!base)
+		return -ENOMEM;
+
+	/* NAND MUXed from WEIM pins on MX53EVK*/
+	reg = __raw_readl(base + 0xc);
+	reg &= ~1;
+	__raw_writel(reg, base + 0xc);
+	iounmap(base);
+
+	return 0;
+}
+
 static void __init mx53_evk_board_init(void)
 {
 	imx53_soc_init();
@@ -152,6 +196,9 @@ static void __init mx53_evk_board_init(void)
 	imx53_add_ecspi(0, &mx53_evk_spi_data);
 	imx53_add_imx2_wdt(0, NULL);
 	gpio_led_register_device(-1, &mx53evk_leds_data);
+
+	mx53_evk_nand_pinmux_init();
+	imx53_add_mxc_nand(&mx53_evk_nand_pdata);
 }
 
 static void __init mx53_evk_timer_init(void)
-- 
1.7.4.1
