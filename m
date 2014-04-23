From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 23 Apr 2014 16:31:19 +0800
Subject: [PATCH 1/2] ARM: imx6q: clk: Parent DI clocks to video PLL via
 di_pre_sel
In-Reply-To: <53577203.6070700@de.bosch.com>
References: <1397485240-29163-1-git-send-email-p.zabel@pengutronix.de>
 <53577203.6070700@de.bosch.com>
Message-ID: <20140423083116.GF2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 09:55:47AM +0200, Dirk Behme wrote:
> On 14.04.2014 16:20, Philipp Zabel wrote:
> >From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> >Route the video PLL to the display interface clocks via the di_pre_sel
> >and di_sel muxes by default.
> >
> >Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> >---
> >  arch/arm/mach-imx/clk-imx6q.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> >diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> >index a3a69ab..ba17299 100644
> >--- a/arch/arm/mach-imx/clk-imx6q.c
> >+++ b/arch/arm/mach-imx/clk-imx6q.c
> >@@ -445,6 +445,15 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
> >  		clk_set_parent(clk[ldb_di1_sel], clk[pll5_video_div]);
> >  	}
> >
> >+	clk_set_parent(clk[ipu1_di0_pre_sel], clk[pll5_video_div]);
> >+	clk_set_parent(clk[ipu1_di1_pre_sel], clk[pll5_video_div]);
> >+	clk_set_parent(clk[ipu2_di0_pre_sel], clk[pll5_video_div]);
> >+	clk_set_parent(clk[ipu2_di1_pre_sel], clk[pll5_video_div]);
> >+	clk_set_parent(clk[ipu1_di0_sel], clk[ipu1_di0_pre]);
> >+	clk_set_parent(clk[ipu1_di1_sel], clk[ipu1_di1_pre]);
> >+	clk_set_parent(clk[ipu2_di0_sel], clk[ipu2_di0_pre]);
> >+	clk_set_parent(clk[ipu2_di1_sel], clk[ipu2_di1_pre]);
> >+
> >  	/*
> >  	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
> >  	 * We can not get the 100MHz from the pll2_pfd0_352m.
> 
> I'm no expert on this, so just a question from an internal review:
> 
> With this, having both ldb_di0_sel and ipu1_di0_sel driven by
> pll5_video, what will happen if both lvds and hdmi are trying to set
> the rate of pll5_video_div?

It's indeed a good question.

Very likely, one or the other will be broken, depending which one calls
clk_set_rate() first.  The one calling clk_set_rate() later will work
fine.

It's a result of that there is no negotiation between rate change
requests from different clients on the same clock.  Such negotiation
can be done with clk rate change notifier.  It will make these client
driver quite complex on clk set rate operation though.  Also, if none
of the possible rate of the source clock can meet the different
requests from these clients at the same time, we're stuck anyway.

That said, for now we have limitation to support both lvds and hdmi.

Shawn
