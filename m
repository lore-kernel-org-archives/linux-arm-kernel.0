From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 23 Jan 2012 22:18:54 +0100
Subject: [PATCH] ARM: mx28: clock-mx28: Use a proper timeout mechanism
In-Reply-To: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
References: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120123211854.GB14133@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

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

Is there a difference in the two versions you sent?

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

I'd remove the jiffy-part of the comment to prevent belief that the
relationship will always be true.

>  static struct clk pll2_clk;
>  static struct clk cpu_clk;
> @@ -127,6 +128,20 @@ static unsigned long pll2_clk_get_rate(struct clk *clk)
>  	return 50000000;
>  }
>  
> +static int mxs_clkctrl_timeout(unsigned int reg_offset, unsigned int mask)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(CLKCTRL_TIMEOUT);
> +	while (readl_relaxed(CLKCTRL_BASE_ADDR + reg_offset) & mask) {

Hmm, this is a lot better, yet not perfect. You could be scheduled away here
for 10ms and then you had only checked at t=0. However, I think it makes more
sense to introduce a generic timeout-loop somehow and then convert to it
later. This is my homework, though...

> +		if (time_after(jiffies, timeout)) {
> +			pr_err("%s: divider writing timeout\n", __func__);

__func__ is probably not useful here. Perhaps reg and mask?

> +			return -ETIMEDOUT;
> +		}
> +

Remove empty line.

> +	}
> +
> +	return 0;
> +}
> +

Rest looked good from a glimpse.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120123/6bdaf43a/attachment.sig>
