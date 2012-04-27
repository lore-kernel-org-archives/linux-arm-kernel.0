From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 10:04:12 +0200
Subject: [PATCH 09/11] ARM: imx6q: add ssi1 clk_lookup
In-Reply-To: <1335510185-7906-10-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-10-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120427080412.GW17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 03:03:03PM +0800, Richard Zhao wrote:
> It's used by audio drivers.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6q.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index f40a35d..9a03dcc 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -418,6 +418,7 @@ int __init mx6q_clocks_init(void)
>  	clk_register_clkdev(clk[sdma], NULL, "20ec000.sdma");
>  	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
>  	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
> +	clk_register_clkdev(clk[ssi1], NULL, "2028000.ssi");

The ssi clock needs a general cleanup on all i.MX just like I cleaned up
the other units. The SSI unit has at least a register clock and a baud
clock. What the driver requests and enables is the register clock.

The baud clock is currently unused and is needed only for master mode
(which is not implemented in the ssi driver)

So where we want to come to is:

	clk_register_clkdev(clk[ipg], "ipg", "2028000.ssi");
	clk_register_clkdev(clk[ssi1], "baud", "2028000.ssi");

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
