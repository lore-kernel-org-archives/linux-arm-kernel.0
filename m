From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Mon, 11 Oct 2010 18:05:42 +0200
Subject: [PATCH] mx51: add resources for SD/MMC on i.MX51
Message-ID: <1286813142-14936-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the attached patch allows SD to work on i.MX51 with Wolfram's drivers
Tested on i.MX51.

From: Richard Zhu <r65037@freescale.com>
Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/clock-mx51.c              |  193 +++++++++++++++++++++++++++
 arch/arm/mach-mx5/devices-imx51.h           |    9 ++
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |   33 +++--
 3 files changed, 221 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 21cecc0..eee2814 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -41,6 +41,35 @@ static struct clk usboh3_clk;
 
 #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
 
+static void __calc_pre_post_dividers(u32 div, u32 *pre, u32 *post)
+{
+	u32 min_pre, temp_pre, old_err, err;
+
+	if (div >= 512) {
+		*pre = 8;
+		*post = 64;
+	} else if (div >= 8) {
+		min_pre = (div - 1) / 64 + 1;
+		old_err = 8;
+		for (temp_pre = 8; temp_pre >= min_pre; temp_pre--) {
+			err = div % temp_pre;
+			if (err == 0) {
+				*pre = temp_pre;
+				break;
+			}
+			err = temp_pre - err;
+			if (err < old_err) {
+				old_err = err;
+				*pre = temp_pre;
+			}
+		}
+		*post = (div + *pre - 1) / *pre;
+	} else if (div < 8) {
+		*pre = div;
+		*post = 1;
+	}
+}
+
 static void _clk_ccgr_setclk(struct clk *clk, unsigned mode)
 {
 	u32 reg = __raw_readl(clk->enable_reg);
@@ -893,6 +922,160 @@ static struct clk ecspi_main_clk = {
 	.set_parent = clk_ecspi_set_parent,
 };
 
+static int _clk_esdhc1_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg, mux;
+	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk,
+			&pll3_sw_clk, &lp_apm_clk);
+	reg = __raw_readl(MXC_CCM_CSCMR1) &
+		~MXC_CCM_CSCMR1_ESDHC1_MSHC1_CLK_SEL_MASK;
+	reg |= mux << MXC_CCM_CSCMR1_ESDHC1_MSHC1_CLK_SEL_OFFSET;
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+
+	return 0;
+}
+
+static unsigned long _clk_esdhc1_get_rate(struct clk *clk)
+{
+	u32 reg, prediv, podf;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	reg = __raw_readl(MXC_CCM_CSCDR1);
+	prediv = ((reg & MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_MASK) >>
+		  MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_OFFSET) + 1;
+	podf = ((reg & MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PODF_MASK) >>
+		MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PODF_OFFSET) + 1;
+
+	return parent_rate / (prediv * podf);
+}
+
+static int _clk_esdhc1_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 reg, div, parent_rate;
+	u32 pre = 0, post = 0;
+
+	parent_rate = clk_get_rate(clk->parent);
+	div = parent_rate / rate;
+
+	if ((parent_rate / div) != rate)
+		return -EINVAL;
+
+	__calc_pre_post_dividers(div, &pre, &post);
+
+	/* Set sdhc1 clock divider */
+	reg = __raw_readl(MXC_CCM_CSCDR1) &
+		~(MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_MASK
+				| MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PODF_MASK);
+	reg |= (post - 1) << MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PODF_OFFSET;
+	reg |= (pre - 1) << MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_OFFSET;
+	__raw_writel(reg, MXC_CCM_CSCDR1);
+
+	return 0;
+}
+
+static struct clk esdhc1_clk[] = {
+	{
+		.id = 0,
+		.parent = &pll2_sw_clk,
+		.secondary = &esdhc1_clk[1],
+		.enable_shift = MXC_CCM_CCGRx_CG1_OFFSET,
+		.enable_reg = MXC_CCM_CCGR3,
+		.get_rate = _clk_esdhc1_get_rate,
+		.set_rate = _clk_esdhc1_set_rate,
+		.enable = _clk_max_enable,
+		.disable = _clk_max_disable,
+		.set_parent = _clk_esdhc1_set_parent,
+	},
+	{
+		.id = 0,
+		.parent = &ipg_clk,
+		.secondary = NULL,
+		.enable = _clk_max_enable,
+		.enable_reg = MXC_CCM_CCGR3,
+		.enable_shift = MXC_CCM_CCGRx_CG0_OFFSET,
+		.disable = _clk_max_disable,
+	}
+};
+
+static int _clk_esdhc2_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg, mux;
+
+	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk,
+			&pll3_sw_clk, &lp_apm_clk);
+	reg = __raw_readl(MXC_CCM_CSCMR1) &
+		~MXC_CCM_CSCMR1_ESDHC2_MSHC2_CLK_SEL_MASK;
+	reg |= mux << MXC_CCM_CSCMR1_ESDHC2_MSHC2_CLK_SEL_OFFSET;
+
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+	return 0;
+}
+
+static unsigned long _clk_esdhc2_get_rate(struct clk *clk)
+{
+	u32 reg, prediv, podf;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	reg = __raw_readl(MXC_CCM_CSCDR1);
+	prediv = ((reg & MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PRED_MASK) >>
+		  MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PRED_OFFSET) + 1;
+	podf = ((reg & MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_MASK) >>
+		MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_OFFSET) + 1;
+
+	return parent_rate / (prediv * podf);
+}
+
+static int _clk_esdhc2_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 reg, div, parent_rate;
+	u32 pre = 0, post = 0;
+
+	parent_rate = clk_get_rate(clk->parent);
+	div = parent_rate / rate;
+	if ((parent_rate / div) != rate)
+		return -EINVAL;
+
+	__calc_pre_post_dividers(div, &pre, &post);
+
+	/* Set sdhc1 clock divider */
+	reg = __raw_readl(MXC_CCM_CSCDR1) &
+		~(MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PRED_MASK
+				| MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_MASK);
+	reg |= (post - 1) << MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_OFFSET;
+	reg |= (pre - 1) << MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PRED_OFFSET;
+	__raw_writel(reg, MXC_CCM_CSCDR1);
+
+	return 0;
+}
+
+static struct clk esdhc2_clk[] = {
+	{
+		.id = 1,
+		.parent = &pll2_sw_clk,
+		.secondary = &esdhc2_clk[1],
+		.enable_shift = MXC_CCM_CCGRx_CG3_OFFSET,
+		.enable_reg = MXC_CCM_CCGR3,
+		.get_rate = _clk_esdhc2_get_rate,
+		.set_rate = _clk_esdhc2_set_rate,
+		.enable = _clk_max_enable,
+		.disable = _clk_max_disable,
+		.set_parent = _clk_esdhc2_set_parent,
+	},
+	{
+		.id = 1,
+		.parent = &ipg_clk,
+		.secondary = NULL,
+		.enable_shift = MXC_CCM_CCGRx_CG2_OFFSET,
+		.enable_reg = MXC_CCM_CCGR3,
+		.enable = _clk_max_enable,
+		.disable = _clk_max_disable,
+	}
+};
+
 #define DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, e, d, p, s)		\
 	static struct clk name = {					\
 		.id		= i,					\
@@ -1014,6 +1197,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
+	_REGISTER_CLOCK(NULL, "sdhc", esdhc1_clk[0])
+	_REGISTER_CLOCK(NULL, "sdhc", esdhc2_clk[0])
 };
 
 static void clk_tree_init(void)
@@ -1057,6 +1242,14 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 	/* set the usboh3_clk parent to pll2_sw_clk */
 	clk_set_parent(&usboh3_clk, &pll2_sw_clk);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(&esdhc1_clk[0], &pll2_sw_clk);
+	clk_set_parent(&esdhc2_clk[0], &pll2_sw_clk);
+
+	/* set SDHC root clock as 166.25MHZ*/
+	clk_set_rate(&esdhc1_clk[0], 166250000);
+	clk_set_rate(&esdhc2_clk[0], 166250000);
+
 	/* System timer */
 	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
 		MX51_MXC_INT_GPT);
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index c233379..547432d 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -36,3 +36,12 @@ extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
 extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
 #define imx51_add_ecspi(id, pdata)	\
 	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
+
+#define imx51_add_esdhc0(pdata)	\
+	imx_add_esdhc(0, MX51_MMC_SDHC1_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC1, pdata)
+#define imx51_add_esdhc1(pdata)	\
+	imx_add_esdhc(1, MX51_MMC_SDHC2_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC2, pdata)
+#define imx51_add_esdhc2(pdata)	\
+	imx_add_esdhc(2, MX51_MMC_SDHC3_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC3, pdata)
+#define imx51_add_esdhc3(pdata)	\
+	imx_add_esdhc(3, MX51_MMC_SDHC4_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC4, pdata)
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 633650d..4b8c61e 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -47,6 +47,9 @@ typedef enum iomux_config {
 				PAD_CTL_SRE_FAST)
 #define MX51_ECSPI_PAD_CTRL	(PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_DSE_HIGH | \
 				PAD_CTL_SRE_FAST)
+#define MX51_SDHCI_PAD_CTRL 	(PAD_CTL_DSE_HIGH | PAD_CTL_PUS_47K_UP | \
+				PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_SRE_FAST | \
+				PAD_CTL_DVS)
 
 #define MX51_PAD_CTRL_1	(PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | \
 					PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_HYS)
@@ -333,20 +336,22 @@ typedef enum iomux_config {
 #define MX51_PAD_DISP2_DAT13__DISP2_DAT13       IOMUX_PAD(0x790, 0x388, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP2_DAT14__DISP2_DAT14       IOMUX_PAD(0x794, 0x38C, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP2_DAT15__DISP2_DAT15       IOMUX_PAD(0x798, 0x390, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_CMD__SD1_CMD               IOMUX_PAD(0x79C, 0x394, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_CLK__SD1_CLK               IOMUX_PAD(0x7A0, 0x398, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA0__SD1_DATA0           IOMUX_PAD(0x7A4, 0x39C, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA1__SD1_DATA1           IOMUX_PAD(0x7A8, 0x3A0, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA2__SD1_DATA2           IOMUX_PAD(0x7AC, 0x3A4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA3__SD1_DATA3           IOMUX_PAD(0x7B0, 0x3A8, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_CMD__SD1_CMD	IOMUX_PAD(0x79C, 0x394, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_CLK__SD1_CLK 	IOMUX_PAD(0x7A0, 0x398, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL \
+		| PAD_CTL_HYS)
+#define MX51_PAD_SD1_DATA0__SD1_DATA0	IOMUX_PAD(0x7A4, 0x39C, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_DATA1__SD1_DATA1	IOMUX_PAD(0x7A8, 0x3A0, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_DATA2__SD1_DATA2	IOMUX_PAD(0x7AC, 0x3A4, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_DATA3__SD1_DATA3	IOMUX_PAD(0x7B0, 0x3A8, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_0__GPIO_1_0		IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, 1, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_CMD__SD2_CMD               IOMUX_PAD(0x7BC, 0x3B4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_CLK__SD2_CLK               IOMUX_PAD(0x7C0, 0x3B8, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA0__SD2_DATA0           IOMUX_PAD(0x7C4, 0x3BC, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA1__SD2_DATA1           IOMUX_PAD(0x7C8, 0x3C0, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA2__SD2_DATA2           IOMUX_PAD(0x7CC, 0x3C4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA3__SD2_DATA3           IOMUX_PAD(0x7D0, 0x3C8, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_1__GPIO_1_1	IOMUX_PAD(0x7B8, 0x3B0, IOMUX_CONFIG_GPIO, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_CMD__SD2_CMD	IOMUX_PAD(0x7BC, 0x3B4, IOMUX_CONFIG_SION, 0x0, 1, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_CLK__SD2_CLK	IOMUX_PAD(0x7C0, 0x3B8, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL \
+		| PAD_CTL_HYS)
+#define MX51_PAD_SD2_DATA0__SD2_DATA0	IOMUX_PAD(0x7C4, 0x3BC, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA1__SD2_DATA1	IOMUX_PAD(0x7C8, 0x3C0, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA2__SD2_DATA2	IOMUX_PAD(0x7CC, 0x3C4, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA3__SD2_DATA3	IOMUX_PAD(0x7D0, 0x3C8, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__I2C2_SCL		IOMUX_PAD(0x7D4, 0x3CC, (2 | IOMUX_CONFIG_SION), \
 							0x9b8,   3, MX51_I2C_PAD_CTRL)
@@ -355,7 +360,7 @@ typedef enum iomux_config {
 							0x9bc,   3, MX51_I2C_PAD_CTRL)
 #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_5__GPIO_1_5	IOMUX_PAD(0x808, 0x3DC, IOMUX_CONFIG_GPIO, 0x0, 1, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   1, MX51_GPIO_PAD_CTRL)
-- 
1.7.0.4
