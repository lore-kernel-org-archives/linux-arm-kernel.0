From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 May 2014 16:45:25 +0800
Subject: [PATCH 07/20] ARM: imx5: drop arguments from mx5_clocks_common_init()
In-Reply-To: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
References: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1400575538-21136-8-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function mx5_clocks_common_init() was created with a number of
arguments to pass oscillator clock rate in non-DT boot.  Since i.MX5
is DT only platform, the arguments can be dropped, and the clock rate
can just be retrieved from device tree.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 1e22d35..67f686e 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -86,17 +86,15 @@ static const char *mx51_spdif1_com_sel[] = { "spdif1_podf", "ssi2_root_gate", };
 static struct clk *clk[IMX5_CLK_END];
 static struct clk_onecell_data clk_data;
 
-static void __init mx5_clocks_common_init(unsigned long rate_ckil,
-		unsigned long rate_osc, unsigned long rate_ckih1,
-		unsigned long rate_ckih2)
+static void __init mx5_clocks_common_init(void)
 {
 	int i;
 
 	clk[IMX5_CLK_DUMMY]		= imx_clk_fixed("dummy", 0);
-	clk[IMX5_CLK_CKIL]		= imx_obtain_fixed_clock("ckil", rate_ckil);
-	clk[IMX5_CLK_OSC]		= imx_obtain_fixed_clock("osc", rate_osc);
-	clk[IMX5_CLK_CKIH1]		= imx_obtain_fixed_clock("ckih1", rate_ckih1);
-	clk[IMX5_CLK_CKIH2]		= imx_obtain_fixed_clock("ckih2", rate_ckih2);
+	clk[IMX5_CLK_CKIL]		= imx_obtain_fixed_clock("ckil", 0);
+	clk[IMX5_CLK_OSC]		= imx_obtain_fixed_clock("osc", 0);
+	clk[IMX5_CLK_CKIH1]		= imx_obtain_fixed_clock("ckih1", 0);
+	clk[IMX5_CLK_CKIH2]		= imx_obtain_fixed_clock("ckih2", 0);
 
 	clk[IMX5_CLK_PERIPH_APM]	= imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12, 2,
 						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
@@ -358,7 +356,7 @@ static void __init mx50_clocks_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	mx5_clocks_common_init(0, 0, 0, 0);
+	mx5_clocks_common_init();
 
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
@@ -424,7 +422,7 @@ static void __init mx51_clocks_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	mx5_clocks_common_init(0, 0, 0, 0);
+	mx5_clocks_common_init();
 
 	clk_register_clkdev(clk[IMX5_CLK_HSI2C_GATE], NULL, "imx21-i2c.2");
 	clk_register_clkdev(clk[IMX5_CLK_MX51_MIPI], "mipi_hsp", NULL);
@@ -542,7 +540,7 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	mx5_clocks_common_init(0, 0, 0, 0);
+	mx5_clocks_common_init();
 
 	clk_register_clkdev(clk[IMX5_CLK_I2C3_GATE], NULL, "imx21-i2c.2");
 	clk_register_clkdev(clk[IMX5_CLK_FEC_GATE], NULL, "imx25-fec.0");
-- 
1.8.3.2
