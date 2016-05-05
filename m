From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 5 May 2016 16:10:04 -0400
Subject: [RFC v2 11/13] usb: port: Parse pwrseq phandle from Device Tree
In-Reply-To: <1462451666-17945-12-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-12-git-send-email-k.kozlowski@samsung.com>
Message-ID: <e8f310b5-4fe8-3eb2-2d17-b1d9077daea2@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
> Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
> device. The pwrseq device will be used by USB hub to cycle the power
> before activating ports.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

[snip]

>  
> @@ -532,6 +534,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>  		return retval;
>  	}
>  
> +	port_dev->dev.of_node = usb_of_get_child_node(hub->hdev->dev.of_node, port1);
> +	port_dev->pwrseq = pwrseq_alloc(&port_dev->dev);
> +	if (IS_ERR(port_dev->pwrseq)) {
> +		device_unregister(&port_dev->dev);
> +		/* TODO: what about EPROBE_DEFER? */

I think it's OK since the call chain is:

hub_probe()
       hub_configure()
              usb_hub_create_port_device()

so the hub_probe() will be deferred if the usb-pwrseq was not registered yet.
Unless I misunderstood your question :)

Anyway, patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
 
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
