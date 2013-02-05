From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:25:54 +0200
Subject: [PATCH 09/30] USB: ehci-omap: Use devm_request_and_ioremap()
In-Reply-To: <1359372631-8180-10-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <1359372631-8180-10-git-send-email-rogerq@ti.com>
Message-ID: <20130205092554.GR32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:10PM +0200, Roger Quadros wrote:
> Make use of devm_request_and_ioremap() and correct comment.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/host/ehci-omap.c |   19 +++++--------------
>  1 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 30fc482..fd2f5450 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -216,23 +216,17 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  
>  	res =  platform_get_resource_byname(pdev,
>  				IORESOURCE_MEM, "ehci");
> -	if (!res) {
> -		dev_err(dev, "UHH EHCI get resource failed\n");
> -		return -ENODEV;
> -	}
> -
> -	regs = ioremap(res->start, resource_size(res));
> +	regs = devm_request_and_ioremap(dev, res);
>  	if (!regs) {
> -		dev_err(dev, "UHH EHCI ioremap failed\n");
> -		return -ENOMEM;
> +		dev_err(dev, "Resource request/ioremap failed\n");
> +		return -EADDRNOTAVAIL;
>  	}
>  
>  	hcd = usb_create_hcd(&ehci_omap_hc_driver, dev,
>  			dev_name(dev));
>  	if (!hcd) {
> -		dev_err(dev, "failed to create hcd with err %d\n", ret);
> -		ret = -ENOMEM;
> -		goto err_io;
> +		dev_err(dev, "Failed to create HCD\n");
> +		return -ENOMEM;
>  	}
>  
>  	hcd->rsrc_start = res->start;
> @@ -285,8 +279,6 @@ err_pm_runtime:
>  	pm_runtime_put_sync(dev);
>  	usb_put_hcd(hcd);
>  
> -err_io:
> -	iounmap(regs);
>  	return ret;
>  }
>  
> @@ -306,7 +298,6 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
>  
>  	usb_remove_hcd(hcd);
>  	disable_put_regulator(dev->platform_data);
> -	iounmap(hcd->regs);
>  	usb_put_hcd(hcd);
>  
>  	pm_runtime_put_sync(dev);
> -- 
> 1.7.4.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/9143afeb/attachment.sig>
