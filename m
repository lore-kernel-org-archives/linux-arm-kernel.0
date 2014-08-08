From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 09 Aug 2014 00:20:46 +0200
Subject: [PATCH 1/4] clk: rockchip: protect critical clocks from getting
 disabled
In-Reply-To: <CAD=FV=XA31T9i6nLaDhVS+BkJ=U-PiMye_ouC1QY8EMoKqMCiQ@mail.gmail.com>
References: <1406661128-7614-1-git-send-email-heiko@sntech.de>
 <2434370.xFIeZvuJnT@diego>
 <CAD=FV=XA31T9i6nLaDhVS+BkJ=U-PiMye_ouC1QY8EMoKqMCiQ@mail.gmail.com>
Message-ID: <3332039.dxD4mlCSgf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 8. August 2014, 14:58:11 schrieb Doug Anderson:
> Heiko,
> 
> On Fri, Aug 1, 2014 at 1:15 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > Am Donnerstag, 31. Juli 2014, 17:30:25 schrieb Mike Turquette:
> >> Quoting Heiko St?bner (2014-07-31 16:29:34)
> >> 
> >> > Hi Mike,
> >> > 
> >> > Am Donnerstag, 31. Juli 2014, 15:45:23 schrieb Mike Turquette:
> >> > > Quoting Heiko Stuebner (2014-07-29 12:12:05)
> >> > > 
> >> > > > The clock-tree contains clocks that should never get disabled
> >> > > > automatically. One example are the base ACLKs, the base supplies
> >> > > > for
> >> > > > all
> >> > > > peripherals.
> >> > > > 
> >> > > > Therefore add a structure similar to the sunxi clock-tree to
> >> > > > protect
> >> > > > these
> >> > > > special clocks from being disabled.
> >> > > > 
> >> > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> > > > ---
> >> > > > 
> >> > > >  drivers/clk/rockchip/clk-rk3188.c |  7 +++++++
> >> > > >  drivers/clk/rockchip/clk-rk3288.c |  7 +++++++
> >> > > >  drivers/clk/rockchip/clk.c        | 13 +++++++++++++
> >> > > >  drivers/clk/rockchip/clk.h        |  1 +
> >> > > >  4 files changed, 28 insertions(+)
> >> > > > 
> >> > > > diff --git a/drivers/clk/rockchip/clk-rk3188.c
> >> > > > b/drivers/clk/rockchip/clk-rk3188.c index a83a6d8..5aef277 100644
> >> > > > --- a/drivers/clk/rockchip/clk-rk3188.c
> >> > > > +++ b/drivers/clk/rockchip/clk-rk3188.c
> >> > > > @@ -599,6 +599,11 @@ static struct rockchip_clk_branch
> >> > > > rk3188_clk_branches[] __initdata = {>
> >> > > > 
> >> > > >         GATE(ACLK_GPS, "aclk_gps", "aclk_peri", 0,
> >> > > >         RK2928_CLKGATE_CON(8),
> >> > > >         13, GFLAGS),>
> >> > > >  
> >> > > >  };
> >> > > > 
> >> > > > +static const char *rk3188_critical_clocks[] __initconst = {
> >> > > > +       "aclk_cpu",
> >> > > > +       "aclk_peri",
> >> > > 
> >> > > I'm not against the idea of critical clocks, but I want to verify
> >> > > that
> >> > > there is no other driver out there that is a better fit for claiming
> >> > > these clks via clk_get and enabling them the normal way via
> >> > > clk_enable?
> >> > 
> >> > In the clock hierarchy of Rockchip SoCs, both aclks listed here, are
> >> > sources for pclk and hclk, as well as sourcing some other peripheral
> >> > gates further below too. So from what I've seen from the clock
> >> > diagrams,
> >> > there is nothing that would claim these clocks directly, and it
> >> > wouldn't
> >> > also make any sense to let them get disabled as there will always be
> >> > something using them (for example the dram-controller).
> >> 
> >> Sounds good. Just out of curiosity, under what circumstances would you
> >> want to gate them? Is there a use case for it?
> > 
> > hmm, I don't see a use-case for gating these at runtime right now, simply
> > because there should be a user for them all the time. (both aclks combined
> > have at least 68 consumers on the rk3288 and a similar number on the
> > previous socs)
> > 
> > The only thing I could think of would be something suspend related - which
> > we don't have yet. But then this would probably happen in the clock
> > controller itself anyway in some late suspend-related action, so it could
> > take into account them being defined as critical clocks.
> 
> I know Rockchip has some funky stuff planned for memory scaling too.
> Perhaps Kever can comment whether these two clocks might need to be
> disabled in that case?

hmm looking at the core clock tree, I wouldn't think so.

The only intersection between the ddr-clk, aclk_cpu and aclk_peri is the gpll 
which can be a source to both. But the ddr-clk is mainly sourced from the dpll 
anyway.

In any case, turning off aclk_cpu/aclk_peri in this scenario wouldn't normally 
be possible anyway, as most of the time some pclk_* would be active anyway.


> In any case, this patch fixes a hang at boot when using the PWM driver
> that just landed, so:
> 
> Tested-by: Doug Anderson <dianders@chromium.org>

thanks


Heiko
