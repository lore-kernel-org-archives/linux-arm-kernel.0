From: daniel@zonque.org (Daniel Mack)
Date: Thu, 06 Nov 2014 07:47:11 +0100
Subject: [PATCH] usb: gadget: udc: pxa27x: fix build warning when !OF
In-Reply-To: <1415249759-6219-1-git-send-email-balbi@ti.com>
References: <1415249759-6219-1-git-send-email-balbi@ti.com>
Message-ID: <545B196F.2020303@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2014 05:55 AM, Felipe Balbi wrote:
> in case kernel is built without CONFIG_OF there
> will be a build warning (see below) due to of_match_ptr()
> being defined to NULL.
> 
> Because of_match_ptr() is pretty pointless anyway,
> let's just remove it and fix the warning.

The alternative, of course, would be to wrap the udc_pxa_dt_ids
declaration in IS_ENABLED(CONFIG_OF), but I'm not sure whether it's
worth it.


Daniel

> drivers/usb/gadget/udc/pxa27x_udc.c:2403:28: warning: ?udc_pxa_dt_ids? defined but not used [-Wunused-variable]
>  static struct of_device_id udc_pxa_dt_ids[] = {
>                             ^
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/gadget/udc/pxa27x_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
> index 69e7b816..d1d8a9f 100644
> --- a/drivers/usb/gadget/udc/pxa27x_udc.c
> +++ b/drivers/usb/gadget/udc/pxa27x_udc.c
> @@ -2590,7 +2590,7 @@ static struct platform_driver udc_driver = {
>  	.driver		= {
>  		.name	= "pxa27x-udc",
>  		.owner	= THIS_MODULE,
> -		.of_match_table = of_match_ptr(udc_pxa_dt_ids),
> +		.of_match_table = udc_pxa_dt_ids,
>  	},
>  	.probe		= pxa_udc_probe,
>  	.remove		= pxa_udc_remove,
> 
