From: balbi@ti.com (Felipe Balbi)
Date: Tue, 11 Sep 2012 12:05:18 +0300
Subject: [PATCH v2 06/11] USB: mxs-phy: add basic otg support
In-Reply-To: <1346137397-32374-7-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-7-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120911090516.GA18693@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 28, 2012 at 03:03:12PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

if you add a commit log you can add my:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/otg/mxs-phy.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
> index c1a67cb..6a03e97 100644
> --- a/drivers/usb/otg/mxs-phy.c
> +++ b/drivers/usb/otg/mxs-phy.c
> @@ -97,12 +97,24 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy, int port)
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
> @@ -139,6 +151,15 @@ static int mxs_phy_probe(struct platform_device *pdev)
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
> 
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/5fda1de8/attachment.sig>
