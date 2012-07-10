From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 10 Jul 2012 11:14:27 +0800
Subject: [PATCH v9 REBASE 6/9] USB: notify phy when root hub port connect
 change
In-Reply-To: <1341673008-29808-7-git-send-email-richard.zhao@freescale.com>
References: <1341673008-29808-1-git-send-email-richard.zhao@freescale.com>
 <1341673008-29808-7-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120710031426.GG26888@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 07, 2012 at 10:56:45PM +0800, Richard Zhao wrote:
> Phy may need to change settings when port connect change.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Tested-by: Subodh Nijsure <snijsure@grid-net.com>
> ---
>  drivers/usb/core/hub.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 4cc8dc9..2ba9d84 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -20,6 +20,7 @@
>  #include <linux/usb.h>
>  #include <linux/usbdevice_fs.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/usb/otg.h>
>  #include <linux/usb/quirks.h>
>  #include <linux/kthread.h>
>  #include <linux/mutex.h>
> @@ -4037,6 +4038,13 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
>  		}
>  	}
>  
> +	if (unlikely(hcd->phy && !hdev->parent)) {
> +		if (portstatus & USB_PORT_STAT_CONNECTION)
> +			usb_phy_notify_connect(hcd->phy, port1);
> +		else
> +			usb_phy_notify_disconnect(hcd->phy, port1);
There's another issue. When hcd is removed, notify disconnect is not
called. Is it ok, if I remove the above two line and add below patch:

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1924,6 +1924,11 @@ void usb_disconnect(struct usb_device **pdev)
 	 */
 	device_del(&udev->dev);
 
+	if (udev->parent && !udev->parent->parent) {
+		struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+		usb_phy_notify_disconnect(hcd->phy, udev->portnum);
+	}
+
 	/* Free the device number and delete the parent's children[]
 	 * (or root_hub) pointer.
 	 */


Thanks
Richard
 
