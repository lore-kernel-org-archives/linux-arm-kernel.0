From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 18 Apr 2014 14:02:37 +0200
Subject: [PATCH RFC 3/3] drm/exynos: use pending_components for	components
 tracking
In-Reply-To: <20140417220412.GZ24070@n2100.arm.linux.org.uk>
References: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
 <1397734130-21019-4-git-send-email-a.hajda@samsung.com>
 <20140417220412.GZ24070@n2100.arm.linux.org.uk>
Message-ID: <5351145D.8070207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2014 12:04 AM, Russell King - ARM Linux wrote:
> On Thu, Apr 17, 2014 at 01:28:50PM +0200, Andrzej Hajda wrote:
>> +static int exynos_drm_add_blocker(struct device *dev, void *data)
>> +{
>> +	struct device_driver *drv = data;
>> +
>> +	if (!platform_bus_type.match(dev, drv))
>> +		return 0;
>> +
>> +	device_lock(dev);
>> +	if (!dev->driver)
>> +		exynos_drm_dev_busy(dev);
>> +	device_unlock(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void exynos_drm_init_blockers(struct device_driver *drv)
>> +{
>> +	bus_for_each_dev(&platform_bus_type, NULL, drv, exynos_drm_add_blocker);
>> +}
> This feels very wrong to be dumping the above code into every driver which
> wants to make use of some kind of componentised support.
>
> You also appear to need to know the struct device_driver's for every
> component.  While that may work for exynos, it doesn't work elsewhere
> where the various components of the system are very real separate
> kernel modules - for example, a separate I2C driver such as the TDA998x
> case I mentioned in my first reply.
>
> I can't see how your solution would be usable in that circumstance.

It is up to the master driver how it want to create list of required
devices,
this is why I put it into exynos_drm and not into the framework.
You can use superdevice DT node for it, fixed list whatever you want.
It is not a part of the framework, it is just part of exynos_drm specific
implementation.
Component framework also does not provide mechanism for it.

Regarding TDA998x I have replied in the previous e-mail.

>
> The third issue I have is that you're still needing to have internal
> exynos sub-device management - you're having to add the individual
> devices to some kind of list, array or static data, and during DRM
> probe you're having to then walk these lists/arrays/static data to
> locate these sub-devices and finish each of their individual
> initialisations.  So you're ending up with a two-tier initialisation.
>
> That's not particularly good because it means you're exposed to
> problems where the state is different between two initialisations -
> when the device is recreated, your component attempts to re-finalise
> the initialisation a second time.  It wouldn't take much for a field
> to be assumed to be zero at init time somewhere for a bug to creep
> in.
>

Separation of the interfaces exposed by the device from the device itself
seems to me a good thing. I would even consider it as a biggest
advantage of this solution :)

The problem of re-initialization does not seems to be relevant here, it
is classic
problem of coding correctness nothing more, it can appear here and in
many different
places.

Anyway it seems we have different point of view on the problem, your say
about
devices with two stage initialization. I see it more as devices
registering interfaces and superdevice
using it.

Regards
Andrzej
