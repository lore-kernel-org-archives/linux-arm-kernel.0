From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Sep 2013 13:28:09 +0100
Subject: dev->of_node overwrite can cause device loading with different
 driver
In-Reply-To: <20130914121729.GA7823@kroah.com>
References: <20130913155331.GC14456@pengutronix.de>
 <20130913171046.GA26207@kroah.com> <20130914071653.GA26512@pengutronix.de>
 <20130914121729.GA7823@kroah.com>
Message-ID: <20130914122809.GI12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 14, 2013 at 05:17:29AM -0700, Greg Kroah-Hartman wrote:
> On Sat, Sep 14, 2013 at 09:16:53AM +0200, Markus Pargmann wrote:
> > 3. We could fix up all drivers that change the of_node. But there are
> >    ARM DT frameworks that require a device struct as parameter instead
> >    of a device_node parameter (e.g. soc-generic-dmaengine-pcm). So a
> >    driver core, initialized by a glue driver with DT bindings, has to
> >    set dev->of_node to use those frameworks. I think it is strange to
> >    have such DT framework interfaces if a driver is not supposed to
> >    overwrite dev->of_node permanently.
> 
> How about any driver that does muck with this structure, restore it
> properly if their probe() function fails?  Yes, you show that this is
> going to be tricky in some places (i.e. musb), but it makes sense that
> the burden of fixing this issue would rest on them, as they are the ones
> causing this problem, right?

It's not about overwriting at all.

It's quite simple:

1. OF creates a platform device and attaches an of_node to it.
2. This platform device is matched using the data in the of_node structure
   against one of the MUSB stub drivers.
3. The MUSB stub driver creates a new platform device, and copies the
   of_node to it, and registers it.
4. This new platform device _can_ itself be matched against the stub
   driver using the of_node structure.  When this happens, go to step
   2 and repeat 2-4.

That's where the problem is - it's not about overwriting an existing
platform device's of_node pointer with something that the driver has
dreamt up at all.

If we're lucky, step 3.5 would be "match against the 'musb-hdrc' driver
and successfully probe it" which is the only thing that would break
the above loop.
