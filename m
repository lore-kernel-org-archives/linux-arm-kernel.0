From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 4 Apr 2011 22:18:19 +0800
Subject: [PATCH] ARM: mxs/clock-mx28: fix up name##_set_rate
In-Reply-To: <1301926324-9659-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110225084950.GA13684@S2101-09.ap.freescale.net>
	<1301926324-9659-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110404141818.GA27933@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 04:12:04PM +0200, Uwe Kleine-K?nig wrote:
> For the lcdif clock get_rate looks as follows:
> 
> 	read div from HW_CLKCTRL_DIS_LCDIF.DIV
> 	return clk_get_rate(clk->parent) / div
> 
> with clk->parent being ref_pix_clk on my system.
> 
> ref_pix_clk's rate depends on HW_CLKCTRL_FRAC1.PIXFRAC.
> 
> The set_rate function for lcdif does:
> 
> 	parent_rate = clk_get_rate(clk->parent);
> 	based on that calculate frac and div such that
> 	  parent_rate * 18 / frac / div is near the requested rate.
> 	HW_CLKCTRL_FRAC1.PIXFRAC is updated with frac
> 	HW_CLKCTRL_DIS_LCDIF.DIV is updated with div
> 
> For this calculation to be correct parent_rate needs to be
> initialized not with the clock rate of lcdif's parent (i.e. ref_pix) but
> that of its grandparent (i.e. ref_pix' parent == pll0_clk).
> 
> The obvious downside of this patch is that now set_rate(lcdif) changes
> its parent's rate, too.  Still this is better than a wrong rate.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@freescale.com>

-- 
Regards,
Shawn
