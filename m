From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 23:45:35 +0530
Subject: [PATCH v6 07/10] ARM: Exynos4: Add a alias for pdma clocks
In-Reply-To: <1318270538-30450-7-git-send-email-thomas.abraham@linaro.org>
References: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-2-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-4-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-5-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-6-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-7-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1318270538-30450-8-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PDMA controllers when instantiated from device tree are registered using
amba_device_register(). The registration process enables clock to the
controllers to read the peripheral id of the PDMA amba device.

In case of Exynos4, the clocks to the PDMA controllers are named as 'dma'
but amba_device_register() looks up the clock using the name 'apb_pclk'.
Hence, alias clocks with name 'apb_pclk' clock are created for clocks
with name 'dma'.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/clock.c |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index d589fe4..94fc337 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -558,16 +558,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
-		.name		= "dma",
-		.devname	= "dma-pl330.0",
-		.enable		= exynos4_clk_ip_fsys_ctrl,
-		.ctrlbit	= (1 << 0),
-	}, {
-		.name		= "dma",
-		.devname	= "dma-pl330.1",
-		.enable		= exynos4_clk_ip_fsys_ctrl,
-		.ctrlbit	= (1 << 1),
-	}, {
 		.name		= "adc",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 15),
@@ -783,6 +773,20 @@ static struct clk init_clocks[] = {
 	}
 };
 
+static struct clk clk_pdma0 = {
+	.name		= "dma",
+	.devname	= "dma-pl330.0",
+	.enable		= exynos4_clk_ip_fsys_ctrl,
+	.ctrlbit	= (1 << 0),
+};
+
+static struct clk clk_pdma1 = {
+	.name		= "dma",
+	.devname	= "dma-pl330.1",
+	.enable		= exynos4_clk_ip_fsys_ctrl,
+	.ctrlbit	= (1 << 1),
+};
+
 struct clk *clkset_group_list[] = {
 	[0] = &clk_ext_xtal_mux,
 	[1] = &clk_xusbxti,
@@ -1292,6 +1296,11 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_mout_mfc1,
 };
 
+static struct clk *clk_cdev[] = {
+	&clk_pdma0,
+	&clk_pdma1,
+};
+
 static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uart0,
 	&clk_sclk_uart1,
@@ -1312,6 +1321,8 @@ static struct clk_lookup exynos4_clk_lookup[] = {
 	CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 	CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 	CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
+	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &clk_pdma0),
+	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &clk_pdma1),
 };
 
 static int xtal_rate;
@@ -1527,6 +1538,10 @@ void __init exynos4_register_clocks(void)
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
+		s3c_disable_clocks(clk_cdev[ptr], 1);
+
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	clkdev_add_table(exynos4_clk_lookup, ARRAY_SIZE(exynos4_clk_lookup));
-- 
1.6.6.rc2
