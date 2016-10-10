From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 10 Oct 2016 15:54:54 +0200
Subject: [PATCH v2 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <4e8696869cc82443825a590966bbd3a265befdfa.1476092427.git.emil@limesaudio.com>
References: <cover.1476092427.git.emil@limesaudio.com>
 <4e8696869cc82443825a590966bbd3a265befdfa.1476092427.git.emil@limesaudio.com>
Message-ID: <20161010135454.a6t46o4ocpwjmkwi@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 12:03:05PM +0200, Emil Lundmark wrote:
> Since 'parent_rate * mfn' may overflow 32 bits, the result should be
> stored using 64 bits.
> 
> Fixes: ba7f4f557eb6 ("clk: imx: correct AV PLL rate formula")
> Signed-off-by: Emil Lundmark <emil@limesaudio.com>
> ---
>  drivers/clk/imx/clk-pllv3.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index 19f9b622981a..bc7f163ea13c 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -247,7 +247,11 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
>  	do_div(temp64, parent_rate);
>  	mfn = temp64;
>  
> -	return parent_rate * div + parent_rate * mfn / mfd;
> +	temp64 = (u64)parent_rate;
> +	temp64 *= mfn;
> +	do_div(temp64, mfd);

If you change parent_rate from unsigned long to u64 this simplifies to

	temp64 = parent_rate * mfn
	do_div(temp64, mfd);

> +
> +	return parent_rate * div + (u32)temp64;

When thinking about overflow problems: Should this fail somehow if
temp64 != (u32)temp64?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
