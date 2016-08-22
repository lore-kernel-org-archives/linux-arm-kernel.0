From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 22 Aug 2016 12:31:38 -0400 (EDT)
Subject: [PATCH v6] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <1471831061-24110-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1608221224100.1543-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Aug 2016, Wenyou Yang wrote:

> The usb controller does not manage correctly the suspend mode for
> the ehci. In echi mode, there is no way to suspend without any
> device connected to it. This is why this specific control is added
> to fix this issue. Since the suspend mode works in ohci mode, this
> specific control works by suspend the usb controller in ohci mode.
> 
> This specific control is by setting the SUSPEND_A/B/C fields of
> SFR_OHCIICR(OHCI Interrupt Configuration Register) in the SFR
> while the OHCI USB suspend.
> 
> This set operation must be done before the USB clock disabled,
> clear operation after the USB clock enabled.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---

This is getting better...

> @@ -282,6 +301,28 @@ static int ohci_at91_hub_status_data(struct usb_hcd *hcd, char *buf)
>  	return length;
>  }
>  
> +static int ohci_at91_port_ctrl(struct regmap *regmap, u8 set)

How about calling this routine ohci_at91_port_suspend instead of 
_port_control?  After all, the only port feature that it affects is 
the suspend feature.

> +{
> +	u32 regval;
> +	int ret;
> +
> +	if (!regmap)
> +		return 0;
> +
> +	ret = regmap_read(regmap, AT91_SFR_OHCIICR, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (set)
> +		regval |= AT91_OHCIICR_USB_SUSPEND;
> +	else
> +		regval &= ~AT91_OHCIICR_USB_SUSPEND;
> +
> +	regmap_write(regmap, AT91_SFR_OHCIICR, regval);
> +
> +	return 0;
> +}
> +
>  /*
>   * Look at the control requests to the root hub and see if we need to override.
>   */
> @@ -289,6 +330,7 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  				 u16 wIndex, char *buf, u16 wLength)
>  {
>  	struct at91_usbh_data *pdata = dev_get_platdata(hcd->self.controller);
> +	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
>  	struct usb_hub_descriptor *desc;
>  	int ret = -EINVAL;
>  	u32 *data = (u32 *)buf;
> @@ -301,7 +343,8 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  
>  	switch (typeReq) {
>  	case SetPortFeature:
> -		if (wValue == USB_PORT_FEAT_POWER) {
> +		switch (wValue) {
> +		case USB_PORT_FEAT_POWER:
>  			dev_dbg(hcd->self.controller, "SetPortFeat: POWER\n");
>  			if (valid_port(wIndex)) {
>  				ohci_at91_usb_set_power(pdata, wIndex, 1);
> @@ -309,6 +352,11 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  			}
>  
>  			goto out;
> +
> +		case USB_PORT_FEAT_SUSPEND:
> +			dev_dbg(hcd->self.controller, "SetPortFeat: SUSPEND\n");

Don't you want to check valid_port(wIndex) here, like the 
USB_PORT_FEAT_POWER case above?

> +			ohci_at91_port_ctrl(ohci_at91->sfr_regmap, 1);
> +			break;
>  		}
>  		break;
>  
> @@ -342,6 +390,12 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  				ohci_at91_usb_set_power(pdata, wIndex, 0);
>  				return 0;
>  			}
> +			break;
> +
> +		case USB_PORT_FEAT_SUSPEND:
> +			dev_dbg(hcd->self.controller, "ClearPortFeature: SUSPEND\n");

And here too?

> +			ohci_at91_port_ctrl(ohci_at91->sfr_regmap, 0);
> +			break;
>  		}
>  		break;
>  	}
> @@ -599,6 +653,9 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>  	if (ohci_at91->wakeup)
>  		enable_irq_wake(hcd->irq);
>  
> +	ohci_at91_hub_control(hcd, SetPortFeature,
> +			      USB_PORT_FEAT_SUSPEND, 1, NULL, 0);
> +

You really shouldn't call ohci_at91_hub_control here.  Instead, you 
can call ohci_at91_port_ctrl (or ohci_at91_port_suspend, if you 
change the function's name).

>  	ret = ohci_suspend(hcd, ohci_at91->wakeup);
>  	if (ret) {
>  		if (ohci_at91->wakeup)
> @@ -638,6 +695,10 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>  	at91_start_clock(ohci_at91);
>  
>  	ohci_resume(hcd, false);
> +
> +	ohci_at91_hub_control(hcd, ClearPortFeature,
> +			      USB_PORT_FEAT_SUSPEND, 1, NULL, 0);

Same here.

> +
>  	return 0;
>  }

Alan Stern
