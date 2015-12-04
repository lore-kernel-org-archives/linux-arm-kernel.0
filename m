From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 4 Dec 2015 22:15:16 +0800
Subject: [PATCH 3/7] usb: xhci: plat: Fix suspend/resume when the
 optional usb_phy exists
In-Reply-To: <1449238252-5630-4-git-send-email-jszhang@marvell.com>
References: <1449238252-5630-1-git-send-email-jszhang@marvell.com>
 <1449238252-5630-4-git-send-email-jszhang@marvell.com>
Message-ID: <20151204221516.1618d4ee@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc linux-usb at vger.kernel.org

On Fri, 4 Dec 2015 22:10:48 +0800
Jisheng Zhang wrote:

> Commit 7b8ef22ea547 ("usb: xhci: plat: Add USB phy support") adds the
> usb_phy for usb3, but it forgets to shutdown/init the usb_phy in the
> suspend/resume path. This patch fixes this issue by adding missing
> usb_phy related calls.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/usb/host/xhci-plat.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index a8c465a..cd49ae5 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -244,6 +244,7 @@ static int xhci_plat_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	usb_phy_shutdown(xhci->shared_hcd->usb_phy);
>  	clk_disable_unprepare(xhci->clk);
>  
>  	return ret;
> @@ -259,6 +260,10 @@ static int xhci_plat_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	ret = usb_phy_init(xhci->shared_hcd->usb_phy);
> +	if (ret)
> +		return ret;
> +
>  	return xhci_resume(xhci, 0);
>  }
>  
