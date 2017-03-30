From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 30 Mar 2017 13:38:34 +0300
Subject: [PATCH linux-next v2 1/4] usb: gadget: udc: atmel: Check fifo
 configuration values against device tree
In-Reply-To: <4b91a4973e19a5b7ac05d5e0f5b4dcc8cffb75cf.1490715349.git.cristian.birsan@microchip.com>
References: <cover.1490715349.git.cristian.birsan@microchip.com>
 <4b91a4973e19a5b7ac05d5e0f5b4dcc8cffb75cf.1490715349.git.cristian.birsan@microchip.com>
Message-ID: <87fuhvjbh1.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

cristian.birsan at microchip.com writes:
> From: Cristian Birsan <cristian.birsan@microchip.com>
>
> Check fifo configuration values against device tree values for endpoint fifo
> in auto configuration mode (fifo_mode=0).
>
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 2035906b..3fd43fb 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -2118,14 +2118,34 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  			dev_err(&pdev->dev, "of_probe: fifo-size error(%d)\n", ret);
>  			goto err;
>  		}
> -		ep->fifo_size = fifo_mode ? udc->fifo_cfg[i].fifo_size : val;
> +		if (fifo_mode) {
> +			if (val < udc->fifo_cfg[i].fifo_size) {
> +				dev_warn(&pdev->dev,
> +					 "of_probe: fifo-size table value not supported by HW, using DT value\n");

114 characters long. Is this even worth a warning? probably not.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170330/354868fe/attachment-0001.sig>
