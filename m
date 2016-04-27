From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 27 Apr 2016 08:25:38 +0300
Subject: [RESEND PATCH v2 1/7] usb: xhci: plat: Fix suspend/resume when
 the optional clk exists
In-Reply-To: <1461675460-2295-2-git-send-email-jszhang@marvell.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-2-git-send-email-jszhang@marvell.com>
Message-ID: <87shy7pqr1.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

(since you're fixing somebody else's commit, it's nice to Cc authors)

Jisheng Zhang <jszhang@marvell.com> writes:
> Commit 4718c1774051 ("usb: host: xhci-plat: add clock support") adds
> optional clk support, but it forgets to prepare/disable and
                                          ^^^^^^^^^^^^^^^
                                          prepare/enable ?

> enable/unprepare the clk in the resume/suspend path. This path fixes
  ^^^^^^^^^^^^^^^^                                          ^^^^
  disable/unprepare ?                                       patch

> this issue by adding missing clk related calls.

frankly, I'm not sure this patch is entirely correct. At minimum, it's
not necessarily a bug fix. Original commit had no intent in gating
clocks during suspend/resume and, IMHO, that might not be what *all*
XHCI implementations want, though I'm not entirely sure.

> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Fixes: 4718c1774051 ("usb: host: xhci-plat: add clock support")

Assuming this is, indeed, a fix; you need to Cc stable here. Just add:

Cc: <stable@vger.kernel.org> # v3.16+

> ---
>  drivers/usb/host/xhci-plat.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 474b5fa..8cb46cb 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -295,6 +295,7 @@ static int xhci_plat_remove(struct platform_device *dev)
>  #ifdef CONFIG_PM_SLEEP
>  static int xhci_plat_suspend(struct device *dev)
>  {
> +	int ret;

this would look neater after hcd and xhci declarations below

>  	struct usb_hcd	*hcd = dev_get_drvdata(dev);
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>  
> @@ -306,14 +307,25 @@ static int xhci_plat_suspend(struct device *dev)
>  	 * reconsider this when xhci_plat_suspend enlarges its scope, e.g.,
>  	 * also applies to runtime suspend.
>  	 */
> -	return xhci_suspend(xhci, device_may_wakeup(dev));
> +	ret = xhci_suspend(xhci, device_may_wakeup(dev));
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(xhci->clk);
> +
> +	return ret;
>  }
>  
>  static int xhci_plat_resume(struct device *dev)
>  {
> +	int ret;

ditto

>  	struct usb_hcd	*hcd = dev_get_drvdata(dev);
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>  
> +	ret = clk_prepare_enable(xhci->clk);
> +	if (ret)
> +		return ret;
> +
>  	return xhci_resume(xhci, 0);
>  }
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/4c64ec1f/attachment-0001.sig>
