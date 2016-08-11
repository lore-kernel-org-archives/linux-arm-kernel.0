From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 11 Aug 2016 09:07 +0200
Subject: [v2 PATCH] clk: rockchip: mark rk3399 hdcp_noc and vio_noc as
 critical
In-Reply-To: <CABXOdTeDYzOpNxkyScf3WvvFynyTZbKrVdVFzMobMaPAp=f5jw@mail.gmail.com>
References: <1470765753-11619-1-git-send-email-zyw@rock-chips.com>
 <CABXOdTeDYzOpNxkyScf3WvvFynyTZbKrVdVFzMobMaPAp=f5jw@mail.gmail.com>
Message-ID: <1993709.ojDB6MdHog@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 10. August 2016, 15:14:06 schrieb Guenter Roeck:
> On Tue, Aug 9, 2016 at 11:02 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> > Fix incorrect rk3399 aclk_vio gating bit, it should be 0, not 10. With
> > this modification, the aclk_vio_noc should be put into critical list,
> > since it is required by VOP.
> > And the Type-C DP need these clocks: aclk_hdcp_noc, hclk_hdcp_noc,
> > pclk_hdcp_noc. Mark them as critical to avoid someone close them.
> > 
> > Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> > ---
> > 
> >  drivers/clk/rockchip/clk-rk3399.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/rockchip/clk-rk3399.c
> > b/drivers/clk/rockchip/clk-rk3399.c index b173711a..676b017 100644
> > --- a/drivers/clk/rockchip/clk-rk3399.c
> > +++ b/drivers/clk/rockchip/clk-rk3399.c
> > @@ -1073,7 +1073,7 @@ static struct rockchip_clk_branch
> > rk3399_clk_branches[] __initdata = {> 
> >         /* vio */
> >         COMPOSITE(ACLK_VIO, "aclk_vio", mux_pll_src_cpll_gpll_ppll_p,
> >         CLK_IGNORE_UNUSED,>         
> >                         RK3399_CLKSEL_CON(42), 6, 2, MFLAGS, 0, 5, DFLAGS,
> > 
> > -                       RK3399_CLKGATE_CON(11), 10, GFLAGS),
> > +                       RK3399_CLKGATE_CON(11), 0, GFLAGS),
> > 
> >         COMPOSITE_NOMUX(PCLK_VIO, "pclk_vio", "aclk_vio", 0,
> >         
> >                         RK3399_CLKSEL_CON(43), 0, 5, DFLAGS,
> >                         RK3399_CLKGATE_CON(11), 1, GFLAGS),
> > 
> > @@ -1470,6 +1470,9 @@ static const char *const
> > rk3399_cru_critical_clocks[] __initconst = {> 
> >         "aclk_cci_pre",
> >         "aclk_gic",
> >         "aclk_gic_noc",
> > 
> > +       "aclk_hdcp_noc",
> > +       "hclk_hdcp_noc",
> > +       "pclk_hdcp_noc",
> > 
> >         "pclk_perilp0",
> >         "pclk_perilp0",
> >         "hclk_perilp0",
> > 
> > @@ -1489,6 +1492,7 @@ static const char *const
> > rk3399_cru_critical_clocks[] __initconst = {> 
> >         "gpll_hclk_perilp1_src",
> >         "gpll_aclk_perilp0_src",
> >         "gpll_aclk_perihp_src",
> > 
> > +       "aclk_vio_noc",
> 
> I think there was a previous comment suggesting that this clock should
> be handled differently. Has this been resolved ?

The clock getting handled differently was pclk_grf_vio - aka the GRF part 
needed. This one is the interconnect clock of the vio port (as far as I 
understand that), which we currently don't model at all.
But if we did it would probably handled in some new part but not in the 
graphics drivers.

So all looks well like it is here :-)

Heiko
