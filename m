From: B29397@freescale.com (Chen Peter-B29397)
Date: Mon, 17 Sep 2012 10:08:56 +0000
Subject: [PATCH v3] USB: mxs-phy: add basic otg support
In-Reply-To: <1347872703-15167-1-git-send-email-richard.zhao@freescale.com>
References: <1347872703-15167-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803C8293E@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The purpose for this patch is to have set_peripheral implementation,
but in current chipidea code, we don't need to know gadget at all,
as when id switch occurs, the core code know its role (device or host)
very well, and will call related stop/start function.

We have already many code bind struct otg with struct phy, we'd better
split them at later code.
 
A better approach to fix this problem is to either not call set_peripheral
if both device and host use chipidea driver, or implement otg struct
at chipidea driver.


> Changes from v2:
>  - assign host/gadget in mxs_phy_set_host/mxs_phy_set_peripheral
> 
>  drivers/usb/otg/mxs-phy.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
> index 88db976..3255112 100644
> --- a/drivers/usb/otg/mxs-phy.c
> +++ b/drivers/usb/otg/mxs-phy.c
> @@ -129,12 +129,28 @@ static int mxs_phy_on_disconnect(struct usb_phy
> *phy, int port)
>  	return 0;
>  }
> 
> +static int mxs_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{
> +	otg->host = host;
> +
> +	return 0;
> +}
> +
> +static int mxs_phy_set_peripheral(struct usb_otg *otg,
> +					struct usb_gadget *gadget)
> +{
> +	otg->gadget = gadget;
> +
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
> @@ -171,6 +187,15 @@ static int mxs_phy_probe(struct platform_device
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
>  	platform_set_drvdata(pdev, &mxs_phy->phy);
> 
>  	return 0;
> --
> 1.7.9.5
