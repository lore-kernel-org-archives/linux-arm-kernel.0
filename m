From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 May 2015 09:18:11 +0200
Subject: [PATCH V5] ARM: imx: correct Audio/Video PLL rate calculation
 formula
In-Reply-To: <1431084329-10579-1-git-send-email-b20788@freescale.com>
References: <1431084329-10579-1-git-send-email-b20788@freescale.com>
Message-ID: <20150508071811.GH12671@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, May 08, 2015 at 07:25:29PM +0800, Anson Huang wrote:
> The audio/video PLL's rate calculation formula is as below in RM:
> 
> Fref * (DIV_SELECT + NUM / DENOM),
> 
> in original clk-pllv3's code, below code is used:
> 
> (parent_rate * div) + ((parent_rate / mfd) * mfn)
> 
> as it does NOT consider the non-integer part of division,
> so below calculation formula should be better used instead:
> 
> (parent_rate * div) + ((parent_rate * mfn) / mfd)
> 
> and we also need to consider parent_rate * mfd may overflow
> a 32 bit value, 64 bit value should be used.
> 
> Below is one example of old/new formula's difference:
> 
> On i.MX7D, DRAM PLL is a Audio/Video type PLL, the target freq
> is 1066MHz, the register settings are as below:
> 
> PLL_DDRn: 8060202C   -> div = 0x2C
> DDR_NUM: 06AAAC4D    -> mfn = 0x6AAAC4D
> DDR_DENOM: 100003EC  -> mfd = 0x100003EC
> 
> parent_rate = 24MHz.
> 
> with old formula, the (parent_rate / mfd) * mfn = 0, with new formula,
> the (parent_rate * mfn) / mfd = 10MHz, so old formula gets
> PLL_DDR = 1056MHz, while the updated formula gets PLL_DDR = 1066MHz
> which exactly matches the real rate.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  drivers/clk/imx/clk-pllv3.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index 641ebc5..652af4d 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -203,8 +203,13 @@ static unsigned long clk_pllv3_av_recalc_rate(struct clk_hw *hw,
>  	u32 mfn = readl_relaxed(pll->base + PLL_NUM_OFFSET);
>  	u32 mfd = readl_relaxed(pll->base + PLL_DENOM_OFFSET);
>  	u32 div = readl_relaxed(pll->base) & pll->div_mask;
> +	u64 temp64 = parent_rate;
> +
> +	temp64 *= mfn;
> +	do_div(temp64, mfd);
> +
> +	return (parent_rate * div) + temp64;
unnecessary parenthesis

>  
Please drop this empty line.

> -	return (parent_rate * div) + ((parent_rate / mfd) * mfn);
>  }
>  
>  static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
> @@ -228,7 +233,10 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
>  	do_div(temp64, parent_rate);
>  	mfn = temp64;
Shawn, also what is above here is suboptimal (quoted using }):

}        div = rate / parent_rate;
}        temp64 = (u64) (rate - div * parent_rate);
That's equivalent to:
	temp64 = rate % parent_rate;

If you want to save the possible additional division, at least point
this out in a comment.

}        temp64 *= mfd;
}        do_div(temp64, parent_rate);
}        mfn = temp64;
For the example from Anson's commit log (rate = 1066000000, parent_rate
= 24000000) you calculate

	div = 0x2c
	mfn = 416666
	mfd = 1000000

yielding a rate of 1065999984 Hz. Using
do_div(temp64 + parent_rate / 2, parent_rate) instead would make mfn
bigger by one yielding 1066000008.0 which results in a better
approximation. I guess using rational_best_approximation would result in
a still better approximation, probably even finding the optimal match.

>  
> -	return parent_rate * div + parent_rate / mfd * mfn;
> +	temp64 = parent_rate * mfn;
This is wrong, both parent_rate and mfn are 32 bit unsigned integers
(unsigned long and u32) respectively. So this might well overflow.


> +	do_div(temp64, mfd);
> +
> +	return parent_rate * div + temp64;
>  }

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
