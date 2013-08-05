From: tony@atomide.com (Tony Lindgren)
Date: Sun, 4 Aug 2013 23:55:35 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130802141449.GA7533@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802090355.GF7656@atomide.com>
 <20130802093222.GA8982@kroah.com>
 <20130802123445.GG7656@atomide.com>
 <20130802141449.GA7533@kroah.com>
Message-ID: <20130805065535.GP7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Greg KH <greg@kroah.com> [130802 07:20]:
> On Fri, Aug 02, 2013 at 05:34:45AM -0700, Tony Lindgren wrote:
> > * Greg KH <greg@kroah.com> [130802 02:37]:
> > > On Fri, Aug 02, 2013 at 02:03:55AM -0700, Tony Lindgren wrote:
> > > > * Greg KH <greg@kroah.com> [130801 12:33]:
> > > > > 
> > > > > The driver core handles this really well, you just have to create new
> > > > > busses, and don't rely on the "catch-all" platform_bus.
> > > > 
> > > > Hmm do you have some example of a device driver that is generic and
> > > > is supported on platform_bus and some other bus?
> > > 
> > > Take a look at drivers/usb/host/ohci* for one example that I know of,
> > > there are others all through the kernel as well.
> > 
> > Uhh OK so I guess the answer is that the bus glue still needs to
> > be implemented separately for each driver and there's no generic
> > way of supporting multiple busses?
> 
> Different busses implies that there are different ways to physically
> talk to the device hardware, so of course there is no generic way to
> support that.

Right, but in many cases the only difference between SoCs are some bus
specific things like reset and idling of the devices. And using platform
bus allows the driver to stay generic.

> Unless your subsystem wants to do what we did for USB, and define a
> generic way to talk to the hardware in a very abstract way, allowing for
> totally different types of physical layers to handle lots of different
> logical layer drivers.  But odds are, you don't want to do that.
> 
> It should be easy to just abstract out your "this is how I write a byte
> to the hardware" logic to handle the different bus types, if you really
> are using the same chip/core.  Lots of drivers do this today just fine,
> it isn't a big deal.

I agree that makes sense for the driver specific things.

But for things that are completely bus specific for various SoCs, how
would you like to handle those?

For example, we are currently using platform bus and bus notifiers and
then the runtime PM calls from device driver trigger the bus specific
things.

Would you prefer to instead use a custom bus instead of extending
the platform bus for things like that?

Regards,

Tony
