From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:45 -0700
Subject: [PATCH 41/46] davinci: RMII support for DA850/OMAP-L138 EVM
In-Reply-To: <1255720190-7452-42-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-41-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-42-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-43-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chaithrika U S <chaithrika@ti.com>

DA850/OMAP-L138 EVM has a RMII Ethernet PHY on the UI daughter card. The PHY
is enabled by proper programming of the IO Expander (TCA6416) ports. Also for
RMII PHY to work, the MDIO clock of MII PHY has to be disabled since both the
PHYs have the same address. This is done via the GPIO2[6] pin. This patch adds
support for RMII PHY.

This patch also adds a menuconfig option to select one or no peripheral
connected to expander. Currently, sub-options in this menu are RMII and no
peripheral.This menuconfig option is similar to the one present for UI card on
DA830/OMAP-L137 EVM.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Kconfig              |   31 +++++++++++++
 arch/arm/mach-davinci/board-da850-evm.c    |   68 ++++++++++++++++++++++++++-
 arch/arm/mach-davinci/da850.c              |   17 +++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 arch/arm/mach-davinci/include/mach/mux.h   |    9 ++++
 5 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 6c81b6c..dc273b4 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -130,6 +130,37 @@ config MACH_DAVINCI_DA850_EVM
 	help
 	  Say Y here to select the TI DA850/OMAP-L138 Evaluation Module.
 
+config DA850_UI_EXP
+	bool "DA850/OMAP-L138 UI (User Interface) board expander configuration"
+	depends on MACH_DAVINCI_DA850_EVM
+	select GPIO_PCA953X
+	help
+	  Say Y here if you have the DA850/OMAP-L138 UI
+	  (User Interface) board installed and you want to
+	  enable the peripherals located on User Interface
+	  board contorlled by TCA6416 expander.
+
+choice
+	prompt "Select peripherals connected to expander on UI board"
+	depends on DA850_UI_EXP
+
+config DA850_UI_NONE
+	bool "No peripheral is enabled"
+	help
+	  Say Y if you do not want to enable any of the peripherals connected
+	  to TCA6416 expander on DA850/OMAP-L138 EVM UI card
+
+config DA850_UI_RMII
+	bool "RMII Ethernet PHY"
+	help
+	  Say Y if you want to use the RMII PHY on the DA850/OMAP-L138 EVM.
+	  This PHY is found on the UI daughter card that is supplied with
+	  the EVM.
+	  NOTE: Please take care while choosing this option, MII PHY will
+	  not be functional if RMII mode is selected.
+
+endchoice
+
 config DAVINCI_MUX
 	bool "DAVINCI multiplexing support"
 	depends on ARCH_DAVINCI
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 05b2d87..53e434b 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -45,6 +45,8 @@
 #define DA850_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
 #define DA850_MMCSD_WP_PIN		GPIO_TO_PIN(4, 1)
 
+#define DA850_MII_MDIO_CLKEN_PIN	GPIO_TO_PIN(2, 6)
+
 static struct mtd_partition da850_evm_norflash_partition[] = {
 	{
 		.name           = "NOR filesystem",
@@ -152,6 +154,7 @@ static void da850_evm_setup_nor_nand(void);
 static int da850_evm_ui_expander_setup(struct i2c_client *client, unsigned gpio,
 						unsigned ngpio, void *c)
 {
+	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	int sel_a, sel_b, sel_c, ret;
 
 	sel_a = gpio + 7;
@@ -186,6 +189,10 @@ static int da850_evm_ui_expander_setup(struct i2c_client *client, unsigned gpio,
 
 	da850_evm_setup_nor_nand();
 
+	if (soc_info->emac_pdata->rmii_en)
+		/* enable RMII */
+		gpio_set_value(sel_a, 0);
+
 	return 0;
 
 exp_setup_selc_fail:
@@ -509,6 +516,58 @@ static const short da850_evm_lcdc_pins[] = {
 	-1
 };
 
+static int __init da850_evm_config_emac(u8 rmii_en)
+{
+	void __iomem *cfg_chip3_base;
+	int ret;
+	u32 val;
+
+	cfg_chip3_base = DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP3_REG);
+
+	/* configure the CFGCHIP3 register for RMII or MII */
+	val = __raw_readl(cfg_chip3_base);
+	if (rmii_en)
+		val |= BIT(8);
+	else
+		val &= ~BIT(8);
+
+	__raw_writel(val, cfg_chip3_base);
+
+	if (!rmii_en)
+		ret = da8xx_pinmux_setup(da850_cpgmac_pins);
+	else
+		ret = da8xx_pinmux_setup(da850_rmii_pins);
+	if (ret)
+		pr_warning("da850_evm_init: cpgmac/rmii mux setup failed: %d\n",
+				ret);
+
+	ret = davinci_cfg_reg(DA850_GPIO2_6);
+	if (ret)
+		pr_warning("da850_evm_init:GPIO(2,6) mux setup "
+							"failed\n");
+
+	ret = gpio_request(DA850_MII_MDIO_CLKEN_PIN, "mdio_clk_en");
+	if (ret) {
+		pr_warning("Cannot open GPIO %d\n",
+					DA850_MII_MDIO_CLKEN_PIN);
+		return ret;
+	}
+
+	if (rmii_en) {
+		/* Disable MII MDIO clock */
+		gpio_direction_output(DA850_MII_MDIO_CLKEN_PIN, 1);
+		pr_info("EMAC: RMII PHY configured, MII PHY will not be"
+							" functional\n");
+	} else {
+		/* Enable MII MDIO clock */
+		gpio_direction_output(DA850_MII_MDIO_CLKEN_PIN, 0);
+		pr_info("EMAC: MII PHY configured, RMII PHY will not be"
+							" functional\n");
+	}
+
+	return 0;
+}
+
 static __init void da850_evm_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
@@ -536,12 +595,15 @@ static __init void da850_evm_init(void)
 
 	soc_info->emac_pdata->phy_mask = DA850_EVM_PHY_MASK;
 	soc_info->emac_pdata->mdio_max_freq = DA850_EVM_MDIO_FREQUENCY;
+#ifdef CONFIG_DA850_UI_RMII
+	soc_info->emac_pdata->rmii_en = 1;
+#else
 	soc_info->emac_pdata->rmii_en = 0;
+#endif
 
-	ret = da8xx_pinmux_setup(da850_cpgmac_pins);
+	ret = da850_evm_config_emac(soc_info->emac_pdata->rmii_en);
 	if (ret)
-		pr_warning("da850_evm_init: cpgmac mux setup failed: %d\n",
-				ret);
+		pr_warning("da850_evm_init: emac setup failed: %d\n", ret);
 
 	ret = da8xx_register_emac();
 	if (ret)
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 1d6d8b4..b804d57 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -422,6 +422,14 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, MII_RXD_0,	3,	28,	15,	8,	false)
 	MUX_CFG(DA850, MDIO_CLK,	4,	0,	15,	8,	false)
 	MUX_CFG(DA850, MDIO_D,		4,	4,	15,	8,	false)
+	MUX_CFG(DA850, RMII_TXD_0,	14,	12,	15,	8,	false)
+	MUX_CFG(DA850, RMII_TXD_1,	14,	8,	15,	8,	false)
+	MUX_CFG(DA850, RMII_TXEN,	14,	16,	15,	8,	false)
+	MUX_CFG(DA850, RMII_CRS_DV,	15,	4,	15,	8,	false)
+	MUX_CFG(DA850, RMII_RXD_0,	14,	24,	15,	8,	false)
+	MUX_CFG(DA850, RMII_RXD_1,	14,	20,	15,	8,	false)
+	MUX_CFG(DA850, RMII_RXER,	14,	28,	15,	8,	false)
+	MUX_CFG(DA850, RMII_MHZ_50_CLK,	15,	0,	15,	0,	false)
 	/* McASP function */
 	MUX_CFG(DA850,	ACLKR,		0,	0,	15,	1,	false)
 	MUX_CFG(DA850,	ACLKX,		0,	4,	15,	1,	false)
@@ -524,6 +532,7 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, EMA_WAIT_1,	6,	24,	15,	1,	false)
 	MUX_CFG(DA850, NEMA_CS_2,	7,	0,	15,	1,	false)
 	/* GPIO function */
+	MUX_CFG(DA850, GPIO2_6,		6,	4,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_8,		5,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_15,	5,	0,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
@@ -565,6 +574,14 @@ const short da850_cpgmac_pins[] __initdata = {
 	-1
 };
 
+const short da850_rmii_pins[] __initdata = {
+	DA850_RMII_TXD_0, DA850_RMII_TXD_1, DA850_RMII_TXEN,
+	DA850_RMII_CRS_DV, DA850_RMII_RXD_0, DA850_RMII_RXD_1,
+	DA850_RMII_RXER, DA850_RMII_MHZ_50_CLK, DA850_MDIO_CLK,
+	DA850_MDIO_D,
+	-1
+};
+
 const short da850_mcasp_pins[] __initdata = {
 	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
 	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 401bf93..b4cf8b1 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -124,6 +124,7 @@ extern const short da850_uart2_pins[];
 extern const short da850_i2c0_pins[];
 extern const short da850_i2c1_pins[];
 extern const short da850_cpgmac_pins[];
+extern const short da850_rmii_pins[];
 extern const short da850_mcasp_pins[];
 extern const short da850_lcdcntl_pins[];
 extern const short da850_mmcsd0_pins[];
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index b2c1ad0..16b8a7f 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -774,6 +774,14 @@ enum davinci_da850_index {
 	DA850_MII_RXD_0,
 	DA850_MDIO_CLK,
 	DA850_MDIO_D,
+	DA850_RMII_TXD_0,
+	DA850_RMII_TXD_1,
+	DA850_RMII_TXEN,
+	DA850_RMII_CRS_DV,
+	DA850_RMII_RXD_0,
+	DA850_RMII_RXD_1,
+	DA850_RMII_RXER,
+	DA850_RMII_MHZ_50_CLK,
 
 	/* McASP function */
 	DA850_ACLKR,
@@ -881,6 +889,7 @@ enum davinci_da850_index {
 	DA850_NEMA_CS_2,
 
 	/* GPIO function */
+	DA850_GPIO2_6,
 	DA850_GPIO2_8,
 	DA850_GPIO2_15,
 	DA850_GPIO4_0,
-- 
1.6.4.3
