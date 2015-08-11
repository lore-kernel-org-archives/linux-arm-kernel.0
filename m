From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 11 Aug 2015 14:34:33 -0700
Subject: [PATCH] clk: rockchip: Fix SPIF special clock definition
In-Reply-To: <2030894.j0VJujBTor@diego>
References: <1438077162-27623-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <2030894.j0VJujBTor@diego>
Message-ID: <20150811213433.31346.58424@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2015-07-28 03:08:54)
> Am Dienstag, 28. Juli 2015, 11:52:42 schrieb Sjoerd Simons:
> > Neither spdif_src nor spdif_pll exists, judging by the vendor kernel in
> > both cases spdif_pre was meant. This brings the naming in line and
> > hierachy in line with that of sclk_i2s0.
> > 
> > Also allow sclk_spdif and spdif_frac to change their parents rate as
> > that the upstream dividers are purely there to feed sclk_spdif
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> I guess there was one rename to many back in the time :-) .
> Verified this with the CRU documentation, so
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Applied to clk-next.

Regards,
Mike

> 
> > ---
> >  drivers/clk/rockchip/clk-rk3188.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clk/rockchip/clk-rk3188.c
> > b/drivers/clk/rockchip/clk-rk3188.c index 0abf22d..ed02bbc 100644
> > --- a/drivers/clk/rockchip/clk-rk3188.c
> > +++ b/drivers/clk/rockchip/clk-rk3188.c
> > @@ -202,7 +202,7 @@ PNAME(mux_pll_src_cpll_gpll_p)    = { "cpll", "gpll" };
> >  PNAME(mux_aclk_cpu_p)                = { "apll", "gpll" };
> >  PNAME(mux_sclk_cif0_p)               = { "cif0_pre", "xin24m" };
> >  PNAME(mux_sclk_i2s0_p)               = { "i2s0_pre", "i2s0_frac", "xin12m" };
> > -PNAME(mux_sclk_spdif_p)              = { "spdif_src", "spdif_frac", "xin12m" };
> > +PNAME(mux_sclk_spdif_p)              = { "spdif_pre", "spdif_frac", "xin12m" };
> >  PNAME(mux_sclk_uart0_p)              = { "uart0_pre", "uart0_frac", "xin24m" };
> >  PNAME(mux_sclk_uart1_p)              = { "uart1_pre", "uart1_frac", "xin24m" };
> >  PNAME(mux_sclk_uart2_p)              = { "uart2_pre", "uart2_frac", "xin24m" };
> > @@ -350,10 +350,10 @@ static struct rockchip_clk_branch
> > common_clk_branches[] __initdata = { COMPOSITE_NOMUX(0, "spdif_pre",
> > "i2s_src", 0,
> >                       RK2928_CLKSEL_CON(5), 0, 7, DFLAGS,
> >                       RK2928_CLKGATE_CON(0), 13, GFLAGS),
> > -     COMPOSITE_FRAC(0, "spdif_frac", "spdif_pll", 0,
> > +     COMPOSITE_FRAC(0, "spdif_frac", "spdif_pre", CLK_SET_RATE_PARENT,
> >                       RK2928_CLKSEL_CON(9), 0,
> >                       RK2928_CLKGATE_CON(0), 14, GFLAGS),
> > -     MUX(SCLK_SPDIF, "sclk_spdif", mux_sclk_spdif_p, 0,
> > +     MUX(SCLK_SPDIF, "sclk_spdif", mux_sclk_spdif_p, CLK_SET_RATE_PARENT,
> >                       RK2928_CLKSEL_CON(5), 8, 2, MFLAGS),
> > 
> >       /*
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
