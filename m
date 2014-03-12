From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 12 Mar 2014 13:06:48 +0200
Subject: [PATCH] video: atmel_lcdfb: ensure the hardware is initialized
 with the correct mode
In-Reply-To: <1394209254-23797-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1394209254-23797-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53203FC8.7010604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/14 18:20, Antoine T?nart wrote:
> If no driver takeover the atmel_lcdfb, the lcd won't be in a working state
> since atmel_lcdfb_set_par() will never be called. Enabling a driver which does,
> like fbcon, will call the function and put atmel_lcdfb in a working state.
> 
> Fixes: b985172b328a (video: atmel_lcdfb: add device tree suport)
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/video/atmel_lcdfb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index cd96162..b74e5f5d 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -1298,6 +1298,12 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  		goto unregister_irqs;
>  	}
>  
> +	ret = atmel_lcdfb_set_par(info);
> +	if (ret < 0) {
> +		dev_err(dev, "set par failed: %d\n", ret);
> +		goto unregister_irqs;
> +	}
> +
>  	dev_set_drvdata(dev, info);
>  
>  	/*
> 

Thanks, queued for 3.15.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/07cbba94/attachment-0001.sig>
