From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Dec 2010 10:31:32 +0100
Subject: [patch 1/5] ehci-mxc: Enable vbus later
In-Reply-To: <20101220155810.708379512@rtp-net.org>
References: <20101220154853.254931637@rtp-net.org>
	<20101220155810.708379512@rtp-net.org>
Message-ID: <20101221093132.GZ6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 04:48:54PM +0100, Arnaud Patard wrote:
> vbus should be enabled after usb_add_hcd() otherwise USB is not working
> on my efikamx.

There is really something wrong with the way we handle initialization of
the mxc ehci controller. There are frequently patches posted trying to
change this order, and I think we are at a point where we can't move
anymore without possibly breaking some other board. Should this be
completely board dependend in the end?

Sascha

> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: tst-usb/drivers/usb/host/ehci-mxc.c
> ===================================================================
> --- tst-usb.orig/drivers/usb/host/ehci-mxc.c	2010-12-20 15:38:41.000000000 +0100
> +++ tst-usb/drivers/usb/host/ehci-mxc.c	2010-12-20 15:38:43.000000000 +0100
> @@ -210,11 +210,6 @@
>  			ret = -ENODEV;
>  			goto err_add;
>  		}
> -		ret = otg_set_vbus(pdata->otg, 1);
> -		if (ret) {
> -			dev_err(dev, "unable to enable vbus on transceiver\n");
> -			goto err_add;
> -		}
>  	}
>  
>  	priv->hcd = hcd;
> @@ -224,6 +219,14 @@
>  	if (ret)
>  		goto err_add;
>  
> +	if (pdata->otg) {
> +		ret = otg_set_vbus(pdata->otg, 1);
> +		if (ret) {
> +			dev_err(dev, "unable to enable vbus on transceiver\n");
> +			goto err_add;
> +		}
> +	}
> +
>  	return 0;
>  
>  err_add:
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
