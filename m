From: John.Youn@synopsys.com (John Youn)
Date: Thu, 18 Aug 2016 11:12:42 -0700
Subject: [PATCH V2 RFC 2/6] usb: dwc2: Add DT properties to specify fifo
 size in host/otg mode
In-Reply-To: <1469559213-16160-3-git-send-email-stefan.wahren@i2se.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <4db23ecb-e35c-e70a-e6ed-f3bbb5f7f1a2@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/26/2016 11:54 AM, Stefan Wahren wrote:
> Currently the fifo sizes for host/otg mode are defined per platform
> and doesn't take the mode into account. So we will get errors
> like this:
> 
> dwc2 20980000.usb: 256 invalid for host_nperio_tx_fifo_size.
> dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 32
> 
> So add DT properties for these mode specific fifo sizes in order
> to define them in the devicetree and avoid these errors.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt |    3 +++
>  drivers/usb/dwc2/core.c                        |   25 ++++++++++++++++++------
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index 20a68bf..298bac1 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -27,6 +27,9 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
>  - g-rx-fifo-size: size of rx fifo size in gadget mode.
>  - g-np-tx-fifo-size: size of non-periodic tx fifo size in gadget mode.
>  - g-tx-fifo-size: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
> +- h-rx-fifo-size: size of rx fifo size in host / otg mode.
> +- h-np-tx-fifo-size: size of non-periodic tx fifo size in host / otg mode.
> +- h-tx-fifo-size: size of periodic tx fifo per endpoint (except ep0) in host / otg mode.
>  
>  Example:
>  
> diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
> index 5645528..5dffc6e 100644
> --- a/drivers/usb/dwc2/core.c
> +++ b/drivers/usb/dwc2/core.c
> @@ -47,6 +47,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/usb.h>
>  
> @@ -1289,6 +1290,9 @@ static void dwc2_set_param_hibernation(struct dwc2_hsotg *hsotg,
>  void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
>  			 const struct dwc2_core_params *params)
>  {
> +	struct device_node *np = hsotg->dev->of_node;
> +	u32 val = 0;
> +
>  	dev_dbg(hsotg->dev, "%s()\n", __func__);
>  
>  	dwc2_set_param_otg_cap(hsotg, params->otg_cap);
> @@ -1299,12 +1303,6 @@ void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
>  			params->host_support_fs_ls_low_power);
>  	dwc2_set_param_enable_dynamic_fifo(hsotg,
>  			params->enable_dynamic_fifo);
> -	dwc2_set_param_host_rx_fifo_size(hsotg,
> -			params->host_rx_fifo_size);
> -	dwc2_set_param_host_nperio_tx_fifo_size(hsotg,
> -			params->host_nperio_tx_fifo_size);
> -	dwc2_set_param_host_perio_tx_fifo_size(hsotg,
> -			params->host_perio_tx_fifo_size);
>  	dwc2_set_param_max_transfer_size(hsotg,
>  			params->max_transfer_size);
>  	dwc2_set_param_max_packet_count(hsotg,
> @@ -1329,6 +1327,21 @@ void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
>  	dwc2_set_param_uframe_sched(hsotg, params->uframe_sched);
>  	dwc2_set_param_external_id_pin_ctl(hsotg, params->external_id_pin_ctl);
>  	dwc2_set_param_hibernation(hsotg, params->hibernation);
> +
> +	if (!IS_ENABLED(CONFIG_OF) ||
> +	    of_property_read_u32(np, "h-rx-fifo-size", &val))
> +		val = params->host_rx_fifo_size;
> +	dwc2_set_param_host_rx_fifo_size(hsotg, val);
> +
> +	if (!IS_ENABLED(CONFIG_OF) ||
> +	    of_property_read_u32(np, "h-np-tx-fifo-size", &val))
> +		val = params->host_nperio_tx_fifo_size;
> +	dwc2_set_param_host_nperio_tx_fifo_size(hsotg, val);
> +
> +	if (!IS_ENABLED(CONFIG_OF) ||
> +	    of_property_read_u32(np, "h-tx-fifo-size", &val))
> +		val = params->host_perio_tx_fifo_size;
> +	dwc2_set_param_host_perio_tx_fifo_size(hsotg, val);
>  }
>  
>  /*
> 

You should be able to use "device_property_read" as in the dwc3
driver. I know gadget.c currently uses of_property_read but we have
already made this change internally. This will allow us to set these
for PCI based devices, and also you won't need the CONFIG_OF check.

Regards,
John
