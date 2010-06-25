From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 25 Jun 2010 14:08:51 -0600
Subject: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
In-Reply-To: <874ogrng3j.fsf@deeprootsystems.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com>
Message-ID: <AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 12:04 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
>> On Thu, Jun 24, 2010 at 5:43 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Implement the new runtime PM framework as a thin layer on top of the
>>> omap_device API. ?Since we don't have an OMAP-specific bus, override
>>> the runtime PM hooks for the platform_bus for the OMAP specific
>>> implementation.
>>>
>>> While the runtime PM API has three main states (idle, suspend, resume)
>>> This version treats idle and suspend the same way by implementing both
>>> on top of omap_device_disable(), which follows closely with how driver
>>> are currently using clock enable/disable calls. Longer-termm
>>> pm_runtime_idle() could take other constraints into consideration to
>>> make the decision, but the current
>>>
>>> Device driver ->runtime_suspend() hooks are called just before the
>>> device is disabled (via omap_device_idle()), and device driver
>>> ->runtime_resume() hooks are called just after device has been
>>> enabled (via omap_device_enable().)
>>
>> Hi Kevin,
>
> Hi Grant. ?Thanks for the review and suggestions.
>
>> You shouldn't hijack the platform bus in this way, for a number of
>> reasons. ?Not all platform devices in an OMAP system are internal OMAP
>> devices (as you know since you do an explicit check for omap devices).
>> ?Right there that says that the abstraction is at the wrong level.
>> What happens when an mostly transparent bridge is added with its own
>> peripherals and its own special operations? ?Does this routine then
>> need to be extended for each new special case? ?It's not maintainable
>> in the long run.
>>
>> This approach is also not multiplatform friendly (cc'ing Eric and
>> Nicolas who are working on ARM multiplatform). ?It won't work for
>> building a kernel that supports, say, both versatile and OMAP.
>
> Totally agree here, but this a separate issue not specifically created
> by this series (it was created when runtime PM support for SH was
> added), but indeed I am continuining bad behavior. :/

I think I could successfully argue that ARM is more important that SH.
 If SH messes up it's sandbox the collateral damage isn't nearly so
severe.  Don't follow the SH lead in this case.

> The issue is that the current method to override bus methods is by
> overriding weak symbols. ?This clearly doesn't scale to support multiple
> platforms in the same image.

Agreed.  It scales better to change the hooks at runtime, which is
actually quite easy, but it still leaves the abstraction at the wrong
level.

> What would be needed (if we continue to override the platform_bus
> methods) is to have some sort of register function for overriding these
> methods. ?I'll look into that based on the result of discussions
> below...
>
>> The kernel already has the facility to do what you need. ?We talked
>> about it briefly at ELC, and now that I look at it closer, I thing
>> gregkh is absolutely right. ?Just create a new bus type for OMAP
>> devices. ?It is simple to add one. ?You can probably even call out to
>> the platform bus ops for most of the operations. ?The fact that OMAP
>> devices have special behaviour that needs to be handled at the bus
>> type level means that they are not platform devices anymore. ?This
>> also eliminates all the omap_device_is_valid and OMAP_DEVICE_MAGIC
>> gymnastics.
>>
>> I see from the comments in omap_device.c that doing an
>> omap_bus/omap_device is being considered anyway. ?Please don't merge
>> this patch and do the omap_bus_type instead.
>
> Agreed, it is logicially simpler in many ways and as you've noticed,
> we've been discussing it in the OMAP community.
>
> However, I keep coming back to extending the platform bus, primarily
> since the resulting new bus code would look almost identical to the
> platform bus. ?All I really needed is the ability to extend a small
> subset of the PM functions, so this led to me the "extend instead of
> duplicate" approach.
>
> In addition, I really don't want to duplicate all the platform_driver
> and platform_device code, again because it would be identical but
> especially since this would seriously impact many drivers. ?For drivers
> that are used on OMAP and also on other platforms, do we want drivers to
> know (or care) if they are on the platform bus or on the OMAP bus?

Some questions to make sure I understand:
Do you have a lot of these cases?
Do non-OMAP devices also have to process the omap clock enable/disable
code too, or is this only for stuff that is internal to the chip?
Or is this the case where existing non-omap device drivers can also
drive the omap SoC hardware?

> I think this is how it is done for OF devices, but I'm not crazy about
> that approach (after our discussions at ELC, I remember thinking you'd
> been through this with the OF devices as well and are moving towards
> using platform_bus/platform_device for those too. ?Did I understand
> correctly?)

Yes, I've got patches which merge of_platform_bus_type with the
platform bus.  This was an easy decision to make because the
of-specific bits (specifically, matching an of_device_id table with a
device tree node) are applicable to all bus types; i2c, spi, mdio,
platform, etc).  The needed OF data structures have been moved into
struct device and struct device_driver so that of_platform_bus_type no
longer has anything different.

The drivers still need to care about OF when extra platform data needs
to be extracted from the DT node, but for IRQs and register ranges it
is automatic.

The omap case looks different.  You've got special runtime pm ops that
you want to hook in; but only for omap_devices.  It doesn't really
apply to more than one bus type in the system.

> This affects many aspects of all drivers, from register and probe (for
> early devices/drivers too!) to all the plaform_get_resource() usage, all
> of which assumes a platform_driver and platform_device. ?I didn't look
> closely, but I didn't see if (or how) OF was handling early devices.

You don't have to reimplement the entire platform bus.  You could
simply create a new bus type, but reuse all the existing platform bus
code.  All that changes is the bus type that the device and the driver
gets registered on.  Then you could easily replace only the functions
that matter.  (do a git grep platform_bus_type to see how few
references there actually are.  It looks like there are only 5
references to it in drivers/base/platform.c that you'd need to work
around; in platform_device_add(), platform_driver_register(), 2 in
platform_driver_probe(), and the register in platform_bus_init().  You
may not even need to reimplement platform_driver_probe().

It might even be as simple as doing this:
-        pdev->dev.bus = &platform_bus_type;
+       if (!pdev->dev.bus)
+                pdev->dev.bus = &platform_bus_type;

So that a different bus type can be selected at device registration
time (but this might be a little on the dangerous side.  It might be
better to have a wrapper function that accepts an omap_device, and
then does the appropriate registration so that the compiler can
type-check it for you).

Another way to look at the problem is that these runtime
customizations are kind of a property of the parent device (the bus,
not the bus_type).  Would it make sense for parent devices to have
runtime ops to perform for each child that is suspended/resumed?  That
would make it simple to register another device that implements the
bus behaviour and attach it at runtime instead of compile time.

So, instead of having all the platform_bus_type devices as children of
the "platform" device (/sys/devices/platform/*), you could set the
omap devices to be children of an omap bus device
(/sys/devices/omap/*).  Different busses can also implement different
behaviour by using a different parent device.  For example:

/sys/devices/platform
/sys/devices/omap-bus-a
/sys/devices/omap-bus-a/omap-bus-b

Thoughts?

> All that being said, if I could create a custom bus, but continue to use
> platform_devices, that would greatly simply the changes to drivers. ?Do
> you think that's acceptable? ?If so, I can take a stab at that and see
> what it looks like.

Heh, I should read the whole email before replying.  See above.

>> Also, I notice that most of these hooks open-code the generic versions
>> of the runtime hooks. ?Instead of open coding it, can the omap hooks
>> call the generic hooks before/after doing the omap-specific work?
>
> Ah, good point.
>
> This patch pre-dates the creation of pm_generic_runtime_*, but certainly
> should be upgraded to use those. ?Thanks.
>
> Kevin
>
>
>> Cheers,
>> g.
>>
>>>
>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>> ---
>>> ?arch/arm/mach-omap2/Makefile | ? ?7 +++-
>>> ?arch/arm/mach-omap2/pm_bus.c | ? 70 ++++++++++++++++++++++++++++++++++++++++++
>>> ?2 files changed, 76 insertions(+), 1 deletions(-)
>>> ?create mode 100644 arch/arm/mach-omap2/pm_bus.c
>>>
>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>> index ea52b03..8ed47ea 100644
>>> --- a/arch/arm/mach-omap2/Makefile
>>> +++ b/arch/arm/mach-omap2/Makefile
>>> @@ -46,12 +46,17 @@ obj-$(CONFIG_ARCH_OMAP2) ? ? ? ? ? ?+= sdrc2xxx.o
>>> ?ifeq ($(CONFIG_PM),y)
>>> ?obj-$(CONFIG_ARCH_OMAP2) ? ? ? ? ? ? ? += pm24xx.o
>>> ?obj-$(CONFIG_ARCH_OMAP2) ? ? ? ? ? ? ? += sleep24xx.o
>>> -obj-$(CONFIG_ARCH_OMAP3) ? ? ? ? ? ? ? += pm34xx.o sleep34xx.o cpuidle34xx.o
>>> +obj-$(CONFIG_ARCH_OMAP3) ? ? ? ? ? ? ? += pm34xx.o sleep34xx.o cpuidle34xx.o \
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?pm_bus.o
>>> ?obj-$(CONFIG_PM_DEBUG) ? ? ? ? ? ? ? ? += pm-debug.o
>>>
>>> ?AFLAGS_sleep24xx.o ? ? ? ? ? ? ? ? ? ? :=-Wa,-march=armv6
>>> ?AFLAGS_sleep34xx.o ? ? ? ? ? ? ? ? ? ? :=-Wa,-march=armv7-a
>>>
>>> +ifeq ($(CONFIG_PM_VERBOSE),y)
>>> +CFLAGS_pm_bus.o ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= -DDEBUG
>>> +endif
>>> +
>>> ?endif
>>>
>>> ?# PRCM
>>> diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
>>> new file mode 100644
>>> index 0000000..9719a9f
>>> --- /dev/null
>>> +++ b/arch/arm/mach-omap2/pm_bus.c
>>> @@ -0,0 +1,70 @@
>>> +/*
>>> + * Runtime PM support code for OMAP
>>> + *
>>> + * Author: Kevin Hilman, Deep Root Systems, LLC
>>> + *
>>> + * Copyright (C) 2010 Texas Instruments, Inc.
>>> + *
>>> + * This file is licensed under the terms of the GNU General Public
>>> + * License version 2. This program is licensed "as is" without any
>>> + * warranty of any kind, whether express or implied.
>>> + */
>>> +#include <linux/init.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/io.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/mutex.h>
>>> +
>>> +#include <plat/omap_device.h>
>>> +#include <plat/omap-pm.h>
>>> +
>>> +#ifdef CONFIG_PM_RUNTIME
>>> +int platform_pm_runtime_suspend(struct device *dev)
>>> +{
>>> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
>>> + ? ? ? struct omap_device *odev = to_omap_device(pdev);
>>> + ? ? ? int r, ret = 0;
>>> +
>>> + ? ? ? dev_dbg(dev, "%s\n", __func__);
>>> +
>>> + ? ? ? if (dev->driver->pm && dev->driver->pm->runtime_suspend)
>>> + ? ? ? ? ? ? ? ret = dev->driver->pm->runtime_suspend(dev);
>>> + ? ? ? if (!ret && omap_device_is_valid(odev)) {
>>> + ? ? ? ? ? ? ? r = omap_device_idle(pdev);
>>> + ? ? ? ? ? ? ? WARN_ON(r);
>>> + ? ? ? }
>>> +
>>> + ? ? ? return ret;
>>> +};
>>> +
>>> +int platform_pm_runtime_resume(struct device *dev)
>>> +{
>>> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
>>> + ? ? ? struct omap_device *odev = to_omap_device(pdev);
>>> + ? ? ? int r, ret = 0;
>>> +
>>> + ? ? ? dev_dbg(dev, "%s\n", __func__);
>>> +
>>> + ? ? ? if (omap_device_is_valid(odev)) {
>>> + ? ? ? ? ? ? ? r = omap_device_enable(pdev);
>>> + ? ? ? ? ? ? ? WARN_ON(r);
>>> + ? ? ? }
>>> +
>>> + ? ? ? if (dev->driver->pm && dev->driver->pm->runtime_resume)
>>> + ? ? ? ? ? ? ? ret = dev->driver->pm->runtime_resume(dev);
>>> +
>>> + ? ? ? return ret;
>>> +};
>>> +
>>> +int platform_pm_runtime_idle(struct device *dev)
>>> +{
>>> + ? ? ? int ret;
>>> +
>>> + ? ? ? ret = pm_runtime_suspend(dev);
>>> + ? ? ? dev_dbg(dev, "%s [%d]\n", __func__, ret);
>>> +
>>> + ? ? ? return 0;
>>> +};
>>> +#endif /* CONFIG_PM_RUNTIME */
>>> +
>>> --
>>> 1.7.0.2
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
