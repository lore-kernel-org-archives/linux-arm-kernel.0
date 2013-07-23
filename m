From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Jul 2013 15:22:49 +0200
Subject: [PATCH RFC 5/8] clk: sunxi: add PLL5 and PLL6 support
In-Reply-To: <1374541272-32173-6-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
 <1374541272-32173-6-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130723132249.GE10389@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Mon, Jul 22, 2013 at 10:01:09PM -0300, Emilio L?pez wrote:
> This commit implements PLL5 and PLL6 support on the sunxi clock driver.
> These PLLs use a similar factor clock, but differ on their outputs.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
>  drivers/clk/sunxi/clk-sunxi.c                     | 159 +++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 9a28022..6634eac 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -8,6 +8,8 @@ Required properties:
>  - compatible : shall be one of the following:
>  	"allwinner,sun4i-osc-clk" - for a gatable oscillator
>  	"allwinner,sun4i-pll1-clk" - for the main PLL clock as well as PLL4
> +	"allwinner,sun4i-pll5-clk" - for the PLL5 clock
> +	"allwinner,sun4i-pll6-clk" - for the PLL6 clock
>  	"allwinner,sun4i-cpu-clk" - for the CPU multiplexer clock
>  	"allwinner,sun4i-axi-clk" - for the AXI clock
>  	"allwinner,sun4i-axi-gates-clk" - for the AXI gates
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 4dccdb9..743c2c2 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -127,6 +127,38 @@ static void sunxi_get_pll1_factors(u32 *freq, u32 parent_rate,
>  
>  
>  /**
> + * sunxi_get_pll5_factors() - calculates n, k factors for PLL5
> + * PLL5 rate is calculated as follows
> + * rate = parent_rate * n * (k + 1)

In the A10 and A10s datasheet, the given formula is:

for the DDR

rate = parent * n * (k + 1) / (m + 1)

and for the other output

rate = (parent * n * (k + 1)) >> (p + 1)

so it doesn't look very right to me here.

> + * parent_rate is always 24Mhz
> + */
> +
> +static void sunxi_get_pll5_factors(u32 *freq, u32 parent_rate,
> +				   u8 *n, u8 *k, u8 *m, u8 *p)
> +{
> +	u8 div;
> +
> +	/* Normalize value to a 24M multiple */
> +	div = *freq / 24000000;
> +	*freq = 24000000 * div;

And that also means that we can generate frequencies that are not
necessarily multiples of 24MHz, so the round up here is wrong as well.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/ce2aee0b/attachment.sig>
