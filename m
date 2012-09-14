From: B29397@freescale.com (Chen Peter-B29397)
Date: Fri, 14 Sep 2012 08:56:13 +0000
Subject: [PATCH v2 06/11] USB: mxs-phy: add basic otg support
In-Reply-To: <1346137397-32374-7-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-7-git-send-email-richard.zhao@freescale.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803C81A63@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
> index c1a67cb..6a03e97 100644
> --- a/drivers/usb/otg/mxs-phy.c
> +++ b/drivers/usb/otg/mxs-phy.c
> @@ -97,12 +97,24 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy,
> int port)
>  	return 0;
>  }
> 
> +static int mxs_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{
> +	return 0;
> +}
> +
> +static int mxs_phy_set_peripheral(struct usb_otg *otg,
> +					struct usb_gadget *gadget)
> +{
> +	return 0;
> +}
> +
>  static int mxs_phy_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	void __iomem *base;
>  	struct clk *clk;
>  	struct mxs_phy *mxs_phy;
> +	struct usb_otg *otg;
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> @@ -139,6 +151,15 @@ static int mxs_phy_probe(struct platform_device
> *pdev)
> 
>  	mxs_phy->clk = clk;
> 
> +	otg = devm_kzalloc(&pdev->dev, sizeof(struct usb_otg), GFP_KERNEL);
> +	if (!otg)
> +		return -ENOMEM;
> +	otg->phy = &mxs_phy->phy;
> +	otg->set_host = mxs_phy_set_host;
> +	otg->set_peripheral = mxs_phy_set_peripheral;
> +
> +	mxs_phy->phy.otg = otg;
> +

Put otg struct at PHY driver is not a good practice.
Only OTG driver who handles ID interrupt cases about host and gadget struct.
PHY is a transceiver, it not cares otg, host and device at all.

>  	platform_set_drvdata(pdev, &mxs_phy->phy);
> 
>  	return 0;
> --
> 1.7.9.5
