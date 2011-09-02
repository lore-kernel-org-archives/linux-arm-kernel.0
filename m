From: gregkh@suse.de (Greg KH)
Date: Fri, 2 Sep 2011 09:24:40 -0700
Subject: [PATCH 1/5] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <201109021602.14782.arnd@arndb.de>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
	<20110901233403.GA28176@suse.de> <201109021602.14782.arnd@arndb.de>
Message-ID: <20110902162440.GA5331@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2011 at 04:02:14PM +0200, Arnd Bergmann wrote:
> On Friday 02 September 2011, Greg KH wrote:
> > On Thu, Sep 01, 2011 at 01:27:19PM +0100, Lee Jones wrote:
> > > +
> > > +int __init soc_device_register(struct device *dev)
> > 
> > Don't pass a struct device in here, why are you making the caller create
> > the device?  This is the function that should create it for you?
> 
> Well, when we have device tree based probing, the soc device might already
> have been created by of_bus_probe(), so we just want to pass it to the
> soc core code in order to create the common interfaces. 

No, you want to pass the PARENT pointer in here that this new SOC device
will hang off of.  You can't expect to pass in any old random struct
device and expect it to make any kind of sense at all.

> It's probably not right that soc_device_register actually calls
> device_register, because when you have a device that you pass in,
> it will already be registered.

And where would it be registered?  No, please don't do this, again, have
this code create the struct device because it is responsible for it.
That's the way the rest of the kernel works, please don't try to create
new models to confuse everyone even more than is needed :)

> > > diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> > > new file mode 100644
> > > index 0000000..811d7fe
> > > --- /dev/null
> > > +++ b/include/linux/sys_soc.h
> > > @@ -0,0 +1,27 @@
> > > +/*
> > > + * Copyright (C) ST-Ericsson SA 2011
> > > + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
> > > + * License terms:  GNU General Public License (GPL), version 2
> > > + */
> > > +#ifndef __SYS_SOC_H
> > > +#define __SYS_SOC_H
> > > +
> > > +#include <linux/kobject.h>
> > > +#include <linux/device.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +struct soc_device {
> > > +	struct device dev;
> > > +	const char *machine;
> > > +	const char *family;
> > > +	const char *revision;
> > > +	const char *(*pfn_soc_id)(void);
> > > +};
> > 
> > Nice structure, but why do you export it, you aren't using it anywhere,
> > nor should you be...
> 
> This gets filled by the soc-specific code with information that is exported
> through the common callbacks, so it needs to be visible to the platforms.

But this api doesn't allow that to happen, so use it to create the data
in the first place somehow, this is really confusing as-is.

> > > +
> > > +/**
> > > + * soc_device_register - register SoC as a device
> > > + * @dev: Parent node '/sys/devices/soc/X'
> > > + */
> > > +int soc_device_register(struct device *dev);
> > 
> > This whole api needs to be rethunk, please, it's really wrong.
> > 
> > What you want is a way to create a soc device, by calling a function,
> > not be responsible for creating it, then call the soc core, and then
> > somehow, removing it.
> 
> Yes, it's definitely still not where it ought to be, and we've been
> discussing this for ages. It all started out as a way to find out
> information about the system, and I suggested to better make that
> information part of the interface for the soc node that is required
> anyway, rather than making up a purely fictional device.
> 
> Now, we need this to cover two scenarios:
> 
> 1. The classic setup without device tree where the soc node is
>    created by platform code. This would work great by just calling
>    a function that creates the device and lets the soc code add
>    the children according to compile-time tables of child devices.
> 
> 2. Probing from OF device-tree, where the linux device tree is populated
>    by walking the devices found in the flat device tree description.
>    This doesn't really fit your suggestion, nor does it fit Lee's
>    patch really, because it would require reparenting the soc node
>    into /sys/devices/soc and registering it again after it's already
>    registered.

No it would not, both of these work just fine like we handle with all
other subsystems.  You pass in the parent, and if it is not present, the
device will show up under /sys/devices/virtual/ just fine.  Please don't
create new type of things here.

> I think the ideal solution would be to make the soc layer a
> class that can be set when initially adding the device (one way
> or another) and that adds the standard attributes. Since you don't
> really like classes any more, another option would be to just
> have a function call that adds an attribute group to the soc node,
> but then it's not easy to find which devices are actually soc
> root nodes.

Then make it a bus, like it should be, which would solve all of this,
right?

> > Oh wait, you forgot to have a function to remove anything created with
> > the above call, that seems really broken and wrong.
> 
> There is no way to remove a soc from the system, just like there
> is no complementary function to pcibios_scan_root that removes
> the PCI root bridge.

And no one is ever going to remove the module that created the SOC
device in the first place?  It just really bothers me to see creation
code but no removal code, as it feels wrong somehow :)

thanks,

greg k-h
