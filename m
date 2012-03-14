From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 09:48:44 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203140840.18333.sr@denx.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203131644.12048.arnd@arndb.de> <201203140840.18333.sr@denx.de>
Message-ID: <201203140948.44823.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Stefan Roese wrote:

> > This is very cool, welcome onboard for the DT conversion with spear600!
> > 
> > > +static struct amba_device *amba_devs[] __initdata = {
> > > +	&gpio_device[0],
> > > +	&gpio_device[1],
> > > +	&gpio_device[2],
> > > +	&uart_device[0],
> > > +	&uart_device[1],
> > > +};
> > 
> > I would suggest you convert these to DT next so you can remove the
> > amba_devs list. Which devices are these? If they are pl061 and
> > pl010/pl011, the binding should be really easy to do.
> 
> Yes. I really wanted to do that. But from a quick look at the pl011 driver 
> (drivers/tty/serial/amba-pl011.c), this driver doesn't support DT probing. I 
> might have missed something here though. And ideas?

amba primecell devices don't actually need to register to a "compatible"
property, they are probed using the primecell ID, and the device tree
is just used to tell the system about memory and IRQ resources.

The pl061 driver has support for setting the gc.base and irq_base using
device tree instead of the platform data and that might be enough.

> > Since there is only one upstream board file and that is for the same board,
> > we can soon collapse all of it into the base platform support.
> > 
> > I think you should add all the code from this file to spear6xx.c instead
> > of adding a new file. We can then delete the spear600.c and spear600_evb.c
> > files once the DT support has matured.
> 
> Sounds like a plan. I'll rework the patch soon.

Great!

Don't worry about the the gpio and uart devices if they are not in the
first initial version. I do think that they should be done fairly soon
though, before we get into most of the other devices.

It's ok if you put a lot of the other devices in the dts file though,
like the ethernet device, it gives a better overview of what is actually
there, even if the driver does not actually use it yet.

	Arnd
