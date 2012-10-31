From: balbi@ti.com (Felipe Balbi)
Date: Wed, 31 Oct 2012 16:05:48 +0200
Subject: [PATCH v7 2/5] usb: s3c-hsotg: Adding phy driver support
In-Reply-To: <1351573057-22249-3-git-send-email-p.paneri@samsung.com>
References: <1351573057-22249-1-git-send-email-p.paneri@samsung.com>
 <1351573057-22249-3-git-send-email-p.paneri@samsung.com>
Message-ID: <20121031140548.GE10998@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 30, 2012 at 10:27:34AM +0530, Praveen Paneri wrote:
> @@ -3501,20 +3511,27 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
>  	int ret;
>  	int i;
>  
> -	plat = pdev->dev.platform_data;
> -	if (!plat) {
> -		dev_err(&pdev->dev, "no platform data defined\n");
> -		return -EINVAL;
> -	}
> -
>  	hsotg = devm_kzalloc(&pdev->dev, sizeof(struct s3c_hsotg), GFP_KERNEL);
>  	if (!hsotg) {
>  		dev_err(dev, "cannot get memory\n");
>  		return -ENOMEM;
>  	}
>  
> +	plat = pdev->dev.platform_data;
> +	if (!plat) {
> +		/* Fallback for transceiver */
> +		phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +		if (IS_ERR_OR_NULL(phy)) {
> +			dev_err(&pdev->dev, "no platform data or transceiver defined\n");
> +			return -EPROBE_DEFER;
> +		} else {
> +			hsotg->phy = phy;
> +		}
> +	} else {
> +		hsotg->plat = plat;
> +	}

I think this should be the other way around, meaning you try to grab the
phy, if you can't, then you fallback to pdata.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121031/6d31b60c/attachment.sig>
