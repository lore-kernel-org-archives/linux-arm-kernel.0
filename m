From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue,  3 Sep 2013 17:04:30 +0530
Subject: [RFC Patch v2 2/3] clk: update users of "clk_register_mux" and
 "DEFINE_CLK_MUX"
In-Reply-To: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
References: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1378208072-10173-3-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As with the patch "clk: add support for temporary parent clock migration"
a new field "temp_parent_name", is added to clk structure. This field can
be passed using clk_register_mux API and DEFINE_CLK_MUX macro.

Hence this patch fixes all the users of these two interfaces by passing
NULL value w.r.t. "temp_parent_name" field. All users who want use
"temp_parent_name" can replace NULL value with appropriate clk name.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/mach-imx/clk.h                |    6 +--
 arch/arm/mach-omap2/cclock2420_data.c  |    2 +-
 arch/arm/mach-omap2/cclock2430_data.c  |    4 +-
 arch/arm/mach-omap2/cclock33xx_data.c  |    7 +--
 arch/arm/mach-omap2/cclock3xxx_data.c  |    8 ++--
 arch/arm/mach-omap2/cclock44xx_data.c  |   61 +++++++++++++------------
 drivers/clk/mmp/clk-mmp2.c             |   39 ++++++++++------
 drivers/clk/mmp/clk-pxa910.c           |   30 ++++++++----
 drivers/clk/mxs/clk.h                  |    2 +-
 drivers/clk/samsung/clk-exynos-audss.c |    4 +-
 drivers/clk/samsung/clk-exynos4.c      |   10 ++--
 drivers/clk/samsung/clk.c              |    3 +-
 drivers/clk/samsung/clk.h              |   17 ++++---
 drivers/clk/spear/spear1310_clock.c    |   78 ++++++++++++++++++--------------
 drivers/clk/spear/spear1340_clock.c    |   47 ++++++++++---------
 drivers/clk/spear/spear3xx_clock.c     |   36 +++++++--------
 drivers/clk/spear/spear6xx_clock.c     |   20 ++++----
 drivers/clk/sunxi/clk-sunxi.c          |    2 +-
 drivers/clk/tegra/clk-tegra114.c       |   24 +++++-----
 drivers/clk/tegra/clk-tegra20.c        |    4 +-
 drivers/clk/tegra/clk-tegra30.c        |   22 ++++-----
 drivers/clk/versatile/clk-vexpress.c   |    2 +-
 drivers/clk/zynq/clkc.c                |   65 +++++++++++++-------------
 23 files changed, 270 insertions(+), 223 deletions(-)

diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index c8575fb..61cefa1 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -80,7 +80,7 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT, reg, shift,
+			CLK_SET_RATE_NO_REPARENT, NULL, reg, shift,
 			width, 0, &imx_ccm_lock);
 }
 
@@ -89,8 +89,8 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 		int num_parents, unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
-			&imx_ccm_lock);
+			flags | CLK_SET_RATE_NO_REPARENT, NULL, reg,
+			shift, width, 0, &imx_ccm_lock);
 }
 
 static inline struct clk *imx_clk_fixed_factor(const char *name,
diff --git a/arch/arm/mach-omap2/cclock2420_data.c b/arch/arm/mach-omap2/cclock2420_data.c
index 3662f4d..6d583a9 100644
--- a/arch/arm/mach-omap2/cclock2420_data.c
+++ b/arch/arm/mach-omap2/cclock2420_data.c
@@ -451,7 +451,7 @@ static const char *func_54m_ck_parent_names[] = {
 	"apll54_ck", "alt_ck",
 };
 
-DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parent_names, NULL, 0x0,
+DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parent_names, NULL, 0x0, NULL,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	       OMAP24XX_54M_SOURCE_SHIFT, OMAP24XX_54M_SOURCE_WIDTH,
 	       0x0, NULL);
diff --git a/arch/arm/mach-omap2/cclock2430_data.c b/arch/arm/mach-omap2/cclock2430_data.c
index 5e4b037..8223a70 100644
--- a/arch/arm/mach-omap2/cclock2430_data.c
+++ b/arch/arm/mach-omap2/cclock2430_data.c
@@ -226,7 +226,7 @@ static const char *func_96m_ck_parent_names[] = {
 	"apll96_ck", "alt_ck",
 };
 
-DEFINE_CLK_MUX(func_96m_ck, func_96m_ck_parent_names, NULL, 0x0,
+DEFINE_CLK_MUX(func_96m_ck, func_96m_ck_parent_names, NULL, 0x0, NULL,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1), OMAP2430_96M_SOURCE_SHIFT,
 	       OMAP2430_96M_SOURCE_WIDTH, 0x0, NULL);
 
@@ -431,7 +431,7 @@ static const char *func_54m_ck_parent_names[] = {
 	"apll54_ck", "alt_ck",
 };
 
-DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parent_names, NULL, 0x0,
+DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parent_names, NULL, 0x0, NULL,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	       OMAP24XX_54M_SOURCE_SHIFT, OMAP24XX_54M_SOURCE_WIDTH, 0x0, NULL);
 
diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index ba6534d..7882af4 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -65,7 +65,7 @@ static const char *sys_clkin_ck_parents[] = {
  *   adc_tsc, smartreflex0-1, timer1-7, mcasp0-1, dcan0-1, cefuse
  *
  */
-DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, NULL, 0x0, NULL,
 	       AM33XX_CTRL_REGADDR(AM33XX_CONTROL_STATUS),
 	       AM33XX_CONTROL_STATUS_SYSBOOT1_SHIFT,
 	       AM33XX_CONTROL_STATUS_SYSBOOT1_WIDTH,
@@ -901,11 +901,12 @@ static const char *stm_pmd_clock_mux_ck_parents[] = {
 };
 
 DEFINE_CLK_MUX(stm_pmd_clock_mux_ck, stm_pmd_clock_mux_ck_parents, NULL, 0x0,
-	       AM33XX_CM_WKUP_DEBUGSS_CLKCTRL, AM33XX_STM_PMD_CLKSEL_SHIFT,
+	       NULL, AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
+	       AM33XX_STM_PMD_CLKSEL_SHIFT,
 	       AM33XX_STM_PMD_CLKSEL_WIDTH, 0x0, NULL);
 
 DEFINE_CLK_MUX(trace_pmd_clk_mux_ck, stm_pmd_clock_mux_ck_parents, NULL, 0x0,
-	       AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
+	       NULL, AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
 	       AM33XX_TRC_PMD_CLKSEL_SHIFT,
 	       AM33XX_TRC_PMD_CLKSEL_WIDTH, 0x0, NULL);
 
diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 334b767..6a0ce03 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -78,7 +78,7 @@ static const char *osc_sys_ck_parent_names[] = {
 	"virt_38_4m_ck", "virt_16_8m_ck",
 };
 
-DEFINE_CLK_MUX(osc_sys_ck, osc_sys_ck_parent_names, NULL, 0x0,
+DEFINE_CLK_MUX(osc_sys_ck, osc_sys_ck_parent_names, NULL, 0x0, NULL,
 	       OMAP3430_PRM_CLKSEL, OMAP3430_SYS_CLKIN_SEL_SHIFT,
 	       OMAP3430_SYS_CLKIN_SEL_WIDTH, 0x0, NULL);
 
@@ -560,7 +560,7 @@ static const char *omap_54m_fck_parent_names[] = {
 	"dpll4_m3x2_ck", "sys_altclk",
 };
 
-DEFINE_CLK_MUX(omap_54m_fck, omap_54m_fck_parent_names, NULL, 0x0,
+DEFINE_CLK_MUX(omap_54m_fck, omap_54m_fck_parent_names, NULL, 0x0, NULL,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1), OMAP3430_SOURCE_54M_SHIFT,
 	       OMAP3430_SOURCE_54M_WIDTH, 0x0, NULL);
 
@@ -655,7 +655,7 @@ static const char *omap_96m_fck_parent_names[] = {
 	"cm_96m_fck", "sys_ck",
 };
 
-DEFINE_CLK_MUX(omap_96m_fck, omap_96m_fck_parent_names, NULL, 0x0,
+DEFINE_CLK_MUX(omap_96m_fck, omap_96m_fck_parent_names, NULL, 0x0, NULL,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	       OMAP3430_SOURCE_96M_SHIFT, OMAP3430_SOURCE_96M_WIDTH, 0x0, NULL);
 
@@ -2790,7 +2790,7 @@ DEFINE_CLK_DIVIDER(sys_clkout2, "clkout2_src_ck", &clkout2_src_ck, 0x0,
 		   OMAP3430_CM_CLKOUT_CTRL, OMAP3430_CLKOUT2_DIV_SHIFT,
 		   OMAP3430_CLKOUT2_DIV_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
 
-DEFINE_CLK_MUX(traceclk_src_fck, emu_src_ck_parent_names, NULL, 0x0,
+DEFINE_CLK_MUX(traceclk_src_fck, emu_src_ck_parent_names, NULL, 0x0, NULL,
 	       OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	       OMAP3430_TRACE_MUX_CTRL_SHIFT, OMAP3430_TRACE_MUX_CTRL_WIDTH,
 	       0x0, NULL);
diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 88e37a4..4bf0c8a 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -101,7 +101,7 @@ static const char *sys_clkin_ck_parents[] = {
 	"virt_38400000_ck",
 };
 
-DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM_SYS_CLKSEL, OMAP4430_SYS_CLKSEL_SHIFT,
 	       OMAP4430_SYS_CLKSEL_WIDTH, CLK_MUX_INDEX_ONE, NULL);
 
@@ -122,12 +122,12 @@ static const char *abe_dpll_bypass_clk_mux_ck_parents[] = {
 };
 
 DEFINE_CLK_MUX(abe_dpll_bypass_clk_mux_ck, abe_dpll_bypass_clk_mux_ck_parents,
-	       NULL, 0x0, OMAP4430_CM_L4_WKUP_CLKSEL, OMAP4430_CLKSEL_SHIFT,
-	       OMAP4430_CLKSEL_WIDTH, 0x0, NULL);
+	       NULL, 0x0, NULL, OMAP4430_CM_L4_WKUP_CLKSEL,
+	       OMAP4430_CLKSEL_SHIFT, OMAP4430_CLKSEL_WIDTH, 0x0, NULL);
 
 DEFINE_CLK_MUX(abe_dpll_refclk_mux_ck, abe_dpll_bypass_clk_mux_ck_parents, NULL,
-	       0x0, OMAP4430_CM_ABE_PLL_REF_CLKSEL, OMAP4430_CLKSEL_0_0_SHIFT,
-	       OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
+	       0x0, NULL, OMAP4430_CM_ABE_PLL_REF_CLKSEL,
+	       OMAP4430_CLKSEL_0_0_SHIFT, OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
 /* DPLL_ABE */
 static struct dpll_data dpll_abe_dd = {
@@ -229,7 +229,7 @@ static const char *core_hsd_byp_clk_mux_ck_parents[] = {
 };
 
 DEFINE_CLK_MUX(core_hsd_byp_clk_mux_ck, core_hsd_byp_clk_mux_ck_parents, NULL,
-	       0x0, OMAP4430_CM_CLKSEL_DPLL_CORE,
+	       0x0, NULL, OMAP4430_CM_CLKSEL_DPLL_CORE,
 	       OMAP4430_DPLL_BYP_CLKSEL_SHIFT, OMAP4430_DPLL_BYP_CLKSEL_WIDTH,
 	       0x0, NULL);
 
@@ -368,7 +368,8 @@ static const char *iva_hsd_byp_clk_mux_ck_parents[] = {
 };
 
 DEFINE_CLK_MUX(iva_hsd_byp_clk_mux_ck, iva_hsd_byp_clk_mux_ck_parents, NULL,
-	       0x0, OMAP4430_CM_CLKSEL_DPLL_IVA, OMAP4430_DPLL_BYP_CLKSEL_SHIFT,
+	       0x0, NULL, OMAP4430_CM_CLKSEL_DPLL_IVA,
+	       OMAP4430_DPLL_BYP_CLKSEL_SHIFT,
 	       OMAP4430_DPLL_BYP_CLKSEL_WIDTH, 0x0, NULL);
 
 /* DPLL_IVA */
@@ -486,8 +487,9 @@ static const char *per_hsd_byp_clk_mux_ck_parents[] = {
 };
 
 DEFINE_CLK_MUX(per_hsd_byp_clk_mux_ck, per_hsd_byp_clk_mux_ck_parents, NULL,
-	       0x0, OMAP4430_CM_CLKSEL_DPLL_PER, OMAP4430_DPLL_BYP_CLKSEL_SHIFT,
-	       OMAP4430_DPLL_BYP_CLKSEL_WIDTH, 0x0, NULL);
+	       0x0, NULL, OMAP4430_CM_CLKSEL_DPLL_PER,
+	       OMAP4430_DPLL_BYP_CLKSEL_SHIFT, OMAP4430_DPLL_BYP_CLKSEL_WIDTH,
+	       0x0, NULL);
 
 /* DPLL_PER */
 static struct dpll_data dpll_per_dd = {
@@ -661,7 +663,7 @@ static const char *ducati_clk_mux_ck_parents[] = {
 	"div_core_ck", "dpll_per_m6x2_ck",
 };
 
-DEFINE_CLK_MUX(ducati_clk_mux_ck, ducati_clk_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(ducati_clk_mux_ck, ducati_clk_mux_ck_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM_CLKSEL_DUCATI_ISS_ROOT, OMAP4430_CLKSEL_0_0_SHIFT,
 	       OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
@@ -732,7 +734,7 @@ static const char *l4_wkup_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "lp_clk_div_ck",
 };
 
-DEFINE_CLK_MUX(l4_wkup_clk_mux_ck, l4_wkup_clk_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(l4_wkup_clk_mux_ck, l4_wkup_clk_mux_ck_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM_L4_WKUP_CLKSEL, OMAP4430_CLKSEL_0_0_SHIFT,
 	       OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
@@ -803,7 +805,7 @@ static const char *dmic_sync_mux_ck_parents[] = {
 };
 
 DEFINE_CLK_MUX(dmic_sync_mux_ck, dmic_sync_mux_ck_parents, NULL,
-	       0x0, OMAP4430_CM1_ABE_DMIC_CLKCTRL,
+	       0x0, NULL, OMAP4430_CM1_ABE_DMIC_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
 
@@ -893,7 +895,7 @@ DEFINE_CLK_GATE(iss_ctrlclk, "func_96m_fclk", &func_96m_fclk, 0x0,
 		OMAP4430_CM_CAM_ISS_CLKCTRL, OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_MUX(mcasp_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(mcasp_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM1_ABE_MCASP_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -913,7 +915,7 @@ DEFINE_CLK_OMAP_MUX(func_mcasp_abe_gfclk, "abe_clkdm", func_mcasp_abe_gfclk_sel,
 		    OMAP4430_CM1_ABE_MCASP_CLKCTRL, OMAP4430_CLKSEL_SOURCE_MASK,
 		    func_mcasp_abe_gfclk_parents, func_dmic_abe_gfclk_ops);
 
-DEFINE_CLK_MUX(mcbsp1_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(mcbsp1_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -934,7 +936,7 @@ DEFINE_CLK_OMAP_MUX(func_mcbsp1_gfclk, "abe_clkdm", func_mcbsp1_gfclk_sel,
 		    OMAP4430_CLKSEL_SOURCE_MASK, func_mcbsp1_gfclk_parents,
 		    func_dmic_abe_gfclk_ops);
 
-DEFINE_CLK_MUX(mcbsp2_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(mcbsp2_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -955,7 +957,7 @@ DEFINE_CLK_OMAP_MUX(func_mcbsp2_gfclk, "abe_clkdm", func_mcbsp2_gfclk_sel,
 		    OMAP4430_CLKSEL_SOURCE_MASK, func_mcbsp2_gfclk_parents,
 		    func_dmic_abe_gfclk_ops);
 
-DEFINE_CLK_MUX(mcbsp3_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(mcbsp3_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -980,7 +982,7 @@ static const char *mcbsp4_sync_mux_ck_parents[] = {
 	"func_96m_fclk", "per_abe_nc_fclk",
 };
 
-DEFINE_CLK_MUX(mcbsp4_sync_mux_ck, mcbsp4_sync_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(mcbsp4_sync_mux_ck, mcbsp4_sync_mux_ck_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -1162,7 +1164,7 @@ static const char *utmi_p1_gfclk_parents[] = {
 	"init_60m_fclk", "xclk60mhsp1_ck",
 };
 
-DEFINE_CLK_MUX(utmi_p1_gfclk, utmi_p1_gfclk_parents, NULL, 0x0,
+DEFINE_CLK_MUX(utmi_p1_gfclk, utmi_p1_gfclk_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	       OMAP4430_CLKSEL_UTMI_P1_SHIFT, OMAP4430_CLKSEL_UTMI_P1_WIDTH,
 	       0x0, NULL);
@@ -1175,7 +1177,7 @@ static const char *utmi_p2_gfclk_parents[] = {
 	"init_60m_fclk", "xclk60mhsp2_ck",
 };
 
-DEFINE_CLK_MUX(utmi_p2_gfclk, utmi_p2_gfclk_parents, NULL, 0x0,
+DEFINE_CLK_MUX(utmi_p2_gfclk, utmi_p2_gfclk_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	       OMAP4430_CLKSEL_UTMI_P2_SHIFT, OMAP4430_CLKSEL_UTMI_P2_WIDTH,
 	       0x0, NULL);
@@ -1220,7 +1222,7 @@ static const char *otg_60m_gfclk_parents[] = {
 	"utmi_phy_clkout_ck", "xclk60motg_ck",
 };
 
-DEFINE_CLK_MUX(otg_60m_gfclk, otg_60m_gfclk_parents, NULL, 0x0,
+DEFINE_CLK_MUX(otg_60m_gfclk, otg_60m_gfclk_parents, NULL, 0x0, NULL,
 	       OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL, OMAP4430_CLKSEL_60M_SHIFT,
 	       OMAP4430_CLKSEL_60M_WIDTH, 0x0, NULL);
 
@@ -1272,11 +1274,12 @@ static const char *pmd_stm_clock_mux_ck_parents[] = {
 };
 
 DEFINE_CLK_MUX(pmd_stm_clock_mux_ck, pmd_stm_clock_mux_ck_parents, NULL, 0x0,
-	       OMAP4430_CM_EMU_DEBUGSS_CLKCTRL, OMAP4430_PMD_STM_MUX_CTRL_SHIFT,
-	       OMAP4430_PMD_STM_MUX_CTRL_WIDTH, 0x0, NULL);
+	       NULL, OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
+	       OMAP4430_PMD_STM_MUX_CTRL_SHIFT, OMAP4430_PMD_STM_MUX_CTRL_WIDTH,
+	       0x0, NULL);
 
 DEFINE_CLK_MUX(pmd_trace_clk_mux_ck, pmd_stm_clock_mux_ck_parents, NULL, 0x0,
-	       OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
+	       NULL, OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
 	       OMAP4430_PMD_TRACE_MUX_CTRL_SHIFT,
 	       OMAP4430_PMD_TRACE_MUX_CTRL_WIDTH, 0x0, NULL);
 
@@ -1399,27 +1402,27 @@ static const char *auxclkreq_ck_parents[] = {
 	"auxclk5_ck",
 };
 
-DEFINE_CLK_MUX(auxclkreq0_ck, auxclkreq_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(auxclkreq0_ck, auxclkreq_ck_parents, NULL, 0x0, NULL,
 	       OMAP4_SCRM_AUXCLKREQ0, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq1_ck, auxclkreq_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(auxclkreq1_ck, auxclkreq_ck_parents, NULL, 0x0, NULL,
 	       OMAP4_SCRM_AUXCLKREQ1, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq2_ck, auxclkreq_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(auxclkreq2_ck, auxclkreq_ck_parents, NULL, 0x0, NULL,
 	       OMAP4_SCRM_AUXCLKREQ2, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq3_ck, auxclkreq_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(auxclkreq3_ck, auxclkreq_ck_parents, NULL, 0x0, NULL,
 	       OMAP4_SCRM_AUXCLKREQ3, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq4_ck, auxclkreq_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(auxclkreq4_ck, auxclkreq_ck_parents, NULL, 0x0, NULL,
 	       OMAP4_SCRM_AUXCLKREQ4, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq5_ck, auxclkreq_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(auxclkreq5_ck, auxclkreq_ck_parents, NULL, 0x0, NULL,
 	       OMAP4_SCRM_AUXCLKREQ5, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
 	       0x0, NULL);
 
diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index b2721ca..c0fe9bd 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -250,7 +250,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "uart0_mux", uart_parent,
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_UART0,
+				4, 3, 0, &clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
@@ -261,7 +262,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "uart1_mux", uart_parent,
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_UART1, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_UART1,
+				4, 3, 0, &clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.1", NULL);
 
@@ -272,7 +274,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "uart2_mux", uart_parent,
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_UART2, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_UART2,
+				4, 3, 0, &clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.2", NULL);
 
@@ -283,7 +286,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "uart3_mux", uart_parent,
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_UART3, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_UART3,
+				4, 3, 0, &clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.3", NULL);
 
@@ -294,7 +298,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "ssp0_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_SSP0, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_SSP0,
+				4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
 	clk = mmp_clk_register_apbc("ssp0", "ssp0_mux",
@@ -304,7 +309,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "ssp1_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_SSP1, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_SSP1,
+				4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.1", NULL);
 
 	clk = mmp_clk_register_apbc("ssp1", "ssp1_mux",
@@ -314,7 +320,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "ssp2_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_SSP2, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_SSP2,
+				4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.2", NULL);
 
 	clk = mmp_clk_register_apbc("ssp2", "ssp2_mux",
@@ -324,7 +331,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "ssp3_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_SSP3, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_SSP3,
+				4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.3", NULL);
 
 	clk = mmp_clk_register_apbc("ssp3", "ssp3_mux",
@@ -334,7 +342,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "sdh_mux", sdh_parent,
 				ARRAY_SIZE(sdh_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_SDH0, 8, 2, 0, &clk_lock);
+				NULL, apmu_base + APMU_SDH0,
+				8, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "sdh_mux", NULL);
 
 	clk = clk_register_divider(NULL, "sdh_div", "sdh_mux",
@@ -365,7 +374,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "disp0_mux", disp_parent,
 				ARRAY_SIZE(disp_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_DISP0, 6, 2, 0, &clk_lock);
+				NULL, apmu_base + APMU_DISP0,
+				6, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "disp_mux.0", NULL);
 
 	clk = clk_register_divider(NULL, "disp0_div", "disp0_mux",
@@ -388,7 +398,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "disp1_mux", disp_parent,
 				ARRAY_SIZE(disp_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_DISP1, 6, 2, 0, &clk_lock);
+				NULL, apmu_base + APMU_DISP1,
+				6, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "disp_mux.1", NULL);
 
 	clk = clk_register_divider(NULL, "disp1_div", "disp1_mux",
@@ -407,7 +418,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "ccic0_mux", ccic_parent,
 				ARRAY_SIZE(ccic_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_CCIC0, 6, 2, 0, &clk_lock);
+				NULL, apmu_base + APMU_CCIC0,
+				6, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_mux.0", NULL);
 
 	clk = clk_register_divider(NULL, "ccic0_div", "ccic0_mux",
@@ -435,7 +447,8 @@ void __init mmp2_clk_init(void)
 	clk = clk_register_mux(NULL, "ccic1_mux", ccic_parent,
 				ARRAY_SIZE(ccic_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_CCIC1, 6, 2, 0, &clk_lock);
+				NULL, apmu_base + APMU_CCIC1,
+				6, 2, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_mux.1", NULL);
 
 	clk = clk_register_divider(NULL, "ccic1_div", "ccic1_mux",
diff --git a/drivers/clk/mmp/clk-pxa910.c b/drivers/clk/mmp/clk-pxa910.c
index 9efc6a4..ffaab99 100644
--- a/drivers/clk/mmp/clk-pxa910.c
+++ b/drivers/clk/mmp/clk-pxa910.c
@@ -206,7 +206,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "uart0_mux", uart_parent,
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_UART0,
+				4, 3, 0, &clk_lock);
 	clk_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
@@ -217,7 +218,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "uart1_mux", uart_parent,
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_UART1, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_UART1,
+				4, 3, 0, &clk_lock);
 	clk_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.1", NULL);
 
@@ -228,7 +230,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "uart2_mux", uart_parent,
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbcp_base + APBCP_UART2, 4, 3, 0, &clk_lock);
+				NULL, apbcp_base + APBCP_UART2,
+				4, 3, 0, &clk_lock);
 	clk_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.2", NULL);
 
@@ -239,7 +242,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "ssp0_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_SSP0, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_SSP0,
+				4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
 	clk = mmp_clk_register_apbc("ssp0", "ssp0_mux",
@@ -249,7 +253,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "ssp1_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apbc_base + APBC_SSP1, 4, 3, 0, &clk_lock);
+				NULL, apbc_base + APBC_SSP1,
+				4, 3, 0, &clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.1", NULL);
 
 	clk = mmp_clk_register_apbc("ssp1", "ssp1_mux",
@@ -263,7 +268,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "sdh0_mux", sdh_parent,
 				ARRAY_SIZE(sdh_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_SDH0, 6, 1, 0, &clk_lock);
+				NULL, apmu_base + APMU_SDH0,
+				6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "sdh0_mux", NULL);
 
 	clk = mmp_clk_register_apmu("sdh0", "sdh_mux",
@@ -273,7 +279,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "sdh1_mux", sdh_parent,
 				ARRAY_SIZE(sdh_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_SDH1, 6, 1, 0, &clk_lock);
+				NULL, apmu_base + APMU_SDH1,
+				6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "sdh1_mux", NULL);
 
 	clk = mmp_clk_register_apmu("sdh1", "sdh1_mux",
@@ -291,7 +298,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "disp0_mux", disp_parent,
 				ARRAY_SIZE(disp_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_DISP0, 6, 1, 0, &clk_lock);
+				NULL, apmu_base + APMU_DISP0,
+				6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "disp_mux.0", NULL);
 
 	clk = mmp_clk_register_apmu("disp0", "disp0_mux",
@@ -301,7 +309,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "ccic0_mux", ccic_parent,
 				ARRAY_SIZE(ccic_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_CCIC0, 6, 1, 0, &clk_lock);
+				NULL, apmu_base + APMU_CCIC0,
+				6, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_mux.0", NULL);
 
 	clk = mmp_clk_register_apmu("ccic0", "ccic0_mux",
@@ -311,7 +320,8 @@ void __init pxa910_clk_init(void)
 	clk = clk_register_mux(NULL, "ccic0_phy_mux", ccic_phy_parent,
 				ARRAY_SIZE(ccic_phy_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				apmu_base + APMU_CCIC0, 7, 1, 0, &clk_lock);
+				NULL, apmu_base + APMU_CCIC0,
+				7, 1, 0, &clk_lock);
 	clk_register_clkdev(clk, "ccic_phy_mux.0", NULL);
 
 	clk = mmp_clk_register_apmu("ccic0_phy", "ccic0_phy_mux",
diff --git a/drivers/clk/mxs/clk.h b/drivers/clk/mxs/clk.h
index ef10ad9..46ae98f8 100644
--- a/drivers/clk/mxs/clk.h
+++ b/drivers/clk/mxs/clk.h
@@ -53,7 +53,7 @@ static inline struct clk *mxs_clk_mux(const char *name, void __iomem *reg,
 {
 	return clk_register_mux(NULL, name, parent_names, num_parents,
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-				reg, shift, width, 0, &mxs_lock);
+				NULL, reg, shift, width, 0, &mxs_lock);
 }
 
 static inline struct clk *mxs_clk_fixed_factor(const char *name,
diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 39b40aa..98b89de 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -83,12 +83,12 @@ static void __init exynos_audss_clk_init(struct device_node *np)
 
 	clk_table[EXYNOS_MOUT_AUDSS] = clk_register_mux(NULL, "mout_audss",
 				mout_audss_p, ARRAY_SIZE(mout_audss_p),
-				CLK_SET_RATE_NO_REPARENT,
+				CLK_SET_RATE_NO_REPARENT, NULL,
 				reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
 
 	clk_table[EXYNOS_MOUT_I2S] = clk_register_mux(NULL, "mout_i2s",
 				mout_i2s_p, ARRAY_SIZE(mout_i2s_p),
-				CLK_SET_RATE_NO_REPARENT,
+				CLK_SET_RATE_NO_REPARENT, NULL,
 				reg_base + ASS_CLK_SRC, 2, 2, 0, &lock);
 
 	clk_table[EXYNOS_DOUT_SRP] = clk_register_divider(NULL, "dout_srp",
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 742b4c5..50fa6e5 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -364,14 +364,14 @@ static struct samsung_fixed_rate_clock exynos4210_fixed_rate_clks[] __initdata =
 /* list of mux clocks supported in all exynos4 soc's */
 static struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
 	MUX_FA(mout_apll, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
-			CLK_SET_RATE_PARENT, 0, "mout_apll"),
+			CLK_SET_RATE_PARENT, 0, "mout_apll", NULL),
 	MUX(none, "mout_hdmi", mout_hdmi_p, SRC_TV, 0, 1),
 	MUX(none, "mout_mfc1", sclk_evpll_p, SRC_MFC, 4, 1),
 	MUX(none, "mout_mfc", mout_mfc_p, SRC_MFC, 8, 1),
 	MUX_F(mout_g3d1, "mout_g3d1", sclk_evpll_p, SRC_G3D, 4, 1,
-			CLK_SET_RATE_PARENT, 0),
+			CLK_SET_RATE_PARENT, 0, NULL),
 	MUX_F(mout_g3d, "mout_g3d", mout_g3d_p, SRC_G3D, 8, 1,
-			CLK_SET_RATE_PARENT, 0),
+			CLK_SET_RATE_PARENT, 0, NULL),
 	MUX(none, "mout_spdif", mout_spdif_p, SRC_PERIL1, 8, 2),
 	MUX(none, "mout_onenand1", mout_onenand1_p, SRC_TOP0, 0, 1),
 	MUX_A(sclk_epll, "sclk_epll", mout_epll_p, SRC_TOP0, 4, 1, "sclk_epll"),
@@ -407,7 +407,7 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX(mout_csis1, "mout_csis1", group1_p4210, SRC_CAM, 28, 4),
 	MUX(none, "mout_mfc0", sclk_ampll_p4210, SRC_MFC, 0, 1),
 	MUX_F(mout_g3d0, "mout_g3d0", sclk_ampll_p4210, SRC_G3D, 0, 1,
-			CLK_SET_RATE_PARENT, 0),
+			CLK_SET_RATE_PARENT, 0, NULL),
 	MUX(none, "mout_fimd0", group1_p4210, SRC_LCD0, 0, 4),
 	MUX(none, "mout_mipi0", group1_p4210, SRC_LCD0, 12, 4),
 	MUX(none, "mout_audio0", mout_audio0_p4210, SRC_MAUDIO, 0, 4),
@@ -468,7 +468,7 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX(mout_csis1, "mout_csis1", group1_p4x12, SRC_CAM, 28, 4),
 	MUX(none, "mout_mfc0", sclk_ampll_p4x12, SRC_MFC, 0, 1),
 	MUX_F(mout_g3d0, "mout_g3d0", sclk_ampll_p4x12, SRC_G3D, 0, 1,
-			CLK_SET_RATE_PARENT, 0),
+			CLK_SET_RATE_PARENT, 0, NULL),
 	MUX(none, "mout_fimd0", group1_p4x12, SRC_LCD0, 0, 4),
 	MUX(none, "mout_mipi0", group1_p4x12, SRC_LCD0, 12, 4),
 	MUX(none, "mout_audio0", mout_audio0_p4x12, SRC_MAUDIO, 0, 4),
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index cd3c40a..d905130 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -191,7 +191,8 @@ void __init samsung_clk_register_mux(struct samsung_mux_clock *list,
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		clk = clk_register_mux(NULL, list->name, list->parent_names,
-			list->num_parents, list->flags, reg_base + list->offset,
+			list->num_parents, list->flags,
+			list->temp_parent_name, reg_base + list->offset,
 			list->shift, list->width, list->mux_flags, &lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 31b4174..80d65a3 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -108,6 +108,7 @@ struct samsung_fixed_factor_clock {
  * @width: width of the mux control bit-field in @reg.
  * @mux_flags: flags for mux-type clock.
  * @alias: optional clock alias name to be assigned to this clock.
+ * @temp_parent_name: alternate clock name needed for temporary migration
  */
 struct samsung_mux_clock {
 	unsigned int		id;
@@ -121,9 +122,10 @@ struct samsung_mux_clock {
 	u8			width;
 	u8			mux_flags;
 	const char		*alias;
+	const char		*temp_parent_name;
 };
 
-#define __MUX(_id, dname, cname, pnames, o, s, w, f, mf, a)	\
+#define __MUX(_id, dname, cname, pnames, o, s, w, f, mf, a, tpname)	\
 	{							\
 		.id		= _id,				\
 		.dev_name	= dname,			\
@@ -136,19 +138,20 @@ struct samsung_mux_clock {
 		.width		= w,				\
 		.mux_flags	= mf,				\
 		.alias		= a,				\
+		.alternate_parent_name	= tpname,		\
 	}
 
 #define MUX(_id, cname, pnames, o, s, w)			\
-	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
+	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL, NULL)
 
 #define MUX_A(_id, cname, pnames, o, s, w, a)			\
-	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, a)
+	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, a, NULL)
 
-#define MUX_F(_id, cname, pnames, o, s, w, f, mf)		\
-	__MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
+#define MUX_F(_id, cname, pnames, o, s, w, f, mf, tpname)	\
+	__MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL, tpname)
 
-#define MUX_FA(_id, cname, pnames, o, s, w, f, mf, a)		\
-	__MUX(_id, NULL, cname, pnames, o, s, w, f, mf, a)
+#define MUX_FA(_id, cname, pnames, o, s, w, f, mf, a, tpname)	\
+	__MUX(_id, NULL, cname, pnames, o, s, w, f, mf, a, tpname)
 
 /**
  * @id: platform specific id of the clock.
diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 65894f7..94feaa1 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -417,7 +417,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	/* vco-pll */
 	clk = clk_register_mux(NULL, "vco1_mclk", vco_parents,
 			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PLL_CFG, SPEAR1310_PLL1_CLK_SHIFT,
+			NULL, SPEAR1310_PLL_CFG, SPEAR1310_PLL1_CLK_SHIFT,
 			SPEAR1310_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco1_mclk", NULL);
 	clk = clk_register_vco_pll("vco1_clk", "pll1_clk", NULL, "vco1_mclk",
@@ -428,7 +428,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "vco2_mclk", vco_parents,
 			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PLL_CFG, SPEAR1310_PLL2_CLK_SHIFT,
+			NULL, SPEAR1310_PLL_CFG, SPEAR1310_PLL2_CLK_SHIFT,
 			SPEAR1310_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco2_mclk", NULL);
 	clk = clk_register_vco_pll("vco2_clk", "pll2_clk", NULL, "vco2_mclk",
@@ -439,7 +439,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "vco3_mclk", vco_parents,
 			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PLL_CFG, SPEAR1310_PLL3_CLK_SHIFT,
+			NULL, SPEAR1310_PLL_CFG, SPEAR1310_PLL3_CLK_SHIFT,
 			SPEAR1310_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco3_mclk", NULL);
 	clk = clk_register_vco_pll("vco3_clk", "pll3_clk", NULL, "vco3_mclk",
@@ -516,7 +516,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	/* gpt clocks */
 	clk = clk_register_mux(NULL, "gpt0_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT0_CLK_SHIFT,
+			NULL, SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT0_CLK_SHIFT,
 			SPEAR1310_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt0_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt0_clk", "gpt0_mclk", 0,
@@ -526,7 +526,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "gpt1_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT1_CLK_SHIFT,
+			NULL, SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT1_CLK_SHIFT,
 			SPEAR1310_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt1_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
@@ -536,7 +536,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "gpt2_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT2_CLK_SHIFT,
+			NULL, SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT2_CLK_SHIFT,
 			SPEAR1310_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt2_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
@@ -546,7 +546,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "gpt3_mclk", gpt_parents,
 			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT3_CLK_SHIFT,
+			NULL, SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GPT3_CLK_SHIFT,
 			SPEAR1310_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt3_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mclk", 0,
@@ -564,7 +564,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
 			ARRAY_SIZE(uart0_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_UART_CLK_SHIFT,
+			NULL, SPEAR1310_PERIP_CLK_CFG, SPEAR1310_UART_CLK_SHIFT,
 			SPEAR1310_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart0_mclk", NULL);
 
@@ -605,7 +605,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk = clk_register_mux(NULL, "c3_mclk", c3_parents,
 			ARRAY_SIZE(c3_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_C3_CLK_SHIFT,
+			NULL, SPEAR1310_PERIP_CLK_CFG, SPEAR1310_C3_CLK_SHIFT,
 			SPEAR1310_C3_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "c3_mclk", NULL);
 
@@ -617,7 +617,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	/* gmac */
 	clk = clk_register_mux(NULL, "phy_input_mclk", gmac_phy_input_parents,
 			ARRAY_SIZE(gmac_phy_input_parents),
-			CLK_SET_RATE_NO_REPARENT, SPEAR1310_GMAC_CLK_CFG,
+			CLK_SET_RATE_NO_REPARENT, NULL, SPEAR1310_GMAC_CLK_CFG,
 			SPEAR1310_GMAC_PHY_INPUT_CLK_SHIFT,
 			SPEAR1310_GMAC_PHY_INPUT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "phy_input_mclk", NULL);
@@ -630,14 +630,15 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "phy_mclk", gmac_phy_parents,
 			ARRAY_SIZE(gmac_phy_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GMAC_PHY_CLK_SHIFT,
+			NULL, SPEAR1310_PERIP_CLK_CFG,
+			SPEAR1310_GMAC_PHY_CLK_SHIFT,
 			SPEAR1310_GMAC_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
 			ARRAY_SIZE(clcd_synth_parents),
-			CLK_SET_RATE_NO_REPARENT, SPEAR1310_CLCD_CLK_SYNT,
+			CLK_SET_RATE_NO_REPARENT, NULL, SPEAR1310_CLCD_CLK_SYNT,
 			SPEAR1310_CLCD_SYNT_CLK_SHIFT,
 			SPEAR1310_CLCD_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_syn_mclk", NULL);
@@ -650,7 +651,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk = clk_register_mux(NULL, "clcd_pixel_mclk", clcd_pixel_parents,
 			ARRAY_SIZE(clcd_pixel_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_CLCD_CLK_SHIFT,
+			NULL, SPEAR1310_PERIP_CLK_CFG, SPEAR1310_CLCD_CLK_SHIFT,
 			SPEAR1310_CLCD_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_pixel_mclk", NULL);
 
@@ -662,7 +663,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	/* i2s */
 	clk = clk_register_mux(NULL, "i2s_src_mclk", i2s_src_parents,
 			ARRAY_SIZE(i2s_src_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_I2S_CLK_CFG, SPEAR1310_I2S_SRC_CLK_SHIFT,
+			NULL, SPEAR1310_I2S_CLK_CFG,
+			SPEAR1310_I2S_SRC_CLK_SHIFT,
 			SPEAR1310_I2S_SRC_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_src_mclk", NULL);
 
@@ -674,7 +676,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk = clk_register_mux(NULL, "i2s_ref_mclk", i2s_ref_parents,
 			ARRAY_SIZE(i2s_ref_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_I2S_CLK_CFG, SPEAR1310_I2S_REF_SHIFT,
+			NULL, SPEAR1310_I2S_CLK_CFG, SPEAR1310_I2S_REF_SHIFT,
 			SPEAR1310_I2S_REF_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_mclk", NULL);
 
@@ -812,14 +814,14 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	/* RAS clks */
 	clk = clk_register_mux(NULL, "gen_syn0_1_mclk", gen_synth0_1_parents,
 			ARRAY_SIZE(gen_synth0_1_parents),
-			CLK_SET_RATE_NO_REPARENT, SPEAR1310_PLL_CFG,
+			CLK_SET_RATE_NO_REPARENT, NULL, SPEAR1310_PLL_CFG,
 			SPEAR1310_RAS_SYNT0_1_CLK_SHIFT,
 			SPEAR1310_RAS_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen_syn0_1_clk", NULL);
 
 	clk = clk_register_mux(NULL, "gen_syn2_3_mclk", gen_synth2_3_parents,
 			ARRAY_SIZE(gen_synth2_3_parents),
-			CLK_SET_RATE_NO_REPARENT, SPEAR1310_PLL_CFG,
+			CLK_SET_RATE_NO_REPARENT, NULL, SPEAR1310_PLL_CFG,
 			SPEAR1310_RAS_SYNT2_3_CLK_SHIFT,
 			SPEAR1310_RAS_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen_syn2_3_clk", NULL);
@@ -937,7 +939,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk = clk_register_mux(NULL, "smii_rgmii_phy_mclk",
 			smii_rgmii_phy_parents,
 			ARRAY_SIZE(smii_rgmii_phy_parents),
-			CLK_SET_RATE_NO_REPARENT, SPEAR1310_RAS_CTRL_REG1,
+			CLK_SET_RATE_NO_REPARENT, NULL, SPEAR1310_RAS_CTRL_REG1,
 			SPEAR1310_SMII_RGMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "stmmacphy.1", NULL);
@@ -946,13 +948,15 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "rmii_phy_mclk", rmii_phy_parents,
 			ARRAY_SIZE(rmii_phy_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG1, SPEAR1310_RMII_PHY_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG1,
+			SPEAR1310_RMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "stmmacphy.3", NULL);
 
 	clk = clk_register_mux(NULL, "uart1_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART1_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0,
+			SPEAR1310_UART1_CLK_SHIFT,
 			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart1_mclk", NULL);
 
@@ -963,7 +967,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "uart2_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART2_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0,
+			SPEAR1310_UART2_CLK_SHIFT,
 			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart2_mclk", NULL);
 
@@ -974,7 +979,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "uart3_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART3_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0,
+			SPEAR1310_UART3_CLK_SHIFT,
 			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart3_mclk", NULL);
 
@@ -985,7 +991,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "uart4_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART4_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0,
+			SPEAR1310_UART4_CLK_SHIFT,
 			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart4_mclk", NULL);
 
@@ -996,7 +1003,8 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "uart5_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_UART5_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0,
+			SPEAR1310_UART5_CLK_SHIFT,
 			SPEAR1310_RAS_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart5_mclk", NULL);
 
@@ -1007,7 +1015,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "i2c1_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C1_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C1_CLK_SHIFT,
 			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c1_mclk", NULL);
 
@@ -1018,7 +1026,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "i2c2_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C2_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C2_CLK_SHIFT,
 			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c2_mclk", NULL);
 
@@ -1029,7 +1037,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "i2c3_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C3_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C3_CLK_SHIFT,
 			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c3_mclk", NULL);
 
@@ -1040,7 +1048,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "i2c4_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C4_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C4_CLK_SHIFT,
 			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c4_mclk", NULL);
 
@@ -1051,7 +1059,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "i2c5_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C5_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C5_CLK_SHIFT,
 			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c5_mclk", NULL);
 
@@ -1062,7 +1070,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "i2c6_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C6_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C6_CLK_SHIFT,
 			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c6_mclk", NULL);
 
@@ -1073,7 +1081,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "i2c7_mclk", i2c_parents,
 			ARRAY_SIZE(i2c_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C7_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_I2C7_CLK_SHIFT,
 			SPEAR1310_I2C_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2c7_mclk", NULL);
 
@@ -1084,7 +1092,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "ssp1_mclk", ssp1_parents,
 			ARRAY_SIZE(ssp1_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_SSP1_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_SSP1_CLK_SHIFT,
 			SPEAR1310_SSP1_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ssp1_mclk", NULL);
 
@@ -1095,7 +1103,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "pci_mclk", pci_parents,
 			ARRAY_SIZE(pci_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_PCI_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_PCI_CLK_SHIFT,
 			SPEAR1310_PCI_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "pci_mclk", NULL);
 
@@ -1106,7 +1114,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "tdm1_mclk", tdm_parents,
 			ARRAY_SIZE(tdm_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_TDM1_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_TDM1_CLK_SHIFT,
 			SPEAR1310_TDM_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "tdm1_mclk", NULL);
 
@@ -1117,7 +1125,7 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 
 	clk = clk_register_mux(NULL, "tdm2_mclk", tdm_parents,
 			ARRAY_SIZE(tdm_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1310_RAS_CTRL_REG0, SPEAR1310_TDM2_CLK_SHIFT,
+			NULL, SPEAR1310_RAS_CTRL_REG0, SPEAR1310_TDM2_CLK_SHIFT,
 			SPEAR1310_TDM_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "tdm2_mclk", NULL);
 
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index fe835c1..174b81b 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -473,7 +473,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	/* clock derived from 24 or 25 MHz osc clk */
 	/* vco-pll */
 	clk = clk_register_mux(NULL, "vco1_mclk", vco_parents,
-			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PLL_CFG, SPEAR1340_PLL1_CLK_SHIFT,
 			SPEAR1340_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco1_mclk", NULL);
@@ -484,7 +484,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "pll1_clk", NULL);
 
 	clk = clk_register_mux(NULL, "vco2_mclk", vco_parents,
-			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PLL_CFG, SPEAR1340_PLL2_CLK_SHIFT,
 			SPEAR1340_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco2_mclk", NULL);
@@ -495,7 +495,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk1, "pll2_clk", NULL);
 
 	clk = clk_register_mux(NULL, "vco3_mclk", vco_parents,
-			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(vco_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PLL_CFG, SPEAR1340_PLL3_CLK_SHIFT,
 			SPEAR1340_PLL_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "vco3_mclk", NULL);
@@ -561,7 +561,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, "amba_syn_clk", NULL);
 
 	clk = clk_register_mux(NULL, "sys_mclk", sys_parents,
-			ARRAY_SIZE(sys_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(sys_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_SYS_CLK_CTRL, SPEAR1340_SCLK_SRC_SEL_SHIFT,
 			SPEAR1340_SCLK_SRC_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "sys_mclk", NULL);
@@ -583,7 +583,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "smp_twd");
 
 	clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
-			ARRAY_SIZE(ahb_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(ahb_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_SYS_CLK_CTRL, SPEAR1340_HCLK_SRC_SEL_SHIFT,
 			SPEAR1340_HCLK_SRC_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ahb_clk", NULL);
@@ -594,7 +594,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	/* gpt clocks */
 	clk = clk_register_mux(NULL, "gpt0_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GPT0_CLK_SHIFT,
 			SPEAR1340_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt0_mclk", NULL);
@@ -604,7 +604,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "gpt0");
 
 	clk = clk_register_mux(NULL, "gpt1_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GPT1_CLK_SHIFT,
 			SPEAR1340_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt1_mclk", NULL);
@@ -614,7 +614,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "gpt1");
 
 	clk = clk_register_mux(NULL, "gpt2_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GPT2_CLK_SHIFT,
 			SPEAR1340_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt2_mclk", NULL);
@@ -624,7 +624,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, NULL, "gpt2");
 
 	clk = clk_register_mux(NULL, "gpt3_mclk", gpt_parents,
-			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(gpt_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GPT3_CLK_SHIFT,
 			SPEAR1340_GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt3_mclk", NULL);
@@ -642,7 +642,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
 			ARRAY_SIZE(uart0_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_UART0_CLK_SHIFT,
 			SPEAR1340_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart0_mclk", NULL);
@@ -660,7 +660,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "uart1_mclk", uart1_parents,
 			ARRAY_SIZE(uart1_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_UART1_CLK_SHIFT,
+			NULL, SPEAR1340_PERIP_CLK_CFG,
+			SPEAR1340_UART1_CLK_SHIFT,
 			SPEAR1340_UART_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "uart1_mclk", NULL);
 
@@ -700,7 +701,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "c3_mclk", c3_parents,
 			ARRAY_SIZE(c3_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_C3_CLK_SHIFT,
 			SPEAR1340_C3_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "c3_mclk", NULL);
@@ -713,7 +714,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	/* gmac */
 	clk = clk_register_mux(NULL, "phy_input_mclk", gmac_phy_input_parents,
 			ARRAY_SIZE(gmac_phy_input_parents),
-			CLK_SET_RATE_NO_REPARENT, SPEAR1340_GMAC_CLK_CFG,
+			CLK_SET_RATE_NO_REPARENT, NULL, SPEAR1340_GMAC_CLK_CFG,
 			SPEAR1340_GMAC_PHY_INPUT_CLK_SHIFT,
 			SPEAR1340_GMAC_PHY_INPUT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "phy_input_mclk", NULL);
@@ -726,14 +727,15 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "phy_mclk", gmac_phy_parents,
 			ARRAY_SIZE(gmac_phy_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GMAC_PHY_CLK_SHIFT,
+			NULL, SPEAR1340_PERIP_CLK_CFG,
+			SPEAR1340_GMAC_PHY_CLK_SHIFT,
 			SPEAR1340_GMAC_PHY_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
 			ARRAY_SIZE(clcd_synth_parents),
-			CLK_SET_RATE_NO_REPARENT, SPEAR1340_CLCD_CLK_SYNT,
+			CLK_SET_RATE_NO_REPARENT, NULL, SPEAR1340_CLCD_CLK_SYNT,
 			SPEAR1340_CLCD_SYNT_CLK_SHIFT,
 			SPEAR1340_CLCD_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_syn_mclk", NULL);
@@ -745,7 +747,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "clcd_pixel_mclk", clcd_pixel_parents,
 			ARRAY_SIZE(clcd_pixel_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_CLCD_CLK_SHIFT,
 			SPEAR1340_CLCD_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "clcd_pixel_mclk", NULL);
@@ -758,7 +760,8 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	/* i2s */
 	clk = clk_register_mux(NULL, "i2s_src_mclk", i2s_src_parents,
 			ARRAY_SIZE(i2s_src_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR1340_I2S_CLK_CFG, SPEAR1340_I2S_SRC_CLK_SHIFT,
+			NULL, SPEAR1340_I2S_CLK_CFG,
+			SPEAR1340_I2S_SRC_CLK_SHIFT,
 			SPEAR1340_I2S_SRC_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_src_mclk", NULL);
 
@@ -770,7 +773,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "i2s_ref_mclk", i2s_ref_parents,
 			ARRAY_SIZE(i2s_ref_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_I2S_CLK_CFG, SPEAR1340_I2S_REF_SHIFT,
 			SPEAR1340_I2S_REF_SEL_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_mclk", NULL);
@@ -897,14 +900,14 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	/* RAS clks */
 	clk = clk_register_mux(NULL, "gen_syn0_1_mclk", gen_synth0_1_parents,
 			ARRAY_SIZE(gen_synth0_1_parents),
-			CLK_SET_RATE_NO_REPARENT, SPEAR1340_PLL_CFG,
+			CLK_SET_RATE_NO_REPARENT, NULL, SPEAR1340_PLL_CFG,
 			SPEAR1340_GEN_SYNT0_1_CLK_SHIFT,
 			SPEAR1340_GEN_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen_syn0_1_mclk", NULL);
 
 	clk = clk_register_mux(NULL, "gen_syn2_3_mclk", gen_synth2_3_parents,
 			ARRAY_SIZE(gen_synth2_3_parents),
-			CLK_SET_RATE_NO_REPARENT, SPEAR1340_PLL_CFG,
+			CLK_SET_RATE_NO_REPARENT, NULL, SPEAR1340_PLL_CFG,
 			SPEAR1340_GEN_SYNT2_3_CLK_SHIFT,
 			SPEAR1340_GEN_SYNT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen_syn2_3_mclk", NULL);
@@ -946,7 +949,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "spdif_out_mclk", spdif_out_parents,
 			ARRAY_SIZE(spdif_out_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_SPDIF_OUT_CLK_SHIFT,
 			SPEAR1340_SPDIF_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "spdif_out_mclk", NULL);
@@ -958,7 +961,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "spdif_in_mclk", spdif_in_parents,
 			ARRAY_SIZE(spdif_in_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_SPDIF_IN_CLK_SHIFT,
 			SPEAR1340_SPDIF_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "spdif_in_mclk", NULL);
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index c2d2043..63469d7 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -296,7 +296,7 @@ static void __init spear320_clk_init(void __iomem *soc_config_base)
 	clk = clk_register_mux(NULL, "i2s_ref_clk", i2s_ref_parents,
 			ARRAY_SIZE(i2s_ref_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR320_CONTROL_REG, I2S_REF_PCLK_SHIFT,
+			NULL, SPEAR320_CONTROL_REG, I2S_REF_PCLK_SHIFT,
 			I2S_REF_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "i2s_ref_clk", NULL);
 
@@ -316,21 +316,21 @@ static void __init spear320_clk_init(void __iomem *soc_config_base)
 	clk = clk_register_mux(NULL, "rs485_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR320_EXT_CTRL_REG, SPEAR320_RS485_PCLK_SHIFT,
+			NULL, SPEAR320_EXT_CTRL_REG, SPEAR320_RS485_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a9300000.serial");
 
 	clk = clk_register_mux(NULL, "sdhci_clk", sdhci_parents,
 			ARRAY_SIZE(sdhci_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR320_CONTROL_REG, SDHCI_PCLK_SHIFT, SDHCI_PCLK_MASK,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "70000000.sdhci");
 
 	clk = clk_register_mux(NULL, "smii_pclk", smii0_parents,
 			ARRAY_SIZE(smii0_parents), CLK_SET_RATE_NO_REPARENT,
-			SPEAR320_CONTROL_REG, SMII_PCLK_SHIFT, SMII_PCLK_MASK,
-			0, &_lock);
+			NULL, SPEAR320_CONTROL_REG, SMII_PCLK_SHIFT,
+			SMII_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "smii_pclk");
 
 	clk = clk_register_fixed_factor(NULL, "smii_clk", "smii_pclk", 0, 1, 1);
@@ -338,7 +338,7 @@ static void __init spear320_clk_init(void __iomem *soc_config_base)
 
 	clk = clk_register_mux(NULL, "uart1_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			SPEAR320_CONTROL_REG, UART1_PCLK_SHIFT, UART1_PCLK_MASK,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "a3000000.serial");
@@ -346,35 +346,35 @@ static void __init spear320_clk_init(void __iomem *soc_config_base)
 	clk = clk_register_mux(NULL, "uart2_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR320_EXT_CTRL_REG, SPEAR320_UART2_PCLK_SHIFT,
+			NULL, SPEAR320_EXT_CTRL_REG, SPEAR320_UART2_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a4000000.serial");
 
 	clk = clk_register_mux(NULL, "uart3_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR320_EXT_CTRL_REG, SPEAR320_UART3_PCLK_SHIFT,
+			NULL, SPEAR320_EXT_CTRL_REG, SPEAR320_UART3_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a9100000.serial");
 
 	clk = clk_register_mux(NULL, "uart4_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR320_EXT_CTRL_REG, SPEAR320_UART4_PCLK_SHIFT,
+			NULL, SPEAR320_EXT_CTRL_REG, SPEAR320_UART4_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a9200000.serial");
 
 	clk = clk_register_mux(NULL, "uart5_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR320_EXT_CTRL_REG, SPEAR320_UART5_PCLK_SHIFT,
+			NULL, SPEAR320_EXT_CTRL_REG, SPEAR320_UART5_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "60000000.serial");
 
 	clk = clk_register_mux(NULL, "uart6_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			SPEAR320_EXT_CTRL_REG, SPEAR320_UART6_PCLK_SHIFT,
+			NULL, SPEAR320_EXT_CTRL_REG, SPEAR320_UART6_PCLK_SHIFT,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "60100000.serial");
 }
@@ -439,7 +439,7 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 	clk = clk_register_mux(NULL, "uart0_mclk", uart0_parents,
 			ARRAY_SIZE(uart0_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			PERIP_CLK_CFG, UART_CLK_SHIFT, UART_CLK_MASK, 0,
+			NULL, PERIP_CLK_CFG, UART_CLK_SHIFT, UART_CLK_MASK, 0,
 			&_lock);
 	clk_register_clkdev(clk, "uart0_mclk", NULL);
 
@@ -457,7 +457,7 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 	clk = clk_register_mux(NULL, "firda_mclk", firda_parents,
 			ARRAY_SIZE(firda_parents),
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
-			PERIP_CLK_CFG, FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0,
+			NULL, PERIP_CLK_CFG, FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0,
 			&_lock);
 	clk_register_clkdev(clk, "firda_mclk", NULL);
 
@@ -471,7 +471,7 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt0_clk", gpt0_parents,
 			ARRAY_SIZE(gpt0_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			PERIP_CLK_CFG, GPT0_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt0");
 
@@ -479,7 +479,7 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt1_mclk", gpt1_parents,
 			ARRAY_SIZE(gpt1_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			PERIP_CLK_CFG, GPT1_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt1_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk",
@@ -491,7 +491,7 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 			ARRAY_SIZE(gpt_rtbl), &_lock);
 	clk = clk_register_mux(NULL, "gpt2_mclk", gpt2_parents,
 			ARRAY_SIZE(gpt2_parents),
-			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT, NULL,
 			PERIP_CLK_CFG, GPT2_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gpt2_mclk", NULL);
 	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk",
@@ -514,7 +514,7 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 
 	clk = clk_register_mux(NULL, "gen2_3_par_clk", gen2_3_parents,
 			ARRAY_SIZE(gen2_3_parents), CLK_SET_RATE_NO_REPARENT,
-			CORE_CLK_CFG, GEN_SYNTH2_3_CLK_SHIFT,
+			NULL, CORE_CLK_CFG, GEN_SYNTH2_3_CLK_SHIFT,
 			GEN_SYNTH2_3_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "gen2_3_par_clk", NULL);
 
@@ -555,7 +555,7 @@ void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_
 	clk_register_clkdev(clk, "ahbmult2_clk", NULL);
 
 	clk = clk_register_mux(NULL, "ddr_clk", ddr_parents,
-			ARRAY_SIZE(ddr_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(ddr_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			PLL_CLK_CFG, MCTR_CLK_SHIFT, MCTR_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ddr_clk", NULL);
 
diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index 4f649c9..359823c 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -170,7 +170,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "uart_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), CLK_SET_RATE_NO_REPARENT,
-			PERIP_CLK_CFG, UART_CLK_SHIFT, UART_CLK_MASK, 0,
+			NULL, PERIP_CLK_CFG, UART_CLK_SHIFT, UART_CLK_MASK, 0,
 			&_lock);
 	clk_register_clkdev(clk, "uart_mclk", NULL);
 
@@ -190,7 +190,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "firda_mclk", firda_parents,
 			ARRAY_SIZE(firda_parents), CLK_SET_RATE_NO_REPARENT,
-			PERIP_CLK_CFG, FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0,
+			NULL, PERIP_CLK_CFG, FIRDA_CLK_SHIFT, FIRDA_CLK_MASK, 0,
 			&_lock);
 	clk_register_clkdev(clk, "firda_mclk", NULL);
 
@@ -206,7 +206,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "clcd_mclk", clcd_parents,
 			ARRAY_SIZE(clcd_parents), CLK_SET_RATE_NO_REPARENT,
-			PERIP_CLK_CFG, CLCD_CLK_SHIFT, CLCD_CLK_MASK, 0,
+			NULL, PERIP_CLK_CFG, CLCD_CLK_SHIFT, CLCD_CLK_MASK, 0,
 			&_lock);
 	clk_register_clkdev(clk, "clcd_mclk", NULL);
 
@@ -221,12 +221,14 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "gpt0_mclk", gpt0_1_parents,
 			ARRAY_SIZE(gpt0_1_parents), CLK_SET_RATE_NO_REPARENT,
-			PERIP_CLK_CFG, GPT0_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			NULL, PERIP_CLK_CFG, GPT0_CLK_SHIFT, GPT_CLK_MASK,
+			0, &_lock);
 	clk_register_clkdev(clk, NULL, "gpt0");
 
 	clk = clk_register_mux(NULL, "gpt1_mclk", gpt0_1_parents,
 			ARRAY_SIZE(gpt0_1_parents), CLK_SET_RATE_NO_REPARENT,
-			PERIP_CLK_CFG, GPT1_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			NULL, PERIP_CLK_CFG, GPT1_CLK_SHIFT, GPT_CLK_MASK,
+			0, &_lock);
 	clk_register_clkdev(clk, "gpt1_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "gpt1_clk", "gpt1_mclk", 0,
@@ -239,7 +241,8 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "gpt2_mclk", gpt2_parents,
 			ARRAY_SIZE(gpt2_parents), CLK_SET_RATE_NO_REPARENT,
-			PERIP_CLK_CFG, GPT2_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			NULL, PERIP_CLK_CFG, GPT2_CLK_SHIFT, GPT_CLK_MASK,
+			0, &_lock);
 	clk_register_clkdev(clk, "gpt2_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "gpt2_clk", "gpt2_mclk", 0,
@@ -252,7 +255,8 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_mux(NULL, "gpt3_mclk", gpt3_parents,
 			ARRAY_SIZE(gpt3_parents), CLK_SET_RATE_NO_REPARENT,
-			PERIP_CLK_CFG, GPT3_CLK_SHIFT, GPT_CLK_MASK, 0, &_lock);
+			NULL, PERIP_CLK_CFG, GPT3_CLK_SHIFT, GPT_CLK_MASK,
+			0, &_lock);
 	clk_register_clkdev(clk, "gpt3_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "gpt3_clk", "gpt3_mclk", 0,
@@ -280,7 +284,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	clk_register_clkdev(clk, "ahbmult2_clk", NULL);
 
 	clk = clk_register_mux(NULL, "ddr_clk", ddr_parents,
-			ARRAY_SIZE(ddr_parents), CLK_SET_RATE_NO_REPARENT,
+			ARRAY_SIZE(ddr_parents), CLK_SET_RATE_NO_REPARENT, NULL,
 			PLL_CLK_CFG, MCTR_CLK_SHIFT, MCTR_CLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, "ddr_clk", NULL);
 
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 34ee69f..6287de8 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -363,7 +363,7 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 		i++;
 
 	clk = clk_register_mux(NULL, clk_name, parents, i,
-			       CLK_SET_RATE_NO_REPARENT, reg,
+			       CLK_SET_RATE_NO_REPARENT, NULL, reg,
 			       data->shift, SUNXI_MUX_GATE_WIDTH,
 			       0, &clk_lock);
 
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index be40856..428e9ce 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1559,7 +1559,7 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 	/* audio0 */
 	clk = clk_register_mux(NULL, "audio0_mux", mux_audio_sync_clk,
 			       ARRAY_SIZE(mux_audio_sync_clk),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + AUDIO_SYNC_CLK_I2S0, 0, 3, 0,
 			       NULL);
 	clks[audio0_mux] = clk;
@@ -1572,7 +1572,7 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 	/* audio1 */
 	clk = clk_register_mux(NULL, "audio1_mux", mux_audio_sync_clk,
 			       ARRAY_SIZE(mux_audio_sync_clk),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + AUDIO_SYNC_CLK_I2S1, 0, 3, 0,
 			       NULL);
 	clks[audio1_mux] = clk;
@@ -1585,7 +1585,7 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 	/* audio2 */
 	clk = clk_register_mux(NULL, "audio2_mux", mux_audio_sync_clk,
 			       ARRAY_SIZE(mux_audio_sync_clk),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + AUDIO_SYNC_CLK_I2S2, 0, 3, 0,
 			       NULL);
 	clks[audio2_mux] = clk;
@@ -1598,7 +1598,7 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 	/* audio3 */
 	clk = clk_register_mux(NULL, "audio3_mux", mux_audio_sync_clk,
 			       ARRAY_SIZE(mux_audio_sync_clk),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + AUDIO_SYNC_CLK_I2S3, 0, 3, 0,
 			       NULL);
 	clks[audio3_mux] = clk;
@@ -1611,7 +1611,7 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 	/* audio4 */
 	clk = clk_register_mux(NULL, "audio4_mux", mux_audio_sync_clk,
 			       ARRAY_SIZE(mux_audio_sync_clk),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + AUDIO_SYNC_CLK_I2S4, 0, 3, 0,
 			       NULL);
 	clks[audio4_mux] = clk;
@@ -1624,7 +1624,7 @@ static void __init tegra114_audio_clk_init(void __iomem *clk_base)
 	/* spdif */
 	clk = clk_register_mux(NULL, "spdif_mux", mux_audio_sync_clk,
 			       ARRAY_SIZE(mux_audio_sync_clk),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + AUDIO_SYNC_CLK_SPDIF, 0, 3, 0,
 			       NULL);
 	clks[spdif_mux] = clk;
@@ -1720,7 +1720,7 @@ static void __init tegra114_pmc_clk_init(void __iomem *pmc_base)
 	/* clk_out_1 */
 	clk = clk_register_mux(NULL, "clk_out_1_mux", clk_out1_parents,
 			       ARRAY_SIZE(clk_out1_parents),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 6, 3, 0,
 			       &clk_out_lock);
 	clks[clk_out_1_mux] = clk;
@@ -1733,7 +1733,7 @@ static void __init tegra114_pmc_clk_init(void __iomem *pmc_base)
 	/* clk_out_2 */
 	clk = clk_register_mux(NULL, "clk_out_2_mux", clk_out2_parents,
 			       ARRAY_SIZE(clk_out2_parents),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 14, 3, 0,
 			       &clk_out_lock);
 	clks[clk_out_2_mux] = clk;
@@ -1746,7 +1746,7 @@ static void __init tegra114_pmc_clk_init(void __iomem *pmc_base)
 	/* clk_out_3 */
 	clk = clk_register_mux(NULL, "clk_out_3_mux", clk_out3_parents,
 			       ARRAY_SIZE(clk_out3_parents),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 22, 3, 0,
 			       &clk_out_lock);
 	clks[clk_out_3_mux] = clk;
@@ -2065,7 +2065,7 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base)
 	/* dsia */
 	clk = clk_register_mux(NULL, "dsia_mux", mux_plld_out0_plld2_out0,
 			       ARRAY_SIZE(mux_plld_out0_plld2_out0),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + PLLD_BASE, 25, 1, 0, &pll_d_lock);
 	clks[dsia_mux] = clk;
 	clk = tegra_clk_register_periph_gate("dsia", "dsia_mux", 0, clk_base,
@@ -2076,7 +2076,7 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base)
 	/* dsib */
 	clk = clk_register_mux(NULL, "dsib_mux", mux_plld_out0_plld2_out0,
 			       ARRAY_SIZE(mux_plld_out0_plld2_out0),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + PLLD2_BASE, 25, 1, 0, &pll_d2_lock);
 	clks[dsib_mux] = clk;
 	clk = tegra_clk_register_periph_gate("dsib", "dsib_mux", 0, clk_base,
@@ -2114,7 +2114,7 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base)
 	/* emc */
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + CLK_SOURCE_EMC,
 			       29, 3, 0, NULL);
 	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base,
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 056f649..026f83c 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -779,7 +779,7 @@ static void __init tegra20_audio_clk_init(void)
 	/* audio */
 	clk = clk_register_mux(NULL, "audio_mux", audio_parents,
 				ARRAY_SIZE(audio_parents),
-				CLK_SET_RATE_NO_REPARENT,
+				CLK_SET_RATE_NO_REPARENT, NULL,
 				clk_base + AUDIO_SYNC_CLK, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio", "audio_mux", 0,
 				clk_base + AUDIO_SYNC_CLK, 4,
@@ -943,7 +943,7 @@ static void __init tegra20_periph_clk_init(void)
 	/* emc */
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + CLK_SOURCE_EMC,
 			       30, 2, 0, NULL);
 	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base, 0,
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index dbe7c80..6c62c63 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1027,7 +1027,7 @@ static void __init tegra30_pll_init(void)
 	/* PLLE */
 	clk = clk_register_mux(NULL, "pll_e_mux", pll_e_parents,
 			       ARRAY_SIZE(pll_e_parents),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + PLLE_AUX, 2, 1, 0, NULL);
 	clk = tegra_clk_register_plle("pll_e", "pll_e_mux", clk_base, pmc_base,
 			     CLK_GET_RATE_NOCACHE, 100000000, &pll_e_params,
@@ -1088,7 +1088,7 @@ static void __init tegra30_audio_clk_init(void)
 	/* audio0 */
 	clk = clk_register_mux(NULL, "audio0_mux", mux_audio_sync_clk,
 				ARRAY_SIZE(mux_audio_sync_clk),
-				CLK_SET_RATE_NO_REPARENT,
+				CLK_SET_RATE_NO_REPARENT, NULL,
 				clk_base + AUDIO_SYNC_CLK_I2S0, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio0", "audio0_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S0, 4,
@@ -1099,7 +1099,7 @@ static void __init tegra30_audio_clk_init(void)
 	/* audio1 */
 	clk = clk_register_mux(NULL, "audio1_mux", mux_audio_sync_clk,
 				ARRAY_SIZE(mux_audio_sync_clk),
-				CLK_SET_RATE_NO_REPARENT,
+				CLK_SET_RATE_NO_REPARENT, NULL,
 				clk_base + AUDIO_SYNC_CLK_I2S1, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio1", "audio1_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S1, 4,
@@ -1110,7 +1110,7 @@ static void __init tegra30_audio_clk_init(void)
 	/* audio2 */
 	clk = clk_register_mux(NULL, "audio2_mux", mux_audio_sync_clk,
 				ARRAY_SIZE(mux_audio_sync_clk),
-				CLK_SET_RATE_NO_REPARENT,
+				CLK_SET_RATE_NO_REPARENT, NULL,
 				clk_base + AUDIO_SYNC_CLK_I2S2, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio2", "audio2_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S2, 4,
@@ -1121,7 +1121,7 @@ static void __init tegra30_audio_clk_init(void)
 	/* audio3 */
 	clk = clk_register_mux(NULL, "audio3_mux", mux_audio_sync_clk,
 				ARRAY_SIZE(mux_audio_sync_clk),
-				CLK_SET_RATE_NO_REPARENT,
+				CLK_SET_RATE_NO_REPARENT, NULL,
 				clk_base + AUDIO_SYNC_CLK_I2S3, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio3", "audio3_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S3, 4,
@@ -1132,7 +1132,7 @@ static void __init tegra30_audio_clk_init(void)
 	/* audio4 */
 	clk = clk_register_mux(NULL, "audio4_mux", mux_audio_sync_clk,
 				ARRAY_SIZE(mux_audio_sync_clk),
-				CLK_SET_RATE_NO_REPARENT,
+				CLK_SET_RATE_NO_REPARENT, NULL,
 				clk_base + AUDIO_SYNC_CLK_I2S4, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "audio4", "audio4_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_I2S4, 4,
@@ -1143,7 +1143,7 @@ static void __init tegra30_audio_clk_init(void)
 	/* spdif */
 	clk = clk_register_mux(NULL, "spdif_mux", mux_audio_sync_clk,
 				ARRAY_SIZE(mux_audio_sync_clk),
-				CLK_SET_RATE_NO_REPARENT,
+				CLK_SET_RATE_NO_REPARENT, NULL,
 				clk_base + AUDIO_SYNC_CLK_SPDIF, 0, 3, 0, NULL);
 	clk = clk_register_gate(NULL, "spdif", "spdif_mux", 0,
 				clk_base + AUDIO_SYNC_CLK_SPDIF, 4,
@@ -1237,7 +1237,7 @@ static void __init tegra30_pmc_clk_init(void)
 	/* clk_out_1 */
 	clk = clk_register_mux(NULL, "clk_out_1_mux", clk_out1_parents,
 			       ARRAY_SIZE(clk_out1_parents),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 6, 3, 0,
 			       &clk_out_lock);
 	clks[clk_out_1_mux] = clk;
@@ -1250,7 +1250,7 @@ static void __init tegra30_pmc_clk_init(void)
 	/* clk_out_2 */
 	clk = clk_register_mux(NULL, "clk_out_2_mux", clk_out2_parents,
 			       ARRAY_SIZE(clk_out2_parents),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 14, 3, 0,
 			       &clk_out_lock);
 	clk = clk_register_gate(NULL, "clk_out_2", "clk_out_2_mux", 0,
@@ -1262,7 +1262,7 @@ static void __init tegra30_pmc_clk_init(void)
 	/* clk_out_3 */
 	clk = clk_register_mux(NULL, "clk_out_3_mux", clk_out3_parents,
 			       ARRAY_SIZE(clk_out3_parents),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       pmc_base + PMC_CLK_OUT_CNTRL, 22, 3, 0,
 			       &clk_out_lock);
 	clk = clk_register_gate(NULL, "clk_out_3", "clk_out_3_mux", 0,
@@ -1690,7 +1690,7 @@ static void __init tegra30_periph_clk_init(void)
 	/* emc */
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
-			       CLK_SET_RATE_NO_REPARENT,
+			       CLK_SET_RATE_NO_REPARENT, NULL,
 			       clk_base + CLK_SOURCE_EMC,
 			       30, 2, 0, NULL);
 	clk = tegra_clk_register_periph_gate("emc", "emc_mux", 0, clk_base, 0,
diff --git a/drivers/clk/versatile/clk-vexpress.c b/drivers/clk/versatile/clk-vexpress.c
index 2d5e1b4..e3bbc3e 100644
--- a/drivers/clk/versatile/clk-vexpress.c
+++ b/drivers/clk/versatile/clk-vexpress.c
@@ -37,7 +37,7 @@ static void __init vexpress_sp810_init(void __iomem *base)
 		snprintf(name, ARRAY_SIZE(name), "timerclken%d", i);
 
 		vexpress_sp810_timerclken[i] = clk_register_mux(NULL, name,
-				parents, 2, CLK_SET_RATE_NO_REPARENT,
+				parents, 2, CLK_SET_RATE_NO_REPARENT, NULL,
 				base + SCCTRL, SCCTRL_TIMERENnSEL_SHIFT(i), 1,
 				0, &vexpress_sp810_lock);
 
diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index e05c9e3..f8714ad 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -125,8 +125,8 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
 	div1_name = kasprintf(GFP_KERNEL, "%s_div1", clk_name);
 
 	clk = clk_register_mux(NULL, mux_name, parents, 4,
-			CLK_SET_RATE_NO_REPARENT, fclk_ctrl_reg, 4, 2, 0,
-			fclk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, fclk_ctrl_reg,
+			4, 2, 0, fclk_lock);
 
 	clk = clk_register_divider(NULL, div0_name, mux_name,
 			0, fclk_ctrl_reg, 8, 6, CLK_DIVIDER_ONE_BASED |
@@ -169,7 +169,8 @@ static void __init zynq_clk_register_periph_clk(enum zynq_clk clk0,
 	div_name = kasprintf(GFP_KERNEL, "%s_div", clk_name0);
 
 	clk = clk_register_mux(NULL, mux_name, parents, 4,
-			CLK_SET_RATE_NO_REPARENT, clk_ctrl, 4, 2, 0, lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, clk_ctrl,
+			4, 2, 0, lock);
 
 	clk = clk_register_divider(NULL, div_name, mux_name, 0, clk_ctrl, 8, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO, lock);
@@ -236,26 +237,26 @@ static void __init zynq_clk_setup(struct device_node *np)
 	clk = clk_register_zynq_pll("armpll_int", "ps_clk", SLCR_ARMPLL_CTRL,
 			SLCR_PLL_STATUS, 0, &armpll_lock);
 	clks[armpll] = clk_register_mux(NULL, clk_output_name[armpll],
-			armpll_parents, 2, CLK_SET_RATE_NO_REPARENT,
+			armpll_parents, 2, CLK_SET_RATE_NO_REPARENT, NULL,
 			SLCR_ARMPLL_CTRL, 4, 1, 0, &armpll_lock);
 
 	clk = clk_register_zynq_pll("ddrpll_int", "ps_clk", SLCR_DDRPLL_CTRL,
 			SLCR_PLL_STATUS, 1, &ddrpll_lock);
 	clks[ddrpll] = clk_register_mux(NULL, clk_output_name[ddrpll],
-			ddrpll_parents, 2, CLK_SET_RATE_NO_REPARENT,
+			ddrpll_parents, 2, CLK_SET_RATE_NO_REPARENT, NULL,
 			SLCR_DDRPLL_CTRL, 4, 1, 0, &ddrpll_lock);
 
 	clk = clk_register_zynq_pll("iopll_int", "ps_clk", SLCR_IOPLL_CTRL,
 			SLCR_PLL_STATUS, 2, &iopll_lock);
 	clks[iopll] = clk_register_mux(NULL, clk_output_name[iopll],
-			iopll_parents, 2, CLK_SET_RATE_NO_REPARENT,
+			iopll_parents, 2, CLK_SET_RATE_NO_REPARENT, NULL,
 			SLCR_IOPLL_CTRL, 4, 1, 0, &iopll_lock);
 
 	/* CPU clocks */
 	tmp = readl(SLCR_621_TRUE) & 1;
 	clk = clk_register_mux(NULL, "cpu_mux", cpu_parents, 4,
-			CLK_SET_RATE_NO_REPARENT, SLCR_ARM_CLK_CTRL, 4, 2, 0,
-			&armclk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_ARM_CLK_CTRL,
+			4, 2, 0, &armclk_lock);
 	clk = clk_register_divider(NULL, "cpu_div", "cpu_mux", 0,
 			SLCR_ARM_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &armclk_lock);
@@ -295,8 +296,8 @@ static void __init zynq_clk_setup(struct device_node *np)
 	}
 	clks[swdt] = clk_register_mux(NULL, clk_output_name[swdt],
 			swdt_ext_clk_mux_parents, 2, CLK_SET_RATE_PARENT |
-			CLK_SET_RATE_NO_REPARENT, SLCR_SWDT_CLK_SEL, 0, 1, 0,
-			&gem0clk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_SWDT_CLK_SEL,
+			0, 1, 0, &gem0clk_lock);
 
 	/* DDR clocks */
 	clk = clk_register_divider(NULL, "ddr2x_div", "ddrpll", 0,
@@ -359,8 +360,8 @@ static void __init zynq_clk_setup(struct device_node *np)
 					idx);
 	}
 	clk = clk_register_mux(NULL, "gem0_mux", periph_parents, 4,
-			CLK_SET_RATE_NO_REPARENT, SLCR_GEM0_CLK_CTRL, 4, 2, 0,
-			&gem0clk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_GEM0_CLK_CTRL,
+			4, 2, 0, &gem0clk_lock);
 	clk = clk_register_divider(NULL, "gem0_div0", "gem0_mux", 0,
 			SLCR_GEM0_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &gem0clk_lock);
@@ -369,8 +370,8 @@ static void __init zynq_clk_setup(struct device_node *np)
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			&gem0clk_lock);
 	clk = clk_register_mux(NULL, "gem0_emio_mux", gem0_mux_parents, 2,
-			CLK_SET_RATE_NO_REPARENT, SLCR_GEM0_CLK_CTRL, 6, 1, 0,
-			&gem0clk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_GEM0_CLK_CTRL,
+			6, 1, 0, &gem0clk_lock);
 	clks[gem0] = clk_register_gate(NULL, clk_output_name[gem0],
 			"gem0_emio_mux", CLK_SET_RATE_PARENT,
 			SLCR_GEM0_CLK_CTRL, 0, 0, &gem0clk_lock);
@@ -383,8 +384,8 @@ static void __init zynq_clk_setup(struct device_node *np)
 					idx);
 	}
 	clk = clk_register_mux(NULL, "gem1_mux", periph_parents, 4,
-			CLK_SET_RATE_NO_REPARENT, SLCR_GEM1_CLK_CTRL, 4, 2, 0,
-			&gem1clk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_GEM1_CLK_CTRL,
+			4, 2, 0, &gem1clk_lock);
 	clk = clk_register_divider(NULL, "gem1_div0", "gem1_mux", 0,
 			SLCR_GEM1_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &gem1clk_lock);
@@ -393,8 +394,8 @@ static void __init zynq_clk_setup(struct device_node *np)
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			&gem1clk_lock);
 	clk = clk_register_mux(NULL, "gem1_emio_mux", gem1_mux_parents, 2,
-			CLK_SET_RATE_NO_REPARENT, SLCR_GEM1_CLK_CTRL, 6, 1, 0,
-			&gem1clk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_GEM1_CLK_CTRL,
+			6, 1, 0, &gem1clk_lock);
 	clks[gem1] = clk_register_gate(NULL, clk_output_name[gem1],
 			"gem1_emio_mux", CLK_SET_RATE_PARENT,
 			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
@@ -414,8 +415,8 @@ static void __init zynq_clk_setup(struct device_node *np)
 	}
 	kfree(clk_name);
 	clk = clk_register_mux(NULL, "can_mux", periph_parents, 4,
-			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2, 0,
-			&canclk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_CAN_CLK_CTRL,
+			4, 2, 0, &canclk_lock);
 	clk = clk_register_divider(NULL, "can_div0", "can_mux", 0,
 			SLCR_CAN_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &canclk_lock);
@@ -431,20 +432,20 @@ static void __init zynq_clk_setup(struct device_node *np)
 			&canclk_lock);
 	clk = clk_register_mux(NULL, "can0_mio_mux",
 			can_mio_mux_parents, 54, CLK_SET_RATE_PARENT |
-			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 0, 6, 0,
-			&canmioclk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_CAN_MIOCLK_CTRL,
+			0, 6, 0, &canmioclk_lock);
 	clk = clk_register_mux(NULL, "can1_mio_mux",
 			can_mio_mux_parents, 54, CLK_SET_RATE_PARENT |
-			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 16, 6,
-			0, &canmioclk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_CAN_MIOCLK_CTRL,
+			16, 6, 0, &canmioclk_lock);
 	clks[can0] = clk_register_mux(NULL, clk_output_name[can0],
 			can0_mio_mux2_parents, 2, CLK_SET_RATE_PARENT |
-			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 6, 1, 0,
-			&canmioclk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_CAN_MIOCLK_CTRL,
+			6, 1, 0, &canmioclk_lock);
 	clks[can1] = clk_register_mux(NULL, clk_output_name[can1],
 			can1_mio_mux2_parents, 2, CLK_SET_RATE_PARENT |
-			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 22, 1,
-			0, &canmioclk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_CAN_MIOCLK_CTRL,
+			22, 1, 0, &canmioclk_lock);
 
 	for (i = 0; i < ARRAY_SIZE(dbgtrc_emio_input_names); i++) {
 		int idx = of_property_match_string(np, "clock-names",
@@ -454,14 +455,14 @@ static void __init zynq_clk_setup(struct device_node *np)
 					idx);
 	}
 	clk = clk_register_mux(NULL, "dbg_mux", periph_parents, 4,
-			CLK_SET_RATE_NO_REPARENT, SLCR_DBG_CLK_CTRL, 4, 2, 0,
-			&dbgclk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_DBG_CLK_CTRL,
+			4, 2, 0, &dbgclk_lock);
 	clk = clk_register_divider(NULL, "dbg_div", "dbg_mux", 0,
 			SLCR_DBG_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &dbgclk_lock);
 	clk = clk_register_mux(NULL, "dbg_emio_mux", dbg_emio_mux_parents, 2,
-			CLK_SET_RATE_NO_REPARENT, SLCR_DBG_CLK_CTRL, 6, 1, 0,
-			&dbgclk_lock);
+			CLK_SET_RATE_NO_REPARENT, NULL, SLCR_DBG_CLK_CTRL,
+			6, 1, 0, &dbgclk_lock);
 	clks[dbg_trc] = clk_register_gate(NULL, clk_output_name[dbg_trc],
 			"dbg_emio_mux", CLK_SET_RATE_PARENT, SLCR_DBG_CLK_CTRL,
 			0, 0, &dbgclk_lock);
-- 
1.7.9.5
