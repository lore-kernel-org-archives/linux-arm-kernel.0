From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 12:26:23 +0200
Subject: [PATCH v2 12/20] clk: sunxi: Add A23 APB0 support to
 sun6i-a31-apb0-clk
In-Reply-To: <1403016777-15121-13-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-13-git-send-email-wens@csie.org>
Message-ID: <20140618102623.GQ19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:49PM +0800, Chen-Yu Tsai wrote:
> The A23 has an almost identical PRCM clock tree. The difference in
> the APB0 clock is the smallest divisor is 1, instead of 2.
> 
> This patch extends the sun6i-a31-apb0-clk driver to take divider
> tables associated to compatibles, and adds a compatible for the A23
> variant.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  drivers/clk/sunxi/clk-sun6i-apb0.c                | 28 ++++++++++++++++++-----
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index af9e47d..e3a47ec 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -28,6 +28,7 @@ Required properties:
>  	"allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
>  	"allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
>  	"allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
> +	"allwinner,sun8i-a23-apb0-clk" - for the APB0 clock on A23
>  	"allwinner,sun4i-a10-apb0-gates-clk" - for the APB0 gates on A10
>  	"allwinner,sun5i-a13-apb0-gates-clk" - for the APB0 gates on A13
>  	"allwinner,sun5i-a10s-apb0-gates-clk" - for the APB0 gates on A10s
> diff --git a/drivers/clk/sunxi/clk-sun6i-apb0.c b/drivers/clk/sunxi/clk-sun6i-apb0.c
> index 11f17c3..2197ac7 100644
> --- a/drivers/clk/sunxi/clk-sun6i-apb0.c
> +++ b/drivers/clk/sunxi/clk-sun6i-apb0.c
> @@ -11,6 +11,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  /*
> @@ -28,6 +29,21 @@ static const struct clk_div_table sun6i_a31_apb0_divs[] = {
>  	{ /* sentinel */ },
>  };
>  
> +/* The A23 APB0 clock has a standard power of 2 divisor */

Why not just pass CLK_DIVIDER_POWER_OF_TWO then, instead of a table?

> +static const struct clk_div_table sun8i_a23_apb0_divs[] = {
> +	{ .val = 0, .div = 1, },
> +	{ .val = 1, .div = 2, },
> +	{ .val = 2, .div = 4, },
> +	{ .val = 3, .div = 8, },
> +	{ /* sentinel */ },
> +};
> +
> +const struct of_device_id sun6i_a31_apb0_clk_dt_ids[] = {
> +	{ .compatible = "allwinner,sun6i-a31-apb0-clk", .data = &sun6i_a31_apb0_divs },
> +	{ .compatible = "allwinner,sun8i-a23-apb0-clk", .data = &sun8i_a23_apb0_divs },
> +	{ /* sentinel */ }
> +};
> +
>  static int sun6i_a31_apb0_clk_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -36,12 +52,17 @@ static int sun6i_a31_apb0_clk_probe(struct platform_device *pdev)
>  	struct resource *r;
>  	void __iomem *reg;
>  	struct clk *clk;
> +	const struct of_device_id *device;
>  
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	reg = devm_ioremap_resource(&pdev->dev, r);
>  	if (IS_ERR(reg))
>  		return PTR_ERR(reg);
>  
> +	device = of_match_device(sun6i_a31_apb0_clk_dt_ids, &pdev->dev);
> +	if (!device)
> +		return -EINVAL;
> +
>  	clk_parent = of_clk_get_parent_name(np, 0);
>  	if (!clk_parent)
>  		return -EINVAL;
> @@ -49,7 +70,7 @@ static int sun6i_a31_apb0_clk_probe(struct platform_device *pdev)
>  	of_property_read_string(np, "clock-output-names", &clk_name);
>  
>  	clk = clk_register_divider_table(&pdev->dev, clk_name, clk_parent,
> -					 0, reg, 0, 2, 0, sun6i_a31_apb0_divs,
> +					 0, reg, 0, 2, 0, device->data,

I'm not sure that it will actually work for the A31, since it does
define some dividers anyway, and the divider table is !NULL, even
though there's actually no dividers defined.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/7a467527/attachment.sig>
