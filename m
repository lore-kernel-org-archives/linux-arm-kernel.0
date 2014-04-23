From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 23 Apr 2014 10:20:38 +0200
Subject: [PATCH 1/2] ARM: imx6q: clk: Parent DI clocks to video PLL via
 di_pre_sel
In-Reply-To: <53577203.6070700@de.bosch.com>
References: <1397485240-29163-1-git-send-email-p.zabel@pengutronix.de>
 <53577203.6070700@de.bosch.com>
Message-ID: <1398241238.10369.5.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 23.04.2014, 09:55 +0200 schrieb Dirk Behme:
> On 14.04.2014 16:20, Philipp Zabel wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > Route the video PLL to the display interface clocks via the di_pre_sel
> > and di_sel muxes by default.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >   arch/arm/mach-imx/clk-imx6q.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > index a3a69ab..ba17299 100644
> > --- a/arch/arm/mach-imx/clk-imx6q.c
> > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > @@ -445,6 +445,15 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
> >   		clk_set_parent(clk[ldb_di1_sel], clk[pll5_video_div]);
> >   	}
> >
> > +	clk_set_parent(clk[ipu1_di0_pre_sel], clk[pll5_video_div]);
> > +	clk_set_parent(clk[ipu1_di1_pre_sel], clk[pll5_video_div]);
> > +	clk_set_parent(clk[ipu2_di0_pre_sel], clk[pll5_video_div]);
> > +	clk_set_parent(clk[ipu2_di1_pre_sel], clk[pll5_video_div]);
> > +	clk_set_parent(clk[ipu1_di0_sel], clk[ipu1_di0_pre]);
> > +	clk_set_parent(clk[ipu1_di1_sel], clk[ipu1_di1_pre]);
> > +	clk_set_parent(clk[ipu2_di0_sel], clk[ipu2_di0_pre]);
> > +	clk_set_parent(clk[ipu2_di1_sel], clk[ipu2_di1_pre]);
> > +
> >   	/*
> >   	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
> >   	 * We can not get the 100MHz from the pll2_pfd0_352m.
> 
> I'm no expert on this, so just a question from an internal review:
> 
> With this, having both ldb_di0_sel and ipu1_di0_sel driven by 
> pll5_video, what will happen if both lvds and hdmi are trying to set the 
> rate of pll5_video_div?
> 
Last one that comes around wins. We could change this to use clock
notifiers, but it doesn't make much sense right now, as this would just
change the situation to first one wins.

What we really need is some kind of clock negotiation, but there isn't
anything in the clock framework yet to make this happen. We have some
ideas about this, but it will take a little while.

In the meanwhile this patch improves the situation for people using the
driver with one LVDS or HDMI display.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
