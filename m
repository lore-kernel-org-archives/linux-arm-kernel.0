From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 18 Jan 2016 15:13:09 +0800
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <Pine.LNX.4.44L0.1601151220020.1533-100000@iolanthe.rowland.org>
References: <1452877630.6067.97.camel@pengutronix.de>
 <Pine.LNX.4.44L0.1601151220020.1533-100000@iolanthe.rowland.org>
Message-ID: <20160118071309.GC8150@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 12:30:41PM -0500, Alan Stern wrote:
> On Fri, 15 Jan 2016, Philipp Zabel wrote:
> 
> > > +- reg: the port number which this device is connecting to.
> > 
> > Should it be noted here that the port number range is 1-255?
> 
> Actually the range is 1 - 31 (defined by USB_MAXCHILDREN set in 
> include/uapi/linux/usb/ch11.h).
> 
> > > @@ -502,11 +503,14 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
> > >  	dev->connect_time = jiffies;
> > >  	dev->active_duration = -jiffies;
> > >  #endif
> > > -	if (root_hub)	/* Root hub always ok [and always wired] */
> > > +	if (root_hub) {	/* Root hub always ok [and always wired] */
> > >  		dev->authorized = 1;
> > > -	else {
> > > +		dev->of_node = bus->controller->of_node;
> > 
> > Why can't the root_hub reuse dev->dev.of_node?
> 
> Indeed, there's no need to add an .of_node field to struct usb_device, 
> since the embedded struct device already contains an .of_node field.
> 

No, the usb_device needs the .of_node field.

The devices belong to platform bus contains device node.
The devices (usb device) belong to USB bus which are created
dynamically do not contain device node.

-- 

Best Regards,
Peter Chen
