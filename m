From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 11:42:51 +0200
Subject: [PATCH v2 05/20] clk: sunxi: Support factor clocks with N
 multiplier factor starting from 1
In-Reply-To: <1403016777-15121-6-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-6-git-send-email-wens@csie.org>
Message-ID: <20140618094251.GK19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:42PM +0800, Chen-Yu Tsai wrote:
> The PLLs on newer Allwinner SoC's, such as the A31 and A23, have a
> N multiplier factor that starts from 1, not 0.
> 
> This patch adds an option to the clock driver's config data structures
> to define the difference.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi/clk-factors.c | 5 ++++-
>  drivers/clk/sunxi/clk-factors.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
> index 3806d97..399cf4d 100644
> --- a/drivers/clk/sunxi/clk-factors.c
> +++ b/drivers/clk/sunxi/clk-factors.c
> @@ -62,7 +62,10 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
>  		p = FACTOR_GET(config->pshift, config->pwidth, reg);
>  
>  	/* Calculate the rate */
> -	rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
> +	if (config->n_from_one)
> +		rate = (parent_rate * (n + 1) * (k + 1) >> p) / (m + 1);
> +	else
> +		rate = (parent_rate * n * (k + 1) >> p) / (m + 1);

Thinking a bit more about this, I wonder wether it wouldn't be better
to just have a n_start variable or something, and just use (n +
n_start) instead.

That would avoid having to declare twice the same function.

Maxime

>  
>  	return rate;
>  }
> diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
> index 02e1a43..0484a48 100644
> --- a/drivers/clk/sunxi/clk-factors.h
> +++ b/drivers/clk/sunxi/clk-factors.h
> @@ -15,6 +15,7 @@ struct clk_factors_config {
>  	u8 mwidth;
>  	u8 pshift;
>  	u8 pwidth;
> +	u8 n_from_one;

Especially when you declare it as an u8, and not a bool.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/0591a81f/attachment.sig>
