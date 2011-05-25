From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 May 2011 21:03:47 +0200
Subject: [PATCH 2/4] clk: Implement clk_set_rate
In-Reply-To: <1305876469.326620.351525457111.2.gpush@pororo>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.326620.351525457111.2.gpush@pororo>
Message-ID: <20110525190347.GH22096@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Fri, May 20, 2011 at 03:27:49PM +0800, Jeremy Kerr wrote:
> Implemenent clk_set_rate by adding a set_rate callback to clk_hw_ops,
> and core code to handle propagation of rate changes up and down the
> clock tree.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> +
> +propagate:
> +	ret = clk->ops->set_rate(clk->hw, new_rate, &parent_rate);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/* ops->set_rate may require the parent's rate to change (to
> +	 * parent_rate), we need to propagate the set_rate call to the
> +	 * parent.
> +	 */
> +	if (ret == CLK_SET_RATE_PROPAGATE) {
> +		new_rate = parent_rate;
> +		clk = clk->parent;
> +		goto propagate;
> +	}

I'm unsure about this one. Every clock should have the ability to stop
or continue the rate propagation to the parent. This suggests to leave
the decision whether or not to propagate to the core and not to the
individual clocks.
Right now each mux/div/gate needs an individual propagate flag. By
adding the flag to the core the building block implementations could be
simpler and the knowledge about propagatability might become handy for
the core later.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
