From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 8 Aug 2018 09:00:42 +0000
Subject: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
In-Reply-To: <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <1533703167-26583-2-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
Message-ID: <DB3PR0402MB3916F8BC381BBA01DB21D1C0F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Peng Fan
> Sent: Wednesday, August 8, 2018 4:49 PM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo at kernel.org;
> s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; mturquette at baylibre.com; sboyd at kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-clk at vger.kernel.org;
> linux-kernel at vger.kernel.org; Rob Herring <robh@kernel.org>
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: RE: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
> 
> 
> 
> > -----Original Message-----
> > From: Anson Huang
> > Sent: 2018?8?8? 12:39
> > To: shawnguo at kernel.org; s.hauer at pengutronix.de;
> > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > mturquette at baylibre.com; sboyd at kernel.org;
> > linux-arm-kernel at lists.infradead.org;
> > linux-clk at vger.kernel.org; linux-kernel at vger.kernel.org
> > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
> >
> > Clock framework will enable those clocks registered with
> > CLK_IS_CRITICAL flag, so no need to have clks_init_on array during clock
> initialization now.
> 
> Will it be more flexible to parse dts saying "critical-clocks = <xxx>" or
> "init-on-arrary=<xxx>"
> and enable those clocks?
 
Parsing the clocks arrays from dtb is another way of enabling critical clocks, but
for current i.MX6/7 platforms, we implement it in same way as most of other SoCs,
currently I did NOT see any necessity of putting them in dtb,
just adding flag during clock registering is more simple, if there is any special requirement
for different clocks set to be enabled, then we can add support to enable the method of
parsing critical-clocks from dtb. Just my two cents.

Anson.

> 
> Regards,
> Peng.
> 
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx7d.c | 27 ++++++++-------------------
> >  drivers/clk/imx/clk.h       |  7 +++++++
> >  2 files changed, 15 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> > index c4518d7..076460b 100644
> > --- a/drivers/clk/imx/clk-imx7d.c
> > +++ b/drivers/clk/imx/clk-imx7d.c
> > @@ -379,13 +379,6 @@ static const char *pll_enet_bypass_sel[] = {
> > "pll_enet_main", "pll_enet_main_src  static const char
> > *pll_audio_bypass_sel[] = { "pll_audio_main", "pll_audio_main_src", };
> > static const char *pll_video_bypass_sel[] = { "pll_video_main",
> > "pll_video_main_src", };
> >
> > -static int const clks_init_on[] __initconst = {
> > -	IMX7D_ARM_A7_ROOT_CLK, IMX7D_MAIN_AXI_ROOT_CLK,
> > -	IMX7D_PLL_SYS_MAIN_480M_CLK, IMX7D_IPG_ROOT_CLK,
> > -	IMX7D_DRAM_PHYM_ROOT_CLK, IMX7D_DRAM_ROOT_CLK,
> > -	IMX7D_DRAM_PHYM_ALT_ROOT_CLK, IMX7D_DRAM_ALT_ROOT_CLK,
> > -};
> > -
> >  static struct clk_onecell_data clk_data;
> >
> >  static struct clk ** const uart_clks[] __initconst = { @@ -403,7
> > +396,6 @@ static void __init imx7d_clocks_init(struct device_node
> *ccm_node)  {
> >  	struct device_node *np;
> >  	void __iomem *base;
> > -	int i;
> >
> >  	clks[IMX7D_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
> >  	clks[IMX7D_OSC_24M_CLK] = of_clk_get_by_name(ccm_node, "osc");
> @@
> > -466,7 +458,7 @@ static void __init imx7d_clocks_init(struct
> > device_node
> > *ccm_node)
> >  	clks[IMX7D_PLL_SYS_MAIN_120M] =
> > imx_clk_fixed_factor("pll_sys_main_120m", "pll_sys_main_clk", 1, 4);
> >  	clks[IMX7D_PLL_DRAM_MAIN_533M] =
> > imx_clk_fixed_factor("pll_dram_533m", "pll_dram_main_clk", 1, 2);
> >
> > -	clks[IMX7D_PLL_SYS_MAIN_480M_CLK] =
> > imx_clk_gate_dis("pll_sys_main_480m_clk", "pll_sys_main_480m", base +
> > 0xb0, 4);
> > +	clks[IMX7D_PLL_SYS_MAIN_480M_CLK] =
> > +imx_clk_gate_dis_flags("pll_sys_main_480m_clk", "pll_sys_main_480m",
> > +base + 0xb0, 4, CLK_IS_CRITICAL);
> >  	clks[IMX7D_PLL_SYS_MAIN_240M_CLK] =
> > imx_clk_gate_dis("pll_sys_main_240m_clk", "pll_sys_main_240m", base +
> > 0xb0, 5);
> >  	clks[IMX7D_PLL_SYS_MAIN_120M_CLK] =
> > imx_clk_gate_dis("pll_sys_main_120m_clk", "pll_sys_main_120m", base +
> > 0xb0, 6);
> >  	clks[IMX7D_PLL_DRAM_MAIN_533M_CLK] =
> > imx_clk_gate("pll_dram_533m_clk", "pll_dram_533m", base + 0x70, 12);
> > @@
> > -719,7 +711,7 @@ static void __init imx7d_clocks_init(struct
> > device_node
> > *ccm_node)
> >  	clks[IMX7D_ENET_AXI_ROOT_DIV] =
> > imx_clk_divider2("enet_axi_post_div", "enet_axi_pre_div", base + 0x8900, 0,
> 6);
> >  	clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] =
> > imx_clk_divider2("nand_usdhc_root_clk", "nand_usdhc_pre_div", base +
> > 0x8980, 0, 6);
> >  	clks[IMX7D_AHB_CHANNEL_ROOT_DIV] =
> > imx_clk_divider2("ahb_root_clk", "ahb_pre_div", base + 0x9000, 0, 6);
> > -	clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider2("ipg_root_clk",
> > "ahb_root_clk", base + 0x9080, 0, 2);
> > +	clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider_flags("ipg_root_clk",
> > +"ahb_root_clk", base + 0x9080, 0, 2, CLK_IS_CRITICAL |
> > +CLK_OPS_PARENT_ENABLE | CLK_SET_RATE_PARENT);
> >  	clks[IMX7D_DRAM_ROOT_DIV] = imx_clk_divider2("dram_post_div",
> > "dram_cg", base + 0x9880, 0, 3);
> >  	clks[IMX7D_DRAM_PHYM_ALT_ROOT_DIV] =
> > imx_clk_divider2("dram_phym_alt_post_div", "dram_phym_alt_pre_div",
> > base
> > + 0xa000, 0, 3);
> >  	clks[IMX7D_DRAM_ALT_ROOT_DIV] =
> > imx_clk_divider2("dram_alt_post_div", "dram_alt_pre_div", base +
> > 0xa080, 0, 3); @@ -783,17 +775,17 @@ static void __init
> > imx7d_clocks_init(struct device_node *ccm_node)
> >  	clks[IMX7D_CLKO1_ROOT_DIV] = imx_clk_divider2("clko1_post_div",
> > "clko1_pre_div", base + 0xbd80, 0, 6);
> >  	clks[IMX7D_CLKO2_ROOT_DIV] = imx_clk_divider2("clko2_post_div",
> > "clko2_pre_div", base + 0xbe00, 0, 6);
> >
> > -	clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk",
> > "arm_a7_div", base + 0x4000, 0);
> > +	clks[IMX7D_ARM_A7_ROOT_CLK] =
> > imx_clk_gate2_flags("arm_a7_root_clk",
> > +"arm_a7_div", base + 0x4000, 0, CLK_IS_CRITICAL |
> > +CLK_OPS_PARENT_ENABLE);
> >  	clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk",
> > "arm_m4_div", base + 0x4010, 0);
> > -	clks[IMX7D_MAIN_AXI_ROOT_CLK] = imx_clk_gate4("main_axi_root_clk",
> > "axi_post_div", base + 0x4040, 0);
> > +	clks[IMX7D_MAIN_AXI_ROOT_CLK] =
> > +imx_clk_gate2_flags("main_axi_root_clk", "axi_post_div", base +
> > +0x4040, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
> >  	clks[IMX7D_DISP_AXI_ROOT_CLK] = imx_clk_gate4("disp_axi_root_clk",
> > "disp_axi_post_div", base + 0x4050, 0);
> >  	clks[IMX7D_ENET_AXI_ROOT_CLK] = imx_clk_gate4("enet_axi_root_clk",
> > "enet_axi_post_div", base + 0x4060, 0);
> >  	clks[IMX7D_OCRAM_CLK] = imx_clk_gate4("ocram_clk",
> > "main_axi_root_clk", base + 0x4110, 0);
> >  	clks[IMX7D_OCRAM_S_CLK] = imx_clk_gate4("ocram_s_clk",
> > "ahb_root_clk", base + 0x4120, 0);
> > -	clks[IMX7D_DRAM_ROOT_CLK] = imx_clk_gate4("dram_root_clk",
> > "dram_post_div", base + 0x4130, 0);
> > -	clks[IMX7D_DRAM_PHYM_ROOT_CLK] =
> > imx_clk_gate4("dram_phym_root_clk", "dram_phym_cg", base + 0x4130, 0);
> > -	clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] =
> > imx_clk_gate4("dram_phym_alt_root_clk", "dram_phym_alt_post_div", base
> > + 0x4130, 0);
> > -	clks[IMX7D_DRAM_ALT_ROOT_CLK] =
> imx_clk_gate4("dram_alt_root_clk",
> > "dram_alt_post_div", base + 0x4130, 0);
> > +	clks[IMX7D_DRAM_ROOT_CLK] = imx_clk_gate2_flags("dram_root_clk",
> > "dram_post_div", base + 0x4130, 0, CLK_IS_CRITICAL |
> > CLK_OPS_PARENT_ENABLE);
> > +	clks[IMX7D_DRAM_PHYM_ROOT_CLK] =
> > imx_clk_gate2_flags("dram_phym_root_clk", "dram_phym_cg", base +
> > 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
> > +	clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] =
> > imx_clk_gate2_flags("dram_phym_alt_root_clk",
> > "dram_phym_alt_post_div", base + 0x4130, 0, CLK_IS_CRITICAL |
> > CLK_OPS_PARENT_ENABLE);
> > +	clks[IMX7D_DRAM_ALT_ROOT_CLK] =
> > +imx_clk_gate2_flags("dram_alt_root_clk", "dram_alt_post_div", base +
> > +0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
> >  	clks[IMX7D_OCOTP_CLK] = imx_clk_gate4("ocotp_clk", "ipg_root_clk",
> > base + 0x4230, 0);
> >  	clks[IMX7D_SNVS_CLK] = imx_clk_gate4("snvs_clk", "ipg_root_clk",
> > base + 0x4250, 0);
> >  	clks[IMX7D_MU_ROOT_CLK] = imx_clk_gate4("mu_root_clk",
> > "ipg_root_clk", base + 0x4270, 0); @@ -882,9 +874,6 @@ static void
> > __init imx7d_clocks_init(struct device_node *ccm_node)
> >  	clk_data.clk_num = ARRAY_SIZE(clks);
> >  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> >
> > -	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
> > -		clk_prepare_enable(clks[clks_init_on[i]]);
> > -
> >  	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS],
> > clks[IMX7D_PLL_ARM_MAIN]);
> >  	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS],
> > clks[IMX7D_PLL_DRAM_MAIN]);
> >  	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS],
> > clks[IMX7D_PLL_SYS_MAIN]); diff --git a/drivers/clk/imx/clk.h
> > b/drivers/clk/imx/clk.h index 8076ec0..5895e223 100644
> > --- a/drivers/clk/imx/clk.h
> > +++ b/drivers/clk/imx/clk.h
> > @@ -137,6 +137,13 @@ static inline struct clk *imx_clk_gate_dis(const
> > char *name, const char *parent,
> >  			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);  }
> >
> > +static inline struct clk *imx_clk_gate_dis_flags(const char *name,
> > +const char
> > *parent,
> > +		void __iomem *reg, u8 shift, unsigned long flags) {
> > +	return clk_register_gate(NULL, name, parent, flags |
> > CLK_SET_RATE_PARENT, reg,
> > +			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock); }
> > +
> >  static inline struct clk *imx_clk_gate2(const char *name, const char
> *parent,
> >  		void __iomem *reg, u8 shift)
> >  {
> > --
> > 2.7.4
