From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 03 Sep 2012 22:42:04 +0200
Subject: [PATCH 1/4] can: c_can: Adopt pinctrl support
In-Reply-To: <1346673139-14540-2-git-send-email-anilkumar@ti.com>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
 <1346673139-14540-2-git-send-email-anilkumar@ti.com>
Message-ID: <5045161C.4000100@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
> Adopt pinctrl support to c_can driver based on c_can device
> pointer, pinctrl driver configure SoC pins to d_can mode
> according to definitions provided in .dts file.
> 
> In device specific device tree file 'pinctrl-names = "default";'
> and 'pinctrl-0 = <&d_can1_pins>;' needs to add to configure pins
> from c_can driver. d_can1_pins node contains the pinmux/config
> details of d_can L/H pins.

Looks good, is the pinctrl property documented in the dt bindings already?

Marc

> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  drivers/net/can/c_can/c_can_platform.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> index 90801c4..c351975 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -33,6 +33,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <linux/can/dev.h>
>  
> @@ -98,6 +99,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>  	struct c_can_priv *priv;
>  	const struct of_device_id *match;
>  	const struct platform_device_id *id;
> +	struct pinctrl *pinctrl;
>  	struct resource *mem;
>  	int irq;
>  	struct clk *clk;
> @@ -114,6 +116,11 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>  		id = platform_get_device_id(pdev);
>  	}
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev,
> +			"failed to configure pins from driver\n");
> +
>  	/* get the appropriate clk */
>  	clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(clk)) {
> 


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120903/17105472/attachment.sig>
