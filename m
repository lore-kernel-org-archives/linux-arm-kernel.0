From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 13 May 2016 01:36:39 +0000
Subject: [PATCH] usb: ohci-at91: Suspend the ports while USB suspending
In-Reply-To: <Pine.LNX.4.44L0.1605121359120.5957-100000@netrider.rowland.org>
References: <1463015134-32364-1-git-send-email-wenyou.yang@atmel.com>
 <Pine.LNX.4.44L0.1605121359120.5957-100000@netrider.rowland.org>
Message-ID: <B256D81BAE5131468A838E5D7A243641016509B9A5@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

> -----Original Message-----
> From: Alan Stern [mailto:stern at rowland.harvard.edu]
> Sent: 2016?5?13? 2:11
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Ferre, Nicolas
> <Nicolas.FERRE@atmel.com>; linux-usb at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] usb: ohci-at91: Suspend the ports while USB suspending
> 
> On Thu, 12 May 2016, Wenyou Yang wrote:
> 
> > In order to get lower consumption, as a workaround, suspend the USB
> > PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI Interrupt
> > Configuration Register while OHCI USB suspending.
> 
> What does this mean?  What does suspending a port do?  

It is a IP workaround for SAMA5D2 USB. By setting corresponding bits of a specific register to get lower consumption.  

> Is it the same as a normal USB port suspend?

No, it is not same.

> 
> If it is the same, why doesn't the USB_PORT_FEAT_SUSPEND subcase of the
> SetPortFeature case in ohci_hub_control() already take care of this?
> 
> > This suspend operation must be done before stopping the USB clock,
> > resume after the USB clock enabled.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> 
> > @@ -132,6 +135,17 @@ static void at91_stop_hc(struct platform_device
> > *pdev)
> >
> >
> > /*--------------------------------------------------------------------
> > -----*/
> >
> > +struct regmap *at91_dt_syscon_sfr(void) {
> > +	struct regmap *regmap;
> > +
> > +	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
> > +	if (IS_ERR(regmap))
> > +		return NULL;
> 
> If you get an error, the regmap pointer is set to NULL...
> 
> > @@ -197,6 +211,8 @@ static int usb_hcd_at91_probe(const struct hc_driver
> *driver,
> >  		goto err;
> >  	}
> >
> > +	ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
> 
> With no other error checking...

Add error checking in next version.

> 
> > +
> >  	board = hcd->self.controller->platform_data;
> >  	ohci = hcd_to_ohci(hcd);
> >  	ohci->num_ports = board->ports;
> 
> > +static int ohci_at91_port_ctrl(struct regmap *regmap, bool enable) {
> > +	u32 regval;
> > +	int ret;
> > +
> > +	if (IS_ERR(regmap))
> > +		return PTR_ERR(regmap);
> > +
> > +	ret = regmap_read(regmap, SFR_OHCIICR, &regval);
> 
> And now what happens if regmap is NULL?  Hint: It won't be pretty...

Yes, it is not pretty. Will rework in next version.

> 
> Alan Stern


Best Regards,
Wenyou Yang
