From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 03 Jun 2012 18:12:45 +0530
Subject: [PATCH v2 2/6] ARM: Exynos5: Add spi clock support
In-Reply-To: <1338727369-18241-1-git-send-email-thomas.abraham@linaro.org>
References: <1338727369-18241-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1338727369-18241-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for clock instances for each spi controller.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>
---
 arch/arm/mach-exynos/clock-exynos5.c |   98 ++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index fefa336..7369b51 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -131,6 +131,11 @@ static int exynos5_clksrc_mask_peric0_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_PERIC0, clk, enable);
 }
 
+static int exynos5_clksrc_mask_peric1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_PERIC1, clk, enable);
+}
+
 static int exynos5_clk_ip_acp_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_ACP, clk, enable);
@@ -741,6 +746,24 @@ static struct clk exynos5_init_clocks_off[] = {
 		.enable		= exynos5_clk_ip_peric_ctrl,
 		.ctrlbit	= (1 << 14),
 	}, {
+		.name		= "spi",
+		.devname	= "exynos4210-spi.0",
+		.parent		= &exynos5_clk_aclk_66.clk,
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.ctrlbit	= (1 << 16),
+	}, {
+		.name		= "spi",
+		.devname	= "exynos4210-spi.1",
+		.parent		= &exynos5_clk_aclk_66.clk,
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.ctrlbit	= (1 << 17),
+	}, {
+		.name		= "spi",
+		.devname	= "exynos4210-spi.2",
+		.parent		= &exynos5_clk_aclk_66.clk,
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.ctrlbit	= (1 << 18),
+	}, {
 		.name		= SYSMMU_CLOCK_NAME,
 		.devname	= SYSMMU_CLOCK_DEVNAME(mfc_l, 0),
 		.enable		= &exynos5_clk_ip_mfc_ctrl,
@@ -1034,6 +1057,72 @@ static struct clksrc_clk exynos5_clk_sclk_mmc3 = {
 	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS2, .shift = 24, .size = 8 },
 };
 
+static struct clksrc_clk exynos5_clk_mdout_spi0 = {
+	.clk	= {
+		.name		= "sclk_spi_mdout",
+		.devname	= "exynos4210-spi.0",
+	},
+	.sources = &exynos5_clkset_group,
+	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC1, .shift = 16, .size = 4 },
+	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC1, .shift = 0, .size = 4 },
+
+};
+
+static struct clksrc_clk exynos5_clk_sclk_spi0 = {
+	.clk	= {
+		.name		= "sclk_spi",
+		.devname	= "exynos4210-spi.0",
+		.parent		= &exynos5_clk_mdout_spi0.clk,
+		.enable		= exynos5_clksrc_mask_peric1_ctrl,
+		.ctrlbit	= (1 << 16),
+	},
+	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC1, .shift = 8, .size = 8 },
+};
+
+static struct clksrc_clk exynos5_clk_mdout_spi1 = {
+	.clk	= {
+		.name		= "sclk_spi_mdout",
+		.devname	= "exynos4210-spi.1",
+	},
+	.sources = &exynos5_clkset_group,
+	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC1, .shift = 20, .size = 4 },
+	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC1, .shift = 16, .size = 4 },
+
+};
+
+static struct clksrc_clk exynos5_clk_sclk_spi1 = {
+	.clk	= {
+		.name		= "sclk_spi",
+		.devname	= "exynos4210-spi.1",
+		.parent		= &exynos5_clk_mdout_spi1.clk,
+		.enable		= exynos5_clksrc_mask_peric1_ctrl,
+		.ctrlbit	= (1 << 20),
+	},
+	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC1, .shift = 24, .size = 8 },
+};
+
+static struct clksrc_clk exynos5_clk_mdout_spi2 = {
+	.clk	= {
+		.name		= "sclk_spi_mdout",
+		.devname	= "exynos4210-spi.2",
+	},
+	.sources = &exynos5_clkset_group,
+	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC1, .shift = 24, .size = 4 },
+	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC2, .shift = 0, .size = 4 },
+
+};
+
+static struct clksrc_clk exynos5_clk_sclk_spi2 = {
+	.clk	= {
+		.name		= "sclk_spi",
+		.devname	= "exynos4210-spi.2",
+		.parent		= &exynos5_clk_mdout_spi2.clk,
+		.enable		= exynos5_clksrc_mask_peric1_ctrl,
+		.ctrlbit	= (1 << 24),
+	},
+	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC2, .shift = 8, .size = 8 },
+};
+
 static struct clksrc_clk exynos5_clksrcs[] = {
 	{
 		.clk	= {
@@ -1148,6 +1237,12 @@ static struct clksrc_clk *exynos5_sysclks[] = {
 	&exynos5_clk_dout_mmc4,
 	&exynos5_clk_aclk_acp,
 	&exynos5_clk_pclk_acp,
+	&exynos5_clk_sclk_spi0,
+	&exynos5_clk_sclk_spi1,
+	&exynos5_clk_sclk_spi2,
+	&exynos5_clk_mdout_spi0,
+	&exynos5_clk_mdout_spi1,
+	&exynos5_clk_mdout_spi2,
 };
 
 static struct clk *exynos5_clk_cdev[] = {
@@ -1176,6 +1271,9 @@ static struct clk_lookup exynos5_clk_lookup[] = {
 	CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &exynos5_clk_sclk_mmc1.clk),
 	CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &exynos5_clk_sclk_mmc2.clk),
 	CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &exynos5_clk_sclk_mmc3.clk),
+	CLKDEV_INIT("exynos4210-spi.0", "spi_busclk0", &exynos5_clk_sclk_spi0.clk),
+	CLKDEV_INIT("exynos4210-spi.1", "spi_busclk0", &exynos5_clk_sclk_spi1.clk),
+	CLKDEV_INIT("exynos4210-spi.2", "spi_busclk0", &exynos5_clk_sclk_spi2.clk),
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma0),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma1),
 	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma1),
-- 
1.6.6.rc2
