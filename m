From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 17:00:49 +0530
Subject: [PATCH V6 10/10] ST SPEAr13xx: Add padmux support
In-Reply-To: <cover.1298977719.git.viresh.kumar@st.com>
References: <cover.1298977719.git.viresh.kumar@st.com>
Message-ID: <87664a8fe885c6dfce5ded6bca70947d3bb7582f.1298977719.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

This patch adds padmux support for SPEAr1300 & SPEAr1310.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |  198 +++++++++-
 arch/arm/mach-spear13xx/spear1300.c            |   17 +-
 arch/arm/mach-spear13xx/spear1300_evb.c        |   21 +-
 arch/arm/mach-spear13xx/spear1310.c            |  352 +++++++++++++++-
 arch/arm/mach-spear13xx/spear1310_evb.c        |   27 ++-
 arch/arm/mach-spear13xx/spear13xx.c            |  559 ++++++++++++++++++++++++
 arch/arm/plat-spear/Makefile                   |    1 +
 7 files changed, 1169 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 64feaa5..a75de93 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -19,6 +19,198 @@
 #include <linux/amba/bus.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
+#include <plat/padmux.h>
+
+/*
+ * Function enable (Pad multiplexing register) offsets
+ */
+/* Pad multiplexing base */
+#define SPEAR13XX_FUNC_ENB_BASE		UL(0xE0700650)
+#define SPEAR13XX_PCM_CFG_BASE		UL(0xE0700100)
+
+#define PAD_MUX_CONFIG_REG_0	UL(0xE0700650)
+#define PAD_MUX_CONFIG_REG_1	UL(0xE0700654)
+#define PAD_MUX_CONFIG_REG_2	UL(0xE0700658)
+#define PAD_MUX_CONFIG_REG_3	UL(0xE070065C)
+
+#if defined(CONFIG_MACH_SPEAR1310)
+#define SPEAR1310_FUNC_CNTL_0	UL(0x6C800000)
+
+#define PMX_SMII_MASK		(1 << 24)	/* Func cntl reg0 */
+#define PMX_EGPIO7_MASK		(1 << 2)	/* Pcm cfg reg */
+#endif
+
+/* pad mux declarations */
+#define PMX_I2S1_MASK		(1 << 3)
+#define PMX_I2S2_MASK		(1 << 16)	/* Offset 4 */
+#define PMX_CLCD1_MASK		(1 << 5)
+#define PMX_CLCD2_MASK		(1 << 3)	/* Offset 4 */
+#define PMX_EGPIO00_MASK	(1 << 6)
+#define PMX_EGPIO01_MASK	(1 << 7)
+#define PMX_EGPIO02_MASK	(1 << 8)
+#define PMX_EGPIO03_MASK	(1 << 9)
+#define PMX_EGPIO04_MASK	(1 << 10)
+#define PMX_EGPIO05_MASK	(1 << 11)
+#define PMX_EGPIO06_MASK	(1 << 12)
+#define PMX_EGPIO07_MASK	(1 << 13)
+#define PMX_EGPIO08_MASK	(1 << 14)
+#define PMX_EGPIO09_MASK	(1 << 15)
+#define PMX_EGPIO10_MASK	(1 << 5)	/* Offset 4 */
+#define PMX_EGPIO11_MASK	(1 << 6)	/* Offset 4 */
+#define PMX_EGPIO12_MASK	(1 << 7)	/* Offset 4 */
+#define PMX_EGPIO13_MASK	(1 << 8)	/* Offset 4 */
+#define PMX_EGPIO14_MASK	(1 << 9)	/* Offset 4 */
+#define PMX_EGPIO15_MASK	(1 << 10)	/* Offset 4 */
+#define PMX_EGPIO_0_GRP_MASK	(PMX_EGPIO00_MASK | PMX_EGPIO01_MASK | \
+		PMX_EGPIO02_MASK | PMX_EGPIO03_MASK | PMX_EGPIO04_MASK | \
+		PMX_EGPIO05_MASK | PMX_EGPIO06_MASK | PMX_EGPIO07_MASK | \
+		PMX_EGPIO08_MASK | PMX_EGPIO09_MASK)
+#define PMX_EGPIO_1_GRP_MASK	(PMX_EGPIO10_MASK | PMX_EGPIO11_MASK | \
+		PMX_EGPIO12_MASK | PMX_EGPIO13_MASK | PMX_EGPIO14_MASK | \
+		PMX_EGPIO15_MASK)
+
+#define PMX_SMI_MASK		(1 << 16)
+#define PMX_SMINCS2_MASK	(1 << 1)	/* Offset 4 */
+#define PMX_SMINCS3_MASK	(1 << 2)	/* Offset 4 */
+
+#define PMX_GMIICLK_MASK			(1 << 18)
+#define PMX_GMIICOL_CRS_XFERER_MIITXCLK_MASK	(1 << 19)
+#define PMX_RXCLK_RDV_TXEN_D03_MASK		(1 << 20)
+#define PMX_GMIID47_MASK			(1 << 21)
+#define PMX_MDC_MDIO_MASK			(1 << 22)
+
+#define PMX_GMII_MASK		(PMX_GMIICLK_MASK | \
+		PMX_GMIICOL_CRS_XFERER_MIITXCLK_MASK | \
+		PMX_RXCLK_RDV_TXEN_D03_MASK | PMX_GMIID47_MASK | \
+		PMX_MDC_MDIO_MASK)
+
+#define PMX_NAND8_MASK		(1 << 17)
+#define PMX_NFAD023_MASK	(1 << 24)
+#define PMX_NFAD24_MASK		(1 << 25)
+#define PMX_NFAD25_MASK		(1 << 26)
+#define PMX_NFWPRT1_MASK	(1 << 24)	/* Offset 4 */
+#define PMX_NFWPRT2_MASK	(1 << 26)	/* Offset 4 */
+#define PMX_NFWPRT3_MASK	(1 << 28)
+#define PMX_NFRSTPWDWN0_MASK	(1 << 29)
+#define PMX_NFRSTPWDWN1_MASK	(1 << 30)
+#define PMX_NFRSTPWDWN2_MASK	(1 << 31)
+#define PMX_NFRSTPWDWN3_MASK	(1 << 0)	/* Offset 4 */
+#define PMX_NFCE1_MASK		(1 << 20)	/* Offset 4 */
+#define PMX_NFCE2_MASK		(1 << 22)	/* Offset 4 */
+#define PMX_NFCE3_MASK		(1 << 27)
+#define PMX_NFIO815_MASK	(1 << 18)	/* Offset 4 */
+
+#define PMX_NAND8BIT_0_MASK	(PMX_NAND8_MASK | PMX_NFAD023_MASK | \
+		PMX_NFAD24_MASK | PMX_NFAD25_MASK | PMX_NFWPRT3_MASK | \
+		PMX_NFRSTPWDWN0_MASK | PMX_NFRSTPWDWN1_MASK | \
+		PMX_NFRSTPWDWN2_MASK | PMX_NFCE3_MASK)
+#define PMX_NAND8BIT_1_MASK	(PMX_NFRSTPWDWN3_MASK)
+
+#define PMX_NAND8BIT4DEV_0_MASK	(PMX_NAND8BIT_0_MASK)
+#define PMX_NAND8BIT4DEV_1_MASK	(PMX_NAND8BIT_1_MASK | PMX_NFCE1_MASK | \
+		PMX_NFCE2_MASK | PMX_NFWPRT1_MASK | PMX_NFWPRT2_MASK)
+
+#define PMX_NAND16BIT_0_MASK	(PMX_NAND8BIT_0_MASK)
+#define PMX_NAND16BIT_1_MASK	(PMX_NAND8BIT_1_MASK | PMX_NFIO815_MASK)
+#define PMX_NAND16BIT4DEV_0_MASK	(PMX_NAND8BIT4DEV_0_MASK)
+#define PMX_NAND16BIT4DEV_1_MASK	(PMX_NAND8BIT4DEV_1_MASK | \
+					PMX_NFIO815_MASK)
+
+#define PMX_KBD_ROW0_MASK	(1 << 25)	/* Offset 4 */
+#define PMX_KBD_ROW1_MASK	(1 << 23)	/* Offset 4 */
+#define PMX_KBD_ROWCOL25_MASK	(1 << 17)	/* Offset 4 */
+#define PMX_KBD_ROWCOL68_MASK	(1 << 4)	/* Offset 4 */
+#define PMX_KBD_COL0_MASK	(1 << 21)	/* Offset 4 */
+#define PMX_KBD_COL1_MASK	(1 << 19)	/* Offset 4 */
+#define PMX_KEYBOARD_6X6_MASK	(PMX_KBD_ROW0_MASK | PMX_KBD_ROW1_MASK | \
+		PMX_KBD_ROWCOL25_MASK | PMX_KBD_COL0_MASK | PMX_KBD_COL1_MASK)
+
+#define PMX_UART0_MASK		(1 << 1)
+#define PMX_I2C_MASK		(1 << 2)
+#define PMX_SSP_MASK		(1 << 4)
+#define PMX_UART0_MODEM_MASK	(1 << 11)	/* Offset 4 */
+#define PMX_GPT0_TMR1_MASK	(1 << 12)	/* Offset 4 */
+#define PMX_GPT0_TMR2_MASK	(1 << 13)	/* Offset 4 */
+#define PMX_GPT1_TMR1_MASK	(1 << 14)	/* Offset 4 */
+#define PMX_GPT1_TMR2_MASK	(1 << 15)	/* Offset 4 */
+
+#define PMX_MCIDATA0_MASK	(1 << 27)	/* Offset 4 */
+#define PMX_MCIDATA1_MASK	(1 << 28)	/* Offset 4 */
+#define PMX_MCIDATA2_MASK	(1 << 29)	/* Offset 4 */
+#define PMX_MCIDATA3_MASK	(1 << 30)	/* Offset 4 */
+#define PMX_MCIDATA4_MASK	(1 << 31)	/* Offset 4 */
+#define PMX_MCIDATA5_MASK	(1 << 0)	/* Offset 8 */
+#define PMX_MCIDATA6_MASK	(1 << 1)	/* Offset 8 */
+#define PMX_MCIDATA7_MASK	(1 << 2)	/* Offset 8 */
+#define PMX_MCIDATA1SD_MASK	(1 << 3)	/* Offset 8 */
+#define PMX_MCIDATA2SD_MASK	(1 << 4)	/* Offset 8 */
+#define PMX_MCIDATA3SD_MASK	(1 << 5)	/* Offset 8 */
+#define PMX_MCIADDR0ALE_MASK	(1 << 6)	/* Offset 8 */
+#define PMX_MCIADDR1CLECLK_MASK	(1 << 7)	/* Offset 8 */
+#define PMX_MCIADDR2_MASK	(1 << 8)	/* Offset 8 */
+#define PMX_MCICECF_MASK	(1 << 9)	/* Offset 8 */
+#define PMX_MCICEXD_MASK	(1 << 10)	/* Offset 8 */
+#define PMX_MCICESDMMC_MASK	(1 << 11)	/* Offset 8 */
+#define PMX_MCICDCF1_MASK	(1 << 12)	/* Offset 8 */
+#define PMX_MCICDCF2_MASK	(1 << 13)	/* Offset 8 */
+#define PMX_MCICDXD_MASK	(1 << 14)	/* Offset 8 */
+#define PMX_MCICDSDMMC_MASK	(1 << 15)	/* Offset 8 */
+#define PMX_MCIDATADIR_MASK	(1 << 16)	/* Offset 8 */
+#define PMX_MCIDMARQWP_MASK	(1 << 17)	/* Offset 8 */
+#define PMX_MCIIORDRE_MASK	(1 << 18)	/* Offset 8 */
+#define PMX_MCIIOWRWE_MASK	(1 << 19)	/* Offset 8 */
+#define PMX_MCIRESETCF_MASK	(1 << 20)	/* Offset 8 */
+#define PMX_MCICS0CE_MASK	(1 << 21)	/* Offset 8 */
+#define PMX_MCICFINTR_MASK	(1 << 22)	/* Offset 8 */
+#define PMX_MCIIORDY_MASK	(1 << 23)	/* Offset 8 */
+#define PMX_MCICS1_MASK		(1 << 24)	/* Offset 8 */
+#define PMX_MCIDMAACK_MASK	(1 << 25)	/* Offset 8 */
+#define PMX_MCISDCMD_MASK	(1 << 26)	/* Offset 8 */
+#define PMX_MCILEDS_MASK	(1 << 27)	/* Offset 8 */
+
+#define PMX_MCIFALL_1_MASK	(0xF8000000)
+#define PMX_MCIFALL_2_MASK	(0x0FFFFFFF)
+
+/* pad mux devices */
+extern struct pmx_dev pmx_i2c;
+extern struct pmx_dev pmx_ssp;
+extern struct pmx_dev pmx_i2s1;
+extern struct pmx_dev pmx_i2s2;
+extern struct pmx_dev pmx_clcd;
+extern struct pmx_dev pmx_clcd_hires;
+extern struct pmx_dev pmx_egpio_grp;
+extern struct pmx_dev pmx_smi_2_chips;
+extern struct pmx_dev pmx_smi_4_chips;
+extern struct pmx_dev pmx_gmii;
+extern struct pmx_dev pmx_nand_8bit;
+extern struct pmx_dev pmx_nand_16bit;
+extern struct pmx_dev pmx_keyboard_6x6;
+extern struct pmx_dev pmx_keyboard_9x9;
+extern struct pmx_dev pmx_uart0;
+extern struct pmx_dev pmx_uart0_modem;
+extern struct pmx_dev pmx_gpt_0_1;
+extern struct pmx_dev pmx_gpt_0_2;
+extern struct pmx_dev pmx_gpt_1_1;
+extern struct pmx_dev pmx_gpt_1_2;
+extern struct pmx_dev pmx_mcif;
+
+#if defined(CONFIG_MACH_SPEAR1310)
+extern struct pmx_dev pmx_uart1_modem;
+extern struct pmx_dev pmx_uart_1;
+extern struct pmx_dev pmx_uart_2;
+extern struct pmx_dev pmx_uart_3_4_5;
+extern struct pmx_dev pmx_rs485_hdlc_1_2;
+extern struct pmx_dev pmx_tdm_hdlc_1_2;
+extern struct pmx_dev pmx_nand32bit;
+extern struct pmx_dev pmx_fsmc16bit_4_chips;
+extern struct pmx_dev pmx_fsmc32bit_4_chips;
+extern struct pmx_dev pmx_gmii1;
+extern struct pmx_dev pmx_rgmii;
+extern struct pmx_dev pmx_i2c1;
+extern struct pmx_dev pmx_smii_0_1_2;
+extern struct pmx_dev pmx_can;
+extern struct pmx_dev pmx_uart1_modem;
+#endif
 
 /*
  * Each GPT has 2 timer channels
@@ -43,7 +235,8 @@ void spear13xx_secondary_startup(void);
 /* spear1300 declarations */
 #ifdef CONFIG_MACH_SPEAR1300
 /* Add spear1300 machine function declarations here */
-void __init spear1300_init(void);
+void __init spear1300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR1300 */
 
@@ -59,7 +252,8 @@ extern struct platform_device spear1310_can0_device;
 extern struct platform_device spear1310_can1_device;
 
 /* Add spear1310 machine function declarations here */
-void __init spear1310_init(void);
+void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count);
 void __init spear1310_map_io(void);
 
 #endif /* CONFIG_MACH_SPEAR1310 */
diff --git a/arch/arm/mach-spear13xx/spear1300.c b/arch/arm/mach-spear13xx/spear1300.c
index 9c38bec..c0f1743 100644
--- a/arch/arm/mach-spear13xx/spear1300.c
+++ b/arch/arm/mach-spear13xx/spear1300.c
@@ -14,10 +14,25 @@
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
+/* pmx driver structure */
+static struct pmx_driver pmx_driver;
+
 /* Add spear1300 specific devices here */
 
-void __init spear1300_init(void)
+void __init spear1300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count)
 {
+	int ret;
+
 	/* call spear13xx family common init function */
 	spear13xx_init();
+
+	/* pmx initialization */
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
+
+	ret = pmx_register(&pmx_driver);
+	if (ret)
+		pr_err("padmux: registeration failed. err no: %d\n", ret);
 }
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index c95c141..2e966cf 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -17,6 +17,25 @@
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
+/* padmux devices to enable */
+static struct pmx_dev *pmx_devs[] = {
+	/* spear13xx specific devices */
+	&pmx_i2c,
+	&pmx_i2s1,
+	&pmx_i2s2,
+	&pmx_clcd,
+	&pmx_egpio_grp,
+	&pmx_gmii,
+	&pmx_keyboard_6x6,
+	&pmx_mcif,
+	&pmx_nand_8bit,
+	&pmx_smi_4_chips,
+	&pmx_ssp,
+	&pmx_uart0,
+
+	/* spear1300 specific devices */
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	&spear13xx_uart_device,
 };
@@ -29,7 +48,7 @@ static void __init spear1300_evb_init(void)
 	unsigned int i;
 
 	/* call spear1300 machine init function */
-	spear1300_init();
+	spear1300_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index e4ad092..21ec388 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -17,6 +17,344 @@
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
+/* pmx driver structure */
+static struct pmx_driver pmx_driver;
+
+/* Pad multiplexing for uart1_modem device */
+static struct pmx_mux_reg pmx_uart1_modem_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_I2S1_MASK | PMX_SSP_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_uart1_modem_modes[] = {
+	{
+		.mux_regs = pmx_uart1_modem_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_uart1_modem_mux),
+	},
+};
+
+struct pmx_dev pmx_uart1_modem = {
+	.name = "uart1_modem",
+	.modes = pmx_uart1_modem_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart1_modem_modes),
+};
+
+/* Pad multiplexing for uart1 device */
+static struct pmx_mux_reg pmx_uart1_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_SSP_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_uart1_modes[] = {
+	{
+		.mux_regs = pmx_uart1_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_uart1_mux),
+	},
+};
+
+struct pmx_dev pmx_uart_1 = {
+	.name = "uart1",
+	.modes = pmx_uart1_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart1_modes),
+};
+
+/* Pad multiplexing for uart2 device */
+static struct pmx_mux_reg pmx_uart2_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_SSP_MASK | PMX_CLCD1_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_uart2_modes[] = {
+	{
+		.mux_regs = pmx_uart2_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_uart2_mux),
+	},
+};
+
+struct pmx_dev pmx_uart_2 = {
+	.name = "uart2",
+	.modes = pmx_uart2_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart2_modes),
+};
+
+/* Pad multiplexing for uart_3_4_5 device */
+static struct pmx_mux_reg pmx_uart_3_4_5_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_CLCD1_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_uart_3_4_5_modes[] = {
+	{
+		.mux_regs = pmx_uart_3_4_5_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_uart_3_4_5_mux),
+	},
+};
+
+struct pmx_dev pmx_uart_3_4_5 = {
+	.name = "uart_3_4_5",
+	.modes = pmx_uart_3_4_5_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart_3_4_5_modes),
+};
+
+/* Pad multiplexing for rs485_hdlc_1_2 device */
+static struct pmx_mux_reg pmx_rs485_hdlc_1_2_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_CLCD1_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_rs485_hdlc_1_2_modes[] = {
+	{
+		.mux_regs = pmx_rs485_hdlc_1_2_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_rs485_hdlc_1_2_mux),
+	},
+};
+
+struct pmx_dev pmx_rs485_hdlc_1_2 = {
+	.name = "rs485_hdlc_1_2",
+	.modes = pmx_rs485_hdlc_1_2_modes,
+	.mode_count = ARRAY_SIZE(pmx_rs485_hdlc_1_2_modes),
+};
+
+/* Pad multiplexing for tdm_hdlc_1_2 device */
+static struct pmx_mux_reg pmx_tdm_hdlc_1_2_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_CLCD1_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_tdm_hdlc_1_2_modes[] = {
+	{
+		.mux_regs = pmx_tdm_hdlc_1_2_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_tdm_hdlc_1_2_mux),
+	},
+};
+
+struct pmx_dev pmx_tdm_hdlc_1_2 = {
+	.name = "tdm_hdlc_1_2",
+	.modes = pmx_tdm_hdlc_1_2_modes,
+	.mode_count = ARRAY_SIZE(pmx_tdm_hdlc_1_2_modes),
+};
+
+/* Pad multiplexing for fsmc32bit device */
+static struct pmx_mux_reg pmx_fsmc32bit_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_EGPIO_0_GRP_MASK | PMX_SMI_MASK | \
+			PMX_NAND16BIT4DEV_0_MASK | PMX_CLCD1_MASK,
+		.value = 0,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_KEYBOARD_6X6_MASK | PMX_NAND16BIT4DEV_1_MASK,
+		.value = 0,
+	}, {
+		.address = SPEAR13XX_PCM_CFG_BASE,
+		.mask = PMX_EGPIO7_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_fsmc32bit_modes[] = {
+	{
+		.mux_regs = pmx_fsmc32bit_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_fsmc32bit_mux),
+	},
+};
+
+struct pmx_dev pmx_fsmc32bit_4_chips = {
+	.name = "fsmc32bit",
+	.modes = pmx_fsmc32bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_fsmc32bit_modes),
+};
+
+/* Pad multiplexing for fsmc16bit device */
+static struct pmx_mux_reg pmx_fsmc16bit_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_NAND16BIT4DEV_0_MASK,
+		.value = 0,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_KEYBOARD_6X6_MASK | PMX_NAND16BIT4DEV_1_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_fsmc16bit_modes[] = {
+	{
+		.mux_regs = pmx_fsmc16bit_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_fsmc16bit_mux),
+	},
+};
+
+struct pmx_dev pmx_fsmc16bit_4_chips = {
+	.name = "fsmc16bit",
+	.modes = pmx_fsmc16bit_modes,
+	.mode_count = ARRAY_SIZE(pmx_fsmc16bit_modes),
+};
+
+/* Pad multiplexing for gmii1 device */
+static struct pmx_mux_reg pmx_gmii1_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_GMII_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_gmii1_modes[] = {
+	{
+		.mux_regs = pmx_gmii1_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_gmii1_mux),
+	},
+};
+
+struct pmx_dev pmx_gmii1 = {
+	.name = "gmii1",
+	.modes = pmx_gmii1_modes,
+	.mode_count = ARRAY_SIZE(pmx_gmii1_modes),
+};
+
+/* Pad multiplexing for rgmii device */
+static struct pmx_mux_reg pmx_rgmii_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_GMII_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_rgmii_modes[] = {
+	{
+		.mux_regs = pmx_rgmii_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_rgmii_mux),
+	},
+};
+
+struct pmx_dev pmx_rgmii = {
+	.name = "rgmii",
+	.modes = pmx_rgmii_modes,
+	.mode_count = ARRAY_SIZE(pmx_rgmii_modes),
+};
+
+/* Pad multiplexing for i2c1 device */
+static struct pmx_mux_reg pmx_i2c1_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_SMINCS2_MASK | PMX_SMINCS3_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_i2c1_modes[] = {
+	{
+		.mux_regs = pmx_i2c1_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_i2c1_mux),
+	},
+};
+
+struct pmx_dev pmx_i2c1 = {
+	.name = "i2c1",
+	.modes = pmx_i2c1_modes,
+	.mode_count = ARRAY_SIZE(pmx_i2c1_modes),
+};
+
+/* Pad multiplexing for smii_0_1_2 device */
+static struct pmx_mux_reg pmx_smii_0_1_2_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_CLCD2_MASK | PMX_KBD_ROWCOL68_MASK | \
+			PMX_EGPIO_1_GRP_MASK | PMX_GPT0_TMR1_MASK | \
+			PMX_GPT0_TMR2_MASK | PMX_GPT1_TMR1_MASK | \
+			PMX_GPT1_TMR2_MASK,
+		.value = 0,
+	}, {
+		.address = SPEAR1310_FUNC_CNTL_0,
+		.mask = PMX_SMII_MASK,
+		.value = PMX_SMII_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_smii_0_1_2_modes[] = {
+	{
+		.mux_regs = pmx_smii_0_1_2_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_smii_0_1_2_mux),
+	},
+};
+
+struct pmx_dev pmx_smii_0_1_2 = {
+	.name = "smii_0_1_2",
+	.modes = pmx_smii_0_1_2_modes,
+	.mode_count = ARRAY_SIZE(pmx_smii_0_1_2_modes),
+};
+
+/* Pad multiplexing for pci1 device */
+static struct pmx_mux_reg pmx_pci1_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_CLCD2_MASK | PMX_KBD_ROWCOL68_MASK | \
+			PMX_EGPIO_1_GRP_MASK | PMX_GPT0_TMR1_MASK | \
+			PMX_GPT0_TMR2_MASK | PMX_GPT1_TMR1_MASK | \
+			PMX_GPT1_TMR2_MASK,
+		.value = 0,
+	}, {
+		.address = SPEAR1310_FUNC_CNTL_0,
+		.mask = PMX_SMII_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_pci1_modes[] = {
+	{
+		.mux_regs = pmx_pci1_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_pci1_mux),
+	},
+};
+
+struct pmx_dev pmx_pci1 = {
+	.name = "pci1",
+	.modes = pmx_pci1_modes,
+	.mode_count = ARRAY_SIZE(pmx_pci1_modes),
+};
+
+/* Pad multiplexing for can device */
+static struct pmx_mux_reg pmx_can_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_I2S2_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_can_modes[] = {
+	{
+		.mux_regs = pmx_can_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_can_mux),
+	},
+};
+
+struct pmx_dev pmx_can = {
+	.name = "can",
+	.modes = pmx_can_modes,
+	.mode_count = ARRAY_SIZE(pmx_can_modes),
+};
+
 /* Add spear1310 specific devices here */
 /* uart1 device registeration */
 struct amba_device spear1310_uart1_device = {
@@ -137,8 +475,20 @@ void __init spear1310_map_io(void)
 	spear13xx_map_io();
 }
 
-void __init spear1310_init(void)
+void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count)
 {
+	int ret;
+
 	/* call spear13xx family common init function */
 	spear13xx_init();
+
+	/* pmx initialization */
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
+
+	ret = pmx_register(&pmx_driver);
+	if (ret)
+		pr_err("padmux: registeration failed. err no: %d\n", ret);
 }
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index a87e82b..42625c8 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -17,6 +17,31 @@
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
+/* padmux devices to enable */
+static struct pmx_dev *pmx_devs[] = {
+	/* spear13xx specific devices */
+	&pmx_i2c,
+	&pmx_i2s1,
+	&pmx_egpio_grp,
+	&pmx_gmii,
+	&pmx_keyboard_6x6,
+	&pmx_mcif,
+	&pmx_nand_8bit,
+	&pmx_smi_2_chips,
+	&pmx_uart0,
+
+	/* spear1310 specific devices */
+	&pmx_can,
+	&pmx_i2c1,
+	&pmx_smii_0_1_2,
+	&pmx_fsmc16bit_4_chips,
+	&pmx_rs485_hdlc_1_2,
+	&pmx_tdm_hdlc_1_2,
+	&pmx_uart_1,
+	&pmx_uart_2,
+	&pmx_uart_3_4_5,
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear13xx specific devices */
 	&spear13xx_uart_device,
@@ -42,7 +67,7 @@ static void __init spear1310_evb_init(void)
 	unsigned int i;
 
 	/* call spear1310 machine init function */
-	spear1310_init();
+	spear1310_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index b5da555..7832c1a 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -136,3 +136,562 @@ static void __init spear13xx_timer_init(void)
 struct sys_timer spear13xx_timer = {
 	.init = spear13xx_timer_init,
 };
+
+/* pad multiplexing support */
+/* devices */
+
+/* Pad multiplexing for i2c device */
+static struct pmx_mux_reg pmx_i2c_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_I2C_MASK,
+		.value = PMX_I2C_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_i2c_modes[] = {
+	{
+		.mux_regs = pmx_i2c_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_i2c_mux),
+	},
+};
+
+struct pmx_dev pmx_i2c = {
+	.name = "i2c",
+	.modes = pmx_i2c_modes,
+	.mode_count = ARRAY_SIZE(pmx_i2c_modes),
+};
+
+/* Pad multiplexing for ssp device */
+static struct pmx_mux_reg pmx_ssp_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_SSP_MASK,
+		.value = PMX_SSP_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_ssp_modes[] = {
+	{
+		.mux_regs = pmx_ssp_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_ssp_mux),
+	},
+};
+
+struct pmx_dev pmx_ssp = {
+	.name = "ssp",
+	.modes = pmx_ssp_modes,
+	.mode_count = ARRAY_SIZE(pmx_ssp_modes),
+};
+
+/* Pad multiplexing for i2s1 device */
+static struct pmx_mux_reg pmx_i2s1_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_I2S1_MASK,
+		.value = PMX_I2S1_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_i2s1_modes[] = {
+	{
+		.mux_regs = pmx_i2s1_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_i2s1_mux),
+	},
+};
+
+struct pmx_dev pmx_i2s1 = {
+	.name = "i2s1",
+	.modes = pmx_i2s1_modes,
+	.mode_count = ARRAY_SIZE(pmx_i2s1_modes),
+};
+
+/* Pad multiplexing for i2s2 device */
+static struct pmx_mux_reg pmx_i2s2_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_I2S2_MASK,
+		.value = PMX_I2S2_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_i2s2_modes[] = {
+	{
+		.mux_regs = pmx_i2s2_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_i2s2_mux),
+	},
+};
+
+struct pmx_dev pmx_i2s2 = {
+	.name = "i2s2",
+	.modes = pmx_i2s2_modes,
+	.mode_count = ARRAY_SIZE(pmx_i2s2_modes),
+};
+
+/* Pad multiplexing for clcd device */
+static struct pmx_mux_reg pmx_clcd_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_CLCD1_MASK,
+		.value = PMX_CLCD1_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_clcd_modes[] = {
+	{
+		.mux_regs = pmx_clcd_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_clcd_mux),
+	},
+};
+
+struct pmx_dev pmx_clcd = {
+	.name = "clcd",
+	.modes = pmx_clcd_modes,
+	.mode_count = ARRAY_SIZE(pmx_clcd_modes),
+};
+
+/* Pad multiplexing for clcd_hires device */
+static struct pmx_mux_reg pmx_clcd_hires_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_CLCD1_MASK,
+		.value = PMX_CLCD1_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_CLCD2_MASK,
+		.value = PMX_CLCD2_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_clcd_hires_modes[] = {
+	{
+		.mux_regs = pmx_clcd_hires_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_clcd_hires_mux),
+	},
+};
+
+struct pmx_dev pmx_clcd_hires = {
+	.name = "clcd_high_res",
+	.modes = pmx_clcd_hires_modes,
+	.mode_count = ARRAY_SIZE(pmx_clcd_hires_modes),
+};
+
+/*
+ * By default, all EGPIOs are enabled.
+ * TBD : Board specific enabling of specific GPIOs only
+ */
+static struct pmx_mux_reg pmx_egpio_grp_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_EGPIO_0_GRP_MASK,
+		.value = PMX_EGPIO_0_GRP_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_EGPIO_1_GRP_MASK,
+		.value = PMX_EGPIO_1_GRP_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_egpio_grp_modes[] = {
+	{
+		.mux_regs = pmx_egpio_grp_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_egpio_grp_mux),
+	},
+};
+
+struct pmx_dev pmx_egpio_grp = {
+	.name = "egpios",
+	.modes = pmx_egpio_grp_modes,
+	.mode_count = ARRAY_SIZE(pmx_egpio_grp_modes),
+};
+
+/* Pad multiplexing for smi 2 chips device */
+static struct pmx_mux_reg pmx_smi_2_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_SMI_MASK,
+		.value = PMX_SMI_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_smi_2_modes[] = {
+	{
+		.mux_regs = pmx_smi_2_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_smi_2_mux),
+	},
+};
+
+struct pmx_dev pmx_smi_2_chips = {
+	.name = "smi_2_chips",
+	.modes = pmx_smi_2_modes,
+	.mode_count = ARRAY_SIZE(pmx_smi_2_modes),
+};
+
+/* Pad multiplexing for smi 4 chips device */
+static struct pmx_mux_reg pmx_smi_4_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_SMI_MASK,
+		.value = PMX_SMI_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_SMINCS2_MASK | PMX_SMINCS3_MASK,
+		.value = PMX_SMINCS2_MASK | PMX_SMINCS3_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_smi_4_modes[] = {
+	{
+		.mux_regs = pmx_smi_4_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_smi_4_mux),
+	},
+};
+
+struct pmx_dev pmx_smi_4_chips = {
+	.name = "smi_4_chips",
+	.modes = pmx_smi_4_modes,
+	.mode_count = ARRAY_SIZE(pmx_smi_4_modes),
+};
+
+/* Pad multiplexing for gmii device */
+static struct pmx_mux_reg pmx_gmii_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_GMII_MASK,
+		.value = PMX_GMII_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_gmii_modes[] = {
+	{
+		.mux_regs = pmx_gmii_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_gmii_mux),
+	},
+};
+
+struct pmx_dev pmx_gmii = {
+	.name = "gmii",
+	.modes = pmx_gmii_modes,
+	.mode_count = ARRAY_SIZE(pmx_gmii_modes),
+};
+
+/* Pad multiplexing for nand 8bit (4 chips) */
+static struct pmx_mux_reg pmx_nand8_4_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_NAND8BIT4DEV_0_MASK,
+		.value = PMX_NAND8BIT4DEV_0_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_NAND8BIT4DEV_1_MASK | PMX_KEYBOARD_6X6_MASK,
+		.value = PMX_NAND8BIT4DEV_1_MASK | PMX_KEYBOARD_6X6_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_nand8_4_modes[] = {
+	{
+		.mux_regs = pmx_nand8_4_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_nand8_4_mux),
+	},
+};
+
+struct pmx_dev pmx_nand_8bit_4_chips = {
+	.name = "nand-8bit_4_chips",
+	.modes = pmx_nand8_4_modes,
+	.mode_count = ARRAY_SIZE(pmx_nand8_4_modes),
+};
+
+/* Pad multiplexing for nand 8bit device (cs0 only) */
+static struct pmx_mux_reg pmx_nand8_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_NAND8BIT_0_MASK,
+		.value = PMX_NAND8BIT_0_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_NAND8BIT_1_MASK | PMX_KEYBOARD_6X6_MASK,
+		.value = PMX_NAND8BIT_1_MASK | PMX_KEYBOARD_6X6_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_nand8_modes[] = {
+	{
+		.mux_regs = pmx_nand8_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_nand8_mux),
+	},
+};
+
+struct pmx_dev pmx_nand_8bit = {
+	.name = "nand-8bit",
+	.modes = pmx_nand8_modes,
+	.mode_count = ARRAY_SIZE(pmx_nand8_modes),
+};
+
+/*
+ * Pad multiplexing for nand 16bit device
+ * Note : Enabling pmx_nand_16bit means that all the required pads for
+ *   16bit nand device operations are enabled. These also include pads
+ *   for 8bit devices
+ */
+static struct pmx_mux_reg pmx_nand16_4_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_NAND16BIT4DEV_0_MASK,
+		.value = PMX_NAND16BIT4DEV_0_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_NAND16BIT4DEV_1_MASK | PMX_KEYBOARD_6X6_MASK,
+		.value = PMX_NAND16BIT4DEV_1_MASK | PMX_KEYBOARD_6X6_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_nand16_4_modes[] = {
+	{
+		.mux_regs = pmx_nand16_4_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_nand16_4_mux),
+	},
+};
+
+struct pmx_dev pmx_nand_16bit_4_chips = {
+	.name = "nand-16bit_4_chips",
+	.modes = pmx_nand16_4_modes,
+	.mode_count = ARRAY_SIZE(pmx_nand16_4_modes),
+};
+
+/* Pad multiplexing for nand 16bit device (cs0 only) */
+static struct pmx_mux_reg pmx_nand16_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_NAND16BIT_0_MASK,
+		.value = PMX_NAND16BIT_0_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_NAND16BIT_1_MASK | PMX_KEYBOARD_6X6_MASK,
+		.value = PMX_NAND16BIT_1_MASK | PMX_KEYBOARD_6X6_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_nand16_modes[] = {
+	{
+		.mux_regs = pmx_nand16_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_nand16_mux),
+	},
+};
+
+struct pmx_dev pmx_nand_16bit = {
+	.name = "nand-16bit",
+	.modes = pmx_nand16_modes,
+	.mode_count = ARRAY_SIZE(pmx_nand16_modes),
+};
+
+/* Pad multiplexing for keyboard_6x6 device */
+static struct pmx_mux_reg pmx_keyboard_6x6_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_KEYBOARD_6X6_MASK,
+		.value = PMX_KEYBOARD_6X6_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_NFIO815_MASK | PMX_NFCE1_MASK | \
+			PMX_NFCE2_MASK | PMX_NFWPRT1_MASK | PMX_NFWPRT2_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_keyboard_6x6_modes[] = {
+	{
+		.mux_regs = pmx_keyboard_6x6_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_keyboard_6x6_mux),
+	},
+};
+
+struct pmx_dev pmx_keyboard_6x6 = {
+	.name = "keyboard_6x6",
+	.modes = pmx_keyboard_6x6_modes,
+	.mode_count = ARRAY_SIZE(pmx_keyboard_6x6_modes),
+};
+
+/* Pad multiplexing for keyboard_9x9 device */
+static struct pmx_mux_reg pmx_keyboard_9x9_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_KEYBOARD_6X6_MASK | PMX_KBD_ROWCOL68_MASK,
+		.value = PMX_KEYBOARD_6X6_MASK | PMX_KBD_ROWCOL68_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_NFIO815_MASK | PMX_NFCE1_MASK | \
+			PMX_NFCE2_MASK | PMX_NFWPRT1_MASK | PMX_NFWPRT2_MASK,
+		.value = 0,
+	},
+};
+
+static struct pmx_dev_mode pmx_keyboard_9x9_modes[] = {
+	{
+		.mux_regs = pmx_keyboard_9x9_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_keyboard_9x9_mux),
+	},
+};
+
+struct pmx_dev pmx_keyboard_9x9 = {
+	.name = "keyboard_9x9",
+	.modes = pmx_keyboard_9x9_modes,
+	.mode_count = ARRAY_SIZE(pmx_keyboard_9x9_modes),
+};
+
+/* Pad multiplexing for uart0 device */
+static struct pmx_mux_reg pmx_uart0_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_0,
+		.mask = PMX_UART0_MASK,
+		.value = PMX_UART0_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_uart0_modes[] = {
+	{
+		.mux_regs = pmx_uart0_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_uart0_mux),
+	},
+};
+
+struct pmx_dev pmx_uart0 = {
+	.name = "uart0",
+	.modes = pmx_uart0_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart0_modes),
+};
+
+/* Pad multiplexing for uart0_modem device */
+static struct pmx_mux_reg pmx_uart0_modem_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_UART0_MODEM_MASK,
+		.value = PMX_UART0_MODEM_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_uart0_modem_modes[] = {
+	{
+		.mux_regs = pmx_uart0_modem_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_uart0_modem_mux),
+	},
+};
+
+struct pmx_dev pmx_uart0_modem = {
+	.name = "uart0_modem",
+	.modes = pmx_uart0_modem_modes,
+	.mode_count = ARRAY_SIZE(pmx_uart0_modem_modes),
+};
+
+/* Pad multiplexing for gpt_0_1 device */
+static struct pmx_mux_reg pmx_gpt_0_1_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_GPT0_TMR1_MASK,
+		.value = PMX_GPT0_TMR1_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_gpt_0_1_modes[] = {
+	{
+		.mux_regs = pmx_gpt_0_1_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_gpt_0_1_mux),
+	},
+};
+
+struct pmx_dev pmx_gpt_0_1 = {
+	.name = "gpt_0_1",
+	.modes = pmx_gpt_0_1_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpt_0_1_modes),
+};
+
+/* Pad multiplexing for gpt_0_2 device */
+static struct pmx_mux_reg pmx_gpt_0_2_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_GPT0_TMR2_MASK,
+		.value = PMX_GPT0_TMR2_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_gpt_0_2_modes[] = {
+	{
+		.mux_regs = pmx_gpt_0_2_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_gpt_0_2_mux),
+	},
+};
+
+struct pmx_dev pmx_gpt_0_2 = {
+	.name = "gpt_0_2",
+	.modes = pmx_gpt_0_2_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpt_0_2_modes),
+};
+
+/* Pad multiplexing for gpt_1_1 device */
+static struct pmx_mux_reg pmx_gpt_1_1_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_GPT1_TMR1_MASK,
+		.value = PMX_GPT1_TMR1_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_gpt_1_1_modes[] = {
+	{
+		.mux_regs = pmx_gpt_1_1_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_gpt_1_1_mux),
+	},
+};
+
+struct pmx_dev pmx_gpt_1_1 = {
+	.name = "gpt_1_1",
+	.modes = pmx_gpt_1_1_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpt_1_1_modes),
+};
+
+/* Pad multiplexing for gpt_1_2 device */
+static struct pmx_mux_reg pmx_gpt_1_2_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_GPT1_TMR2_MASK,
+		.value = PMX_GPT1_TMR2_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_gpt_1_2_modes[] = {
+	{
+		.mux_regs = pmx_gpt_1_2_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_gpt_1_2_mux),
+	},
+};
+
+struct pmx_dev pmx_gpt_1_2 = {
+	.name = "gpt_1_2",
+	.modes = pmx_gpt_1_2_modes,
+	.mode_count = ARRAY_SIZE(pmx_gpt_1_2_modes),
+};
+
+/* Pad multiplexing for mcif device */
+static struct pmx_mux_reg pmx_mcif_mux[] = {
+	{
+		.address = PAD_MUX_CONFIG_REG_1,
+		.mask = PMX_MCIFALL_1_MASK,
+		.value = PMX_MCIFALL_1_MASK,
+	}, {
+		.address = PAD_MUX_CONFIG_REG_2,
+		.mask = PMX_MCIFALL_2_MASK,
+		.value = PMX_MCIFALL_2_MASK,
+	},
+};
+
+static struct pmx_dev_mode pmx_mcif_modes[] = {
+	{
+		.mux_regs = pmx_mcif_mux,
+		.mux_reg_cnt = ARRAY_SIZE(pmx_mcif_mux),
+	},
+};
+
+struct pmx_dev pmx_mcif = {
+	.name = "mcif",
+	.modes = pmx_mcif_modes,
+	.mode_count = ARRAY_SIZE(pmx_mcif_modes),
+};
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index b4f340b..03f9acc 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -5,4 +5,5 @@
 # Common support
 obj-y	:= clock.o time.o
 
+obj-$(CONFIG_ARCH_SPEAR13XX)	+= padmux.o
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
-- 
1.7.2.2
