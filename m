From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Jul 2012 21:35:56 +0800
Subject: [PATCH] clk: mxs: imx28: decrease the frequency of ref_io1 for
 SSP2 and SSP3
In-Reply-To: <1341398994-28028-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1341398994-28028-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <20120704133554.GB2595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 01:49:54PM +0300, Lauri Hintsala wrote:
> SSP0 and SSP1 use ref_io0 which has decreased frequency. Expand
> the frequency fix for ref_io1 to get SSP2 and SSP3 to work.
> 
The patch looks okay.  Just to confirm that you are running SSP2&SSP3
into the same frequency problem that we had with SSP0&SSP1?  I never
got a board to verify that for SSP2&SSP3.

Regards,
Shawn

> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> ---
>  drivers/clk/mxs/clk-imx28.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index 2826a26..0097c3a 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -112,11 +112,11 @@ static void __init clk_misc_init(void)
>  
>  	/*
>  	 * 480 MHz seems too high to be ssp clock source directly,
> -	 * so set frac0 to get a 288 MHz ref_io0.
> +	 * so set frac0 to get a 288 MHz ref_io0 and ref_io1.
>  	 */
>  	val = readl_relaxed(FRAC0);
> -	val &= ~(0x3f << BP_FRAC0_IO0FRAC);
> -	val |= 30 << BP_FRAC0_IO0FRAC;
> +	val &= ~((0x3f << BP_FRAC0_IO0FRAC) | (0x3f << BP_FRAC0_IO1FRAC));
> +	val |= (30 << BP_FRAC0_IO0FRAC) | (30 << BP_FRAC0_IO1FRAC);
>  	writel_relaxed(val, FRAC0);
>  }
>  
> -- 
> 1.7.9.5
> 
