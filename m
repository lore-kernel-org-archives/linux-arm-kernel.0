From: ping.bai@nxp.com (Jacky Bai)
Date: Mon, 12 Dec 2016 02:58:01 +0000
Subject: [PATCH 03/11] driver: clk: imx: Add clock driver for imx6sll
In-Reply-To: <20161208225257.GP5423@codeaurora.org>
References: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
 <1480660774-25055-4-git-send-email-ping.bai@nxp.com>
 <20161208225257.GP5423@codeaurora.org>
Message-ID: <AM3PR04MB5302BE33BE1F2C9913FF61587980@AM3PR04MB530.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH 03/11] driver: clk: imx: Add clock driver for imx6sll
> 
> On 12/02, Bai Ping wrote:
> > diff --git a/drivers/clk/imx/clk-imx6sll.c
> > b/drivers/clk/imx/clk-imx6sll.c new file mode 100644 index
> > 0000000..c5219e1
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-imx6sll.c
> > @@ -0,0 +1,366 @@
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <dt-bindings/clock/imx6sll-clock.h>
> > +#include <linux/clk.h>
> > +#include <linux/clkdev.h>
> 
> Is this include used?
> 

It seems no use, I will remove it in V2.

> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/types.h>
> 
> Is there an include of clk_provider.h missing?
> 

clk_provider.h is included in below "clk.h".

> > +
> > +#include "clk.h"
> > +
> > +#define BM_CCM_CCDR_MMDC_CH0_MASK	(0x2 << 16)
> > +#define CCDR	0x4
> > +
> > +static const char *pll_bypass_src_sels[] = { "osc", "dummy", };
> 
> const char * const? For all of these names.
> 

ok, I will fix in V2.

> > +static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src",
> > +}; static const char *pll2_bypass_sels[] = { "pll2",
> > +"pll2_bypass_src", }; static const char *pll3_bypass_sels[] = {
> > +"pll3", "pll3_bypass_src", }; static const char *pll4_bypass_sels[] =
> > +{ "pll4", "pll4_bypass_src", }; static const char *pll5_bypass_sels[]
> > += { "pll5", "pll5_bypass_src", }; static const char
> > +*pll6_bypass_sels[] = { "pll6", "pll6_bypass_src", }; static const
> > +char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", }; static
> > +const char *step_sels[] = { "osc", "pll2_pfd2_396m", }; static const
> > +char *pll1_sw_sels[] = { "pll1_sys", "step", }; static const char
> > +*axi_alt_sels[] = { "pll2_pfd2_396m", "pll3_pfd1_540m", }; static
> > +const char *axi_sels[] = {"periph", "axi_alt_sel", }; static const
> > +char *periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m",
> > +"pll2_pfd0_352m", "pll2_198m", }; static const char
> > +*periph2_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m",
> > +"pll2_pfd0_352m", "pll4_audio_div", }; static const char
> > +*periph_clk2_sels[] = { "pll3_usb_otg", "osc", "osc", }; static const
> > +char *periph2_clk2_sels[] = { "pll3_usb_otg", "osc", }; static const
> > +char *periph_sels[] = { "periph_pre", "periph_clk2", }; static const
> > +char *periph2_sels[] = { "periph2_pre", "periph2_clk2", }; static
> > +const char *usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
> > +static const char *ssi_sels[] = {"pll3_pfd2_508m", "pll3_pfd3_454m",
> > +"pll4_audio_div", "dummy",}; static const char *spdif_sels[] = {
> > +"pll4_audio_div", "pll3_pfd2_508m", "pll5_video_div", "pll3_usb_otg",
> > +}; static const char *ldb_di0_div_sels[] = { "ldb_di0_div_3_5",
> > +"ldb_di0_div_7", }; static const char *ldb_di1_div_sels[] = {
> > +"ldb_di1_div_3_5", "ldb_di1_div_7", }; static const char
> > +*ldb_di0_sels[] = { "pll5_video_div", "pll2_pfd0_352m",
> > +"pll2_pfd2_396m", "pll2_pfd3_594m", "pll2_pfd1_594m",
> > +"pll3_pfd3_454m", }; static const char *ldb_di1_sels[] = {
> > +"pll3_usb_otg", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll2_bus",
> > +"pll3_pfd3_454m", "pll3_pfd2_508m", }; static const char
> > +*lcdif_pre_sels[] = { "pll2_bus", "pll3_pfd3_454m", "pll5_video_div",
> > +"pll2_pfd0_352m", "pll2_pfd1_594m", "pll3_pfd1_540m", }; static const
> > +char *ecspi_sels[] = { "pll3_60m", "osc", }; static const char
> > +*uart_sels[] = { "pll3_80m", "osc", }; static const char
> > +*perclk_sels[] = { "ipg", "osc", }; static const char *lcdif_sels[] =
> > +{ "lcdif_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
> > +
> > +static const char *epdc_pre_sels[] = { "pll2_bus", "pll3_usb_otg",
> > +"pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m",
> > +"pll3_pfd2_508m", }; static const char *epdc_sels[] = { "epdc_podf",
> > +"ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
> > +
> > +static struct clk *clks[IMX6SLL_CLK_END]; static struct
> > +clk_onecell_data clk_data;
> > +
> > +static int const clks_init_on[] __initconst = {
> 
> static const int is more preferred style.
> 

ok, will fix in V2.

> > +	IMX6SLL_CLK_AIPSTZ1, IMX6SLL_CLK_AIPSTZ2,
> > +	IMX6SLL_CLK_OCRAM, IMX6SLL_CLK_ARM, IMX6SLL_CLK_ROM,
> > +	IMX6SLL_CLK_MMDC_P0_FAST, IMX6SLL_CLK_MMDC_P0_IPG, };
> > +
> > +static struct clk_div_table post_div_table[] = {
> 
> const?
> 

ok, will fix in V2.

> > +	{ .val = 2, .div = 1, },
> > +	{ .val = 1, .div = 2, },
> > +	{ .val = 0, .div = 4, },
> > +	{ }
> > +};
> > +
> > +static struct clk_div_table video_div_table[] = {
> 
> const?
> 

ok. will fix in V2.

> > +	{ .val = 0, .div = 1, },
> > +	{ .val = 1, .div = 2, },
> > +	{ .val = 2, .div = 1, },
> > +	{ .val = 3, .div = 4, },
> > +	{ }
> > +};
> > +
> > +static u32 share_count_audio;
> > +static u32 share_count_ssi1;
> > +static u32 share_count_ssi2;
> > +static u32 share_count_ssi3;
> > +
> > +static void __init imx6sll_clocks_init(struct device_node *ccm_node)
> > +{
> > +	struct device_node *np;
> > +	void __iomem *base;
> > +	int i;
> > +
> > +	clks[IMX6SLL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
> > +
> > +	clks[IMX6SLL_CLK_CKIL] = of_clk_get_by_name(ccm_node, "ckil");
> > +	clks[IMX6SLL_CLK_OSC] = of_clk_get_by_name(ccm_node, "osc");
> > +
> > +	/* ipp_di clock is external input */
> > +	clks[IMX6SLL_CLK_IPP_DI0] = of_clk_get_by_name(ccm_node,
> "ipp_di0");
> > +	clks[IMX6SLL_CLK_IPP_DI1] = of_clk_get_by_name(ccm_node,
> "ipp_di1");
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sll-anatop");
> > +	base = of_iomap(np, 0);
> > +	WARN_ON(!base);
> > +
> > +	clks[IMX6SLL_PLL1_BYPASS_SRC] = imx_clk_mux("pll1_bypass_src",
> base + 0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> > +	clks[IMX6SLL_PLL2_BYPASS_SRC] = imx_clk_mux("pll2_bypass_src",
> base + 0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> > +	clks[IMX6SLL_PLL3_BYPASS_SRC] = imx_clk_mux("pll3_bypass_src",
> base + 0x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> > +	clks[IMX6SLL_PLL4_BYPASS_SRC] = imx_clk_mux("pll4_bypass_src",
> base + 0x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> > +	clks[IMX6SLL_PLL5_BYPASS_SRC] = imx_clk_mux("pll5_bypass_src",
> base + 0xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> > +	clks[IMX6SLL_PLL6_BYPASS_SRC] = imx_clk_mux("pll6_bypass_src",
> base + 0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> > +	clks[IMX6SLL_PLL7_BYPASS_SRC] = imx_clk_mux("pll7_bypass_src",
> base
> > ++ 0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> > +
> > +	clks[IMX6SLL_CLK_PLL1] = imx_clk_pllv3(IMX_PLLV3_SYS,	 "pll1",
> "pll1_bypass_src", base + 0x00, 0x7f);
> > +	clks[IMX6SLL_CLK_PLL2] = imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2",
> "pll2_bypass_src", base + 0x30, 0x1);
> > +	clks[IMX6SLL_CLK_PLL3] = imx_clk_pllv3(IMX_PLLV3_USB,	 "pll3",
> "pll3_bypass_src", base + 0x10, 0x3);
> > +	clks[IMX6SLL_CLK_PLL4] = imx_clk_pllv3(IMX_PLLV3_AV,	 "pll4",
> "pll4_bypass_src", base + 0x70, 0x7f);
> > +	clks[IMX6SLL_CLK_PLL5] = imx_clk_pllv3(IMX_PLLV3_AV,	 "pll5",
> "pll5_bypass_src", base + 0xa0, 0x7f);
> > +	clks[IMX6SLL_CLK_PLL6] = imx_clk_pllv3(IMX_PLLV3_ENET,	 "pll6",
> "pll6_bypass_src", base + 0xe0, 0x3);
> > +	clks[IMX6SLL_CLK_PLL7] = imx_clk_pllv3(IMX_PLLV3_USB,	 "pll7",
> "pll7_bypass_src", base + 0x20, 0x3);
> > +
> > +	clks[IMX6SLL_PLL1_BYPASS] = imx_clk_mux_flags("pll1_bypass", base
> + 0x00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels),
> CLK_SET_RATE_PARENT);
> > +	clks[IMX6SLL_PLL2_BYPASS] = imx_clk_mux_flags("pll2_bypass", base
> + 0x30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels),
> CLK_SET_RATE_PARENT);
> > +	clks[IMX6SLL_PLL3_BYPASS] = imx_clk_mux_flags("pll3_bypass", base
> + 0x10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels),
> CLK_SET_RATE_PARENT);
> > +	clks[IMX6SLL_PLL4_BYPASS] = imx_clk_mux_flags("pll4_bypass", base
> + 0x70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels),
> CLK_SET_RATE_PARENT);
> > +	clks[IMX6SLL_PLL5_BYPASS] = imx_clk_mux_flags("pll5_bypass", base
> + 0xa0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels),
> CLK_SET_RATE_PARENT);
> > +	clks[IMX6SLL_PLL6_BYPASS] = imx_clk_mux_flags("pll6_bypass", base
> + 0xe0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels),
> CLK_SET_RATE_PARENT);
> > +	clks[IMX6SLL_PLL7_BYPASS] = imx_clk_mux_flags("pll7_bypass", base
> +
> > +0x20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels),
> > +CLK_SET_RATE_PARENT);
> > +
> > +	/* Do not bypass PLLs initially */
> > +	clk_set_parent(clks[IMX6SLL_PLL1_BYPASS], clks[IMX6SLL_CLK_PLL1]);
> > +	clk_set_parent(clks[IMX6SLL_PLL2_BYPASS], clks[IMX6SLL_CLK_PLL2]);
> > +	clk_set_parent(clks[IMX6SLL_PLL3_BYPASS], clks[IMX6SLL_CLK_PLL3]);
> > +	clk_set_parent(clks[IMX6SLL_PLL4_BYPASS], clks[IMX6SLL_CLK_PLL4]);
> > +	clk_set_parent(clks[IMX6SLL_PLL5_BYPASS], clks[IMX6SLL_CLK_PLL5]);
> > +	clk_set_parent(clks[IMX6SLL_PLL6_BYPASS], clks[IMX6SLL_CLK_PLL6]);
> > +	clk_set_parent(clks[IMX6SLL_PLL7_BYPASS], clks[IMX6SLL_CLK_PLL7]);
> 
> Can we just put raw register writes here instead? I'd prefer we didn't use clk
> consumer APIs to do things to the clk tree from the providers. The problem
> there being that:
> 
>  1) We're trying to move away from using consumer APIs in  provider drivers.
> It's ok if they're used during probe, but  inside clk_ops is not preferred.
> 
>  2) Even if you have a clk pointer, it may be "orphaned" at the  time of
> registration and so calling the APIs here works now but  eventually we may
> want to return an EPROBE_DEFER error in that  case and this may block that
> effort.
> 
> I suppose if this is the only clk driver on this machine then this last point isn't a
> concern and things are probably ok here.
> 

Using raw register writing has an issue.  The register is modified, but it seems the clock 'parent-child' relationship can 
not match the register setting. The register setting is not bypass the pll, but in debug 'clk_summary', the
pll is bypassed.  

BR

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
> Foundation Collaborative Project
