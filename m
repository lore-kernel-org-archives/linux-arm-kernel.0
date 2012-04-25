From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 09:17:47 +0200
Subject: [PATCH 3/8] clk: mxs: add clock support for imx28
In-Reply-To: <1335023840-1394-4-git-send-email-shawn.guo@linaro.org>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
 <1335023840-1394-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120425071747.GX20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

I realized that you have no register lock which means that you rely on
the locking of the clock framework. This may not be sufficient, see the
following example:

> +	mxs_clk_div("ssp0_div", "ssp0_sel", SSP0, 0, 9, 29);
> +	clk = mxs_clk_gate("ssp0", "ssp0_div", SSP0, 31);

You have both a divider and a gate in the same register here. The gate
implements clk_enable which is protected by a spinlock in the clock
framework. The divider implements clk_set_rate which is protected by a
mutex in the clock framework. This means that during a read-modify-write
operation for a rate change the clk_enable call can come in between.

Ok, here we have two clocks which are both handled by a single driver,
so there probably won't be any real problems, but do you want to rely on
this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
