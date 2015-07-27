From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Jul 2015 07:52:32 +0200
Subject: [PATCH v4 2/7] clk: mediatek: Fix rate and dependency of MT8173
 clocks
In-Reply-To: <CAGS+omC=84oWFcv1Eumsj6FHzSQc+Ba9zVOn6USS9ymQS3mTSQ@mail.gmail.com>
References: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
 <1437706925-3222-3-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omC=84oWFcv1Eumsj6FHzSQc+Ba9zVOn6USS9ymQS3mTSQ@mail.gmail.com>
Message-ID: <20150727055232.GW18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 07:10:14PM +0800, Daniel Kurtz wrote:
> On Fri, Jul 24, 2015 at 11:02 AM, James Liao <jamesjj.liao@mediatek.com> wrote:
> > Remove the dependency from clk_null, and give all root clocks a
> > typical rate, include clkph_mck_o, usb_syspll_125m and hdmitx_dig_cts.
> >
> > dpi_ck was removed due to no clock reference to it.
> >
> > Replace parent clock of infra_cpum with cpum_ck, which is an external
> > clock and can be defined in the deivce tree.
> >
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-mt8173.c      | 13 ++++++-------
> >  include/dt-bindings/clock/mt8173-clk.h |  1 -
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> > index 4b9e04c..50b3266 100644
> > --- a/drivers/clk/mediatek/clk-mt8173.c
> > +++ b/drivers/clk/mediatek/clk-mt8173.c
> > @@ -24,11 +24,9 @@
> >
> >  static DEFINE_SPINLOCK(mt8173_clk_lock);
> >
> > -static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
> > -       FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
> > -       FACTOR(CLK_TOP_DPI, "dpi_ck", "clk_null", 1, 1),
> > -       FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
> > -       FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
> > +static const struct mtk_fixed_clk fixed_clks[] __initconst = {
> > +       FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", 400 * MHZ),
> > +       FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
> >  };
> >
> >  static const struct mtk_fixed_factor top_divs[] __initconst = {
> > @@ -53,6 +51,7 @@ static const struct mtk_fixed_factor top_divs[] __initconst = {
> >         FACTOR(CLK_TOP_CLKRTC_INT, "clkrtc_int", "clk26m", 1, 793),
> >         FACTOR(CLK_TOP_FPC, "fpc_ck", "clk26m", 1, 1),
> >
> > +       FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "tvdpll_445p5m", 1, 3),
> >         FACTOR(CLK_TOP_HDMITXPLL_D2, "hdmitxpll_d2", "hdmitx_dig_cts", 1, 2),
> >         FACTOR(CLK_TOP_HDMITXPLL_D3, "hdmitxpll_d3", "hdmitx_dig_cts", 1, 3),
> >
> > @@ -611,7 +610,7 @@ static const struct mtk_gate infra_clks[] __initconst = {
> >         GATE_ICG(CLK_INFRA_GCE, "infra_gce", "axi_sel", 6),
> >         GATE_ICG(CLK_INFRA_L2C_SRAM, "infra_l2c_sram", "axi_sel", 7),
> >         GATE_ICG(CLK_INFRA_M4U, "infra_m4u", "mem_sel", 8),
> > -       GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "clk_null", 15),
> > +       GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "cpum_ck", 15),
> >         GATE_ICG(CLK_INFRA_KP, "infra_kp", "axi_sel", 16),
> >         GATE_ICG(CLK_INFRA_CEC, "infra_cec", "clk26m", 18),
> >         GATE_ICG(CLK_INFRA_PMICSPI, "infra_pmicspi", "pmicspi_sel", 22),
> > @@ -714,7 +713,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
> >
> >         clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> >
> > -       mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
> > +       mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
> >         mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
> >         mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
> >                         &mt8173_clk_lock, clk_data);
> > diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
> > index 4ad76ed..7230c38 100644
> > --- a/include/dt-bindings/clock/mt8173-clk.h
> > +++ b/include/dt-bindings/clock/mt8173-clk.h
> > @@ -18,7 +18,6 @@
> >  /* TOPCKGEN */
> >
> >  #define CLK_TOP_CLKPH_MCK_O            1
> > -#define CLK_TOP_DPI                    2
> >  #define CLK_TOP_USB_SYSPLL_125M                3
> 
> I think we should renumber the rest of the CLK_TOP_*

They shouldn't be renumbered at all as this makes all binary device
trees out there useless. That may not be a big issue with the MT8173
at the moment as there are hardly any binary device trees with the
mainline device trees shipped, but still we should get used to not
break existing device trees without need.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
