From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Wed, 27 Apr 2016 10:57:51 +0300
Subject: [RESEND PATCH v2 6/7] usb: xhci: plat: add generic PHY support
In-Reply-To: <1461675460-2295-7-git-send-email-jszhang@marvell.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-7-git-send-email-jszhang@marvell.com>
Message-ID: <20160427075751.GA3540@kuha.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 26, 2016 at 08:57:39PM +0800, Jisheng Zhang wrote:
> @@ -232,22 +265,44 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>  		xhci->shared_hcd->can_do_streams = 1;
>  
> +	hcd->phy = devm_phy_get(&pdev->dev, "usb2-phy");
> +	if (IS_ERR(hcd->phy)) {
> +		ret = PTR_ERR(hcd->phy);
> +		if (ret == -EPROBE_DEFER)
> +			goto put_usb3_hcd;
> +		hcd->phy = NULL;
> +	}
> +
> +	phy = devm_phy_get(&pdev->dev, "usb-phy");

"usb-phy" for what I understand is the USB3 PHY right?

I was unable to find any definition for the phy names for example from
Documentation/devicetree/bindings/usb/usb-xhci.txt, so I would say
this needs to be "usb3-phy" and the phy names need to be defined
somewhere.


Thanks,

-- 
heikki
