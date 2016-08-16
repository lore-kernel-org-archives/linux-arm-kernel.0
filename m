From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Tue, 16 Aug 2016 09:05:46 +0000
Subject: [PATCH v5] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <F9F4555C4E01D7469D37975B62D0EFBB393C66@CHN-SV-EXMX07.mchp-main.com>
References: <1470284612-3336-1-git-send-email-wenyou.yang@atmel.com>
 <Pine.LNX.4.44L0.1608041048460.1387-100000@iolanthe.rowland.org>
 <F9F4555C4E01D7469D37975B62D0EFBB393C66@CHN-SV-EXMX07.mchp-main.com>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB3A228A@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

As you saw, I think the version 4 is better than this, can we take the version 4?


Best Regards,
Wenyou Yang

> -----Original Message-----
> From: Wenyou.Yang at microchip.com [mailto:Wenyou.Yang at microchip.com]
> Sent: 2016?8?5? 11:46
> To: stern at rowland.harvard.edu; wenyou.yang at atmel.com
> Cc: gregkh at linuxfoundation.org; nicolas.ferre at atmel.com;
> alexandre.belloni at free-electrons.com; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-usb at vger.kernel.org
> Subject: RE: [PATCH v5] usb: ohci-at91: Forcibly suspend ports while USB
> suspend
> 
> Hi Alan,
> 
> > -----Original Message-----
> > From: Alan Stern [mailto:stern at rowland.harvard.edu]
> > Sent: 2016?8?4? 23:02
> > To: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Nicolas Ferre
> > <nicolas.ferre@atmel.com>; Alexandre Belloni <alexandre.belloni@free-
> > electrons.com>; linux-kernel at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; linux-usb at vger.kernel.org
> > Subject: Re: [PATCH v5] usb: ohci-at91: Forcibly suspend ports while
> > USB suspend
> >
> > On Thu, 4 Aug 2016, Wenyou Yang wrote:
> >
> > > The usb controller does not managed correctly the suspend mode for
> > > the ehci. In echi mode, there is no way to have utmi_suspend_o_n[1]
> > > suspend without any device connected to it. This is why this
> > > specific control is added to fix this issue. The suspend mode works
> > > in ohci mode.
> >
> > Why are you talking about EHCI mode?  This patch is only for the
> > ohci-at91 driver.
> 
> Actually I described the issue according to the documents from our IP, and this
> specific control is recommended to do in ohci mode.
> 
> >
> > > This specific control is by setting the SUSPEND_A/B/C fields of
> > > SFR_OHCIICR(OHCI Interrupt Configuration Register) in the SFR while
> > > OHCI USB suspend.
> > >
> > > This setting operation must be done before the USB clock disabled,
> > > clear them after the USB clock enabled.
> > >
> > > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > > Reviewed-by: Alexandre Belloni
> > > <alexandre.belloni@free-electrons.com>
> > > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >
> > I don't know if this is any better than before!  See the comments below.
> 
> Yes, I think so.
> 
> What else advice?
> 
> >
> > > ---
> > >
> > > Changes in v5:
> > >  - Use the USB_PORT_FEAT_SUSPEND subcase of the SetPortFeature case
> > >    to take care it.
> > >  - Update the commit log.
> > >
> > > Changes in v4:
> > >  - To check whether the SFR node with "atmel,sama5d2-sfr" compatible
> > >    is present or not to decide if this feature is applied or not
> > >    when USB OHCI suspend/resume, instead of new compatible.
> > >  - Drop the compatible "atmel,sama5d2-ohci".
> > >  - Drop [PATCH 2/2] ARM: at91/dt: sama5d2: Use new compatible for
> > >    ohci node.
> > >  - Drop include/soc/at91/at91_sfr.h, move the macro definitions to
> > >    atmel-sfr.h which already exists.
> > >  - Change the defines to align the exists.
> > >
> > > Changes in v3:
> > >  - Change the compatible description for more precise.
> > >
> > > Changes in v2:
> > >  - Add compatible to support forcibly suspend the ports.
> > >  - Add soc/at91/at91_sfr.h to accommodate the defines.
> > >  - Add error checking for .sfr_regmap.
> > >  - Remove unnecessary regmap_read() statement.
> >
> >
> > > @@ -282,6 +301,28 @@ static int ohci_at91_hub_status_data(struct
> > > usb_hcd
> > *hcd, char *buf)
> > >  	return length;
> > >  }
> > >
> > > +static int ohci_at91_port_ctrl(struct regmap *regmap, u16 port, u8
> > > +set) {
> > > +	u32 regval;
> > > +	int ret;
> > > +
> > > +	if (!regmap)
> > > +		return 0;
> > > +
> > > +	ret = regmap_read(regmap, AT91_SFR_OHCIICR, &regval);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (set)
> > > +		regval |= AT91_OHCIICR_SUSPEND(port);
> > > +	else
> > > +		regval &= ~AT91_OHCIICR_SUSPEND(port);
> >
> > In the earlier versions of this patch, you did not use the port number.
> > Why has this changed?
> 
> This function is called by ohci_at91_hub_control(), which is invoked on basis of
> port number.
> 
> So, I think it is more reasonable of adding the port argument.
> 
> >
> > How many ports does this controller have?
> 
> This controller has three ports.
> 
> >
> > > +
> > > +	regmap_write(regmap, AT91_SFR_OHCIICR, regval);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /*
> > >   * Look at the control requests to the root hub and see if we need to override.
> > >   */
> > > @@ -289,6 +330,7 @@ static int ohci_at91_hub_control(struct usb_hcd
> > > *hcd,
> > u16 typeReq, u16 wValue,
> > >  				 u16 wIndex, char *buf, u16 wLength)  {
> > >  	struct at91_usbh_data *pdata =
> > > dev_get_platdata(hcd->self.controller);
> > > +	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
> > >  	struct usb_hub_descriptor *desc;
> > >  	int ret = -EINVAL;
> > >  	u32 *data = (u32 *)buf;
> > > @@ -301,7 +343,8 @@ static int ohci_at91_hub_control(struct usb_hcd
> > > *hcd, u16 typeReq, u16 wValue,
> > >
> > >  	switch (typeReq) {
> > >  	case SetPortFeature:
> > > -		if (wValue == USB_PORT_FEAT_POWER) {
> > > +		switch (wValue) {
> > > +		case USB_PORT_FEAT_POWER:
> > >  			dev_dbg(hcd->self.controller, "SetPortFeat: POWER\n");
> > >  			if (valid_port(wIndex)) {
> > >  				ohci_at91_usb_set_power(pdata, wIndex, 1); @@
> > -309,6 +352,11 @@
> > > static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16
> wValue,
> > >  			}
> > >
> > >  			goto out;
> > > +
> > > +		case USB_PORT_FEAT_SUSPEND:
> > > +			dev_dbg(hcd->self.controller, "SetPortFeat: SUSPEND\n");
> > > +			ohci_at91_port_ctrl(ohci_at91->sfr_regmap, wIndex, 1);
> > > +			break;
> > >  		}
> > >  		break;
> > >
> > > @@ -342,6 +390,12 @@ static int ohci_at91_hub_control(struct usb_hcd
> > > *hcd,
> > u16 typeReq, u16 wValue,
> > >  				ohci_at91_usb_set_power(pdata, wIndex, 0);
> > >  				return 0;
> > >  			}
> > > +			break;
> > > +
> > > +		case USB_PORT_FEAT_SUSPEND:
> > > +			dev_dbg(hcd->self.controller, "ClearPortFeature:
> > SUSPEND\n");
> > > +			ohci_at91_port_ctrl(ohci_at91->sfr_regmap, wIndex, 0);
> > > +			break;
> > >  		}
> > >  		break;
> > >  	}
> >
> > Note that after all this, the code goes ahead to call ohci_bub_control().
> 
> Yes,
> The ohci_bub_control() will change the port_status[port] register after this
> operation.
> 
> >
> > > @@ -587,7 +641,8 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
> > >  	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> > >  	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
> > >  	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
> > > -	int		ret;
> > > +	u16 i;
> > > +	int ret;
> > >
> > >  	/*
> > >  	 * Disable wakeup if we are going to sleep with slow clock mode @@
> > > -599,6 +654,11 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
> > >  	if (ohci_at91->wakeup)
> > >  		enable_irq_wake(hcd->irq);
> > >
> > > +	for (i = 0; i < ohci->num_ports; i++) {
> > > +		ohci_at91_hub_control(hcd, SetPortFeature,
> > > +				      USB_PORT_FEAT_SUSPEND, (i + 1), NULL,
> > 0);
> > > +	}
> > > +
> > >  	ret = ohci_suspend(hcd, ohci_at91->wakeup);
> >
> > Do you really want to call ohci_hub_control() for ports that don't
> > have a device attached?
> 
> Yes. I need to do this operation for ports that don't have a device attached.
> 
> >
> > >  	if (ret) {
> > >  		if (ohci_at91->wakeup)
> > > @@ -630,7 +690,9 @@ static int __maybe_unused
> > > ohci_hcd_at91_drv_resume(struct device *dev)  {
> > >  	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> > > +	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
> > >  	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
> > > +	u16 i;
> > >
> > >  	if (ohci_at91->wakeup)
> > >  		disable_irq_wake(hcd->irq);
> > > @@ -638,6 +700,12 @@ ohci_hcd_at91_drv_resume(struct device *dev)
> > >  	at91_start_clock(ohci_at91);
> > >
> > >  	ohci_resume(hcd, false);
> > > +
> > > +	for (i = 0; i < ohci->num_ports; i++) {
> > > +		ohci_at91_hub_control(hcd, ClearPortFeature,
> > > +				      USB_PORT_FEAT_SUSPEND, i + 1, NULL,
> > 0);
> > > +	}
> >
> > Have you thought about how this will interact with runtime PM?
> >
> > If you intend to do this only for system suspend and not for runtime
> > suspend, why not set all the suspend bits for all the ports in the
> > OHCIICR register at once, in a single write, like you were doing before?
> 
> Yes, this is only for system suspend.
> 
> As I mentioned above, here calls ohci_at91_hub_control(), which is based on port
> number.
> 
> >
> > Alan Stern
> 
> 
> Best Regards,
> Wenyou Yang
