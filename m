From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 27 Jul 2015 09:52:39 +0200
Subject: [PATCH v4 2/7] clk: mediatek: Fix rate and dependency of MT8173
 clocks
In-Reply-To: <CAGS+omDjr6d9=+d-uphrENu3Kenr8QUc3VgbaWTd45wqWzi7tg@mail.gmail.com>
References: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
 <20150727055232.GW18700@pengutronix.de>
 <CAGS+omDjr6d9=+d-uphrENu3Kenr8QUc3VgbaWTd45wqWzi7tg@mail.gmail.com>
Message-ID: <18677675.jZ2GEqS3sy@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 27. Juli 2015, 14:19:41 schrieb Daniel Kurtz:
> On Jul 27, 2015 12:52, "Sascha Hauer" <s.hauer@pengutronix.de> wrote:
> > On Fri, Jul 24, 2015 at 07:10:14PM +0800, Daniel Kurtz wrote:
> > > On Fri, Jul 24, 2015 at 11:02 AM, James Liao <jamesjj.liao@mediatek.com>
> 
> wrote:
> > > > Remove the dependency from clk_null, and give all root clocks a
> > > > typical rate, include clkph_mck_o, usb_syspll_125m and hdmitx_dig_cts.
> > > > 
> > > > dpi_ck was removed due to no clock reference to it.
> > > > 
> > > > Replace parent clock of infra_cpum with cpum_ck, which is an external
> > > > clock and can be defined in the deivce tree.
> > > > 
> > > > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > > > ---
> > > > 
> > > >  drivers/clk/mediatek/clk-mt8173.c      | 13 ++++++-------
> > > >  include/dt-bindings/clock/mt8173-clk.h |  1 -
> > > >  2 files changed, 6 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/clk/mediatek/clk-mt8173.c
> 
> b/drivers/clk/mediatek/clk-mt8173.c
> 
> > > > index 4b9e04c..50b3266 100644
> > > > --- a/drivers/clk/mediatek/clk-mt8173.c
> > > > +++ b/drivers/clk/mediatek/clk-mt8173.c
> > > > @@ -24,11 +24,9 @@
> > > > 
> > > >  static DEFINE_SPINLOCK(mt8173_clk_lock);
> > > > 
> > > > -static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
> > > > -       FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
> > > > -       FACTOR(CLK_TOP_DPI, "dpi_ck", "clk_null", 1, 1),
> > > > -       FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m",
> 
> "clk_null", 1, 1),
> 
> > > > -       FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null",
> 
> 1, 1),
> 
> > > > +static const struct mtk_fixed_clk fixed_clks[] __initconst = {
> > > > +       FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", 400 *
> 
> MHZ),
> 
> > > > +       FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m",
> 
> "clk26m", 125 * MHZ),
> 
> > > >  };
> > > >  
> > > >  static const struct mtk_fixed_factor top_divs[] __initconst = {
> > > > 
> > > > @@ -53,6 +51,7 @@ static const struct mtk_fixed_factor top_divs[]
> 
> __initconst = {
> 
> > > >         FACTOR(CLK_TOP_CLKRTC_INT, "clkrtc_int", "clk26m", 1, 793),
> > > >         FACTOR(CLK_TOP_FPC, "fpc_ck", "clk26m", 1, 1),
> > > > 
> > > > +       FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts",
> 
> "tvdpll_445p5m", 1, 3),
> 
> > > >         FACTOR(CLK_TOP_HDMITXPLL_D2, "hdmitxpll_d2",
> 
> "hdmitx_dig_cts", 1, 2),
> 
> > > >         FACTOR(CLK_TOP_HDMITXPLL_D3, "hdmitxpll_d3",
> 
> "hdmitx_dig_cts", 1, 3),
> 
> > > > @@ -611,7 +610,7 @@ static const struct mtk_gate infra_clks[]
> 
> __initconst = {
> 
> > > >         GATE_ICG(CLK_INFRA_GCE, "infra_gce", "axi_sel", 6),
> > > >         GATE_ICG(CLK_INFRA_L2C_SRAM, "infra_l2c_sram", "axi_sel", 7),
> > > >         GATE_ICG(CLK_INFRA_M4U, "infra_m4u", "mem_sel", 8),
> > > > 
> > > > -       GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "clk_null", 15),
> > > > +       GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "cpum_ck", 15),
> > > > 
> > > >         GATE_ICG(CLK_INFRA_KP, "infra_kp", "axi_sel", 16),
> > > >         GATE_ICG(CLK_INFRA_CEC, "infra_cec", "clk26m", 18),
> > > >         GATE_ICG(CLK_INFRA_PMICSPI, "infra_pmicspi", "pmicspi_sel",
> 
> 22),
> 
> > > > @@ -714,7 +713,7 @@ static void __init mtk_topckgen_init(struct
> 
> device_node *node)
> 
> > > >         clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> > > > 
> > > > -       mtk_clk_register_factors(root_clk_alias,
> 
> ARRAY_SIZE(root_clk_alias), clk_data);
> 
> > > > +       mtk_clk_register_fixed_clks(fixed_clks,
> 
> ARRAY_SIZE(fixed_clks), clk_data);
> 
> > > >         mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
> 
> clk_data);
> 
> > > >         mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
> 
> base,
> 
> > > >                         &mt8173_clk_lock, clk_data);
> > > > 
> > > > diff --git a/include/dt-bindings/clock/mt8173-clk.h
> 
> b/include/dt-bindings/clock/mt8173-clk.h
> 
> > > > index 4ad76ed..7230c38 100644
> > > > --- a/include/dt-bindings/clock/mt8173-clk.h
> > > > +++ b/include/dt-bindings/clock/mt8173-clk.h
> > > > @@ -18,7 +18,6 @@
> > > > 
> > > >  /* TOPCKGEN */
> > > >  
> > > >  #define CLK_TOP_CLKPH_MCK_O            1
> > > > 
> > > > -#define CLK_TOP_DPI                    2
> > > > 
> > > >  #define CLK_TOP_USB_SYSPLL_125M                3
> > > 
> > > I think we should renumber the rest of the CLK_TOP_*
> > 
> > They shouldn't be renumbered at all as this makes all binary device
> > trees out there useless. That may not be a big issue with the MT8173
> > at the moment as there are hardly any binary device trees with the
> > mainline device trees shipped, but still we should get used to not
> > break existing device trees without need.
> 
> As you mention, there are no devices shipped with mainline binary device
> trees.  So, let's just correct the numbering now while we still can do it
> painlessly.  It seems a bit unnecessary to preserve backwards compatibility
> when we are still landing basic device support, like the clock tree.

in general I'm with Sascha on this regarding breaking the dt, and I guess
the empty number does not hurt this much. Another argument against
renumbering would be that the clock is there, it's just not used in the
code anymore, but the clock is acutally still there.


But on the other hand, the clock hasn't been part of an official kernel
release yet (not in 4.1), and if we want to follow protocol to the letter,
the removal of the clock id itself is already breakage, because the
binding-header is considered part of the dt and removing a constant
could already cause breakage in some universe far far away :-)

So you could try to convince the clock maintainers, that this might still
be 4.2 material. Or do a smaller patch for 4.2 like the following, to at
least follow the dt-protocol.

Please also take a look at the mt8135 clock tree, to maybe fix this
already too, before it becomes part of a release.


Heiko

--------------- 8< -----------------
From: Heiko Stuebner <heiko@sntech.de>
Date: Mon, 27 Jul 2015 09:41:56 +0200
Subject: [PATCH] clk: mediatek: mt8173: remove unused dpi_ck clock

The dpi_ck clock is not actually used and its source isn't 100% clear too.
So remove it for the time being.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/mediatek/clk-mt8173.c      | 1 -
 include/dt-bindings/clock/mt8173-clk.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 8b6523d..80871e2 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -26,7 +26,6 @@ static DEFINE_SPINLOCK(mt8173_clk_lock);
 
 static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
 	FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
-	FACTOR(CLK_TOP_DPI, "dpi_ck", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
 };
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
index 4ad76ed..7230c38 100644
--- a/include/dt-bindings/clock/mt8173-clk.h
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -18,7 +18,6 @@
 /* TOPCKGEN */
 
 #define CLK_TOP_CLKPH_MCK_O		1
-#define CLK_TOP_DPI			2
 #define CLK_TOP_USB_SYSPLL_125M		3
 #define CLK_TOP_HDMITX_DIG_CTS		4
 #define CLK_TOP_ARMCA7PLL_754M		5
-- 
2.1.4
