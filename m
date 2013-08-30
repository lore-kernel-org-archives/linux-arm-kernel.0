From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 30 Aug 2013 21:00:19 +0200
Subject: [PATCH] cpufreq: imx6q: Fix clock enable balance
In-Reply-To: <20130829140123.GM18729@S2101-09.ap.freescale.net>
References: <1377517716-27470-1-git-send-email-s.hauer@pengutronix.de>
 <20130829140123.GM18729@S2101-09.ap.freescale.net>
Message-ID: <20130830190019.GG30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 10:01:25PM +0800, Shawn Guo wrote:
> On Mon, Aug 26, 2013 at 01:48:36PM +0200, Sascha Hauer wrote:
> > For changing the cpu frequency the i.MX6q has to be switched to some
> > intermediate clock during the PLL reprogramming. The driver tries
> > to be clever to keep the enable count correct but gets it wrong. If
> > the cpufreq is increased it calls clk_disable_unprepare twice
> > on pll2_pfd2_396m. This puts all other devices which get their clock
> > from pll2_pfd2_396m into a nonworking state.
> 
> So you're running into a problem in real?  The clk_disable_unprepare on
> pll2_pfd2_396m below will only be executed when are leaving 396MHz
> set-point.

And that's when my SD card stops working. On my board the SD clock is
derived from pll2_pfd2_396m. I used the userspace cpufreq governor
and scaled down to 396MHz. When I scale up again the SDHC driver times
out while waiting for interrupts. This is because the cpufreq driver
disables the clock twice.

> It's there to balance the clk_prepare_enable on
> pll2_pfd2_396m when we enters 396MHz set-point.
> 
> 	if (freqs.old * 1000 <= clk_get_rate(pll2_pfd2_396m_clk)) {
> 		clk_prepare_enable(pll1_sys_clk);
> 		clk_disable_unprepare(pll2_pfd2_396m_clk);
> 	}
> 
> > 
> > Fix this by removing the clk enabling/disabling altogether since the
> > clk core will do this automatically during a reparent.
> 
> It seems clk core will only enable the parent clock during the
> clk_set_parent() call, and only in case that the child clock is
> prepared.  For example, I do not think pll2_pfd2_396m_clk and step_clk
> will be altered to ON state.  Or am I missing something?
> 

It seems so, yes. Reparenting takes the prepare/enable state
of a clock with it. See __clk_set_parent, it starts with:

	if (clk->prepare_count) {
		__clk_prepare(parent);
		clk_enable(parent);
		clk_enable(clk);
	}

So if the clock to be reparent is enabled then the new parent
gets enabled aswell. And it ends with:

	if (clk->prepare_count) {
		clk_disable(clk);
		clk_disable(old_parent);
		__clk_unprepare(old_parent);
	}

So if the clock is enabled the old parent now decreases its enable
count.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
