From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 2 Dec 2016 15:59:57 +0000
Subject: [PATCH] usb: gadget: udc: atmel: used managed kasprintf
In-Reply-To: <20161201102656.29041-1-alexandre.belloni@free-electrons.com>
References: <20161201102656.29041-1-alexandre.belloni@free-electrons.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0232C0D@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Belloni
> Sent: 01 December 2016 10:27
> Use devm_kasprintf instead of simple kasprintf to free the allocated memory
> when needed.

s/when needed/when the device is freed/

> Suggested-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 45bc997d0711..aec72fe8273c 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -1978,7 +1978,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  			dev_err(&pdev->dev, "of_probe: name error(%d)\n", ret);
>  			goto err;
>  		}
> -		ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", ep->index);
> +		ep->ep.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ep%d",
> +					     ep->index);

Acually why bother mallocing such a small string at all.
The maximum length is 12 bytes even if 'index' are unrestricted.
 
	David
