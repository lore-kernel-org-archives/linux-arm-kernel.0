From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Jan 2012 20:28:07 +0800
Subject: [PATCH] ARM: mx28: clock-mx28: Use a proper timeout mechanism
In-Reply-To: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
References: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120126122805.GC3523@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 12:41:07PM -0200, Fabio Estevam wrote:
> Introduce a function for checking the busy bits of CLKCTRL register that 
> uses a proper timeout mechanism.
> 
> Remove parts of code that use busy loops and replace them with the 
> mxs_clkctrl_timeout() function.
> 
> Tested on a mx28evk by performing audio playback.
> 
> Suggested-by: Wolfram Sang <w.sang@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mxs/clock-mx28.c |   64 +++++++++++++---------------------------
>  1 files changed, 21 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 5d68e41..ad5482d 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -38,6 +38,7 @@
>  #define DIGCTRL_BASE_ADDR	MX28_IO_ADDRESS(MX28_DIGCTL_BASE_ADDR)
>  
>  #define PARENT_RATE_SHIFT	8
> +#define CLKCTRL_TIMEOUT		10	/* 10 ms = 1 jiffy */
>  
>  static struct clk pll2_clk;
>  static struct clk cpu_clk;
> @@ -127,6 +128,20 @@ static unsigned long pll2_clk_get_rate(struct clk *clk)
>  	return 50000000;
>  }
>  
> +static int mxs_clkctrl_timeout(unsigned int reg_offset, unsigned int mask)

Name it mxs_clkctrl_divider_timeout to be more precise?

As the function name indicates, it's not a mx28 specific call, and
should be put in some place common to mx23 and mx28, so that
the divider timeout code in clock-mx23.c can also be fixed up.  (Yes,
I would expect the patch fixes mx23 as well.)

> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(CLKCTRL_TIMEOUT);
> +	while (readl_relaxed(CLKCTRL_BASE_ADDR + reg_offset) & mask) {
> +		if (time_after(jiffies, timeout)) {
> +			pr_err("%s: divider writing timeout\n", __func__);
> +			return -ETIMEDOUT;
> +		}
> +
Unnecessary blank line.

Regards,
Shawn

> +	}
> +
> +	return 0;
> +}
