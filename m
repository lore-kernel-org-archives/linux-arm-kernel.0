From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Apr 2015 22:29:43 +0800
Subject: [PATCH] ARM: imx: correct Audio/Video PLL rate calculation formula
In-Reply-To: <1429810455-22447-1-git-send-email-b20788@freescale.com>
References: <1429810455-22447-1-git-send-email-b20788@freescale.com>
Message-ID: <20150427142941.GA1788@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 01:34:15AM +0800, Anson Huang wrote:
> The audio/video PLL's rate calculation formula is as below in RM:
> 
> Fref * (DIV_SELECT + NUM / DENOM),
> 
> in original clk-pllv3's code, below code is used:
> 
> (parent_rate * div) + ((parent_rate / mfd) * mfn
> 
> as it does NOT consider the float data using div, so below
> calculation formula should be used as a decent method:
> 
> (parent_rate * div) + ((parent_rate * mfn) / mfd)
> 
> and we also need to consider parent_rate * mfd may exceed
> a 32 bit value, 64 bit value should be used.

Can you provide some real world data (PLL output frequency) to
demonstrate the difference between old and new formula?

Shawn

> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/clk-pllv3.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
> index 641ebc5..f83cf0d 100644
> --- a/arch/arm/mach-imx/clk-pllv3.c
> +++ b/arch/arm/mach-imx/clk-pllv3.c
> @@ -203,8 +203,12 @@ static unsigned long clk_pllv3_av_recalc_rate(struct clk_hw *hw,
>  	u32 mfn = readl_relaxed(pll->base + PLL_NUM_OFFSET);
>  	u32 mfd = readl_relaxed(pll->base + PLL_DENOM_OFFSET);
>  	u32 div = readl_relaxed(pll->base) & pll->div_mask;
> +	u64 temp64 = parent_rate;
>  
> -	return (parent_rate * div) + ((parent_rate / mfd) * mfn);
> +	temp64 *= mfn;
> +	do_div(temp64, mfd);
> +
> +	return (parent_rate * div) + temp64;
>  }
>  
>  static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
> -- 
> 1.9.1
> 
