From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 12 May 2016 14:11:14 -0400 (EDT)
Subject: [PATCH] usb: ohci-at91: Suspend the ports while USB suspending
In-Reply-To: <1463015134-32364-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1605121359120.5957-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 May 2016, Wenyou Yang wrote:

> In order to get lower consumption, as a workaround, suspend
> the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI Interrupt
> Configuration Register while OHCI USB suspending.

What does this mean?  What does suspending a port do?  Is it the same 
as a normal USB port suspend?

If it is the same, why doesn't the USB_PORT_FEAT_SUSPEND subcase of the 
SetPortFeature case in ohci_hub_control() already take care of this?

> This suspend operation must be done before stopping the USB clock,
> resume after the USB clock enabled.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---

> @@ -132,6 +135,17 @@ static void at91_stop_hc(struct platform_device *pdev)
>  
>  /*-------------------------------------------------------------------------*/
>  
> +struct regmap *at91_dt_syscon_sfr(void)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
> +	if (IS_ERR(regmap))
> +		return NULL;

If you get an error, the regmap pointer is set to NULL...

> @@ -197,6 +211,8 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  		goto err;
>  	}
>  
> +	ohci_at91->sfr_regmap = at91_dt_syscon_sfr();

With no other error checking...

> +
>  	board = hcd->self.controller->platform_data;
>  	ohci = hcd_to_ohci(hcd);
>  	ohci->num_ports = board->ports;

> +static int ohci_at91_port_ctrl(struct regmap *regmap, bool enable)
> +{
> +	u32 regval;
> +	int ret;
> +
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = regmap_read(regmap, SFR_OHCIICR, &regval);

And now what happens if regmap is NULL?  Hint: It won't be pretty...

Alan Stern
