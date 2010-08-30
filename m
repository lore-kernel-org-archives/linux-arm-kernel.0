From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:57 +0530
Subject: [PATCH 33/74] ST SPEAr: Adding support for SDHCI (SDIO)
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <c58b1266539594f4485795dd282814cdea9a68b4.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/clock.c                  |   24 ++++----
 arch/arm/mach-spear13xx/include/mach/generic.h   |    1 +
 arch/arm/mach-spear13xx/include/mach/irqs.h      |    2 +-
 arch/arm/mach-spear13xx/include/mach/misc_regs.h |    4 +-
 arch/arm/mach-spear13xx/include/mach/spear.h     |    2 +-
 arch/arm/mach-spear13xx/spear1300_evb.c          |    1 +
 arch/arm/mach-spear13xx/spear13xx.c              |   22 ++++++++
 arch/arm/mach-spear3xx/clock.c                   |   15 +++++
 arch/arm/mach-spear3xx/include/mach/generic.h    |   13 +++--
 arch/arm/mach-spear3xx/include/mach/irqs.h       |    4 +-
 arch/arm/mach-spear3xx/include/mach/spear300.h   |    4 +-
 arch/arm/mach-spear3xx/include/mach/spear320.h   |    6 +-
 arch/arm/mach-spear3xx/spear300.c                |   62 ++++++++++++++++++----
 arch/arm/mach-spear3xx/spear300_evb.c            |   18 ++++++-
 arch/arm/mach-spear3xx/spear320.c                |   43 ++++++++++++----
 arch/arm/mach-spear3xx/spear320_evb.c            |   15 +++++-
 16 files changed, 187 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 630ab65..98ba04e 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -365,15 +365,15 @@ static struct clk uart_clk = {
 	.recalc = &follow_parent,
 };
 
-/* sd configurations */
-static struct aux_clk_config sd_synth_config = {
-	.synth_reg = SD_CLK_SYNT,
+/* sdhci configurations */
+static struct aux_clk_config sdhci_synth_config = {
+	.synth_reg = SDHCI_CLK_SYNT,
 	.masks = &aux_masks,
 };
 
-/* sd synth clock */
-static struct clk sd_synth_clk = {
-	.en_reg = SD_CLK_SYNT,
+/* sdhci synth clock */
+static struct clk sdhci_synth_clk = {
+	.en_reg = SDHCI_CLK_SYNT,
 	.en_reg_bit = AUX_SYNT_ENB,
 	.pclk = &pll1div2_clk,
 	.calc_rate = &aux_calc_rate,
@@ -383,11 +383,11 @@ static struct clk sd_synth_clk = {
 	.private_data = &sdhci_synth_config,
 };
 
-/* sd clock */
-static struct clk sd_clk = {
+/* sdhci clock */
+static struct clk sdhci_clk = {
 	.en_reg = PERIP1_CLK_ENB,
-	.en_reg_bit = SD_CLK_ENB,
-	.pclk = &sd_synth_clk,
+	.en_reg_bit = SDHCI_CLK_ENB,
+	.pclk = &sdhci_synth_clk,
 	.recalc = &follow_parent,
 };
 
@@ -833,7 +833,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{.con_id = "gmii_txclk123_pad_clk",	.clk = &gmii_txclk125_pad},
 	{.con_id = "clcd_synth_clk",		.clk = &clcd_synth_clk},
 	{.con_id = "uart_synth_clk",		.clk = &uart_synth_clk},
-	{.con_id = "sd_synth_clk",		.clk = &sd_synth_clk},
+	{.con_id = "sdhci_synth_clk",		.clk = &sdhci_synth_clk},
 	{.con_id = "cfxd_synth_clk",		.clk = &cfxd_synth_clk},
 	{.con_id = "gmac_phy_input_clk",	.clk = &gmac_phy_input_clk},
 	{.con_id = "gmac_phy_synth_clk",	.clk = &gmac_phy_synth_clk},
@@ -862,7 +862,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{.dev_id = "pcie1",		.clk = &pcie1_clk},
 	{.dev_id = "pcie2",		.clk = &pcie2_clk},
 	{.dev_id = "cfxd",		.clk = &cfxd_clk},
-	{.dev_id = "sd",		.clk = &sd_clk},
+	{.dev_id = "sdhci",		.clk = &sdhci_clk},
 	{.con_id = "fsmc",		.clk = &fsmc_clk},
 	{.dev_id = "sysram0",		.clk = &sysram0_clk},
 	{.dev_id = "sysram1",		.clk = &sysram1_clk},
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 967e96e..a09bf62 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -40,6 +40,7 @@ extern struct platform_device nand_device;
 extern struct platform_device ohci0_device;
 extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
+extern struct platform_device sdhci_device;
 extern struct platform_device smi_device;
 extern struct sys_timer spear13xx_timer;
 
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
index 97d0d80..d2bfbb1 100644
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -45,7 +45,7 @@
 #define IRQ_GPIO1		(IRQ_SHPI_START + 25)
 #define IRQ_PLAY_I2S1		(IRQ_SHPI_START + 26)
 #define IRQ_JPEG		(IRQ_SHPI_START + 27)
-#define IRQ_MMC			(IRQ_SHPI_START + 28)
+#define IRQ_SDHCI		(IRQ_SHPI_START + 28)
 #define IRQ_CF			(IRQ_SHPI_START + 29)
 #define IRQ_SMI			(IRQ_SHPI_START + 30)
 #define IRQ_SSP			(IRQ_SHPI_START + 31)
diff --git a/arch/arm/mach-spear13xx/include/mach/misc_regs.h b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
index bc785f9..2529a48 100644
--- a/arch/arm/mach-spear13xx/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear13xx/include/mach/misc_regs.h
@@ -120,7 +120,7 @@
 
 #define UART_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x254))
 #define GMAC_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x258))
-#define SD_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x25c))
+#define SDHCI_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x25c))
 #define CFXD_CLK_SYNT		((unsigned int *)(MISC_BASE + 0x260))
 #define RAS_CLK_SYNT0		((unsigned int *)(MISC_BASE + 0x264))
 #define RAS_CLK_SYNT1		((unsigned int *)(MISC_BASE + 0x268))
@@ -145,7 +145,7 @@
 	#define SYSRAM0_CLK_ENB		3
 	#define FSMC_CLK_ENB		4
 	#define SMI_CLK_ENB		5
-	#define SD_CLK_ENB		6
+	#define SDHCI_CLK_ENB		6
 	#define CFXD_CLK_ENB		7
 	#define GMAC_CLK_ENB		8
 	#define UHC0_CLK_ENB		9
diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
index 716e215..282ef2f 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -84,7 +84,7 @@
 #define SPEAR13XX_FSMC_BASE		0xB0000000
 #define SPEAR13XX_JPEG_BASE		0xB2000000
 #define SPEAR13XX_MCIF_CF_BASE		0xB2800000
-#define SPEAR13XX_MCIF_MMC_BASE		0xB3000000
+#define SPEAR13XX_MCIF_SDHCI_BASE	0xB3000000
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
 #define SPEAR_DBG_UART_BASE		SPEAR13XX_UART_BASE
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 6aaae5a..aed4bba 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -42,6 +42,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&ohci0_device,
 	&ohci1_device,
 	&rtc_device,
+	&sdhci_device,
 	&smi_device,
 };
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 9e4a673..b06f59e 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -377,6 +377,28 @@ int enable_pcie0_clk(void)
 }
 #endif
 
+/* sdhci (sdio) device declaration */
+static struct resource sdhci_resources[] = {
+	{
+		.start	= SPEAR13XX_MCIF_SDHCI_BASE,
+		.end	= SPEAR13XX_MCIF_SDHCI_BASE + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_SDHCI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device sdhci_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.name = "sdhci",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(sdhci_resources),
+	.resource = sdhci_resources,
+};
+
 /* Do spear13xx familiy common initialization part here */
 void __init spear13xx_init(void)
 {
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 51cf304..b56a755 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -525,6 +525,16 @@ static struct clk fsmc_clk = {
 };
 #endif
 
+/* common clocks to spear300 and spear320 */
+#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR320)
+/* sdhci clock */
+static struct clk sdhci_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ahb_clk,
+	.recalc = &follow_parent,
+};
+#endif /* CONFIG_MACH_SPEAR300 || CONFIG_MACH_SPEAR320 */
+
 /* spear300 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR300
 /* keyboard clock */
@@ -618,6 +628,11 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
 	{ .dev_id = "pwm",		.clk = &pwm_clk},
 #endif
+
+	/* common clock to spear300 and spear320 */
+#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR320)
+	{ .dev_id = "sdhci",	.clk = &sdhci_clk},
+#endif /* CONFIG_MACH_SPEAR300 || CONFIG_MACH_SPEAR320 */
 };
 
 void __init clk_init(void)
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 04ce870..9bd9424 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -116,6 +116,7 @@ extern struct platform_device nand0_device;
 extern struct platform_device nand1_device;
 extern struct platform_device nand2_device;
 extern struct platform_device nand3_device;
+extern struct platform_device sdhci_device;
 
 /* pad mux modes */
 extern struct pmx_mode nand_mode;
@@ -144,12 +145,15 @@ extern struct pmx_dev pmx_telecom_camera;
 extern struct pmx_dev pmx_telecom_dac;
 extern struct pmx_dev pmx_telecom_i2s;
 extern struct pmx_dev pmx_telecom_boot_pins;
-extern struct pmx_dev pmx_telecom_sdio_4bit;
-extern struct pmx_dev pmx_telecom_sdio_8bit;
+extern struct pmx_dev pmx_telecom_sdhci_4bit;
+extern struct pmx_dev pmx_telecom_sdhci_8bit;
 extern struct pmx_dev pmx_gpio1;
 
 /* Add spear300 machine function declarations here */
 void __init spear300_init(void);
+#define SDHCI_MEM_ENB	0x1
+#define I2S_MEM_ENB	0x2
+void sdhci_i2s_mem_enable(u8 mask);
 
 /* Add misc structure declarations here */
 extern struct clcd_board clcd_plat_data;
@@ -182,6 +186,7 @@ extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
 extern struct platform_device pwm_device;
+extern struct platform_device sdhci_device;
 
 /* pad mux modes */
 extern struct pmx_mode auto_net_smii_mode;
@@ -194,14 +199,14 @@ extern struct pmx_dev pmx_clcd;
 extern struct pmx_dev pmx_emi;
 extern struct pmx_dev pmx_fsmc;
 extern struct pmx_dev pmx_spp;
-extern struct pmx_dev pmx_sdio;
+extern struct pmx_dev pmx_sdhci;
 extern struct pmx_dev pmx_i2s;
 extern struct pmx_dev pmx_uart1;
 extern struct pmx_dev pmx_uart1_modem;
 extern struct pmx_dev pmx_uart2;
 extern struct pmx_dev pmx_touchscreen;
 extern struct pmx_dev pmx_can;
-extern struct pmx_dev pmx_sdio_led;
+extern struct pmx_dev pmx_sdhci_led;
 extern struct pmx_dev pmx_pwm0;
 extern struct pmx_dev pmx_pwm1;
 extern struct pmx_dev pmx_pwm2;
diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
index 5ad7574..df0c1f3 100644
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
@@ -69,7 +69,7 @@
 #define IRQ_CLCD				IRQ_GEN_RAS_3
 
 /* IRQs sharing IRQ_INTRCOMM_RAS_ARM */
-#define IRQ_SDIO				IRQ_INTRCOMM_RAS_ARM
+#define IRQ_SDHCI				IRQ_INTRCOMM_RAS_ARM
 
 /* GPIO pins virtual irqs */
 #define SPEAR_GPIO_INT_BASE			(VIRQ_START + 9)
@@ -115,7 +115,7 @@
 #define VIRQ_SPP				(VIRQ_START + 2)
 
 /* IRQs sharing IRQ_GEN_RAS_2 */
-#define IRQ_SDIO				IRQ_GEN_RAS_2
+#define IRQ_SDHCI				IRQ_GEN_RAS_2
 
 /* IRQs sharing IRQ_GEN_RAS_3 */
 #define VIRQ_PLGPIO				(VIRQ_START + 3)
diff --git a/arch/arm/mach-spear3xx/include/mach/spear300.h b/arch/arm/mach-spear3xx/include/mach/spear300.h
index ccaa765..1059d5a 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear300.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear300.h
@@ -39,8 +39,8 @@
 #define SPEAR300_CLCD_BASE		0x60000000
 #define SPEAR300_CLCD_SIZE		0x10000000
 
-#define SPEAR300_SDIO_BASE		0x70000000
-#define SPEAR300_SDIO_SIZE		0x10000000
+#define SPEAR300_SDHCI_BASE		0x70000000
+#define SPEAR300_SDHCI_SIZE		0x10000000
 
 #define SPEAR300_NAND_0_BASE		0x80000000
 #define SPEAR300_NAND_0_SIZE		0x04000000
diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
index aa6727c..89f5bfb 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
@@ -28,8 +28,8 @@
 #define SPEAR320_I2S_BASE		0x60000000
 #define SPEAR320_I2S_SIZE		0x10000000
 
-#define SPEAR320_SDIO_BASE		0x70000000
-#define SPEAR320_SDIO_SIZE		0x10000000
+#define SPEAR320_SDHCI_BASE		0x70000000
+#define SPEAR320_SDHCI_SIZE		0x10000000
 
 #define SPEAR320_CLCD_BASE		0x90000000
 #define SPEAR320_CLCD_SIZE		0x10000000
@@ -77,7 +77,7 @@
 #define EMI_IRQ_MASK			(1 << 7)
 #define CLCD_IRQ_MASK			(1 << 8)
 #define SPP_IRQ_MASK			(1 << 9)
-#define SDIO_IRQ_MASK			(1 << 10)
+#define SDHCI_IRQ_MASK			(1 << 10)
 #define CAN_U_IRQ_MASK			(1 << 11)
 #define CAN_L_IRQ_MASK			(1 << 12)
 #define UART1_IRQ_MASK			(1 << 13)
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 3a86868..e11a625 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -311,7 +311,7 @@ struct pmx_dev pmx_telecom_boot_pins = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
+struct pmx_dev_mode pmx_telecom_sdhci_4bit_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
 			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
@@ -324,14 +324,14 @@ struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdio_4bit = {
-	.name = "telecom_sdio_4bit",
-	.modes = pmx_telecom_sdio_4bit_modes,
-	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_4bit_modes),
+struct pmx_dev pmx_telecom_sdhci_4bit = {
+	.name = "telecom_sdhci_4bit",
+	.modes = pmx_telecom_sdhci_4bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_sdhci_4bit_modes),
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
+struct pmx_dev_mode pmx_telecom_sdhci_8bit_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
 			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
@@ -343,10 +343,10 @@ struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdio_8bit = {
-	.name = "telecom_sdio_8bit",
-	.modes = pmx_telecom_sdio_8bit_modes,
-	.mode_count = ARRAY_SIZE(pmx_telecom_sdio_8bit_modes),
+struct pmx_dev pmx_telecom_sdhci_8bit = {
+	.name = "telecom_sdhci_8bit",
+	.modes = pmx_telecom_sdhci_8bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_telecom_sdhci_8bit_modes),
 	.enb_on_reset = 1,
 };
 
@@ -524,6 +524,28 @@ struct platform_device nand3_device = {
 	.dev.platform_data = &nand3_platform_data,
 };
 
+/* sdhci (sdio) device declaration */
+static struct resource sdhci_resources[] = {
+	{
+		.start	= SPEAR300_SDHCI_BASE,
+		.end	= SPEAR300_SDHCI_BASE + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_SDHCI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device sdhci_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.name = "sdhci",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(sdhci_resources),
+	.resource = sdhci_resources,
+};
+
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
@@ -577,6 +599,26 @@ struct spear_shirq shirq_ras1 = {
 	},
 };
 
+/* Function handling sdhci and i2s memory sharing */
+#define SDHCI_MEM_SELECT	0x20000000
+void sdhci_i2s_mem_enable(u8 mask)
+{
+	u32 val;
+	void __iomem *base = ioremap(SPEAR300_SOC_CONFIG_BASE,
+			SPEAR300_SOC_CONFIG_SIZE);
+	if (!base) {
+		pr_debug("sdhci_i2s_enb: ioremap fail\n");
+		return;
+	}
+
+	val = readl(base + MODE_CONFIG_REG);
+	if (mask == SDHCI_MEM_ENB)
+		val |= SDHCI_MEM_SELECT;
+	else
+		val &= ~SDHCI_MEM_SELECT;
+	writel(val, base + MODE_CONFIG_REG);
+}
+
 /* spear300 routines */
 void __init spear300_init(void)
 {
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 653adec..d6eb2a7 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -16,6 +16,7 @@
 #include <asm/mach-types.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
+#include <linux/mmc/sdhci-spear.h>
 #include <mach/generic.h>
 #include <mach/gpio.h>
 #include <mach/spear.h>
@@ -36,7 +37,7 @@ static struct pmx_dev *pmx_devs[] = {
 	/* spear300 specific devices */
 	&pmx_fsmc_2_chips,
 	&pmx_clcd,
-	&pmx_telecom_sdio_4bit,
+	&pmx_telecom_sdhci_4bit,
 	&pmx_gpio1,
 };
 
@@ -64,6 +65,15 @@ static struct platform_device *plat_devs[] __initdata = {
 
 	/* spear300 specific devices */
 	&kbd_device,
+	&sdhci_device,
+};
+
+/* sdhci board specific information */
+static struct sdhci_plat_data sdhci_plat_data = {
+	.card_power_gpio = RAS_GPIO_2,
+	.power_active_high = 0,
+	.power_always_enb = 0,
+	.card_int_gpio = RAS_GPIO_0,
 };
 
 /* keyboard specific platform data */
@@ -134,6 +144,12 @@ static void __init spear300_evb_init(void)
 	nand_set_plat_data(&nand0_device, NULL, 0, NAND_SKIP_BBTSCAN,
 			SPEAR_NAND_BW8);
 
+	/* set sdhci device platform data */
+	sdhci_set_plat_data(&sdhci_device, &sdhci_plat_data);
+
+	/* Enable sdhci memory */
+	sdhci_i2s_mem_enable(SDHCI_MEM_ENB);
+
 	/* call spear300 machine init function */
 	spear300_init();
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 9c3d75f..341ba4a 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -13,6 +13,8 @@
 
 #include <linux/amba/pl022.h>
 #include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/mmc/sdhci-spear.h>
 #include <asm/irq.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
@@ -113,7 +115,7 @@ struct pmx_dev pmx_spp = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_sdio_modes[] = {
+struct pmx_dev_mode pmx_sdhci_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE |
 			SMALL_PRINTERS_MODE,
@@ -121,10 +123,10 @@ struct pmx_dev_mode pmx_sdio_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_sdio = {
-	.name = "sdio",
-	.modes = pmx_sdio_modes,
-	.mode_count = ARRAY_SIZE(pmx_sdio_modes),
+struct pmx_dev pmx_sdhci = {
+	.name = "sdhci",
+	.modes = pmx_sdhci_modes,
+	.mode_count = ARRAY_SIZE(pmx_sdhci_modes),
 	.enb_on_reset = 1,
 };
 
@@ -218,17 +220,17 @@ struct pmx_dev pmx_can = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_sdio_led_modes[] = {
+struct pmx_dev_mode pmx_sdhci_led_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
 		.mask = PMX_SSP_CS_MASK,
 	},
 };
 
-struct pmx_dev pmx_sdio_led = {
-	.name = "sdio_led",
-	.modes = pmx_sdio_led_modes,
-	.mode_count = ARRAY_SIZE(pmx_sdio_led_modes),
+struct pmx_dev pmx_sdhci_led = {
+	.name = "sdhci_led",
+	.modes = pmx_sdhci_led_modes,
+	.mode_count = ARRAY_SIZE(pmx_sdhci_led_modes),
 	.enb_on_reset = 1,
 };
 
@@ -536,6 +538,27 @@ struct platform_device pwm_device = {
 	.resource = pwm_resources,
 };
 
+/* sdhci (sdio) device registeration */
+static struct resource sdhci_resources[] = {
+	{
+		.start	= SPEAR320_SDHCI_BASE,
+		.end	= SPEAR320_SDHCI_BASE + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_SDHCI,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device sdhci_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.name = "sdhci",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(sdhci_resources),
+	.resource = sdhci_resources,
+};
 
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 99ae3ba..52f3b75 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -15,6 +15,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <linux/spi/flash.h>
+#include <linux/mmc/sdhci-spear.h>
 #include <linux/spi/spi.h>
 #include <mach/generic.h>
 #include <mach/gpio.h>
@@ -33,7 +34,7 @@ static struct pmx_dev *pmx_devs[] = {
 
 	/* spear320 specific devices */
 	&pmx_fsmc,
-	&pmx_sdio,
+	&pmx_sdhci,
 	&pmx_i2s,
 	&pmx_uart1,
 	&pmx_uart2,
@@ -68,6 +69,15 @@ static struct platform_device *plat_devs[] __initdata = {
 	&i2c1_device,
 	&plgpio_device,
 	&pwm_device,
+	&sdhci_device,
+};
+
+/* sdhci board specific information */
+static struct sdhci_plat_data sdhci_plat_data = {
+	.card_power_gpio = PLGPIO_61,
+	.power_active_high = 0,
+	.power_always_enb = 1,
+	.card_int_gpio = -1,
 };
 
 /* Currently no gpios are free on eval board so it is kept commented */
@@ -114,6 +124,9 @@ static void __init spear320_evb_init(void)
 {
 	unsigned int i;
 
+	/* set sdhci device platform data */
+	sdhci_set_plat_data(&sdhci_device, &sdhci_plat_data);
+
 	/* padmux initialization, must be done before spear320_init */
 	pmx_driver.mode = &auto_net_mii_mode;
 	pmx_driver.devs = pmx_devs;
-- 
1.7.2.2
