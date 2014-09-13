From: emilio@elopez.com.ar (=?windows-1252?Q?Emilio_L=F3pez?=)
Date: Sat, 13 Sep 2014 11:43:46 -0300
Subject: [PATCH 1/7] clk: sunxi: Add post clk divider for factor clocks
In-Reply-To: <1410000448-9999-2-git-send-email-wens@csie.org>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-2-git-send-email-wens@csie.org>
Message-ID: <54145822.4020607@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 06/09/14 a las 07:47, Chen-Yu Tsai escibi?:
> Some factor clocks, mostly PLLs, have an extra fixed divider just before
> the clock output. Add an option to the factor clk driver config data to
> specify this divider.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>   drivers/clk/sunxi/clk-factors.c | 3 +++
>   drivers/clk/sunxi/clk-factors.h | 1 +
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
> index 2057c8a..435111d 100644
> --- a/drivers/clk/sunxi/clk-factors.c
> +++ b/drivers/clk/sunxi/clk-factors.c
> @@ -64,6 +64,9 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
>   	/* Calculate the rate */
>   	rate = (parent_rate * (n + config->n_start) * (k + 1) >> p) / (m + 1);
>
> +	if (config->post_div)
> +		rate /= config->post_div;
> +
>   	return rate;
>   }
>
> diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
> index d2d0efa..ce70c65 100644
> --- a/drivers/clk/sunxi/clk-factors.h
> +++ b/drivers/clk/sunxi/clk-factors.h
> @@ -16,6 +16,7 @@ struct clk_factors_config {
>   	u8 pshift;
>   	u8 pwidth;
>   	u8 n_start;
> +	u8 post_div;
>   };
>
>   struct clk_factors {
>

For the record, I liked your solution on[1] more, as it's in line with 
what we're doing on the other sunxi platforms, instead of adding 
features in factors to cover for some cases. But it's your and Maxime's 
call, as I haven't written any of the sun6i code so far.

Cheers!

Emilio

[1] https://patchwork.kernel.org/patch/4228541/
