From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 08 Mar 2013 18:37:40 +0100
Subject: [PATCH 2/3] can: at91_can: add pinctrl support
In-Reply-To: <1362763842-14924-3-git-send-email-ludovic.desroches@atmel.com>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <513A21E4.6000801@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 06:30 PM, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/net/can/at91_can.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index c7f70d4..56fb2aa 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -28,6 +28,7 @@
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/skbuff.h>
> @@ -1292,6 +1293,7 @@ static int at91_can_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	void __iomem *addr;
>  	int err, irq;
> +	struct pinctrl *pinctrl;
>  
>  	devtype_data = at91_can_get_driver_data(pdev);
>  	if (!devtype_data) {
> @@ -1314,6 +1316,13 @@ static int at91_can_probe(struct platform_device *pdev)
>  		goto exit_put;
>  	}
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);

Is this still needed? I think the pinctrl framework automatically
enables the default pinctrl for a device if available.

Marc

> +	if (IS_ERR(pinctrl)) {
> +		dev_err(&pdev->dev, "Failed to request pinctrl\n");
> +		err = PTR_ERR(pinctrl);
> +		goto exit_put;
> +	}
> +
>  	if (!request_mem_region(res->start,
>  				resource_size(res),
>  				pdev->name)) {
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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/43b96b2f/attachment.sig>
