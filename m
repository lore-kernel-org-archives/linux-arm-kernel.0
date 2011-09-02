From: gregkh@suse.de (Greg KH)
Date: Fri, 2 Sep 2011 11:14:48 -0700
Subject: [PATCH 1/5] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <201109021922.04449.arnd@arndb.de>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
	<4E609784.3080507@linaro.org> <20110902163136.GB5331@suse.de>
	<201109021922.04449.arnd@arndb.de>
Message-ID: <20110902181448.GB29430@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2011 at 07:22:04PM +0200, Arnd Bergmann wrote:
> On Friday 02 September 2011, Greg KH wrote:
> > no.
> > 
> > How did you pass the attribute data into this core so that it knows how
> > to get to it?  You didn't, which is a mess.
> > 
> > How about something like:
> >         struct soc_device *soc_device_create(struct device *parent, struct soc_device_attributes *attr);
> > 
> > That would have the proper way to handle lifetime rules, userspace
> > notificatation of userpace, placement in sysfs, and all the other good
> > stuff.
> 
> I early on objected to the individual soc driver providing a set of
> attributes, because we really want the attributes to follow a
> common interface and I want to make it *hard* to add arbitrary
> other attributes that are not documented.

That's fine, which is why the struct soc_device_attributes are there,
those are common and well defined.

We can just do a simple return of 'int' to keep the caller from ever
having access to the device at all, which, if these can never be
removed, is a great way to keep anyone from messing with them.

So the interface gets even simpler:
	int soc_device_create(struct device *parent, struct soc_device_attributes *attr);

Look good?

> > > >> +
> > > >> +  if (!soc_count) {
> > > >> +          /* Register top-level SoC device '/sys/devices/soc' */
> > > >> +          ret = device_register(&soc_grandparent);
> > > > 
> > > > device_register can't be called with a spinlock.  You must have gotten
> > > > lucky in your testing, if you tested this.
> > > > 
> > > > Anyway, this is not needed at all, please don't create "dummy" devices
> > > > in the sysfs tree, properly hook up your new device to where it should
> > > > be in the device tree.
> > > 
> > > We need a /sys/devices/soc, how else can this be done?
> > 
> > No you do not not, why would you think so?
> 
> Well, where is all comes from is the desire to have a way from user space
> to find these devices, based on some path in the device tree. We had
> discussed putting it into
> 
> /sys/class/soc
> /sys/bus/soc
> /sys/devices/platform/soc
> /sys/devices/platform/soc%d
> 
> and a few others and eventually settled on /sys/devices/soc.

No, please use /sys/bus/soc as these are all of the same "type".

> > > Would it make you happier if I called it a bus?
> > 
> > Yes, see the other response about creating a bus for these, which would
> > give you /sys/bus/soc/ where you can properly enumerate your devices,
> > which is what I think you want to be able to do, right?
> 
> I think that would be a reasonable interface, but how does this work
> when the device was created by of_platform_bus_probe? Should we
> assume that any top-level device in the flattened device tree is
> a soc? How about just adding a child device in each soc node that
> is registered to the soc_bus_type?

Yes, that will work with the above soc_device_create() call.

> That would end up looking like
> 
> /sys/devices/db8500
> 		   /soc0   # this is the soc device
> 		   /i2c-0  # and here are the other platform devices below db8500 
> 		   /spi-0
>     /bus/soc/devices/soc0 -> ../../../devices/db8500/soc0
>     /bus/platform/devices/i2c-0 -> ../../../devices/db8500/i2c-0

Looks good to me.  Using a bus, and the above interface, will result in
this.

thanks,

greg k-h
