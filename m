From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 18 Jun 2015 16:57:09 +0200
Subject: [PATCH 00/13] Discover and probe dependencies
In-Reply-To: <55829269.2090309@samsung.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <55829269.2090309@samsung.com>
Message-ID: <CAAObsKB8tSYQ_Z-DAQjCH4evJ9yTOWhojNxjgBLuGdBd58mDNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 June 2015 at 11:42, Andrzej Hajda <a.hajda@samsung.com> wrote:
> Hi Tomeu,
>
> I have few comments about the design.
>
> On 06/17/2015 03:42 PM, Tomeu Vizoso wrote:
>> Hi,
>>
>> this is another attempt at preventing deferred probe from obscuring why your
>> devices aren't probing and from delaying to the end of the boot process the
>> probe of the device you care the most.
>>
>> The major differences with my previous approach [0] are:
>>
>> * Dependencies are probed before the target is probed, so we don't have nested
>>   probe() calls, avoiding a series of deadlock situations.
>>
>> * Dependencies could be stored and reused for other purposes such as for
>>   passing resources to drivers ala devm_probe, or for warning when a device is
>>   going to be unbound and has dependencies active, etc.
>
> With this approach we should assume many things, for example:
> 1. Dependencies are explicitly described in firmware (dts/dtb).
>     It will not work for example with lookup tables present in
> gpios/clocks/regulators.

Yes, but my understanding is that we are moving towards having the hw
described in fwnode (so DT, ACPI and board files), and these
dependencies are part of the hw description.

> 2. Provider create/register their resources only during probe.
>     It is not always the case - for example componentized drivers in
> probe often
>     calls only component_add, the real initialization is performed in
> bind callback.

We don't really try to bind the actual provider, but the platform
device from which it derives, assuming that once that platform device
finishes probing, the actual provider will have been probed as well.

>From what I gather from reading drivers/of/platform.c this assumption
has to hold for DT-based machines, but I'm not so sure about others.

> 3. Dependencies are mandatory, ie without it driver will not be able to
> successfully finish
> the probe.
>     It should be not true. Sometimes device will require given resource
> only in specific
>     scenario, or it can still probe successfully and ask for the
> resource later.
>     I can also imagine that firmware can describe more information than
> given driver require,
>     some resources even if they are present in the dts, will be not
> requested by the driver, it
>     can be the case of drivers providing limited functionality, or just
> obsolete bindings.
>
>
> I have also more general design objection, which should not be
> necessarily true:
> Device node describes piece of the hardware which should be mainly
> interpreted by the driver.
> Parsing it in external code [1] violates this idea. Additionally we will
> have the same information
> parsed and interpreted in two different places (discovery framework and
> the driver),
> it does not look good to me.
> But as I said earlier it is just my opinion, not a solid evidence :)

Yeah, I see that concern, but actually the code that interprets
dependencies are the subsystem cores, not the drivers themselves.

It's true that this approach introduces some code duplication that the
on-demand series doesn't, but I'm not sure it would be a clear win to
refactor that duplication away.

> [1]: I know that for example clk_get is also located in external
> framework but currently the driver
> decides that it should call clk_get, my_private_clk_get,
> other_framework_clk_get or do not call it at all,
> this framework assumes that it will be always clk_get, or at least
> something compatible with it at binding level.

Yeah, in this series I assume that if the gpio bindings say that
phandles in properties with names ending in -gpios, then any phandles
in properties with that name scheme should point to gpiochips.

I have done some grepping and for this and all the other generic
subsystems this seems to hold true (there aren't properties that
follow any of those name schemes and that contain some other
information).

Regards,

Tomeu

> Regards
> Andrzej
>
>
>>
>> * I have tried to keep it firmware-agnostic. The previous approach (on-demand
>>   probing) could be done like this as well, but would require adding fwnode
>>   APIs to all affected subsystems first.
>>
>> I have only implemented the class.get_dependencies() callback for the GPIO
>> subsystem and for the host1x bus because that's all that was needed on my Tegra
>> Chromebook to avoid deferred probes, but if this approach is deemed worthwhile
>> I will add more implementations so that deferred probes are avoided on the
>> other boards I have access to.
>>
>> [0] http://thread.gmane.org/gmane.linux.kernel.gpio/8465
>>
>> Thanks,
>>
>> Tomeu
>>
>> Tomeu Vizoso (13):
>>   gpiolib: Fix docs for gpiochip_add_pingroup_range
>>   driver-core: defer all probes until late_initcall
>>   ARM: tegra: Add gpio-ranges property
>>   pinctrl: tegra: Only set the gpio range if needed
>>   driver core: fix docbook for device_private.device
>>   of/platform: Set fwnode field for new devices
>>   driver-core: Add class.get_dependencies() callback
>>   gpio: sysfs: implement class.get_dependencies()
>>   gpu: host1x: implement class.get_dependencies()
>>   driver-core: add for_each_class()
>>   device property: add fwnode_get_parent()
>>   device property: add fwnode_get_name()
>>   driver-core: probe dependencies before probing
>>
>>  arch/arm/boot/dts/tegra114.dtsi |   1 +
>>  arch/arm/boot/dts/tegra124.dtsi |   1 +
>>  arch/arm/boot/dts/tegra20.dtsi  |   1 +
>>  arch/arm/boot/dts/tegra30.dtsi  |   1 +
>>  drivers/base/base.h             |   4 +-
>>  drivers/base/class.c            |  16 +++++
>>  drivers/base/dd.c               | 128 +++++++++++++++++++++++++++++++++++++++-
>>  drivers/base/property.c         |  38 ++++++++++++
>>  drivers/gpio/gpiolib-sysfs.c    |  81 +++++++++++++++++++++++++
>>  drivers/gpio/gpiolib.c          |   2 +-
>>  drivers/gpu/host1x/dev.c        |  47 +++++++++++++++
>>  drivers/of/platform.c           |   1 +
>>  drivers/pinctrl/pinctrl-tegra.c |  19 +++++-
>>  include/acpi/acpi_bus.h         |   5 ++
>>  include/linux/acpi.h            |   5 ++
>>  include/linux/device.h          |   6 ++
>>  include/linux/fwnode.h          |   5 ++
>>  include/linux/property.h        |   4 ++
>>  18 files changed, 361 insertions(+), 4 deletions(-)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
