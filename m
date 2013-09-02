From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 2 Sep 2013 20:27:47 +0200
Subject: [PATCH] cpufreq: imx6q: Fix clock enable balance
In-Reply-To: <20130902150256.GA17900@S2101-09.ap.freescale.net>
References: <1377517716-27470-1-git-send-email-s.hauer@pengutronix.de>
 <20130829140123.GM18729@S2101-09.ap.freescale.net>
 <20130830190019.GG30088@pengutronix.de>
 <20130902150256.GA17900@S2101-09.ap.freescale.net>
Message-ID: <20130902182747.GA30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 11:02:58PM +0800, Shawn Guo wrote:
> On Fri, Aug 30, 2013 at 09:00:19PM +0200, Sascha Hauer wrote:
> > On Thu, Aug 29, 2013 at 10:01:25PM +0800, Shawn Guo wrote:
> > > On Mon, Aug 26, 2013 at 01:48:36PM +0200, Sascha Hauer wrote:
> > > > For changing the cpu frequency the i.MX6q has to be switched to some
> > > > intermediate clock during the PLL reprogramming. The driver tries
> > > > to be clever to keep the enable count correct but gets it wrong. If
> > > > the cpufreq is increased it calls clk_disable_unprepare twice
> > > > on pll2_pfd2_396m. This puts all other devices which get their clock
> > > > from pll2_pfd2_396m into a nonworking state.
> > > 
> > > So you're running into a problem in real?  The clk_disable_unprepare on
> > > pll2_pfd2_396m below will only be executed when are leaving 396MHz
> > > set-point.
> > 
> > And that's when my SD card stops working. On my board the SD clock is
> > derived from pll2_pfd2_396m. I used the userspace cpufreq governor
> > and scaled down to 396MHz. When I scale up again the SDHC driver times
> > out while waiting for interrupts. This is because the cpufreq driver
> > disables the clock twice.
> 
> So when you scale down to 396MHz, the following function sequence is all
> what you will call.
> 
>         clk_prepare_enable(pll2_pfd2_396m_clk);
>         clk_set_parent(step_clk, pll2_pfd2_396m_clk);
>         clk_set_parent(pll1_sw_clk, step_clk);
>         if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
>                 ...
>         } else {
>                 clk_disable_unprepare(pll1_sys_clk);
>         }
> 
> You will leave imx6q_set_target() with use count of pll2_pfd2_396m_clk
> increased.  Then when you scale up, you call clk_prepare_enable() once
> and clk_disable_unprepare() twice on pll2_pfd2_396m_clk, and you get
> the use count balanced in the end.  Isn't that the case for you?

I see what you mean. I looked a bit deeper.

The issue seems to be that my board comes up with 396MHz. The code
assumes that it switches to 396MHz and back again. When imx6q_set_target
is entered with 396MHz for the first time after startup then it calls
clk_disable_unprepare twice without having called clk_prepare_enable
twice before.


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
