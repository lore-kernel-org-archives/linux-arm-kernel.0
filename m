From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 17 Jun 2016 12:12:03 -0400 (EDT)
Subject: [PATCH 10/12] usb: core: add power sequence handling for USB
 devices
In-Reply-To: <1466158165-9380-11-git-send-email-peter.chen@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1606171209310.1589-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jun 2016, Peter Chen wrote:

> Some hard-wired USB devices need to do power sequence to let the
> device work normally, the typical power sequence like: enable USB
> PHY clock, toggle reset pin, etc. But current Linux USB driver
> lacks of such code to do it, it may cause some hard-wired USB devices
> works abnormal or can't be recognized by controller at all.
> 
> In this patch, it will do power on sequence at hub's probe for all
> devices under this hub (includes root hub) if this device is described
> at dts and there is a phandle "usb-pwrseq" for it.
> 
> At hub_disconnect, it will do power off sequence which is at powered on
> list.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  drivers/usb/core/hub.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/usb/core/hub.h |  1 +
>  include/linux/pwrseq.h |  6 +++++
>  3 files changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index bee1351..cc0f942 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  #include <linux/random.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pwrseq.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/byteorder.h>
> @@ -1684,6 +1685,66 @@ static void hub_release(struct kref *kref)
>  
>  static unsigned highspeed_hubs;
>  
> +static void hub_of_pwrseq_off(struct usb_interface *intf)
> +{
> +	struct usb_hub *hub = usb_get_intfdata(intf);

It would be easier to pass hub as the argument instead of intf.

Otherwise this looks okay to me.

Alan Stern
