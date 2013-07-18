From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Jul 2013 10:36:03 +0200
Subject: [PATCH 4/4] ARM: imx6q: remove board specific CLKO setup
In-Reply-To: <1374132670-791-5-git-send-email-shawn.guo@linaro.org>
References: <1374132670-791-1-git-send-email-shawn.guo@linaro.org>
 <1374132670-791-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130718083603.GK10380@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 03:31:10PM +0800, Shawn Guo wrote:
> The CLKO is widely used by imx6q board designs to clock audio codec.
> Since most codecs accept 24 MHz frequency, let's initially set up CLKO
> with OSC24M (cko <-- cko2 <-- osc).  Then those board specific CLKO
> setup for audio codec can be removed.
> 
> The board dts files also need an update on cko reference in codec node.
> 
> +	/*
> +	 * Let's initially set up CLKO with OSC24M, since this configuration
> +	 * is widely used by imx6q board designs to clock audio codec.
> +	 */
> +	ret = clk_set_parent(clk[cko2_sel], clk[osc]);
> +	if (!ret)
> +		ret = clk_set_parent(clk[cko], clk[cko2]);
> +	if (ret)
> +		pr_warn("failed to set up CLKO: %d\n", ret);


I don't really like that the clock setup code fiddles with clocks it has
no knowledge about just because it happens to be correct for several
boards.

I currently have no example where this bites me, so I think I can live
with it for now. I just wonder what I should do when this clock is used
for something vital to the system (clocking an FPGA for example?).

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
