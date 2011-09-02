From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Sep 2011 19:32:54 +0200
Subject: [PATCH 1/5] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <20110902162440.GA5331@suse.de>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
	<201109021602.14782.arnd@arndb.de> <20110902162440.GA5331@suse.de>
Message-ID: <201109021932.54615.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 September 2011, Greg KH wrote:
> On Fri, Sep 02, 2011 at 04:02:14PM +0200, Arnd Bergmann wrote:
> > On Friday 02 September 2011, Greg KH wrote:
> > > > diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> > > > new file mode 100644
> > > > index 0000000..811d7fe
> > > > --- /dev/null
> > > > +++ b/include/linux/sys_soc.h
> > > > @@ -0,0 +1,27 @@
> > > > +/*
> > > > + * Copyright (C) ST-Ericsson SA 2011
> > > > + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
> > > > + * License terms:  GNU General Public License (GPL), version 2
> > > > + */
> > > > +#ifndef __SYS_SOC_H
> > > > +#define __SYS_SOC_H
> > > > +
> > > > +#include <linux/kobject.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/platform_device.h>
> > > > +
> > > > +struct soc_device {
> > > > +	struct device dev;
> > > > +	const char *machine;
> > > > +	const char *family;
> > > > +	const char *revision;
> > > > +	const char *(*pfn_soc_id)(void);
> > > > +};
> > > 
> > > Nice structure, but why do you export it, you aren't using it anywhere,
> > > nor should you be...
> > 
> > This gets filled by the soc-specific code with information that is exported
> > through the common callbacks, so it needs to be visible to the platforms.
> 
> But this api doesn't allow that to happen, so use it to create the data
> in the first place somehow, this is really confusing as-is.

Yes, that is true. I hadn't noticed the 'struct device' in the above
structure. What really needs to happen is the platform code to fill
out a structure with all the attribute data and to pass that into
the soc common code as constant data which then gets added to the
device data.

> > I think the ideal solution would be to make the soc layer a
> > class that can be set when initially adding the device (one way
> > or another) and that adds the standard attributes. Since you don't
> > really like classes any more, another option would be to just
> > have a function call that adds an attribute group to the soc node,
> > but then it's not easy to find which devices are actually soc
> > root nodes.
> 
> Then make it a bus, like it should be, which would solve all of this,
> right?

I'm not sure if we're talking about the same thing. Do you mean
adding an artifical device (like a class_device) under the soc
device node and have that be of soc_bus type? Or do you mean
putting the entire soc with all its platform_device children
on the soc_bus?

In the former case, it's a somewhat ugly representation. It
would be really nice for the soc to be just one device, not
one device to hang all the children off and another one to
provide a user-space interface.

In the latter case, we would have to rewrite the way we probe
SoCs from the device tree so that the root node of the soc
becomes a soc_bus device instead of a platform_bus device.

> > > Oh wait, you forgot to have a function to remove anything created with
> > > the above call, that seems really broken and wrong.
> > 
> > There is no way to remove a soc from the system, just like there
> > is no complementary function to pcibios_scan_root that removes
> > the PCI root bridge.
> 
> And no one is ever going to remove the module that created the SOC
> device in the first place?  It just really bothers me to see creation
> code but no removal code, as it feels wrong somehow :)

SoC code fundamentally cannot be a module, since the soc contains
all the basic stuff like irq controller, clocksource etc. If it didn't
have those, it would not be a system-on-a-chip but rather some random
multifunction device you hang off some bus.

	Arnd
