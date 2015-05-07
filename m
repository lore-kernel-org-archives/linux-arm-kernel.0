From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 May 2015 09:25:37 +0200
Subject: [PATCH V2] ARM: imx: correct Audio/Video PLL rate calculation
 formula
In-Reply-To: <1431006970-2864-1-git-send-email-b20788@freescale.com>
References: <1431006970-2864-1-git-send-email-b20788@freescale.com>
Message-ID: <20150507072537.GC12306@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, May 07, 2015 at 09:56:10PM +0800, Anson Huang wrote:
> The audio/video PLL's rate calculation formula is as below in RM:
> 
> Fref * (DIV_SELECT + NUM / DENOM),
> 
> in original clk-pllv3's code, below code is used:
> 
> (parent_rate * div) + ((parent_rate / mfd) * mfn
Here a closing ) is missing

> 
> as it does NOT consider the float data using div, so below
> calculation formula should be used as a decent method:
> 
> (parent_rate * div) + ((parent_rate * mfn) / mfd)
> 
> and we also need to consider parent_rate * mfd may exceed
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
> with old formula, the (parent_rate / mfd) * mfn = 0 with new formula,
> the (parent_rate * mfn) / mfd = 10, so old formula gets
That's wrong. (parent_rate * mfn) / mfd == 10000000.

> PLL_DDR = 1056MHz, new formuls gets PLL_DDR = 1066MHz.
So which one is better? To see this it would be nice to also point out
the exact value here.

Another way to get to a more exact calculation but without a 64 bit
division is using shifted math. The formula gets more difficult though,
so probably not worth the effort.

> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  drivers/clk/imx/clk-pllv3.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index 641ebc5..b2f8893 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -203,8 +203,13 @@ static unsigned long clk_pllv3_av_recalc_rate(struct clk_hw *hw,
>  	u32 mfn = readl_relaxed(pll->base + PLL_NUM_OFFSET);
>  	u32 mfd = readl_relaxed(pll->base + PLL_DENOM_OFFSET);
>  	u32 div = readl_relaxed(pll->base) & pll->div_mask;
> +	s64 temp64 = parent_rate;
Why are you using a signed type here? do_div used unsigned anyhow IIRC.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
