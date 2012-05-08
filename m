From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 09 May 2012 03:34:53 +0530
Subject: [PATCH 09/10] ARM: Exynos5: Add spi clock support
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1336514694-22393-10-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for clock instances for each spi controller.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/clock-exynos5.c           |   98 ++++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/regs-clock.h |    4 +
 2 files changed, 102 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 7c0f810..0293beb 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -82,6 +82,11 @@ static int exynos5_clksrc_mask_peric0_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_PERIC0, clk, enable);
 }
 
+static int exynos5_clksrc_mask_peric1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_PERIC1, clk, enable);
+}
+
 static int exynos5_clk_ip_core_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_CORE, clk, enable);
@@ -700,6 +705,24 @@ static struct clk exynos5_init_clocks_off[] = {
 		.parent		= &exynos5_clk_aclk_66.clk,
 		.enable		= exynos5_clk_ip_peric_ctrl,
 		.ctrlbit	= (1 << 14),
+	}, {
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
 	}
 };
 
@@ -924,6 +947,72 @@ static struct clksrc_clk exynos5_clk_sclk_mmc3 = {
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
@@ -1055,6 +1144,12 @@ static struct clksrc_clk *exynos5_clksrc_cdev[] = {
 	&exynos5_clk_sclk_mmc1,
 	&exynos5_clk_sclk_mmc2,
 	&exynos5_clk_sclk_mmc3,
+	&exynos5_clk_mdout_spi0,
+	&exynos5_clk_sclk_spi0,
+	&exynos5_clk_mdout_spi1,
+	&exynos5_clk_sclk_spi1,
+	&exynos5_clk_mdout_spi2,
+	&exynos5_clk_sclk_spi2,
 };
 
 static struct clk_lookup exynos5_clk_lookup[] = {
@@ -1066,6 +1161,9 @@ static struct clk_lookup exynos5_clk_lookup[] = {
 	CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &exynos5_clk_sclk_mmc1.clk),
 	CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &exynos5_clk_sclk_mmc2.clk),
 	CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &exynos5_clk_sclk_mmc3.clk),
+	CLKDEV_INIT("exynos4210-spi.0", "spi_busclk0", &exynos5_clk_sclk_spi0.clk),
+	CLKDEV_INIT("exynos4210-spi.1", "spi_busclk0", &exynos5_clk_sclk_spi1.clk),
+	CLKDEV_INIT("exynos4210-spi.2", "spi_busclk0", &exynos5_clk_sclk_spi2.clk),
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma0),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma1),
 	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma1),
diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
index 130034d..8ff7d83 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -284,12 +284,14 @@
 #define EXYNOS5_CLKSRC_DISP1_0			EXYNOS_CLKREG(0x1022C)
 #define EXYNOS5_CLKSRC_FSYS			EXYNOS_CLKREG(0x10244)
 #define EXYNOS5_CLKSRC_PERIC0			EXYNOS_CLKREG(0x10250)
+#define EXYNOS5_CLKSRC_PERIC1			EXYNOS_CLKREG(0x10254)
 
 #define EXYNOS5_CLKSRC_MASK_TOP			EXYNOS_CLKREG(0x10310)
 #define EXYNOS5_CLKSRC_MASK_GSCL		EXYNOS_CLKREG(0x10320)
 #define EXYNOS5_CLKSRC_MASK_DISP1_0		EXYNOS_CLKREG(0x1032C)
 #define EXYNOS5_CLKSRC_MASK_FSYS		EXYNOS_CLKREG(0x10340)
 #define EXYNOS5_CLKSRC_MASK_PERIC0		EXYNOS_CLKREG(0x10350)
+#define EXYNOS5_CLKSRC_MASK_PERIC1		EXYNOS_CLKREG(0x10354)
 
 #define EXYNOS5_CLKDIV_TOP0			EXYNOS_CLKREG(0x10510)
 #define EXYNOS5_CLKDIV_TOP1			EXYNOS_CLKREG(0x10514)
@@ -301,6 +303,8 @@
 #define EXYNOS5_CLKDIV_FSYS2			EXYNOS_CLKREG(0x10550)
 #define EXYNOS5_CLKDIV_FSYS3			EXYNOS_CLKREG(0x10554)
 #define EXYNOS5_CLKDIV_PERIC0			EXYNOS_CLKREG(0x10558)
+#define EXYNOS5_CLKDIV_PERIC1			EXYNOS_CLKREG(0x1055C)
+#define EXYNOS5_CLKDIV_PERIC2			EXYNOS_CLKREG(0x10560)
 
 #define EXYNOS5_CLKGATE_IP_ACP			EXYNOS_CLKREG(0x08800)
 #define EXYNOS5_CLKGATE_IP_GSCL			EXYNOS_CLKREG(0x10920)
-- 
1.6.6.rc2
