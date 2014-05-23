From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 23 May 2014 14:58:52 +0530
Subject: [PATCH 4/5] usb: host: xhci-plat: add optional PHY support
In-Reply-To: <1400257376-13251-4-git-send-email-gregory.clement@free-electrons.com>
References: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
 <1400257376-13251-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <537F14D4.1090705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 16 May 2014 09:52 PM, Gregory CLEMENT wrote:
> This commit extends the xhci-plat so that it can optionally be passed
> a reference to a PHY through the Device Tree. It will be useful for
> the Armada 375 SoCs. If no PHY is provided then the behavior of the
> driver is unchanged.
> 
> As for the clock, to achieve this, it adds a 'struct phy *' member in
> xhci_hcd. While only used for now in xhci-plat, here again, it might
> be used by other drivers in the future.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/usb/host/xhci-plat.c | 29 ++++++++++++++++++++++++++++-
>  drivers/usb/host/xhci.h      |  2 ++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 0f5f4c8f5bf6..34239b582621 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -15,6 +15,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> @@ -94,6 +95,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	struct resource         *res;
>  	struct usb_hcd		*hcd;
>  	struct clk              *clk;
> +	struct phy              *phy;
>  	int			ret;
>  	int			irq;
>  
> @@ -160,9 +162,23 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  			goto unmap_registers;
>  	}
>  
> +	phy = devm_phy_optional_get(&pdev->dev, "usb");
> +	if (IS_ERR(phy)) {
> +		ret = PTR_ERR(phy);
> +		goto disable_clk;
> +	} else {
> +		ret = phy_init(phy);
> +		if (ret)
> +			goto disable_phy;

I think you meant disable_clk here?
> +
> +		ret = phy_power_on(phy);
> +		if (ret)
> +			goto disable_phy;
> +	}
> +
>  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (ret)
> -		goto disable_clk;
> +		goto power_off_phy;
>  
>  	device_wakeup_enable(hcd->self.controller);
>  
> @@ -198,6 +214,12 @@ put_usb3_hcd:
>  dealloc_usb2_hcd:
>  	usb_remove_hcd(hcd);
>  
> +power_off_phy:
> +	if (!IS_ERR(phy))

This check is unnecessary here since you do power_off only if PHY is not error.
> +		phy_power_off(phy);
> +disable_phy:
> +	if (!IS_ERR(phy))

same here..
> +		phy_exit(phy);
>  disable_clk:
>  	if (!IS_ERR(clk))
>  		clk_disable_unprepare(clk);
> @@ -219,6 +241,7 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	struct usb_hcd	*hcd = platform_get_drvdata(dev);
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>  	struct clk *clk = xhci->clk;
> +	struct phy *phy = xhci->phy;
>  
>  	usb_remove_hcd(xhci->shared_hcd);
>  	usb_put_hcd(xhci->shared_hcd);
> @@ -226,6 +249,10 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	usb_remove_hcd(hcd);
>  	if (!IS_ERR(clk))
>  		clk_disable_unprepare(clk);
> +	if (!IS_ERR(phy)) {

same here..

Thanks
Kishon
