From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 5 May 2016 10:09:47 -0400 (EDT)
Subject: [RFC v2 10/13] usb: hub: Power sequence the ports on activation
In-Reply-To: <1462451666-17945-11-git-send-email-k.kozlowski@samsung.com>
Message-ID: <Pine.LNX.4.44L0.1605051007040.2008-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 May 2016, Krzysztof Kozlowski wrote:

> The autodetection of attached USB device might not work on certain
> boards where the power is delivered externally. These devices also might
> require a hard reset. Use pwrseq for that in USB hub.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/usb/core/hub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 1c82fcc448f5..0fddaacc62bf 100644
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
> @@ -1661,7 +1662,17 @@ static int hub_configure(struct usb_hub *hub,
>  
>  	usb_hub_adjust_deviceremovable(hdev, hub->descriptor);
>  
> +	/* FIXME: When do the pre-power-on? */

It's hard to answer this without knowing what pre-power-on involves.

Why not create a pwrseq_power_on() routine that does pre_power_on 
followed by post_power_on?

> +	/*
> +	for (i = 0; i < maxchild; i++)
> +		pwrseq_pre_power_on(hub->ports[i]->pwrseq);
> +	*/
> +
> +	for (i = 0; i < maxchild; i++)
> +		pwrseq_post_power_on(hub->ports[i]->pwrseq);

This is patch 10/13.  hub->ports[i]->pwrseq doesn't get added until 
11/13.  Obviously you never tried compiling each patch in the series.

> +
>  	hub_activate(hub, HUB_INIT);
> +

Unnecessary blank line added.

>  	return 0;
>  
>  fail:

Alan Stern
