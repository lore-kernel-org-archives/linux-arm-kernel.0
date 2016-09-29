From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 29 Sep 2016 16:18:38 -0700
Subject: [PATCH] clk: bcm2835: Clamp the PLL's requested rate to the
 hardware limits.
In-Reply-To: <20160929022334.25537-1-eric@anholt.net>
References: <20160929022334.25537-1-eric@anholt.net>
Message-ID: <20160929231838.GC940@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28, Eric Anholt wrote:
> Fixes setting low-resolution video modes on HDMI.  Now the PLLH_PIX
> divider adjusts itself until the PLLH is within bounds.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 7a7970865c2d..fedc88908e61 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -499,8 +499,13 @@ static long bcm2835_pll_rate_from_divisors(unsigned long parent_rate,
>  static long bcm2835_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  				   unsigned long *parent_rate)
>  {
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	const struct bcm2835_pll_data *data = pll->data;
>  	u32 ndiv, fdiv;
>  
> +	rate = max(data->min_rate, rate);
> +	rate = min(data->max_rate, rate);

clamp() instead?

I wonder if it's worthwhile to do this through clk rate
constraints instead. That's another topic though so this patch is
fine for now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
