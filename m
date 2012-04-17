From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 17 Apr 2012 11:16:27 +0530
Subject: [PATCH 04/12] ARM: Exynos5: Remove duplicated instantiation of pdma
 clock
In-Reply-To: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1334641595-25301-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock of both the peripheral dma controllers is controlled by a single
clock gate. Hence remove the duplicate instantiation of the pdma clock.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/clock-exynos5.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 662615d..fb95e9b 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -762,16 +762,8 @@ static struct clk exynos5_init_clocks_on[] = {
 	}
 };
 
-static struct clk exynos5_clk_pdma0 = {
+static struct clk exynos5_clk_pdma = {
 	.name		= "dma",
-	.devname	= "dma-pl330.0",
-	.enable		= exynos5_clk_ip_fsys_ctrl,
-	.ctrlbit	= (1 << 1),
-};
-
-static struct clk exynos5_clk_pdma1 = {
-	.name		= "dma",
-	.devname	= "dma-pl330.1",
 	.enable		= exynos5_clk_ip_fsys_ctrl,
 	.ctrlbit	= (1 << 1),
 };
@@ -1064,8 +1056,7 @@ static struct clksrc_clk *exynos5_sysclks[] = {
 };
 
 static struct clk *exynos5_clk_cdev[] = {
-	&exynos5_clk_pdma0,
-	&exynos5_clk_pdma1,
+	&exynos5_clk_pdma,
 	&exynos5_clk_mdma1,
 };
 
@@ -1089,8 +1080,8 @@ static struct clk_lookup exynos5_clk_lookup[] = {
 	CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &exynos5_clk_sclk_mmc1.clk),
 	CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &exynos5_clk_sclk_mmc2.clk),
 	CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &exynos5_clk_sclk_mmc3.clk),
-	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma0),
-	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma1),
+	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma),
+	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma),
 	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma1),
 };
 
-- 
1.6.6.rc2
