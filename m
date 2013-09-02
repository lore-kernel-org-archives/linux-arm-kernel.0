From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 2 Sep 2013 23:02:58 +0800
Subject: [PATCH] cpufreq: imx6q: Fix clock enable balance
In-Reply-To: <20130830190019.GG30088@pengutronix.de>
References: <1377517716-27470-1-git-send-email-s.hauer@pengutronix.de>
 <20130829140123.GM18729@S2101-09.ap.freescale.net>
 <20130830190019.GG30088@pengutronix.de>
Message-ID: <20130902150256.GA17900@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 09:00:19PM +0200, Sascha Hauer wrote:
> On Thu, Aug 29, 2013 at 10:01:25PM +0800, Shawn Guo wrote:
> > On Mon, Aug 26, 2013 at 01:48:36PM +0200, Sascha Hauer wrote:
> > > For changing the cpu frequency the i.MX6q has to be switched to some
> > > intermediate clock during the PLL reprogramming. The driver tries
> > > to be clever to keep the enable count correct but gets it wrong. If
> > > the cpufreq is increased it calls clk_disable_unprepare twice
> > > on pll2_pfd2_396m. This puts all other devices which get their clock
> > > from pll2_pfd2_396m into a nonworking state.
> > 
> > So you're running into a problem in real?  The clk_disable_unprepare on
> > pll2_pfd2_396m below will only be executed when are leaving 396MHz
> > set-point.
> 
> And that's when my SD card stops working. On my board the SD clock is
> derived from pll2_pfd2_396m. I used the userspace cpufreq governor
> and scaled down to 396MHz. When I scale up again the SDHC driver times
> out while waiting for interrupts. This is because the cpufreq driver
> disables the clock twice.

So when you scale down to 396MHz, the following function sequence is all
what you will call.

        clk_prepare_enable(pll2_pfd2_396m_clk);
        clk_set_parent(step_clk, pll2_pfd2_396m_clk);
        clk_set_parent(pll1_sw_clk, step_clk);
        if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
                ...
        } else {
                clk_disable_unprepare(pll1_sys_clk);
        }

You will leave imx6q_set_target() with use count of pll2_pfd2_396m_clk
increased.  Then when you scale up, you call clk_prepare_enable() once
and clk_disable_unprepare() twice on pll2_pfd2_396m_clk, and you get
the use count balanced in the end.  Isn't that the case for you?

The question is not important though, since with your explanation below,
I agree the changes you propose make more sense.

<snip>

> > > Fix this by removing the clk enabling/disabling altogether since the
> > > clk core will do this automatically during a reparent.
> > 
> > It seems clk core will only enable the parent clock during the
> > clk_set_parent() call, and only in case that the child clock is
> > prepared.  For example, I do not think pll2_pfd2_396m_clk and step_clk
> > will be altered to ON state.  Or am I missing something?
> > 
> 
> It seems so, yes. Reparenting takes the prepare/enable state
> of a clock with it. See __clk_set_parent, it starts with:
> 
> 	if (clk->prepare_count) {
> 		__clk_prepare(parent);
> 		clk_enable(parent);
> 		clk_enable(clk);
> 	}
> 
> So if the clock to be reparent is enabled then the new parent
> gets enabled aswell. And it ends with:
> 
> 	if (clk->prepare_count) {
> 		clk_disable(clk);
> 		clk_disable(old_parent);
> 		__clk_unprepare(old_parent);
> 	}
> 
> So if the clock is enabled the old parent now decreases its enable
> count.

Ah, yes, I forgot the fact that clock pll1_sw_clk must be always
prepared/enabled in this case.  So when clk_set_parent(pll1_sw_clk,
step_clk) happens, both step_clk and pll2_pfd2_396m_clk will be enabled.
Thanks.

Shawn
