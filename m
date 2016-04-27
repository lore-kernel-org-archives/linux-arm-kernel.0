From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 27 Apr 2016 08:29:34 +0300
Subject: [RESEND PATCH v2 2/7] usb: xhci: plat: attach the usb_phy to the
 correct hcd
In-Reply-To: <1461675460-2295-3-git-send-email-jszhang@marvell.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-3-git-send-email-jszhang@marvell.com>
Message-ID: <87potbpqkh.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

(Cc authors and maintainer, otherwise you're patch might be forgotten ;-)

Jisheng Zhang <jszhang@marvell.com> writes:
> Commit 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support") adds the
> usb_phy for usb3, but it attached the usb_phy to incorrect hcd. The

where did you see that's the USB3 phy ? I can't see it.

> xhci->shared_hcd is the hcd for usb3, this patch fixes this issue
> by attach the usb_phy to the xhci->shared_hcd.

Fixes: 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support")
Cc: <stable@vger.kernel.org # v4.1+

Maxime, any comments ? It _is_ odd that only one PHY got added.

> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/usb/host/xhci-plat.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 8cb46cb..9ff89e9 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -144,6 +144,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	struct resource         *res;
>  	struct usb_hcd		*hcd;
>  	struct clk              *clk;
> +	struct usb_phy		*usb_phy;
>  	int			ret;
>  	int			irq;
>  
> @@ -231,17 +232,18 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>  		xhci->shared_hcd->can_do_streams = 1;
>  
> -	hcd->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
> -	if (IS_ERR(hcd->usb_phy)) {
> -		ret = PTR_ERR(hcd->usb_phy);
> +	usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
> +	if (IS_ERR(usb_phy)) {
> +		ret = PTR_ERR(usb_phy);
>  		if (ret == -EPROBE_DEFER)
>  			goto put_usb3_hcd;
> -		hcd->usb_phy = NULL;
> +		usb_phy = NULL;
>  	} else {
> -		ret = usb_phy_init(hcd->usb_phy);
> +		ret = usb_phy_init(usb_phy);
>  		if (ret)
>  			goto put_usb3_hcd;
>  	}
> +	xhci->shared_hcd->usb_phy = usb_phy;
>  
>  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (ret)
> @@ -258,7 +260,7 @@ dealloc_usb2_hcd:
>  	usb_remove_hcd(hcd);
>  
>  disable_usb_phy:
> -	usb_phy_shutdown(hcd->usb_phy);
> +	usb_phy_shutdown(usb_phy);
>  
>  put_usb3_hcd:
>  	usb_put_hcd(xhci->shared_hcd);
> @@ -280,7 +282,7 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	struct clk *clk = xhci->clk;
>  
>  	usb_remove_hcd(xhci->shared_hcd);
> -	usb_phy_shutdown(hcd->usb_phy);
> +	usb_phy_shutdown(xhci->shared_hcd->usb_phy);
>  
>  	usb_remove_hcd(hcd);
>  	usb_put_hcd(xhci->shared_hcd);
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/1bb1a626/attachment.sig>
