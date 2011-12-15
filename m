From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 15 Dec 2011 13:51:23 +0100
Subject: [PATCH 5/5] ux500: remove support for early silicon revisions
Message-ID: <1323953483-27191-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The DB8500 ED (Early Drop) and V1 are only available inside of
ST-Ericsson or partners, we have actively replaced and scrapped
these prototypes. All Nova products on the open market (such as
the Snowball board) are based on V2 and later ASIC variants.
So let us focus on supporting the silicon that will be used and
delete this to get a clear overview.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c         |   54 +++----
 arch/arm/mach-ux500/clock.c                    |  203 ++++++------------------
 arch/arm/mach-ux500/cpu-db8500.c               |   30 +----
 arch/arm/mach-ux500/devices-db8500.c           |   10 --
 arch/arm/mach-ux500/include/mach/db8500-regs.h |   16 +--
 arch/arm/mach-ux500/include/mach/devices.h     |    2 -
 6 files changed, 73 insertions(+), 242 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index cf93dca..23be34b 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -22,6 +22,12 @@
 #include "ste-dma40-db8500.h"
 
 /*
+ * v2 has a new version of this block that need to be forced, the number found
+ * in hardware is incorrect
+ */
+#define U8500_SDI_V2_PERIPHID 0x10480180
+
+/*
  * SDI 0 (MicroSD slot)
  */
 
@@ -117,10 +123,7 @@ static void sdi0_configure(void)
 	gpio_direction_output(sdi0_en, 1);
 
 	/* Add the device, force v2 to subrevision 1 */
-	if (cpu_is_u8500v2())
-		db8500_add_sdi0(&mop500_sdi0_data, 0x10480180);
-	else
-		db8500_add_sdi0(&mop500_sdi0_data, 0);
+	db8500_add_sdi0(&mop500_sdi0_data, U8500_SDI_V2_PERIPHID);
 }
 
 void mop500_sdi_tc35892_init(void)
@@ -194,7 +197,8 @@ static struct stedma40_chan_cfg mop500_sdi2_dma_cfg_tx = {
 static struct mmci_platform_data mop500_sdi2_data = {
 	.ocr_mask	= MMC_VDD_165_195,
 	.f_max		= 50000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_MMC_HIGHSPEED,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
 #ifdef CONFIG_STE_DMA40
@@ -244,20 +248,10 @@ static struct mmci_platform_data mop500_sdi4_data = {
 
 void __init mop500_sdi_init(void)
 {
-	u32 periphid = 0;
-
-	/* v2 has a new version of this block that need to be forced */
-	if (cpu_is_u8500v2())
-		periphid = 0x10480180;
-	/* PoP:ed eMMC on top of DB8500 v1.0 has problems with high speed */
-	if (!cpu_is_u8500v10())
-		mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
-
-	db8500_add_sdi2(&mop500_sdi2_data, periphid);
-
+	/* PoP:ed eMMC */
+	db8500_add_sdi2(&mop500_sdi2_data, U8500_SDI_V2_PERIPHID);
 	/* On-board eMMC */
-	db8500_add_sdi4(&mop500_sdi4_data, periphid);
-
+	db8500_add_sdi4(&mop500_sdi4_data, U8500_SDI_V2_PERIPHID);
 	/*
 	 * On boards with the TC35892 GPIO expander, sdi0 will finally
 	 * be added when the TC35892 initializes and calls
@@ -267,13 +261,9 @@ void __init mop500_sdi_init(void)
 
 void __init snowball_sdi_init(void)
 {
-	u32 periphid = 0x10480180;
-
-	mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
-
 	/* On-board eMMC */
-	db8500_add_sdi4(&mop500_sdi4_data, periphid);
-
+	db8500_add_sdi4(&mop500_sdi4_data, U8500_SDI_V2_PERIPHID);
+	/* External Micro SD slot */
 	mop500_sdi0_data.gpio_cd = SNOWBALL_SDMMC_CD_GPIO;
 	mop500_sdi0_data.cd_invert = true;
 	sdi0_en = SNOWBALL_SDMMC_EN_GPIO;
@@ -283,19 +273,15 @@ void __init snowball_sdi_init(void)
 
 void __init hrefv60_sdi_init(void)
 {
-	u32 periphid = 0x10480180;
-
-	mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
-
-	db8500_add_sdi2(&mop500_sdi2_data, periphid);
-
+	/* PoP:ed eMMC */
+	db8500_add_sdi2(&mop500_sdi2_data, U8500_SDI_V2_PERIPHID);
 	/* On-board eMMC */
-	db8500_add_sdi4(&mop500_sdi4_data, periphid);
-
+	db8500_add_sdi4(&mop500_sdi4_data, U8500_SDI_V2_PERIPHID);
+	/* External Micro SD slot */
 	mop500_sdi0_data.gpio_cd = HREFV60_SDMMC_CD_GPIO;
 	sdi0_en = HREFV60_SDMMC_EN_GPIO;
 	sdi0_vsel = HREFV60_SDMMC_1V8_3V_GPIO;
 	sdi0_configure();
-
-	db8500_add_sdi1(&mop500_sdi1_data, periphid);
+	/* WLAN SDIO channel */
+	db8500_add_sdi1(&mop500_sdi1_data, U8500_SDI_V2_PERIPHID);
 }
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index e832664..2ebf998 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -239,23 +239,6 @@ static void clk_prcmu_disable(struct clk *clk)
 	writel(1 << clk->prcmu_cg_bit, cg_clr_reg);
 }
 
-/* ED doesn't have the combined set/clr registers */
-static void clk_prcmu_ed_enable(struct clk *clk)
-{
-	void __iomem *addr = __io_address(U8500_PRCMU_BASE)
-			     + clk->prcmu_cg_mgt;
-
-	writel(readl(addr) | PRCM_MGT_ENABLE, addr);
-}
-
-static void clk_prcmu_ed_disable(struct clk *clk)
-{
-	void __iomem *addr = __io_address(U8500_PRCMU_BASE)
-			     + clk->prcmu_cg_mgt;
-
-	writel(readl(addr) & ~PRCM_MGT_ENABLE, addr);
-}
-
 static struct clkops clk_prcmu_ops = {
 	.enable = clk_prcmu_enable,
 	.disable = clk_prcmu_disable,
@@ -267,7 +250,6 @@ static unsigned int clkrst_base[] = {
 	[3] = U8500_CLKRST3_BASE,
 	[5] = U8500_CLKRST5_BASE,
 	[6] = U8500_CLKRST6_BASE,
-	[7] = U8500_CLKRST7_BASE_ED,
 };
 
 static void clk_prcc_enable(struct clk *clk)
@@ -321,7 +303,6 @@ static DEFINE_PRCMU_CLK(per2clk,	0x0, 12, PER2CLK);
 static DEFINE_PRCMU_CLK(per3clk,	0x0, 13, PER3CLK);
 static DEFINE_PRCMU_CLK(per5clk,	0x0, 14, PER5CLK);
 static DEFINE_PRCMU_CLK_RATE(per6clk,	0x0, 15, PER6CLK, 133330000);
-static DEFINE_PRCMU_CLK_RATE(per7clk,	0x0, 16, PER7CLK, 100000000);
 static DEFINE_PRCMU_CLK(lcdclk,		0x0, 17, LCDCLK);
 static DEFINE_PRCMU_CLK(bmlclk,		0x0, 18, BMLCLK);
 static DEFINE_PRCMU_CLK(hsitxclk,	0x0, 19, HSITXCLK);
@@ -351,44 +332,28 @@ static DEFINE_PRCMU_CLK(uiccclk,	0x4, 1, UICCCLK); /* v1 */
 static DEFINE_PRCC_CLK(1, i2c4,		10, 9, &clk_i2cclk);
 static DEFINE_PRCC_CLK(1, gpio0,	9, -1, NULL);
 static DEFINE_PRCC_CLK(1, slimbus0,	8,  8, &clk_slimclk);
-static DEFINE_PRCC_CLK(1, spi3_ed,	7,  7, NULL);
-static DEFINE_PRCC_CLK(1, spi3_v1,	7, -1, NULL);
+static DEFINE_PRCC_CLK(1, spi3,		7, -1, NULL);
 static DEFINE_PRCC_CLK(1, i2c2,		6,  6, &clk_i2cclk);
 static DEFINE_PRCC_CLK(1, sdi0,		5,  5, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(1, msp1_ed,	4,  4, &clk_msp02clk);
-static DEFINE_PRCC_CLK(1, msp1_v1,	4,  4, &clk_msp1clk);
+static DEFINE_PRCC_CLK(1, msp1,		4,  4, &clk_msp1clk);
 static DEFINE_PRCC_CLK(1, msp0,		3,  3, &clk_msp02clk);
 static DEFINE_PRCC_CLK(1, i2c1,		2,  2, &clk_i2cclk);
 static DEFINE_PRCC_CLK(1, uart1,	1,  1, &clk_uartclk);
 static DEFINE_PRCC_CLK(1, uart0,	0,  0, &clk_uartclk);
 
 /* Peripheral Cluster #2 */
-
-static DEFINE_PRCC_CLK(2, gpio1_ed,	12, -1, NULL);
-static DEFINE_PRCC_CLK(2, ssitx_ed,	11, -1, NULL);
-static DEFINE_PRCC_CLK(2, ssirx_ed,	10, -1, NULL);
-static DEFINE_PRCC_CLK(2, spi0_ed,	 9, -1, NULL);
-static DEFINE_PRCC_CLK(2, sdi3_ed,	 8,  6, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, sdi1_ed,	 7,  5, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, msp2_ed,	 6,  4, &clk_msp02clk);
-static DEFINE_PRCC_CLK(2, sdi4_ed,	 4,  2, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, pwl_ed,	 3,  1, NULL);
-static DEFINE_PRCC_CLK(2, spi1_ed,	 2, -1, NULL);
-static DEFINE_PRCC_CLK(2, spi2_ed,	 1, -1, NULL);
-static DEFINE_PRCC_CLK(2, i2c3_ed,	 0,  0, &clk_i2cclk);
-
-static DEFINE_PRCC_CLK(2, gpio1_v1,	11, -1, NULL);
-static DEFINE_PRCC_CLK(2, ssitx_v1,	10,  7, NULL);
-static DEFINE_PRCC_CLK(2, ssirx_v1,	 9,  6, NULL);
-static DEFINE_PRCC_CLK(2, spi0_v1,	 8, -1, NULL);
-static DEFINE_PRCC_CLK(2, sdi3_v1,	 7,  5, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, sdi1_v1,	 6,  4, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, msp2_v1,	 5,  3, &clk_msp02clk);
-static DEFINE_PRCC_CLK(2, sdi4_v1,	 4,  2, &clk_sdmmcclk);
-static DEFINE_PRCC_CLK(2, pwl_v1,	 3,  1, NULL);
-static DEFINE_PRCC_CLK(2, spi1_v1,	 2, -1, NULL);
-static DEFINE_PRCC_CLK(2, spi2_v1,	 1, -1, NULL);
-static DEFINE_PRCC_CLK(2, i2c3_v1,	 0,  0, &clk_i2cclk);
+static DEFINE_PRCC_CLK(2, gpio1,	11, -1, NULL);
+static DEFINE_PRCC_CLK(2, ssitx,	10,  7, NULL);
+static DEFINE_PRCC_CLK(2, ssirx,	 9,  6, NULL);
+static DEFINE_PRCC_CLK(2, spi0,		8, -1, NULL);
+static DEFINE_PRCC_CLK(2, sdi3,		7,  5, &clk_sdmmcclk);
+static DEFINE_PRCC_CLK(2, sdi1,		6,  4, &clk_sdmmcclk);
+static DEFINE_PRCC_CLK(2, msp2,		5,  3, &clk_msp02clk);
+static DEFINE_PRCC_CLK(2, sdi4,		4,  2, &clk_sdmmcclk);
+static DEFINE_PRCC_CLK(2, pwl,		3,  1, NULL);
+static DEFINE_PRCC_CLK(2, spi1,		2, -1, NULL);
+static DEFINE_PRCC_CLK(2, spi2,		1, -1, NULL);
+static DEFINE_PRCC_CLK(2, i2c3,		0,  0, &clk_i2cclk);
 
 /* Peripheral Cluster #3 */
 static DEFINE_PRCC_CLK(3, gpio2,	8, -1, NULL);
@@ -397,49 +362,34 @@ static DEFINE_PRCC_CLK(3, uart2,	6,  6, &clk_uartclk);
 static DEFINE_PRCC_CLK(3, ske,		5,  5, &clk_32khz);
 static DEFINE_PRCC_CLK(3, sdi2,		4,  4, &clk_sdmmcclk);
 static DEFINE_PRCC_CLK(3, i2c0,		3,  3, &clk_i2cclk);
-static DEFINE_PRCC_CLK(3, ssp1_ed,	2,  2, &clk_i2cclk);
-static DEFINE_PRCC_CLK(3, ssp0_ed,	1,  1, &clk_i2cclk);
-static DEFINE_PRCC_CLK(3, ssp1_v1,	2,  2, &clk_sspclk);
-static DEFINE_PRCC_CLK(3, ssp0_v1,	1,  1, &clk_sspclk);
+static DEFINE_PRCC_CLK(3, ssp1,		2,  2, &clk_sspclk);
+static DEFINE_PRCC_CLK(3, ssp0,		1,  1, &clk_sspclk);
 static DEFINE_PRCC_CLK(3, fsmc,		0, -1, NULL);
 
 /* Peripheral Cluster #4 is in the always on domain */
 
 /* Peripheral Cluster #5 */
 static DEFINE_PRCC_CLK(5, gpio3,	1, -1, NULL);
-static DEFINE_PRCC_CLK(5, usb_ed,	0,  0, &clk_i2cclk);
-static DEFINE_PRCC_CLK(5, usb_v1,	0,  0, NULL);
+static DEFINE_PRCC_CLK(5, usb,		0,  0, NULL);
 
 /* Peripheral Cluster #6 */
 
 /* MTU ID in data */
-static DEFINE_PRCC_CLK_CUSTOM(6, mtu1_v1, 8, -1, NULL, clk_mtu_get_rate, 1);
-static DEFINE_PRCC_CLK_CUSTOM(6, mtu0_v1, 7, -1, NULL, clk_mtu_get_rate, 0);
-static DEFINE_PRCC_CLK(6, cfgreg_v1,	6,  6, NULL);
-static DEFINE_PRCC_CLK(6, dmc_ed,	6,  6, NULL);
+static DEFINE_PRCC_CLK_CUSTOM(6, mtu1, 8, -1, NULL, clk_mtu_get_rate, 1);
+static DEFINE_PRCC_CLK_CUSTOM(6, mtu0, 7, -1, NULL, clk_mtu_get_rate, 0);
+static DEFINE_PRCC_CLK(6, cfgreg,	6,  6, NULL);
 static DEFINE_PRCC_CLK(6, hash1,	5, -1, NULL);
-static DEFINE_PRCC_CLK(6, unipro_v1,	4,  1, &clk_uniproclk);
-static DEFINE_PRCC_CLK(6, cryp1_ed,	4, -1, NULL);
+static DEFINE_PRCC_CLK(6, unipro,	4,  1, &clk_uniproclk);
 static DEFINE_PRCC_CLK(6, pka,		3, -1, NULL);
 static DEFINE_PRCC_CLK(6, hash0,	2, -1, NULL);
 static DEFINE_PRCC_CLK(6, cryp0,	1, -1, NULL);
-static DEFINE_PRCC_CLK(6, rng_ed,	0,  0, &clk_i2cclk);
-static DEFINE_PRCC_CLK(6, rng_v1,	0,  0, &clk_rngclk);
-
-/* Peripheral Cluster #7 */
-
-static DEFINE_PRCC_CLK(7, tzpc0_ed,	4, -1, NULL);
-/* MTU ID in data */
-static DEFINE_PRCC_CLK_CUSTOM(7, mtu1_ed, 3, -1, NULL, clk_mtu_get_rate, 1);
-static DEFINE_PRCC_CLK_CUSTOM(7, mtu0_ed, 2, -1, NULL, clk_mtu_get_rate, 0);
-static DEFINE_PRCC_CLK(7, wdg_ed,	1, -1, NULL);
-static DEFINE_PRCC_CLK(7, cfgreg_ed,	0, -1, NULL);
+static DEFINE_PRCC_CLK(6, rng,	0,  0, &clk_rngclk);
 
 static struct clk clk_dummy_apb_pclk = {
 	.name = "apb_pclk",
 };
 
-static struct clk_lookup u8500_common_clks[] = {
+static struct clk_lookup u8500_clks[] = {
 	CLK(dummy_apb_pclk, NULL,	"apb_pclk"),
 
 	/* Peripheral Cluster #1 */
@@ -494,83 +444,41 @@ static struct clk_lookup u8500_common_clks[] = {
 	CLK(dmaclk,	"dma40.0",	NULL),
 	CLK(b2r2clk,	"b2r2",		NULL),
 	CLK(tvclk,	"tv",		NULL),
-};
 
-static struct clk_lookup u8500_ed_clks[] = {
-	/* Peripheral Cluster #1 */
-	CLK(spi3_ed,	"spi3",		NULL),
-	CLK(msp1_ed,	"msp1",		NULL),
-
-	/* Peripheral Cluster #2 */
-	CLK(gpio1_ed,	"gpio.6",	NULL),
-	CLK(gpio1_ed,	"gpio.7",	NULL),
-	CLK(ssitx_ed,	"ssitx",	NULL),
-	CLK(ssirx_ed,	"ssirx",	NULL),
-	CLK(spi0_ed,	"spi0",		NULL),
-	CLK(sdi3_ed,	"sdi3",		NULL),
-	CLK(sdi1_ed,	"sdi1",		NULL),
-	CLK(msp2_ed,	"msp2",		NULL),
-	CLK(sdi4_ed,	"sdi4",		NULL),
-	CLK(pwl_ed,	"pwl",		NULL),
-	CLK(spi1_ed,	"spi1",		NULL),
-	CLK(spi2_ed,	"spi2",		NULL),
-	CLK(i2c3_ed,	"nmk-i2c.3",	NULL),
-
-	/* Peripheral Cluster #3 */
-	CLK(ssp1_ed,	"ssp1",		NULL),
-	CLK(ssp0_ed,	"ssp0",		NULL),
-
-	/* Peripheral Cluster #5 */
-	CLK(usb_ed,	"musb-ux500.0",	"usb"),
-
-	/* Peripheral Cluster #6 */
-	CLK(dmc_ed,	"dmc",		NULL),
-	CLK(cryp1_ed,	"cryp1",	NULL),
-	CLK(rng_ed,	"rng",		NULL),
-
-	/* Peripheral Cluster #7 */
-	CLK(tzpc0_ed,	"tzpc0",	NULL),
-	CLK(mtu1_ed,	"mtu1",		NULL),
-	CLK(mtu0_ed,	"mtu0",		NULL),
-	CLK(wdg_ed,	"wdg",		NULL),
-	CLK(cfgreg_ed,	"cfgreg",	NULL),
-};
-
-static struct clk_lookup u8500_v1_clks[] = {
 	/* Peripheral Cluster #1 */
 	CLK(i2c4,	"nmk-i2c.4",	NULL),
-	CLK(spi3_v1,	"spi3",		NULL),
-	CLK(msp1_v1,	"msp1",		NULL),
+	CLK(spi3,	"spi3",		NULL),
+	CLK(msp1,	"msp1",		NULL),
 
 	/* Peripheral Cluster #2 */
-	CLK(gpio1_v1,	"gpio.6",	NULL),
-	CLK(gpio1_v1,	"gpio.7",	NULL),
-	CLK(ssitx_v1,	"ssitx",	NULL),
-	CLK(ssirx_v1,	"ssirx",	NULL),
-	CLK(spi0_v1,	"spi0",		NULL),
-	CLK(sdi3_v1,	"sdi3",		NULL),
-	CLK(sdi1_v1,	"sdi1",		NULL),
-	CLK(msp2_v1,	"msp2",		NULL),
-	CLK(sdi4_v1,	"sdi4",		NULL),
-	CLK(pwl_v1,	"pwl",		NULL),
-	CLK(spi1_v1,	"spi1",		NULL),
-	CLK(spi2_v1,	"spi2",		NULL),
-	CLK(i2c3_v1,	"nmk-i2c.3",	NULL),
+	CLK(gpio1,	"gpio.6",	NULL),
+	CLK(gpio1,	"gpio.7",	NULL),
+	CLK(ssitx,	"ssitx",	NULL),
+	CLK(ssirx,	"ssirx",	NULL),
+	CLK(spi0,	"spi0",		NULL),
+	CLK(sdi3,	"sdi3",		NULL),
+	CLK(sdi1,	"sdi1",		NULL),
+	CLK(msp2,	"msp2",		NULL),
+	CLK(sdi4,	"sdi4",		NULL),
+	CLK(pwl,	"pwl",		NULL),
+	CLK(spi1,	"spi1",		NULL),
+	CLK(spi2,	"spi2",		NULL),
+	CLK(i2c3,	"nmk-i2c.3",	NULL),
 
 	/* Peripheral Cluster #3 */
-	CLK(ssp1_v1,	"ssp1",		NULL),
-	CLK(ssp0_v1,	"ssp0",		NULL),
+	CLK(ssp1,	"ssp1",		NULL),
+	CLK(ssp0,	"ssp0",		NULL),
 
 	/* Peripheral Cluster #5 */
-	CLK(usb_v1,	"musb-ux500.0",	"usb"),
+	CLK(usb,	"musb-ux500.0",	"usb"),
 
 	/* Peripheral Cluster #6 */
-	CLK(mtu1_v1,	"mtu1",		NULL),
-	CLK(mtu0_v1,	"mtu0",		NULL),
-	CLK(cfgreg_v1,	"cfgreg",	NULL),
+	CLK(mtu1,	"mtu1",		NULL),
+	CLK(mtu0,	"mtu0",		NULL),
+	CLK(cfgreg,	"cfgreg",	NULL),
 	CLK(hash1,	"hash1",	NULL),
-	CLK(unipro_v1,	"unipro",	NULL),
-	CLK(rng_v1,	"rng",		NULL),
+	CLK(unipro,	"unipro",	NULL),
+	CLK(rng,	"rng",		NULL),
 
 	/* PRCMU level clock gating */
 
@@ -790,11 +698,7 @@ late_initcall(clk_init_smp_twd_cpufreq);
 
 int __init clk_init(void)
 {
-	if (cpu_is_u8500ed()) {
-		clk_prcmu_ops.enable = clk_prcmu_ed_enable;
-		clk_prcmu_ops.disable = clk_prcmu_ed_disable;
-		clk_per6clk.rate = 100000000;
-	} else if (cpu_is_u5500()) {
+	if (cpu_is_u5500()) {
 		/* Clock tree for U5500 not implemented yet */
 		clk_prcc_ops.enable = clk_prcc_ops.disable = NULL;
 		clk_prcmu_ops.enable = clk_prcmu_ops.disable = NULL;
@@ -802,20 +706,11 @@ int __init clk_init(void)
 		clk_sdmmcclk.rate = 99900000;
 	}
 
-	clkdev_add_table(u8500_common_clks, ARRAY_SIZE(u8500_common_clks));
-	if (cpu_is_u8500ed())
-		clkdev_add_table(u8500_ed_clks, ARRAY_SIZE(u8500_ed_clks));
-	else
-		clkdev_add_table(u8500_v1_clks, ARRAY_SIZE(u8500_v1_clks));
-
+	clkdev_add_table(u8500_clks, ARRAY_SIZE(u8500_clks));
 	clkdev_add(&clk_smp_twd_lookup);
 
 #ifdef CONFIG_DEBUG_FS
-	clk_debugfs_add_table(u8500_common_clks, ARRAY_SIZE(u8500_common_clks));
-	if (cpu_is_u8500ed())
-		clk_debugfs_add_table(u8500_ed_clks, ARRAY_SIZE(u8500_ed_clks));
-	else
-		clk_debugfs_add_table(u8500_v1_clks, ARRAY_SIZE(u8500_v1_clks));
+	clk_debugfs_add_table(u8500_clks, ARRAY_SIZE(u8500_clks));
 #endif
 	return 0;
 }
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 7f2729c..7176ee7 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008-2009 ST-Ericsson
+ * Copyright (C) 2008-2009 ST-Ericsson SA
  *
  * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
  *
@@ -53,19 +53,6 @@ static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO3_BASE, SZ_4K),
-};
-
-static struct map_desc u8500_ed_io_desc[] __initdata = {
-	__IO_DEV_DESC(U8500_MTU0_BASE_ED, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST7_BASE_ED, SZ_8K),
-};
-
-static struct map_desc u8500_v1_io_desc[] __initdata = {
-	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE_V1, SZ_4K),
-};
-
-static struct map_desc u8500_v2_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K),
 };
 
@@ -80,13 +67,6 @@ void __init u8500_map_io(void)
 
 	iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
 
-	if (cpu_is_u8500ed())
-		iotable_init(u8500_ed_io_desc, ARRAY_SIZE(u8500_ed_io_desc));
-	else if (cpu_is_u8500v1())
-		iotable_init(u8500_v1_io_desc, ARRAY_SIZE(u8500_v1_io_desc));
-	else if (cpu_is_u8500v2())
-		iotable_init(u8500_v2_io_desc, ARRAY_SIZE(u8500_v2_io_desc));
-
 	_PRCMU_BASE = __io_address(U8500_PRCMU_BASE);
 }
 
@@ -155,12 +135,9 @@ static resource_size_t __initdata db8500_gpio_base[] = {
 static void __init db8500_add_gpios(void)
 {
 	struct nmk_gpio_platform_data pdata = {
-		/* No custom data yet */
+		.supports_sleepmode = true,
 	};
 
-	if (cpu_is_u8500v2())
-		pdata.supports_sleepmode = true;
-
 	dbx500_add_gpios(ARRAY_AND_SIZE(db8500_gpio_base),
 			 IRQ_DB8500_GPIO0, &pdata);
 }
@@ -192,9 +169,6 @@ static int usb_db8500_tx_dma_cfg[] = {
  */
 void __init u8500_init_devices(void)
 {
-	if (cpu_is_u8500ed())
-		dma40_u8500ed_fixup();
-
 	db8500_add_rtc();
 	db8500_add_gpios();
 	db8500_add_usb(usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 73b1740..a7c6cdc 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -166,16 +166,6 @@ struct platform_device u8500_dma40_device = {
 	.resource = dma40_resources
 };
 
-void dma40_u8500ed_fixup(void)
-{
-	dma40_plat_data.memcpy = NULL;
-	dma40_plat_data.memcpy_len = 0;
-	dma40_resources[0].start = U8500_DMA_BASE_ED;
-	dma40_resources[0].end = U8500_DMA_BASE_ED + SZ_4K - 1;
-	dma40_resources[1].start = U8500_DMA_LCPA_BASE_ED;
-	dma40_resources[1].end = U8500_DMA_LCPA_BASE_ED + 2 * SZ_1K - 1;
-}
-
 struct resource keypad_resources[] = {
 	[0] = {
 		.start = U8500_SKE_BASE,
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/include/mach/db8500-regs.h
index 8decf18..80e10f5 100644
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db8500-regs.h
@@ -22,7 +22,6 @@
 #define U8500_ESRAM_DMA_LCPA_OFFSET     0x10000
 
 #define U8500_DMA_LCPA_BASE    (U8500_ESRAM_BANK0 + U8500_ESRAM_DMA_LCPA_OFFSET)
-#define U8500_DMA_LCPA_BASE_ED	(U8500_ESRAM_BANK4 + 0x4000)
 
 /* This address fulfills the 256k alignment requirement of the lcla base */
 #define U8500_DMA_LCLA_BASE	U8500_ESRAM_BANK4
@@ -45,14 +44,12 @@
 #define U8500_PER6_BASE		0xa03c0000
 #define U8500_PER7_BASE		0xa03d0000
 #define U8500_PER5_BASE		0xa03e0000
-#define U8500_PER7_BASE_ED	0xa03d0000
 
 #define U8500_SVA_BASE		0xa0100000
 #define U8500_SIA_BASE		0xa0200000
 
 #define U8500_SGA_BASE		0xa0300000
 #define U8500_MCDE_BASE		0xa0350000
-#define U8500_DMA_BASE_ED	0xa0362000
 #define U8500_DMA_BASE		0x801C0000	/* v1 */
 
 #define U8500_SBAG_BASE		0xa0390000
@@ -70,13 +67,6 @@
 #define U8500_GPIO2_BASE	(U8500_PER2_BASE + 0xE000)
 #define U8500_GPIO3_BASE	(U8500_PER5_BASE + 0x1E000)
 
-/* per7 base addresses */
-#define U8500_CR_BASE_ED	(U8500_PER7_BASE_ED + 0x8000)
-#define U8500_MTU0_BASE_ED	(U8500_PER7_BASE_ED + 0xa000)
-#define U8500_MTU1_BASE_ED	(U8500_PER7_BASE_ED + 0xb000)
-#define U8500_TZPC0_BASE_ED	(U8500_PER7_BASE_ED + 0xc000)
-#define U8500_CLKRST7_BASE_ED	(U8500_PER7_BASE_ED + 0xf000)
-
 #define U8500_UART0_BASE	(U8500_PER1_BASE + 0x0000)
 #define U8500_UART1_BASE	(U8500_PER1_BASE + 0x1000)
 
@@ -106,12 +96,10 @@
 #define U8500_SCR_BASE		(U8500_PER4_BASE + 0x05000)
 #define U8500_DMC_BASE		(U8500_PER4_BASE + 0x06000)
 #define U8500_PRCMU_BASE	(U8500_PER4_BASE + 0x07000)
-#define U8500_PRCMU_TIMER_3_BASE (U8500_PER4_BASE + 0x07338)
-#define U8500_PRCMU_TIMER_4_BASE (U8500_PER4_BASE + 0x07450)
-#define U8500_PRCMU_TCDM_BASE_V1 (U8500_PER4_BASE + 0x0f000)
 #define U8500_PRCMU_TCDM_BASE	(U8500_PER4_BASE + 0x68000)
 #define U8500_PRCMU_TCPM_BASE   (U8500_PER4_BASE + 0x60000)
-
+#define U8500_PRCMU_TIMER_3_BASE (U8500_PER4_BASE + 0x07338)
+#define U8500_PRCMU_TIMER_4_BASE (U8500_PER4_BASE + 0x07450)
 
 /* per3 base addresses */
 #define U8500_FSMC_BASE		(U8500_PER3_BASE + 0x0000)
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 020b636..5f6cb71 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -18,6 +18,4 @@ extern struct amba_device ux500_pl031_device;
 extern struct platform_device u8500_dma40_device;
 extern struct platform_device ux500_ske_keypad_device;
 
-void dma40_u8500ed_fixup(void);
-
 #endif
-- 
1.7.3.2
