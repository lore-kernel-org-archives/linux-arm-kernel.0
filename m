From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:14:12 +0200
Subject: [PATCH 02/30] usb: phy: nop: use devm_kzalloc()
In-Reply-To: <1359372631-8180-3-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <1359372631-8180-3-git-send-email-rogerq@ti.com>
Message-ID: <20130205091412.GK32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:03PM +0200, Roger Quadros wrote:
> Use resource managed kzalloc.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---

Acked-by: Felipe Balbi <balbi@ti.com>

>  drivers/usb/otg/nop-usb-xceiv.c |   16 ++++------------
>  1 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
> index a3ce24b..7ffb0c8 100644
> --- a/drivers/usb/otg/nop-usb-xceiv.c
> +++ b/drivers/usb/otg/nop-usb-xceiv.c
> @@ -100,15 +100,13 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>  	enum usb_phy_type	type = USB_PHY_TYPE_USB2;
>  	int err;
>  
> -	nop = kzalloc(sizeof *nop, GFP_KERNEL);
> +	nop = devm_kzalloc(&pdev->dev, sizeof *nop, GFP_KERNEL);
>  	if (!nop)
>  		return -ENOMEM;
>  
> -	nop->phy.otg = kzalloc(sizeof *nop->phy.otg, GFP_KERNEL);
> -	if (!nop->phy.otg) {
> -		kfree(nop);
> +	nop->phy.otg = devm_kzalloc(&pdev->dev, sizeof *nop->phy.otg, GFP_KERNEL);
> +	if (!nop->phy.otg)
>  		return -ENOMEM;
> -	}
>  
>  	if (pdata)
>  		type = pdata->type;
> @@ -127,7 +125,7 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>  	if (err) {
>  		dev_err(&pdev->dev, "can't register transceiver, err: %d\n",
>  			err);
> -		goto exit;
> +		return err;
>  	}
>  
>  	platform_set_drvdata(pdev, nop);
> @@ -135,10 +133,6 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>  	ATOMIC_INIT_NOTIFIER_HEAD(&nop->phy.notifier);
>  
>  	return 0;
> -exit:
> -	kfree(nop->phy.otg);
> -	kfree(nop);
> -	return err;
>  }
>  
>  static int nop_usb_xceiv_remove(struct platform_device *pdev)
> @@ -148,8 +142,6 @@ static int nop_usb_xceiv_remove(struct platform_device *pdev)
>  	usb_remove_phy(&nop->phy);
>  
>  	platform_set_drvdata(pdev, NULL);
> -	kfree(nop->phy.otg);
> -	kfree(nop);
>  
>  	return 0;
>  }
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/8e963b27/attachment.sig>
