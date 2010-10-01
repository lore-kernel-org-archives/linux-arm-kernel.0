From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:35 -0700
Subject: [PATCH 11/47] davinci: am18x/da850/omap-l138: keep async clock
	constant with cpufreq
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-12-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Keep PLL0 SYSCLK3 at a constant rate of 100MHz. This enables the AEMIF
timing to remain valid even as the PLL0 output is changed by cpufreq
driver to save power.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c    |    2 +-
 arch/arm/mach-davinci/da850.c              |   10 +++++++++-
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index f5f9472..c2800a98 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -787,7 +787,7 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warning("da850_evm_init: rtc setup failed: %d\n", ret);
 
-	ret = da850_register_cpufreq();
+	ret = da850_register_cpufreq("pll0_sysclk3");
 	if (ret)
 		pr_warning("da850_evm_init: cpufreq registration failed: %d\n",
 				ret);
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 6932d80..5af7cfb 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -86,6 +86,8 @@ static struct clk pll0_sysclk3 = {
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV3,
+	.set_rate	= davinci_set_sysclk_rate,
+	.maxrate	= 100000000,
 };
 
 static struct clk pll0_sysclk4 = {
@@ -929,10 +931,16 @@ static struct platform_device da850_cpufreq_device = {
 	.dev = {
 		.platform_data	= &cpufreq_info,
 	},
+	.id = -1,
 };
 
-int __init da850_register_cpufreq(void)
+int __init da850_register_cpufreq(char *async_clk)
 {
+	/* cpufreq driver can help keep an "async" clock constant */
+	if (async_clk)
+		clk_add_alias("async", da850_cpufreq_device.name,
+							async_clk, NULL);
+
 	return platform_device_register(&da850_cpufreq_device);
 }
 
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 3c07059..2c3f418 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -78,7 +78,7 @@ int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
 int da8xx_register_mmcsd0(struct davinci_mmc_config *config);
 void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata);
 int da8xx_register_rtc(void);
-int da850_register_cpufreq(void);
+int da850_register_cpufreq(char *async_clk);
 int da8xx_register_cpuidle(void);
 void __iomem * __init da8xx_get_mem_ctlr(void);
 int da850_register_pm(struct platform_device *pdev);
-- 
1.7.2.1
