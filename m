From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 27 Apr 2016 08:35:58 +0300
Subject: [RESEND PATCH v2 6/7] usb: xhci: plat: add generic PHY support
In-Reply-To: <1461675460-2295-7-git-send-email-jszhang@marvell.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-7-git-send-email-jszhang@marvell.com>
Message-ID: <87eg9rpq9t.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Jisheng Zhang <jszhang@marvell.com> writes:
> Marvell BG4CT SoC needs two phy: one for usb2 and another for usb3. Add
> the calls to retrieve generic PHY to xhci plat in order to support this.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/usb/host/xhci-plat.c | 87 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 75 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 83669d0..d7f4f3c 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -16,6 +16,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/usb/phy.h>
> @@ -134,6 +135,37 @@ static const struct of_device_id usb_xhci_of_match[] = {
>  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
>  #endif
>  
> +static int xhci_plat_phy_init(struct usb_hcd *hcd)
> +{
> +	int ret;
> +
> +	if (hcd->phy) {
> +		ret = phy_init(hcd->phy);
> +		if (ret)
> +			return ret;
> +
> +		ret = phy_power_on(hcd->phy);
> +		if (ret) {
> +			phy_exit(hcd->phy);
> +			return ret;
> +		}
> +	} else {
> +		ret = usb_phy_init(hcd->usb_phy);
> +	}
> +
> +	return ret;
> +}
> +
> +static void xhci_plat_phy_exit(struct usb_hcd *hcd)
> +{
> +	if (hcd->phy) {
> +		phy_power_off(hcd->phy);
> +		phy_exit(hcd->phy);
> +	} else {
> +		usb_phy_shutdown(hcd->usb_phy);
> +	}
> +}
> +
>  static int xhci_plat_probe(struct platform_device *pdev)
>  {
>  	struct device_node	*node = pdev->dev.of_node;
> @@ -145,6 +177,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	struct usb_hcd		*hcd;
>  	struct clk              *clk;
>  	struct usb_phy		*usb_phy;
> +	struct phy		*phy;

so, one phy driver using USB PHY layer and another using generic PHY
layer ? Why ? I think the first thing your series should do would be to
add proper suport for both APIs with two PHYs and make them all optional
for xhci-plat.

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
> +	if (IS_ERR(phy)) {
> +		ret = PTR_ERR(phy);
> +		if (ret == -EPROBE_DEFER)
> +			goto put_usb3_hcd;
> +		phy = NULL;
> +	}
> +
>  	usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
>  	if (IS_ERR(usb_phy)) {
>  		ret = PTR_ERR(usb_phy);
>  		if (ret == -EPROBE_DEFER)
>  			goto put_usb3_hcd;
>  		usb_phy = NULL;
> -	} else {
> -		ret = usb_phy_init(usb_phy);
> -		if (ret)
> -			goto put_usb3_hcd;
>  	}
> +
>  	xhci->shared_hcd->usb_phy = usb_phy;
> +	xhci->shared_hcd->phy = phy;
> +
> +	ret = xhci_plat_phy_init(hcd);
> +	if (ret)
> +		goto put_usb3_hcd;
> +
> +	ret = xhci_plat_phy_init(xhci->shared_hcd);
> +	if (ret)
> +		goto disable_usb2_phy;
>  
>  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (ret)
> -		goto disable_usb_phy;
> +		goto disable_usb3_phy;
>  
>  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>  	if (ret)
> @@ -259,8 +314,11 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  dealloc_usb2_hcd:
>  	usb_remove_hcd(hcd);
>  
> -disable_usb_phy:
> -	usb_phy_shutdown(usb_phy);
> +disable_usb3_phy:
> +	xhci_plat_phy_exit(xhci->shared_hcd);
> +
> +disable_usb2_phy:
> +	xhci_plat_phy_exit(hcd);
>  
>  put_usb3_hcd:
>  	usb_put_hcd(xhci->shared_hcd);
> @@ -281,11 +339,11 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	struct clk *clk = xhci->clk;
>  
>  	usb_remove_hcd(xhci->shared_hcd);
> -	usb_phy_shutdown(xhci->shared_hcd->usb_phy);
> -
> -	usb_remove_hcd(hcd);
> +	xhci_plat_phy_exit(xhci->shared_hcd);
>  	usb_put_hcd(xhci->shared_hcd);
>  
> +	usb_remove_hcd(hcd);
> +	xhci_plat_phy_exit(hcd);
>  	clk_disable_unprepare(clk);
>  	usb_put_hcd(hcd);
>  
> @@ -311,7 +369,8 @@ static int xhci_plat_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	usb_phy_shutdown(xhci->shared_hcd->usb_phy);
> +	xhci_plat_phy_exit(xhci->shared_hcd);
> +	xhci_plat_phy_exit(hcd);
>  	clk_disable_unprepare(xhci->clk);
>  
>  	return ret;
> @@ -327,7 +386,11 @@ static int xhci_plat_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = usb_phy_init(xhci->shared_hcd->usb_phy);
> +	ret = xhci_plat_phy_init(hcd);
> +	if (ret)
> +		return ret;
> +
> +	ret = xhci_plat_phy_init(xhci->shared_hcd);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/dadf98da/attachment.sig>
