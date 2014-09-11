From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 11 Sep 2014 23:04:31 +0200
Subject: [PATCH] clk: don't use __initconst for non-const arrays
Message-ID: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The statement

	static const char *name[];

defines a modifiable array of pointers to constant chars. That is

	*name[0] = 'f';

is forbidden, but

	name[0] = "f";

is not. So marking an array that is defined as above with __initconst is
wrong. Either an additional const must be added such that the whole
definition reads:

	static const char *const name[] __initconst;

or where this is not possible __initdata must be used.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/hisilicon/clk-hix5hd2.c |  6 ++--
 drivers/clk/mxs/clk-imx23.c         | 12 ++++----
 drivers/clk/mxs/clk-imx28.c         | 18 ++++++------
 drivers/clk/rockchip/clk.h          |  2 +-
 drivers/clk/samsung/clk-s5pv210.c   | 56 ++++++++++++++++++-------------------
 drivers/clk/ti/composite.c          |  2 +-
 6 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index e5fcfb4e32ef..7acae2eeb490 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -44,15 +44,15 @@ static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
 	{ HIX5HD2_FIXED_83M, "83m", NULL, CLK_IS_ROOT, 83333333, },
 };
 
-static const char *sfc_mux_p[] __initconst = {
+static const char *sfc_mux_p[] __initdata = {
 		"24m", "150m", "200m", "100m", "75m", };
 static u32 sfc_mux_table[] = {0, 4, 5, 6, 7};
 
-static const char *sdio1_mux_p[] __initconst = {
+static const char *sdio1_mux_p[] __initdata = {
 		"75m", "100m", "50m", "15m", };
 static u32 sdio1_mux_table[] = {0, 1, 2, 3};
 
-static const char *fephy_mux_p[] __initconst = { "25m", "125m"};
+static const char *fephy_mux_p[] __initdata = { "25m", "125m"};
 static u32 fephy_mux_table[] = {0, 1};
 
 
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 9fc9359f5133..22d136aa699f 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -77,12 +77,12 @@ static void __init clk_misc_init(void)
 	writel_relaxed(30 << BP_FRAC_IOFRAC, FRAC + SET);
 }
 
-static const char *sel_pll[]  __initconst = { "pll", "ref_xtal", };
-static const char *sel_cpu[]  __initconst = { "ref_cpu", "ref_xtal", };
-static const char *sel_pix[]  __initconst = { "ref_pix", "ref_xtal", };
-static const char *sel_io[]   __initconst = { "ref_io", "ref_xtal", };
-static const char *cpu_sels[] __initconst = { "cpu_pll", "cpu_xtal", };
-static const char *emi_sels[] __initconst = { "emi_pll", "emi_xtal", };
+static const char *sel_pll[]  __initdata = { "pll", "ref_xtal", };
+static const char *sel_cpu[]  __initdata = { "ref_cpu", "ref_xtal", };
+static const char *sel_pix[]  __initdata = { "ref_pix", "ref_xtal", };
+static const char *sel_io[]   __initdata = { "ref_io", "ref_xtal", };
+static const char *cpu_sels[] __initdata = { "cpu_pll", "cpu_xtal", };
+static const char *emi_sels[] __initdata = { "emi_pll", "emi_xtal", };
 
 enum imx23_clk {
 	ref_xtal, pll, ref_cpu, ref_emi, ref_pix, ref_io, saif_sel,
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index a6c35010e4e5..b1be3746ce95 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -125,15 +125,15 @@ static void __init clk_misc_init(void)
 	writel_relaxed(val, FRAC0);
 }
 
-static const char *sel_cpu[]  __initconst = { "ref_cpu", "ref_xtal", };
-static const char *sel_io0[]  __initconst = { "ref_io0", "ref_xtal", };
-static const char *sel_io1[]  __initconst = { "ref_io1", "ref_xtal", };
-static const char *sel_pix[]  __initconst = { "ref_pix", "ref_xtal", };
-static const char *sel_gpmi[] __initconst = { "ref_gpmi", "ref_xtal", };
-static const char *sel_pll0[] __initconst = { "pll0", "ref_xtal", };
-static const char *cpu_sels[] __initconst = { "cpu_pll", "cpu_xtal", };
-static const char *emi_sels[] __initconst = { "emi_pll", "emi_xtal", };
-static const char *ptp_sels[] __initconst = { "ref_xtal", "pll0", };
+static const char *sel_cpu[]  __initdata = { "ref_cpu", "ref_xtal", };
+static const char *sel_io0[]  __initdata = { "ref_io0", "ref_xtal", };
+static const char *sel_io1[]  __initdata = { "ref_io1", "ref_xtal", };
+static const char *sel_pix[]  __initdata = { "ref_pix", "ref_xtal", };
+static const char *sel_gpmi[] __initdata = { "ref_gpmi", "ref_xtal", };
+static const char *sel_pll0[] __initdata = { "pll0", "ref_xtal", };
+static const char *cpu_sels[] __initdata = { "cpu_pll", "cpu_xtal", };
+static const char *emi_sels[] __initdata = { "emi_pll", "emi_xtal", };
+static const char *ptp_sels[] __initdata = { "ref_xtal", "pll0", };
 
 enum imx28_clk {
 	ref_xtal, pll0, pll1, pll2, ref_cpu, ref_emi, ref_io0, ref_io1,
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 887cbdeca2aa..74fbb9c4b6de 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -120,7 +120,7 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 		struct rockchip_pll_rate_table *rate_table,
 		spinlock_t *lock);
 
-#define PNAME(x) static const char *x[] __initconst
+#define PNAME(x) static const char *x[] __initdata
 
 enum rockchip_clk_branch_type {
 	branch_composite,
diff --git a/drivers/clk/samsung/clk-s5pv210.c b/drivers/clk/samsung/clk-s5pv210.c
index d270a2084644..e668e479a697 100644
--- a/drivers/clk/samsung/clk-s5pv210.c
+++ b/drivers/clk/samsung/clk-s5pv210.c
@@ -169,44 +169,44 @@ static inline void s5pv210_clk_sleep_init(void) { }
 #endif
 
 /* Mux parent lists. */
-static const char *fin_pll_p[] __initconst = {
+static const char *fin_pll_p[] __initdata = {
 	"xxti",
 	"xusbxti"
 };
 
-static const char *mout_apll_p[] __initconst = {
+static const char *mout_apll_p[] __initdata = {
 	"fin_pll",
 	"fout_apll"
 };
 
-static const char *mout_mpll_p[] __initconst = {
+static const char *mout_mpll_p[] __initdata = {
 	"fin_pll",
 	"fout_mpll"
 };
 
-static const char *mout_epll_p[] __initconst = {
+static const char *mout_epll_p[] __initdata = {
 	"fin_pll",
 	"fout_epll"
 };
 
-static const char *mout_vpllsrc_p[] __initconst = {
+static const char *mout_vpllsrc_p[] __initdata = {
 	"fin_pll",
 	"sclk_hdmi27m"
 };
 
-static const char *mout_vpll_p[] __initconst = {
+static const char *mout_vpll_p[] __initdata = {
 	"mout_vpllsrc",
 	"fout_vpll"
 };
 
-static const char *mout_group1_p[] __initconst = {
+static const char *mout_group1_p[] __initdata = {
 	"dout_a2m",
 	"mout_mpll",
 	"mout_epll",
 	"mout_vpll"
 };
 
-static const char *mout_group2_p[] __initconst = {
+static const char *mout_group2_p[] __initdata = {
 	"xxti",
 	"xusbxti",
 	"sclk_hdmi27m",
@@ -218,7 +218,7 @@ static const char *mout_group2_p[] __initconst = {
 	"mout_vpll",
 };
 
-static const char *mout_audio0_p[] __initconst = {
+static const char *mout_audio0_p[] __initdata = {
 	"xxti",
 	"pcmcdclk0",
 	"sclk_hdmi27m",
@@ -230,7 +230,7 @@ static const char *mout_audio0_p[] __initconst = {
 	"mout_vpll",
 };
 
-static const char *mout_audio1_p[] __initconst = {
+static const char *mout_audio1_p[] __initdata = {
 	"i2scdclk1",
 	"pcmcdclk1",
 	"sclk_hdmi27m",
@@ -242,7 +242,7 @@ static const char *mout_audio1_p[] __initconst = {
 	"mout_vpll",
 };
 
-static const char *mout_audio2_p[] __initconst = {
+static const char *mout_audio2_p[] __initdata = {
 	"i2scdclk2",
 	"pcmcdclk2",
 	"sclk_hdmi27m",
@@ -254,63 +254,63 @@ static const char *mout_audio2_p[] __initconst = {
 	"mout_vpll",
 };
 
-static const char *mout_spdif_p[] __initconst = {
+static const char *mout_spdif_p[] __initdata = {
 	"dout_audio0",
 	"dout_audio1",
 	"dout_audio3",
 };
 
-static const char *mout_group3_p[] __initconst = {
+static const char *mout_group3_p[] __initdata = {
 	"mout_apll",
 	"mout_mpll"
 };
 
-static const char *mout_group4_p[] __initconst = {
+static const char *mout_group4_p[] __initdata = {
 	"mout_mpll",
 	"dout_a2m"
 };
 
-static const char *mout_flash_p[] __initconst = {
+static const char *mout_flash_p[] __initdata = {
 	"dout_hclkd",
 	"dout_hclkp"
 };
 
-static const char *mout_dac_p[] __initconst = {
+static const char *mout_dac_p[] __initdata = {
 	"mout_vpll",
 	"sclk_hdmiphy"
 };
 
-static const char *mout_hdmi_p[] __initconst = {
+static const char *mout_hdmi_p[] __initdata = {
 	"sclk_hdmiphy",
 	"dout_tblk"
 };
 
-static const char *mout_mixer_p[] __initconst = {
+static const char *mout_mixer_p[] __initdata = {
 	"mout_dac",
 	"mout_hdmi"
 };
 
-static const char *mout_vpll_6442_p[] __initconst = {
+static const char *mout_vpll_6442_p[] __initdata = {
 	"fin_pll",
 	"fout_vpll"
 };
 
-static const char *mout_mixer_6442_p[] __initconst = {
+static const char *mout_mixer_6442_p[] __initdata = {
 	"mout_vpll",
 	"dout_mixer"
 };
 
-static const char *mout_d0sync_6442_p[] __initconst = {
+static const char *mout_d0sync_6442_p[] __initdata = {
 	"mout_dsys",
 	"div_apll"
 };
 
-static const char *mout_d1sync_6442_p[] __initconst = {
+static const char *mout_d1sync_6442_p[] __initdata = {
 	"mout_psys",
 	"div_apll"
 };
 
-static const char *mout_group2_6442_p[] __initconst = {
+static const char *mout_group2_6442_p[] __initdata = {
 	"fin_pll",
 	"none",
 	"none",
@@ -322,7 +322,7 @@ static const char *mout_group2_6442_p[] __initconst = {
 	"mout_vpll",
 };
 
-static const char *mout_audio0_6442_p[] __initconst = {
+static const char *mout_audio0_6442_p[] __initdata = {
 	"fin_pll",
 	"pcmcdclk0",
 	"none",
@@ -334,7 +334,7 @@ static const char *mout_audio0_6442_p[] __initconst = {
 	"mout_vpll",
 };
 
-static const char *mout_audio1_6442_p[] __initconst = {
+static const char *mout_audio1_6442_p[] __initdata = {
 	"i2scdclk1",
 	"pcmcdclk1",
 	"none",
@@ -347,7 +347,7 @@ static const char *mout_audio1_6442_p[] __initconst = {
 	"fin_pll",
 };
 
-static const char *mout_clksel_p[] __initconst = {
+static const char *mout_clksel_p[] __initdata = {
 	"fout_apll_clkout",
 	"fout_mpll_clkout",
 	"fout_epll",
@@ -370,7 +370,7 @@ static const char *mout_clksel_p[] __initconst = {
 	"div_dclk"
 };
 
-static const char *mout_clksel_6442_p[] __initconst = {
+static const char *mout_clksel_6442_p[] __initdata = {
 	"fout_apll_clkout",
 	"fout_mpll_clkout",
 	"fout_epll",
@@ -393,7 +393,7 @@ static const char *mout_clksel_6442_p[] __initconst = {
 	"div_dclk"
 };
 
-static const char *mout_clkout_p[] __initconst = {
+static const char *mout_clkout_p[] __initdata = {
 	"dout_clkout",
 	"none",
 	"xxti",
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 19d8980ba458..c429c65b5b21 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -67,7 +67,7 @@ struct component_clk {
 	struct list_head link;
 };
 
-static const char * __initconst component_clk_types[] = {
+static const char * const component_clk_types[] __initconst = {
 	"gate", "divider", "mux"
 };
 
-- 
2.1.0
