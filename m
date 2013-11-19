From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Nov 2013 13:23:54 -0500
Subject: [PATCH 1/4] clk: keystone: use clkod register bits for postdiv
In-Reply-To: <1384884788-29137-1-git-send-email-m-karicheri2@ti.com>
References: <1384884788-29137-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <528BACBA.4070309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 November 2013 01:13 PM, Murali Karicheri wrote:
> DDR3A/B, ARM and PA PLL controllers have clkod register bits for
> configuring postdiv values. So use it instead of using fixed
> post dividers for these pll controllers. Assume that if fixed-postdiv
> attribute is not present, use clkod register value for pistdiv.
> 
> Also update the Documentation of bindings to reflect the same.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  .../devicetree/bindings/clock/keystone-pll.txt     |    8 +++----
>  drivers/clk/keystone/pll.c                         |   25 ++++++++++++++++----
>  2 files changed, 25 insertions(+), 8 deletions(-)
> 
[..]

> diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
> index 47a1bd9..f59d5db 100644
> --- a/drivers/clk/keystone/pll.c
> +++ b/drivers/clk/keystone/pll.c
> @@ -24,6 +24,8 @@
>  #define MAIN_PLLM_HIGH_MASK	0x7f000
>  #define PLLM_HIGH_SHIFT		6
>  #define PLLD_MASK		0x3f
> +#define CLKOD_MASK		0x780000
> +#define CLKOD_SHIFT		19
>  
>  /**
>   * struct clk_pll_data - pll data structure
> @@ -41,7 +43,10 @@
>   * @pllm_upper_mask: multiplier upper mask
>   * @pllm_upper_shift: multiplier upper shift
>   * @plld_mask: divider mask
> - * @postdiv: Post divider
> + * @clkod_mask: output divider mask
> + * @clkod_shift: output divider shift
> + * @plld_mask: divider mask
> + * @postdiv: Fixed post divider
>   */
>  struct clk_pll_data {
>  	bool has_pllctrl;
> @@ -53,6 +58,8 @@ struct clk_pll_data {
>  	u32 pllm_upper_mask;
>  	u32 pllm_upper_shift;
>  	u32 plld_mask;
> +	u32 clkod_mask;
> +	u32 clkod_shift;
>  	u32 postdiv;
>  };
>  
> @@ -87,10 +94,17 @@ static unsigned long clk_pllclk_recalc(struct clk_hw *hw,
>  
>  	/* bit6-12 of PLLM is in Main PLL control register */
>  	val = readl(pll_data->pll_ctl0);
> +
Drop that extra line. Other than that patch looks fine to me.

Regards,
Santosh
