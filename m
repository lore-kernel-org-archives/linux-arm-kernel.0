From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 4 Feb 2016 11:36:53 -0500 (EST)
Subject: [PATCH v4 1/1] USB: core: let USB device know device node
In-Reply-To: <20160204015928.GA11158@shlinux2>
Message-ID: <Pine.LNX.4.44L0.1602041130590.1515-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Feb 2016, Peter Chen wrote:

> On Mon, Jan 25, 2016 at 03:24:39PM +0800, Peter Chen wrote:
> > Although most of USB devices are hot-plug's, there are still some devices
> > are hard wired on the board, eg, for HSIC and SSIC interface USB devices.
> > If these kinds of USB devices are multiple functions, and they can supply
> > other interfaces like i2c, gpios for other devices, we may need to
> > describe these at device tree.
> > 
> > In this commit, it uses "reg" in dts as physical port number to match
> > the phyiscal port number decided by USB core, if they are the same,
> > then the device node is for the device we are creating for USB core.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> > Changes for v4:
> > - The range of "reg" should be 1-31, changing device node address
> >   style as in lower case hexadecimal with leading zeroes suppressed
> >   [binding doc, usb-device.txt]
> > - Improve the example at binding doc, it describes node from the top
> >   (the controller)
> > - Delete the struct of_node * within struct usb_device
> > - Using usb_hcd_find_raw_port_number to get raw port number under root
> >   hub port
> > 
> 
> Hi Alan, Arnd, and others, would you please give Ack for it if you
> are OK with this patch? I am not sure if Greg will queue it or not
> if no one Acks it, thanks.


> > @@ -508,11 +509,20 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
> >  	dev->connect_time = jiffies;
> >  	dev->active_duration = -jiffies;
> >  #endif
> > -	if (root_hub)	/* Root hub always ok [and always wired] */
> > +	if (root_hub) {	/* Root hub always ok [and always wired] */
> >  		dev->authorized = 1;
> > -	else {
> > +		dev->dev.of_node = bus->controller->of_node;
> > +	} else {
> >  		dev->authorized = !!HCD_DEV_AUTHORIZED(usb_hcd);
> >  		dev->wusb = usb_bus_is_wusb(bus) ? 1 : 0;
> > +
> > +		if (dev->dev.parent->parent == bus->controller)
> > +			/* device under root hub's port */
> > +			port1 = usb_hcd_find_raw_port_number(usb_hcd,
> > +				port1);

I would change the test to "if (!parent->parent)" and add {} around the 
body (since it's 3 lines long).  Also, although this doesn't really 
matter, you could consider putting the new code inside the previous big 
"if" statement instead of down here at the end of the function.

Otherwise the USB parts of this patch look okay to me.  I can't comment 
on the DT parts.

Alan Stern
