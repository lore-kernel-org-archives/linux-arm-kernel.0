From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 9 Jan 2014 08:55:26 +0100
Subject: [PATCH] ARM: imx6q: Add missing esai_ahb clock to current clock
 tree
In-Reply-To: <1389236699-10387-1-git-send-email-Guangyu.Chen@freescale.com>
References: <1389236699-10387-1-git-send-email-Guangyu.Chen@freescale.com>
Message-ID: <20140109075525.GO6750@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Added Mike Turquette to Cc]

On Thu, Jan 09, 2014 at 11:04:59AM +0800, Nicolin Chen wrote:
> esai_ahb clock is derived from ahb and used to provide ESAI the capability of
> register accessing and FSYS clock source for I2S clocks dividing. Although the
> gate of this esai_ahb is duplicated with esai clock -- the baud clock, yet
> considering about the differences of their clock rates, it's quite essential
> to patch this missing clock.
> 

[...]

>  static struct clk *clk[clk_max];
> @@ -355,6 +355,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	clk[ecspi5]       = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
>  	clk[enet]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
>  	clk[esai]         = imx_clk_gate2("esai",          "esai_podf",         base + 0x6c, 16);
> +	clk[esai_ahb]     = imx_clk_gate2("esai_ahb",      "ahb",               base + 0x6c, 16);

We have the situation here that a single bit controls two clocks. As
Shawn mentioned just using two gates on the same bit doesn't work
properly. Do we need a new basic clock type or expand the common gate
code somehow?
This situation happens from time to time and I haven't seen a solution
for this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
