From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 16 Nov 2014 18:02:24 +0100
Subject: [PATCH v3 4/6] clk: sunxi: unify sun6i AHB1 clock with proper
 PLL6 pre-divider
In-Reply-To: <1415815715-31791-5-git-send-email-wens@csie.org>
References: <1415815715-31791-1-git-send-email-wens@csie.org>
 <1415815715-31791-5-git-send-email-wens@csie.org>
Message-ID: <20141116170224.GK6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 13, 2014 at 02:08:33AM +0800, Chen-Yu Tsai wrote:
> This patch unifies the sun6i AHB1 clock, originally supported
> with separate mux and divider clks. It also adds support for
> the pre-divider on the PLL6 input, thus allowing the clock to
> be muxed to PLL6 with proper clock rate calculation.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> This patch produces a warning on of_io_request_and_map complaining
> about dropping the const modifier. I have a separate patch for fixing
> of_io_request_and_map.
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   2 +-
>  drivers/clk/sunxi/clk-sunxi.c                     | 208 ++++++++++++++++++++++
>  2 files changed, 209 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 67b2b99..9dc4f55 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -26,7 +26,7 @@ Required properties:
>  	"allwinner,sun5i-a10s-ahb-gates-clk" - for the AHB gates on A10s
>  	"allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
>  	"allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
> -	"allwinner,sun6i-a31-ahb1-mux-clk" - for the AHB1 multiplexer on A31
> +	"allwinner,sun6i-a31-ahb1-clk" - for the AHB1 clock on A31
>  	"allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
>  	"allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
>  	"allwinner,sun9i-a80-ahb0-gates-clk" - for the AHB0 gates on A80
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 5702025..2bb769f 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_address.h>
>  #include <linux/reset-controller.h>
>  #include <linux/spinlock.h>
> +#include <linux/log2.h>

Why is this needed?

>  #include "clk-factors.h"
>  
> @@ -1233,3 +1234,210 @@ static void __init sun9i_init_clocks(struct device_node *node)
>  	sunxi_init_clocks(NULL, 0);
>  }
>  CLK_OF_DECLARE(sun9i_a80_clk_init, "allwinner,sun9i-a80", sun9i_init_clocks);
> +
> +/**
> + * sun6i_a31_ahb1_clk_setup() - Setup function for a31 ahb1 composite clk
> + */

Why is that added to the A80 clock file ?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141116/34c80e24/attachment.sig>
