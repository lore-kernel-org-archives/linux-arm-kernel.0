From: balbi@ti.com (Felipe Balbi)
Date: Tue, 9 Jul 2013 14:34:14 +0300
Subject: [PATCH v3 4/4] USB: OMAP1: Tahvo USB transceiver driver
In-Reply-To: <20130708194402.GA8516@blackmetal.musicnaut.iki.fi>
References: <1371575221-360-1-git-send-email-aaro.koskinen@iki.fi>
 <1371575221-360-5-git-send-email-aaro.koskinen@iki.fi>
 <20130708072109.GA16635@arwen.pp.htv.fi>
 <20130708194402.GA8516@blackmetal.musicnaut.iki.fi>
Message-ID: <20130709113414.GK5552@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 08, 2013 at 10:44:02PM +0300, Aaro Koskinen wrote:
> > > +static void tahvo_usb_become_host(struct tahvo_usb *tu)
> > > +{
> > > +	struct retu_dev *rdev = dev_get_drvdata(tu->pt_dev->dev.parent);
> > > +
> > > +	extcon_set_cable_state(&tu->extcon, "USB-HOST", true);
> > > +
> > > +	/* Power up the transceiver in USB host mode */
> > > +	retu_write(rdev, TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
> > > +		   USBR_MASTER_SW2 | USBR_MASTER_SW1);
> > > +	tu->phy.state = OTG_STATE_A_IDLE;
> > > +
> > > +	check_vbus_state(tu);
> > > +}
> > > +
> > > +static void tahvo_usb_stop_host(struct tahvo_usb *tu)
> > > +{
> > > +	tu->phy.state = OTG_STATE_A_IDLE;
> > 
> > shouldn't you undo tahvo_usb_become_host() here ? I mean, set the
> > transceiver to SLAVE ?
> 
> tahvo_usb_become_peripheral() (or power_off) is always called after this
> function. Actually, these stop functions can be eliminated altogether
> as they are only called from a single place...

alright, I guess GCC is already inlining them anyway, your choice.

> > > +static int tahvo_usb_set_host(struct usb_otg *otg, struct usb_bus *host)
> > > +{
> > > +	struct tahvo_usb *tu = container_of(otg->phy, struct tahvo_usb, phy);
> > > +
> > > +	dev_dbg(&tu->pt_dev->dev, "%s %p\n", __func__, host);
> > > +
> > > +	if (otg == NULL)
> > > +		return -ENODEV;
> > > +
> > > +	mutex_lock(&tu->serialize);
> > > +
> > > +	if (host == NULL) {
> > > +		if (tu->tahvo_mode == TAHVO_MODE_HOST)
> > > +			tahvo_usb_power_off(tu);
> > > +		otg->host = NULL;
> > > +		mutex_unlock(&tu->serialize);
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (tu->tahvo_mode == TAHVO_MODE_HOST) {
> > > +		otg->host = NULL;
> > > +		tahvo_usb_become_host(tu);
> > > +	}
> > > +
> > > +	otg->host = host;
> > > +
> > > +	mutex_unlock(&tu->serialize);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int tahvo_usb_set_peripheral(struct usb_otg *otg,
> > > +				    struct usb_gadget *gadget)
> > 
> > I want to get rid of the extra 'gadget' and 'host' parameters on
> > ->set_host() and ->set_peripheral(). Nobody really uses them other than:
> > 
> > my_phy->phy.otg->{gadget,host} = {gadget,host};
> > 
> > For that, I need all other PHYs to stop relying on those parameters and
> > I'll cook patches for that for v3.12 merge window.
> 
> How will the PHY know if there is a host/gadget driver present? I guess
> I will need to wait for those patches...

It won't. We're assuming that if the link asks to become a host, it
should already know that there is a host side available :-)

> > > +static int tahvo_usb_probe(struct platform_device *pdev)
> > > +{
> > > +	struct retu_dev *rdev = dev_get_drvdata(pdev->dev.parent);
> > > +	struct tahvo_usb *tu;
> > > +	int ret;
> > > +
> > > +	tu = devm_kzalloc(&pdev->dev, sizeof(*tu), GFP_KERNEL);
> > > +	if (!tu)
> > > +		return -ENOMEM;
> > > +
> > > +	tu->phy.otg = devm_kzalloc(&pdev->dev, sizeof(*tu->phy.otg),
> > > +				   GFP_KERNEL);
> > > +	if (!tu->phy.otg)
> > > +		return -ENOMEM;
> > > +
> > > +	tu->pt_dev = pdev;
> > > +
> > > +	/* Default mode */
> > > +#ifdef CONFIG_TAHVO_USB_HOST_BY_DEFAULT
> > > +	tu->tahvo_mode = TAHVO_MODE_HOST;
> > > +#else
> > > +	tu->tahvo_mode = TAHVO_MODE_PERIPHERAL;
> > > +#endif
> > 
> > should you call become_host()/become_peripheral() here ?
> 
> Not needed. Once the PHY is registered, the framework will call set_host /
> set_peripheral and the HW gets set to correct state.

ok good, thanks

> > /Could also use devm_request_threaded_irq()
> 
> Does not really help much, since the IRQ has to be freed manually anyway
> (to ensure it's disabled before usb_remove_phy(); also looks like it's
> currently enabled too early...).

you miss a free() in the error path. Switching to
devm_request_threaded_irq() would save you the trouble of having to call
that explicitly.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/213b3138/attachment.sig>
