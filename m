From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 23 Oct 2013 10:46:09 -0400 (EDT)
Subject: [Patch v2 09/10] usb: chipidea: host: add ehci quirk for imx
 controller
In-Reply-To: <1382423019-26184-10-git-send-email-peter.chen@freescale.com>
Message-ID: <Pine.LNX.4.44L0.1310231043100.1326-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Oct 2013, Peter Chen wrote:

> When the port goes to suspend or finishes resme, it needs to
> notify PHY, it is not a standard EHCI operation, so we add a
> quirk for it.

Actually, this _should_ be a standard EHCI operation.  But we have to
figure out a way to do it that will work on all platforms.

Felipe, any ideas?

Alan Stern

> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/chipidea/host.c  |  129 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb/chipidea.h |    1 +
>  2 files changed, 130 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index 283b385..c1d05c4 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -34,6 +34,10 @@
>  
>  static struct hc_driver __read_mostly ci_ehci_hc_driver;
>  static int (*orig_bus_suspend)(struct usb_hcd *hcd);
> +static int (*orig_bus_resume)(struct usb_hcd *hcd);
> +static int (*orig_hub_control)(struct usb_hcd *hcd,
> +				u16 typeReq, u16 wValue, u16 wIndex,
> +				char *buf, u16 wLength);
>  
>  static int ci_ehci_bus_suspend(struct usb_hcd *hcd)
>  {
> @@ -75,12 +79,131 @@ static int ci_ehci_bus_suspend(struct usb_hcd *hcd)
>  				 */
>  				udelay(125);
>  			}
> +			if (hcd->phy && test_bit(port, &ehci->bus_suspended)
> +				&& (ehci_port_speed(ehci, portsc) ==
> +					USB_PORT_STAT_HIGH_SPEED))
> +				/*
> +				 * notify the USB PHY, it is for global
> +				 * suspend case.
> +				 */
> +				usb_phy_notify_suspend(hcd->phy,
> +					USB_SPEED_HIGH);
>  		}
>  	}
>  
>  	return 0;
>  }
>  
> +static int ci_imx_ehci_bus_resume(struct usb_hcd *hcd)
> +{
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +	int port;
> +
> +	int ret = orig_bus_resume(hcd);
> +
> +	if (ret)
> +		return ret;
> +
> +	port = HCS_N_PORTS(ehci->hcs_params);
> +	while (port--) {
> +		u32 __iomem *reg = &ehci->regs->port_status[port];
> +		u32 portsc = ehci_readl(ehci, reg);
> +		/*
> +		 * Notify PHY after resume signal has finished, it is
> +		 * for global suspend case.
> +		 */
> +		if (hcd->phy
> +			&& test_bit(port, &ehci->bus_suspended)
> +			&& (portsc & PORT_CONNECT)
> +			&& (ehci_port_speed(ehci, portsc) ==
> +				USB_PORT_STAT_HIGH_SPEED))
> +			/* notify the USB PHY */
> +			usb_phy_notify_resume(hcd->phy, USB_SPEED_HIGH);
> +	}
> +
> +	return 0;
> +}
