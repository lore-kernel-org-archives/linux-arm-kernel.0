From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 01 Jun 2016 01:57:23 -0700
Subject: [PATCH v3 09/12] EXAMPLE CODE: usb: port: Parse pwrseq phandle
 from Device Tree
In-Reply-To: <1464768141-25420-10-git-send-email-k.kozlowski@samsung.com>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-10-git-send-email-k.kozlowski@samsung.com>
Message-ID: <146477144362.1485.3331887341591876278@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Krzysztof Kozlowski (2016-06-01 01:02:18)
> Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
> device.  The pwrseq device will be used by USB hub to cycle the power
> before activating ports.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Drive by review comment.

I was hoping this would help me with a problem I'm having where I have a
hub (smsc4604) that needs to be taken out of reset before my HSIC
controller sends a USB reset to it, but it seems this is more about
doing some sort of power on sequence after enumeration?

> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 460c855be0d0..89b9bdfc7061 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -18,6 +18,8 @@
>  
>  #include <linux/slab.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pwrseq.h>
> +#include <linux/usb/of.h>
>  
>  #include "hub.h"
>  
> @@ -526,6 +528,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>                 return retval;
>         }
>  
> +       port_dev->dev.of_node = usb_of_get_child_node(hdev->dev.parent->of_node,
> +                                                     port1);
> +       port_dev->pwrseq = pwrseq_alloc(&port_dev->dev, "usb-pwrseq");
> +       if (IS_ERR(port_dev->pwrseq)) {
> +               device_unregister(&port_dev->dev);
> +               return PTR_ERR(port_dev->pwrseq);

Are we certain that port_dev hasn't been freed at this point? We just
called device_unregister() on it, so it seems safer to save away the
return value before calling device_unregister() here.
