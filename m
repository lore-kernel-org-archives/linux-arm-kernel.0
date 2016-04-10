From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 Apr 2016 02:50:06 -0700
Subject: [PATCH 2/3] clk: sunxi: Add sun6i/8i PLL video support
In-Reply-To: <e63499f789971b8c45a0ae5e90bd127371cbcf19.1459358017.git.moinejf@free.fr>
References: <cover.1459358017.git.moinejf@free.fr>
 <e63499f789971b8c45a0ae5e90bd127371cbcf19.1459358017.git.moinejf@free.fr>
Message-ID: <20160410095006.GY4227@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 30, 2016 at 06:50:43PM +0200, Jean-Francois Moine wrote:
> Add the PLL type which is used by the sun6i/8i families for video display.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  drivers/clk/sunxi/clk-sunxi.c                     | 65 +++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 8c0fda8..ff93aee 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -10,6 +10,7 @@ Required properties:
>  	"allwinner,sun4i-a10-pll1-clk" - for the main PLL clock and PLL4
>  	"allwinner,sun6i-a31-pll1-clk" - for the main PLL clock on A31
>  	"allwinner,sun8i-a23-pll1-clk" - for the main PLL clock on A23
> +	"allwinner,sun6i-a31-pll3-clk" - for the video PLL clock
>  	"allwinner,sun9i-a80-pll4-clk" - for the peripheral PLLs on A80
>  	"allwinner,sun4i-a10-pll5-clk" - for the PLL5 clock
>  	"allwinner,sun4i-a10-pll6-clk" - for the PLL6 clock
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 0581e1b..270f2a9 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -23,6 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/log2.h>
> +#include <linux/rational.h>
>  
>  #include "clk-factors.h"
>  
> @@ -1129,6 +1130,70 @@ CLK_OF_DECLARE(sun6i_pll6, "allwinner,sun6i-a31-pll6-clk",
>  	       sun6i_pll6_clk_setup);
>  
>  /*
> + * sun6i pll3
> + *
> + * if (p == 0) rate = k ? 270MHz : 297MHz
> + * else rate = parent_rate / (m + 1) * (n + 1);
> + */
> +static void sun6i_pll3_factors(struct factors_request *req)
> +{
> +	unsigned long n, m;
> +
> +	if (req->rate == 270000000) {
> +		req->m = 0;
> +		req->p = 0;
> +		req->k = 0;
> +	} else if (req->rate == 297000000) {
> +		req->m = 0;
> +		req->p = 0;
> +		req->k = 1;
> +	} else {
> +		rational_best_approximation(req->rate,
> +					req->parent_rate,
> +					1 << 7, 1 << 4, &n, &m);
> +		req->rate = req->parent_rate / m * n;
> +		req->p = 1;
> +		req->m = m - 1;
> +		req->n = n - 1;
> +	}
> +}
> +
> +static void sun6i_pll3_recalc(struct factors_request *req)
> +{
> +	if (req->p)
> +		req->rate = req->parent_rate / (req->m + 1) * (req->n + 1);
> +	else if (req->k)
> +		req->rate = 270000000;
> +	else
> +		req->rate = 297000000;
> +}
> +
> +static const struct clk_factors_config sun6i_pll3_config = {
> +	.mshift = 0,
> +	.mwidth = 4,
> +	.nshift = 8,
> +	.nwidth = 7,
> +	.pshift = 24,	/* mode selection fractional / integer */
> +	.pwidth = 1,
> +	.kshift = 25,	/* fraction 270 / 297 MHz */
> +	.kwidth = 1,
> +};

That's not what p and k are.

Please add extra parameters to deal with fractional rates in the
clk_factors_config (like an extra bit + an array with the two rate
exposed.

That way, you can also deal with it in the core, instead of doing a
hack.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160410/9bcdf800/attachment.sig>
