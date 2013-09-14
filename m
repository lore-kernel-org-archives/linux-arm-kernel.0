From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 14 Sep 2013 05:17:29 -0700
Subject: dev->of_node overwrite can cause device loading with different
 driver
In-Reply-To: <20130914071653.GA26512@pengutronix.de>
References: <20130913155331.GC14456@pengutronix.de>
 <20130913171046.GA26207@kroah.com>
 <20130914071653.GA26512@pengutronix.de>
Message-ID: <20130914121729.GA7823@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 14, 2013 at 09:16:53AM +0200, Markus Pargmann wrote:
> > Ok, so what do you suggest we do for stuff like this?  Fix up the musb
> > driver?  Or something else?
> 
> I think there are three options to solve this:
> 
> 1. Break out of the driver list iteration loop as soon as a driver probe
>    function fails. This way there is no possibility for another driver
>    to be probed with a device struct that was changed by the first
>    driver. But it would remove the support to fall back to
>    another driver for a device. I am not aware of any device that is
>    supported by multiple drivers.

No, that's not ok, lots of drivers say "I support all devices, send them
to me!" and then fail their probe function when they realize they don't
really support a specific device that was sent to them.  So that
wouldn't work at all, as you would break all of those situations.

> 2. We could restore the device struct completely or partially (only
>    of_node) after a probe failure. This would avoid driver probes with
>    unclean device structs, but introduces some overhead.

Overhead isn't an issue here, this is not "performance critical" code
paths.  But it would be messy.

> 3. We could fix up all drivers that change the of_node. But there are
>    ARM DT frameworks that require a device struct as parameter instead
>    of a device_node parameter (e.g. soc-generic-dmaengine-pcm). So a
>    driver core, initialized by a glue driver with DT bindings, has to
>    set dev->of_node to use those frameworks. I think it is strange to
>    have such DT framework interfaces if a driver is not supposed to
>    overwrite dev->of_node permanently.

How about any driver that does muck with this structure, restore it
properly if their probe() function fails?  Yes, you show that this is
going to be tricky in some places (i.e. musb), but it makes sense that
the burden of fixing this issue would rest on them, as they are the ones
causing this problem, right?

thanks,

greg k-h
