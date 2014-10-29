From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 29 Oct 2014 22:53:32 +0100
Subject: [PATCH] clk: rockchip: disable unused clocks
In-Reply-To: <CAD=FV=Vnt7Pg9V_cE0S8u-2X2hDsPN8huwy8xKv1UwvWEo-Hyw@mail.gmail.com>
References: <1414577167-25666-1-git-send-email-kever.yang@rock-chips.com>
 <CAD=FV=Vnt7Pg9V_cE0S8u-2X2hDsPN8huwy8xKv1UwvWEo-Hyw@mail.gmail.com>
Message-ID: <13348555.zj6gsMcCpK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 29. Oktober 2014, 13:50:20 schrieb Doug Anderson:
> Kever,
> 
> On Wed, Oct 29, 2014 at 3:06 AM, Kever Yang <kever.yang@rock-chips.com> 
wrote:
> > The rockchip clock driver use CLK_IGNORE_UNUSED flag to make sure
> > all the clocks are available like default power on state.
> > We have implement the clock manage in most of rockchip drivers,
> > it is time to remove it for power save.
> > Instead we add CLK_IGNORE_UNUSED for some clock nodes which should
> > be on during boot or no module driver in kernel will initialize it.
> > 
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > ---
> > 
> >  drivers/clk/rockchip/clk-rk3188.c |  32 ++++-----
> >  drivers/clk/rockchip/clk-rk3288.c | 146
> >  +++++++++++++++++++------------------- drivers/clk/rockchip/clk.c       
> >  |   9 ---
> >  3 files changed, 90 insertions(+), 97 deletions(-)
> 
> Your patch didn't seem to apply to the top of Heiko's
> "v3.19-clk/next".  Where should it apply to?
> 
> > -       GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_pre", 0,
> > +       GATE(0, "aclk_cpu", "aclk_cpu_pre", CLK_IGNORE_UNUSED,
> > 
> >                         RK3288_CLKGATE_CON(0), 3, GFLAGS),
> 
> It seems strange to me that you're removing the ACLK_CPU ID here.  Was
> that on purpose?
> 
> > -       COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_pre", 0,
> > +       COMPOSITE_NOMUX(0, "pclk_cpu", "aclk_cpu_pre", CLK_IGNORE_UNUSED,
> > 
> >                         RK3288_CLKSEL_CON(1), 12, 3, DFLAGS,
> >                         RK3288_CLKGATE_CON(0), 5, GFLAGS),
> 
> Here too for PCLK_CPU.  There are a few others as well.

yeah, they should keep their clock ids


> I'll also say that when I applied this atop my local tree that USB
> stopped working.  I just see:
> 
> [ 1647.626747] hub 2-1:1.0: hub_port_status failed (err = -110)
> [ 1657.626746] hub 2-1:1.0: hub_port_status failed (err = -110)
> 
> ...over and over and over again.

maybe Kever's dwc2 clock-handling patch [0] might help there, as the dwc2-host 
currently does not seem to do any clock handling at all.


Heiko


[0] http://www.spinics.net/lists/linux-usb/msg116278.html
