From: balbi@ti.com (Felipe Balbi)
Date: Mon, 17 Nov 2014 17:04:30 -0600
Subject: [PATCH V5 01/12] xhci: Set shared HCD's hcd_priv in xhci_gen_setup
In-Reply-To: <1416264102-1323-2-git-send-email-abrestic@chromium.org>
References: <1416264102-1323-1-git-send-email-abrestic@chromium.org>
 <1416264102-1323-2-git-send-email-abrestic@chromium.org>
Message-ID: <20141117230430.GA9716@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 02:41:31PM -0800, Andrew Bresticker wrote:
> xhci_gen_setup() sets the hcd_priv field for the primary HCD, but not
> for the shared HCD, requiring xHCI host-controller drivers to set it
> between usb_create_shared_hcd() and usb_add_hcd().  There's no reason
> xhci_gen_setup() can't set the shared HCD's hcd_priv as well, so move
> that bit out of the host-controller drivers and into xhci_gen_setup().
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> New for v5.
> Peviously posted here: https://lkml.org/lkml/2014/10/30/726
> ---
>  drivers/usb/host/xhci-pci.c  | 5 -----
>  drivers/usb/host/xhci-plat.c | 5 -----
>  drivers/usb/host/xhci.c      | 6 +++---
>  3 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 9a69b1f..31025e4 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -221,11 +221,6 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		goto dealloc_usb2_hcd;
>  	}
>  
> -	/* Set the xHCI pointer before xhci_pci_setup() (aka hcd_driver.reset)
> -	 * is called by usb_add_hcd().
> -	 */
> -	*((struct xhci_hcd **) xhci->shared_hcd->hcd_priv) = xhci;
> -
>  	retval = usb_add_hcd(xhci->shared_hcd, dev->irq,
>  			IRQF_SHARED);
>  	if (retval)
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 3d78b0c..5bc33bc 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -149,11 +149,6 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	if ((node && of_property_read_bool(node, "usb3-lpm-capable")) ||
>  			(pdata && pdata->usb3_lpm_capable))
>  		xhci->quirks |= XHCI_LPM_SUPPORT;
> -	/*
> -	 * Set the xHCI pointer before xhci_plat_setup() (aka hcd_driver.reset)
> -	 * is called by usb_add_hcd().
> -	 */
> -	*((struct xhci_hcd **) xhci->shared_hcd->hcd_priv) = xhci;
>  
>  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>  		xhci->shared_hcd->can_do_streams = 1;
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 2a5d45b..ae05471 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4843,9 +4843,9 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>  		 */
>  		hcd->has_tt = 1;
>  	} else {
> -		/* xHCI private pointer was set in xhci_pci_probe for the second
> -		 * registered roothub.
> -		 */
> +		xhci = hcd_to_xhci(hcd->primary_hcd);
> +		*((struct xhci_hcd **) hcd->hcd_priv) = xhci;
> +
>  		return 0;
>  	}
>  
> -- 
> 2.1.0.rc2.206.gedb03e5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/b8f02b46/attachment.sig>
