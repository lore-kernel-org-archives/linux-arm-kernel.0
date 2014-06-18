From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 12:04:04 +0200
Subject: [PATCH v2 09/20] clk: sunxi: Add sun6i MBUS clock support
In-Reply-To: <1403016777-15121-10-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-10-git-send-email-wens@csie.org>
Message-ID: <20140618100404.GM19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:46PM +0800, Chen-Yu Tsai wrote:
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  drivers/clk/sunxi/clk-sunxi.c                     | 44 +++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index b9ec668..7b2ba41 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -40,6 +40,7 @@ Required properties:
>  	"allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
>  	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
>  	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
> +	"allwinner,sun6i-a31-mbus-clk" - for the MBUS clocks on A31 / A23
>  	"allwinner,sun7i-a20-out-clk" - for the external output clocks
>  	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
>  	"allwinner,sun4i-a10-usb-clk" - for usb gates + resets on A10 / A20
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index eca3c6e..a086b5b 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -307,6 +307,37 @@ static void sun4i_get_mod0_factors(u32 *freq, u32 parent_rate,
>  
>  
>  /**
> + * sun6i_a31_get_mbus_factors() - calculates m factor for MBUS clocks
> + * MBUS rate is calculated as follows
> + * rate = parent_rate / (m + 1);
> + */
> +
> +static void sun6i_a31_get_mbus_factors(u32 *freq, u32 parent_rate,
> +				       u8 *n, u8 *k, u8 *m, u8 *p)
> +{
> +	u8 div;
> +
> +	/* These clocks can only divide, so we will never be able to achieve
> +	 * frequencies higher than the parent frequency */
> +	if (*freq > parent_rate)
> +		*freq = parent_rate;
> +
> +	div = DIV_ROUND_UP(parent_rate, *freq);
> +
> +	if (div > 8)
> +		div = 8;
> +
> +	*freq = parent_rate / div;
> +
> +	/* we were called to round the frequency, we can now return */
> +	if (n == NULL)

s/n/m/ ?

> +		return;
> +
> +	*m = div - 1;
> +}
> +
> +
> +/**
>   * sun7i_a20_get_out_factors() - calculates m, p factors for CLK_OUT_A/B
>   * CLK_OUT rate is calculated as follows
>   * rate = (parent_rate >> p) / (m + 1);
> @@ -447,6 +478,11 @@ static struct clk_factors_config sun4i_mod0_config = {
>  	.pwidth = 2,
>  };
>  
> +static struct clk_factors_config sun6i_a31_mbus_config = {
> +	.mshift = 0,
> +	.mwidth = 3,

Actually, the A31 has an extra N factor.

So this mbus clock looks like it's only about the A23, and not the A31
at all.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/38db71cf/attachment-0001.sig>
