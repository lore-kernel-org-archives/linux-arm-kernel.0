From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 22 May 2015 11:28:33 +0900
Subject: [PATCH] extcon: fix phy-tahvo driver for extcon API change
In-Reply-To: <4940971.fmN098LqHi@wuerfel>
References: <4940971.fmN098LqHi@wuerfel>
Message-ID: <555E9451.2010504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Felipe,

If you review this patch, I'll apply it on extcon tree.

Best Regards,
Chanwoo Choi

On 05/21/2015 06:39 PM, Arnd Bergmann wrote:
> Today, the API for the extcon drivers was changed, along
> with all drivers in drivers/extcon. However, one extcon driver
> instead lives in drivers/usb/phy/ and did not get change.
> 
> Gcc warns about the now incorrect API usage:
> 
> drivers/usb/phy/phy-tahvo.c: In function 'tahvo_usb_probe':
> drivers/usb/phy/phy-tahvo.c:368:29: warning: assignment from incompatible pointer type [-Wincompatible-pointer-types]
>   tu->extcon.supported_cable = tahvo_cable;
> 
> This changes the API in the same way as the other drivers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 17cd440c9acc ("extcon: Update the prototype of extcon_register_notifier() with enum extcon")
> ---
> As the API change is only present in the extcon tree, this patch should get
> merged there as well, not in the usb-phy tree.
> 
> If possible, please fold into the original commit.
> 
> diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
> index 845f658276b1..1d1bb9ad8ccf 100644
> --- a/drivers/usb/phy/phy-tahvo.c
> +++ b/drivers/usb/phy/phy-tahvo.c
> @@ -60,10 +60,11 @@ struct tahvo_usb {
>  	struct extcon_dev	extcon;
>  };
>  
> -static const char *tahvo_cable[] = {
> -	"USB-HOST",
> -	"USB",
> -	NULL,
> +static const enum extcon tahvo_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +
> +	EXTCON_NONE,
>  };
>  
>  static ssize_t vbus_state_show(struct device *device,
> 
> 
