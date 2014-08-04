From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Mon, 4 Aug 2014 19:11:15 +0800
Subject: [PATCH V1 3/3] ARM: imx6q: Add the clock route from external OSC to
 ESAI clock
In-Reply-To: <cover.1407148853.git.shengjiu.wang@freescale.com>
References: <cover.1407148853.git.shengjiu.wang@freescale.com>
Message-ID: <f680e189741811194a8096c933b63a8b5ad83fae.1407148853.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch mainly adds the clock route from external 24.576MHz OSC to internal
ESAI clock via analog clock2 PADs on the SoC and pll4 so that ESAI can get an
entirely synchronous clock source against CS42888.

[ 1, We found if using pll4 to generate a 24.576MHz from inernal 24.0MHz OSC,
  we would get noise during the audio playback via ESAI->CS42888 even though
  this generated clock's rate is equal to the external one statistically. It
  might be resulted from the tiny difference between two clock source, which
  might be crucial to the sensitive CODEC we use -- CS42888. So we here apply
  the old 3.0.35 way to feed ESAI the same clock source as CS42888.

  2, Ideally, we should use bypass mode for pll4 since we only need to get
  the raw rate (24.576MHz) while currently bypass mode in clk-pllv3.c isn't
  entirely supported: The clock rate would be fixed to 24.0MHz if setting to
  bypass, which would cause child clock get an incorrect rate and the driver
  who uses the child clock fail to derive a needed clock rate, and it might
  be dangerous to involve the clk-pllv3.c driver to this fix. Thus we here
  apply 3.0.35 way provisionally. ]

  Expected result:

  anaclk2                 0           1            24576000
   lvds2_in               0           1            24576000
    pll4_sel              0           1            24576000
     pll4_audio           0           1            786432000
      pll4_post_div       0           1            786432000
       pll4_audio_div     0           1            786432000
        esai_sel          0           1            786432000
         esai_pred        0           1            98304000
          esai_podf       0           1            24576000
           esai           0           1            24576000

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c  |    5 +++++
 arch/arm/mach-imx/mach-imx6q.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 927a062..2d3634f 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -413,6 +413,10 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	clk_register_clkdev(clk[IMX6QDL_CLK_ENET_REF], "enet_ref", NULL);
+	clk_register_clkdev(clk[IMX6QDL_CLK_PLL4_AUDIO_DIV], "pll4_audio_div", NULL);
+	clk_register_clkdev(clk[IMX6QDL_CLK_PLL4_SEL], "pll4_sel", NULL);
+	clk_register_clkdev(clk[IMX6QDL_CLK_LVDS2_IN], "lvds2_in", NULL);
+	clk_register_clkdev(clk[IMX6QDL_CLK_ESAI_EXTAL], "esai_extal", NULL);
 
 	if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
 	    cpu_is_imx6dl()) {
@@ -456,6 +460,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 
 	/* Audio-related clocks configuration */
 	clk_set_parent(clk[IMX6QDL_CLK_SPDIF_SEL], clk[IMX6QDL_CLK_PLL3_PFD3_454M]);
+	clk_set_parent(clk[IMX6QDL_CLK_ESAI_SEL], clk[IMX6QDL_CLK_PLL4_AUDIO_DIV]);
 
 	/* All existing boards with PCIe use LVDS1 */
 	if (IS_ENABLED(CONFIG_PCI_IMX6))
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index d51c6e9..ea24a96 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -362,6 +362,28 @@ put_node:
 	of_node_put(np);
 }
 
+#define ESAI_AUDIO_MCLK 24576000
+
+static void __init imx6q_audio_lvds2_init(void)
+{
+        struct clk *pll4_sel, *lvds2_in, *pll4_audio_div, *esai_extal;
+
+        pll4_audio_div = clk_get_sys(NULL, "pll4_audio_div");
+        pll4_sel = clk_get_sys(NULL, "pll4_sel");
+        lvds2_in = clk_get_sys(NULL, "lvds2_in");
+        esai_extal = clk_get_sys(NULL, "esai_extal");
+        if (IS_ERR(pll4_audio_div) || IS_ERR(pll4_sel) ||
+            IS_ERR(lvds2_in) || IS_ERR(esai_extal))
+                return;
+
+        if (clk_get_rate(lvds2_in) != ESAI_AUDIO_MCLK)
+                return;
+
+        clk_set_parent(pll4_sel, lvds2_in);
+        clk_set_rate(pll4_audio_div, 786432000);
+        clk_set_rate(esai_extal, ESAI_AUDIO_MCLK);
+}
+
 static struct platform_device imx6q_cpufreq_pdev = {
 	.name = "imx6q-cpufreq",
 };
@@ -379,6 +401,12 @@ static void __init imx6q_init_late(void)
 		imx6q_opp_init();
 		platform_device_register(&imx6q_cpufreq_pdev);
 	}
+
+	if (of_machine_is_compatible("fsl,imx6q-sabreauto")
+		|| of_machine_is_compatible("fsl,imx6dl-sabreauto")) {
+		imx6q_audio_lvds2_init();
+	}
+
 }
 
 static void __init imx6q_map_io(void)
-- 
1.7.9.5
