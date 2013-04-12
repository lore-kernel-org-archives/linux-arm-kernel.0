From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 12 Apr 2013 11:03:39 +0200
Subject: [PATCH] ARM i.MX6q: Fix periph_clk2_sel and periph2_clk2_sel
 clocks
In-Reply-To: <20130412030228.GF16970@S2101-09.ap.freescale.net>
References: <1365675812-21600-1-git-send-email-p.zabel@pengutronix.de>
 <20130412030228.GF16970@S2101-09.ap.freescale.net>
Message-ID: <1365757419.5330.17.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 12.04.2013, 11:02 +0800 schrieb Shawn Guo:
> On Thu, Apr 11, 2013 at 12:23:32PM +0200, Philipp Zabel wrote:
> > The periph_clk2_sel mux can be set to pll3, pll1, or
> > osc/pll2-bypass/pll2_burn_in_clk.
> 
> Looking at IMX6DQRM Rev. 0, 11/2012, I see
> 
> 13?12 periph_clk2_sel: Selector for peripheral clk2 clock multiplexer
> 
> 	00 derive clock from pll3_sw_clk
> 	01 derive clock from pll1_ref_clk
> 	10 derive clock from pll2_burn_in_clk (default)
> 	11 reserved
> 
> Are you sure pll1_ref_clk actually means pll1_sys?

No, pll1_sys indeed is pll1_sw_clk, not pll1_ref_clk.

> I searched the
> document and word "pll1_ref_clk" occurs only once.  But Figure 18-5. BUS
> clock generation on page 819 suggests it's OSC_CLK (24M).

This is consistent (24 MHz osc is the pll1 reference), and thus might be
correct. I'll fix the patch to keep periph_clk2_sels[1] = "osc".

regards
Philipp

> > The periph2_clk2_sel
> > mux can be set to pll3 or pll2.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  arch/arm/mach-imx/clk-imx6q.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > index 65319d5..bdeddf3 100644
> > --- a/arch/arm/mach-imx/clk-imx6q.c
> > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > @@ -177,7 +177,8 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
> >  static const char *step_sels[]	= { "osc", "pll2_pfd2_396m", };
> >  static const char *pll1_sw_sels[]	= { "pll1_sys", "step", };
> >  static const char *periph_pre_sels[]	= { "pll2_bus", "pll2_pfd2_396m", "pll2_pfd0_352m", "pll2_198m", };
> > -static const char *periph_clk2_sels[]	= { "pll3_usb_otg", "osc", };
> > +static const char *periph_clk2_sels[]	= { "pll3_usb_otg", "pll1_sys", "osc", "dummy", };
> > +static const char *periph2_clk2_sels[]	= { "pll3_usb_otg", "pll2_bus", };
> >  static const char *periph_sels[]	= { "periph_pre", "periph_clk2", };
> >  static const char *periph2_sels[]	= { "periph2_pre", "periph2_clk2", };
> >  static const char *axi_sels[]		= { "periph", "pll2_pfd2_396m", "pll3_pfd1_540m", };
> > @@ -369,8 +370,8 @@ int __init mx6q_clocks_init(void)
> >  	clk[pll1_sw]          = imx_clk_mux("pll1_sw",	        base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
> >  	clk[periph_pre]       = imx_clk_mux("periph_pre",       base + 0x18, 18, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
> >  	clk[periph2_pre]      = imx_clk_mux("periph2_pre",      base + 0x18, 21, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
> > -	clk[periph_clk2_sel]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 1, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
> > -	clk[periph2_clk2_sel] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
> > +	clk[periph_clk2_sel]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
> > +	clk[periph2_clk2_sel] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
> >  	clk[axi_sel]          = imx_clk_mux("axi_sel",          base + 0x14, 6,  2, axi_sels,          ARRAY_SIZE(axi_sels));
> >  	clk[esai_sel]         = imx_clk_mux("esai_sel",         base + 0x20, 19, 2, audio_sels,        ARRAY_SIZE(audio_sels));
> >  	clk[asrc_sel]         = imx_clk_mux("asrc_sel",         base + 0x30, 7,  2, audio_sels,        ARRAY_SIZE(audio_sels));
> > -- 
> > 1.8.2.rc2
> > 
> 
> 
