From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 16 Nov 2011 14:22:23 +0100
Subject: [PATCH] arm: mx28: check for gated clocks when setting saif
 divider
In-Reply-To: <1315650583-4793-1-git-send-email-w.sang@pengutronix.de>
References: <1315650583-4793-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20111116132222.GD2596@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 10, 2011 at 12:29:43PM +0200, Wolfram Sang wrote:
> Like with all other clocks, the divider for the SAIF devices should not
> be altered when the clock is gated. Bail out when this is the case like
> the other clocks do.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Dong Aisheng-B29396 <B29396@freescale.com>
> ---
> 
> Aisheng: I think this is the correct solution for clock-mx28.c. If setting the
> rate of the saif clocks hit the error path, it should be fixed in the driver?

Ping. Trying to catch up, has this been resolved meanwhile?

> 
>  arch/arm/mach-mxs/clock-mx28.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 63d6117..c9482b5 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -457,6 +457,10 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>  	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
>  	reg &= ~BM_CLKCTRL_##rs##_DIV;					\
>  	reg |= div << BP_CLKCTRL_##rs##_DIV;				\
> +	if (reg & (1 << clk->enable_shift)) {				\
> +		pr_err("%s: clock is gated\n", __func__);		\
> +		return -EINVAL;						\
> +	}								\
>  	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
>  									\
>  	for (i = 10000; i; i--)						\
> -- 
> 1.7.5.4
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111116/a7bcb41c/attachment.sig>
