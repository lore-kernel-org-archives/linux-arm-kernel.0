From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 7 Apr 2017 17:39:11 +0200
Subject: [PATCH v2 2/2] clk: meson: mpll: use 64bit math in
 rate_from_params
In-Reply-To: <20170407153433.18640-3-jbrunet@baylibre.com>
References: <20170407153433.18640-1-jbrunet@baylibre.com>
 <20170407153433.18640-3-jbrunet@baylibre.com>
Message-ID: <182b946b-70db-887e-c107-c01108282969@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2017 05:34 PM, Jerome Brunet wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> On Meson8b the MPLL parent clock (fixed_pll) has a rate of 2550MHz.
> Multiplying this with SDM_DEN results in a value greater than 32bits.
> This is not a problem on the 64bit Meson GX SoCs, but it may result in
> undefined behavior on the older 32bit Meson8b SoC.
> 
> While rate_from_params was only introduced recently to make the math
> reusable from _round_rate and _recalc_rate the original bug exists much
> longer.
> 
> Fixes: 1c50da4f27 ("clk: meson: add mpll support")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> [as discussed on the ml, use DIV_ROUND_UP_ULL]
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/clk-mpll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
> index d9462b505dcc..39eab69fe51a 100644
> --- a/drivers/clk/meson/clk-mpll.c
> +++ b/drivers/clk/meson/clk-mpll.c
> @@ -79,7 +79,7 @@ static long rate_from_params(unsigned long parent_rate,
>  	if (n2 < N2_MIN)
>  		return -EINVAL;
>  
> -	return (parent_rate * SDM_DEN) / divisor;
> +	return DIV_ROUND_UP_ULL((u64)parent_rate * SDM_DEN, divisor);
>  }
>  
>  static void params_from_rate(unsigned long requested_rate,
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
