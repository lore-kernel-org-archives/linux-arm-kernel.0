From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jun 2012 15:05:06 +0000
Subject: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
In-Reply-To: <20120629145203.GJ4202@atomide.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <201206291433.06718.arnd@arndb.de> <20120629145203.GJ4202@atomide.com>
Message-ID: <201206291505.07249.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 June 2012, Tony Lindgren wrote:
> > A lot of devices already provide the mac address in the device tree,
> > wherever that comes from. Ideally that would always be possible but
> > never necessary.
> > 
> > > > I'm not sure what it takes to add the link for the device node in the
> > > > usb probing code, but my feeling is that it's not too hard.
> > > > 
> > > > Right now, USB is probed entirely without DT, so the patch is about
> > > > the best we can do.
> > > 
> > > Right, but that still assumes a static mac from the bootloader unless
> > > we do a generic driver as below? Or do you have some other ideas?
> > 
> > The boot loader could theoretically have the same algorithm that Andy's
> > patch implements, unless it is configured to something else by the
> > user. In many cases, you don't want the boot loader to be that smart,
> > but sometimes it is the right solution.
> 
> OK that would mean bootloader modifying the .dtb then.

Right.

> > In the device tree, we can uniquely identify the USB hosts, that
> > is not a problem here. The problem exists only if you base your
> > path on the linux specific name for the devices.
> > It's definitely ugly to rely on that, but I think we can actually
> > guarantee that it's stable as long as we enforce in the
> > Kconfig/Kbuild that the controller that has the ethernet device
> > is always built-in on Panda and comes before the other one if
> > both are built-in. I would much prefer not to have to rely on
> > those things, but I believe it is actually guaranteed at the
> > moment for the cases that matter. While you could have both
> > controllers as loadable modules and load them in reverse
> > order that would also imply that you cannot actually boot from
> > the network, so you know that you have a file system on which
> > you can set the mac address of the device using udev, before
> > you start using networking.
> 
> OK. So how about we do the following:
> 
> 1. Make Andy's notifier part into a generic mac notifier
>    driver that can take platform data for the driver name
>    mac address pair. Devicetree binding could be added as
>    needed.

I don't think the devicetree bindign should be part of that
driver but instead should go into the individual network
device drivers, otherwise it sounds ok to me.
Obviously, this still needs buy-in from the networking
people.

> 2. Pass the Panda mac information as platform data to this
>    driver for now with a comment on the usb path naming being
>    potentially wrong in the loadable modules case.

IMHO code outside of the platform driver world would be more
appropriate here. It's not actually a platform device because
it's more of an abstract concept to define a mac address than
physical hardware.

A new file with a single global function in net/ethernet/
that you can use to register a callback sounds like the
easiest approach to me.

> 3. Add devicetree support to the driver once the USB binding
>    is available.

Here you mean the smsc95xx driver, not the new code, right?

> That will make my life much easier as then I'm not stuck with
> more legacy code to deal with ;) Also writing the driver part
> should be trivial as all the code is there already.

Sounds ok to me, if we can get Andy to reshuffle his code once
more ;-)

	Arnd
