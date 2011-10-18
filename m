From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Oct 2011 16:05:12 +0200
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <4E9D5FAB.2080605@linaro.org>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<20111017161854.GB5108@suse.de> <4E9D5FAB.2080605@linaro.org>
Message-ID: <201110181605.12512.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 October 2011, Lee Jones wrote:
> On 17/10/11 17:18, Greg KH wrote:
> > On Mon, Oct 17, 2011 at 12:52:54PM +0100, Lee Jones wrote:
> >> +{
> >> +	struct soc_device *soc_dev =
> >> +		container_of(dev, struct soc_device, dev);
> >> +
> >> +	sysfs_remove_group(&dev->kobj, &soc_attr_group);
> >> +
> >> +	if (device_is_registered(dev))
> >> +		device_unregister(dev);
> > 
> > Why is this call needed?
> 
> To unregister a previously unregistered device?
> 
> Is that wrong?

See Jamie's excellent explanation: you don't need to check
for device_is_registered() here, but just call device_unregister
unconditionally.

> >> +
> >> +	bus_unregister(&soc_bus_type);
> > 
> > What happens if you have more than one SOC device?  I think you just
> > oopsed.
> 
> I think you're right.
> 
> When to you suggest we unregister the bus?

Do it in the same way as registering it, as a module_exit() function
below the initcall that instantiates it. These interfaces usually come
in pairs, so if something does not look symmetric, you should better
have another look.

	Arnd
