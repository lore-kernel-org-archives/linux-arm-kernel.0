From: robh@kernel.org (Rob Herring)
Date: Sat, 26 Sep 2015 13:17:04 -0500
Subject: [PATCH v6 0/22] On-demand device probing
In-Reply-To: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <5606E120.3070305@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2015 09:02 AM, Tomeu Vizoso wrote:
> Hello,
> 
> I have a problem with the panel on my Tegra Chromebook taking longer
> than expected to be ready during boot (St?phane Marchesin reported what
> is basically the same issue in [0]), and have looked into ordered
> probing as a better way of solving this than moving nodes around in the
> DT or playing with initcall levels and linking order.
> 
> While reading the thread [1] that Alexander Holler started with his
> series to make probing order deterministic, it occurred to me that it
> should be possible to achieve the same by probing devices as they are
> referenced by other devices.
> 
> This basically reuses the information that is already implicit in the
> probe() implementations, saving us from refactoring existing drivers or
> adding information to DTBs.
> 
> During review of v1 of this series Linus Walleij suggested that it
> should be the device driver core to make sure that dependencies are
> ready before probing a device. I gave this idea a try [2] but Mark Brown
> pointed out to the logic duplication between the resource acquisition
> and dependency discovery code paths (though I think it's fairly minor).
> 
> To address that code duplication I experimented with Arnd's devm_probe
> [3] concept of having drivers declare their dependencies instead of
> acquiring them during probe, and while it worked [4], I don't think we
> end up winning anything when compared to just probing devices on-demand
> from resource getters.
> 
> One remaining objection is to the "sprinkling" of calls to
> of_device_probe() in the resource getters of each subsystem, but I think
> it's the right thing to do given that the storage of resources is
> currently subsystem-specific.
> 
> We could avoid the above by moving resource storage into the core, but I
> don't think there's a compelling case for that.
> 
> I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip and
> OMAP SoCs, and these patches were enough to eliminate all the deferred
> probes (except one in PandaBoard because omap_dma_system doesn't have a
> firmware node as of yet).
> 
> Have submitted a branch [5][6][7] with these patches on top of today's
> linux-next (20150921) to kernelci.org and I don't see any issues that
> could be caused by them.
> 
> With this series I get the kernel to output to the panel in 0.5s,
> instead of 2.8s.

I think we're pretty close other than some minor comments. I would like
to see ack's from Greg and some reviewed-bys from others. The subsystem
changes are minor and there has been plenty of chance to comment, so I
don't think acks from all subsystems are needed.

Your branch is based on -next. Is there any dependence on something in
-next? I want to get this into -next soon, but need a branch not based
on -next. Please send me a pull request with the collected acks and
minor comments I have addressed.

Rob

> 
> Regards,
> 
> Tomeu
> 
> [0] http://lists.freedesktop.org/archives/dri-devel/2014-August/066527.html
> 
> [1] https://lkml.org/lkml/2014/5/12/452
> 
> [2] https://lkml.org/lkml/2015/6/17/305
> 
> [3] http://article.gmane.org/gmane.linux.ports.arm.kernel/277689
> 
> [4] https://lkml.org/lkml/2015/7/21/441a
> 
> [5] https://git.collabora.com/cgit/user/tomeu/linux.git/log/?h=on-demand-probes-v8
> 
> [6] http://kernelci.org/boot/all/job/collabora/kernel/v4.3-rc2-2587-gf92b0ab33d14/
> 
> [7] http://kernelci.org/boot/all/job/next/kernel/next-20150921
> 
> Changes in v6:
> - Drop bus_type.pre_probe and read the periphid in match() instead as
>   suggested by Alan Stern.
> - Merge changes to the regulator subsystem's locking so no references
>   are leaked between commits.
> 
> Changes in v5:
> - Set the pointer to struct device also for AMBA devices
> - Unset the pointer to struct device when the platform device is about
>   to be unregistered
> - Increase the reference count of the device before returning from
>   of_find_device_by_node()
> - Move the assignment to device_node->device for AMBA devices to another
>   commit.
> - Hold a reference to the struct device while it's in use in
>   of_device_probe().
> - Use regulator_class' klist of devices instead of regulator_list to
>   store and lookup regulator devices.
> 
> Changes in v4:
> - Added bus.pre_probe callback so the probes of Primecell devices can be
>   deferred if their device IDs cannot be yet read because of the clock
>   driver not having probed when they are registered. Maybe this goes
>   overboard and the matching information should be in the DT if there is
>   one.
> - Rename of_platform_probe to of_device_probe
> - Use device_node.device instead of device_node.platform_dev
> - Add Kconfig DELAY_DEVICE_PROBES to allow disabling delayed probing in
>   machines with initcalls that depend on devices probing at a given time.
> - Start processing deferred probes in device_initcall_sync
> - Also defer probes of AMBA devices registered from the DT as they can
>   also request resources.
> 
> Changes in v3:
> - Set and use device_node.platform_dev instead of reversing the logic to
>   find the platform device that encloses a device node.
> - Drop the fwnode API to probe firmware nodes and add OF-only API for
>   now. I think this same scheme could be used for machines with ACPI,
>   but I haven't been able to find one that had to defer its probes because
>   of the device probe order.
> 
> Tomeu Vizoso (22):
>   driver core: handle -EPROBE_DEFER from bus_type.match()
>   ARM: amba: Move reading of periphid to amba_match()
>   of/platform: Point to struct device from device node
>   of: add function to allow probing a device from a OF node
>   gpio: Probe GPIO drivers on demand
>   gpio: Probe pinctrl devices on demand
>   regulator: core: Remove regulator_list
>   regulator: core: Probe regulators on demand
>   drm: Probe panels on demand
>   drm/tegra: Probe dpaux devices on demand
>   i2c: core: Probe i2c adapters and devices on demand
>   pwm: Probe PWM chip devices on demand
>   backlight: Probe backlight devices on demand
>   usb: phy: Probe phy devices on demand
>   clk: Probe clk providers on demand
>   pinctrl: Probe pinctrl devices on demand
>   phy: core: Probe phy providers on demand
>   dma: of: Probe DMA controllers on demand
>   power-supply: Probe power supplies on demand
>   driver core: Allow deferring probes until late init
>   driver core: Start processing deferred probes earlier
>   of/platform: Defer probes of registered devices
> 
>  drivers/amba/bus.c                  |  88 ++++++------
>  drivers/base/Kconfig                |  18 +++
>  drivers/base/dd.c                   |  35 ++++-
>  drivers/clk/clk.c                   |   3 +
>  drivers/dma/of-dma.c                |   3 +
>  drivers/gpio/gpiolib-of.c           |   5 +
>  drivers/gpu/drm/drm_panel.c         |   3 +
>  drivers/gpu/drm/tegra/dpaux.c       |   3 +
>  drivers/i2c/i2c-core.c              |   4 +
>  drivers/of/device.c                 |  61 +++++++++
>  drivers/of/platform.c               |  30 +++--
>  drivers/phy/phy-core.c              |   3 +
>  drivers/pinctrl/devicetree.c        |   3 +
>  drivers/power/power_supply_core.c   |   3 +
>  drivers/pwm/core.c                  |   3 +
>  drivers/regulator/core.c            | 257 +++++++++++++++++++++++-------------
>  drivers/usb/phy/phy.c               |   3 +
>  drivers/video/backlight/backlight.c |   3 +
>  include/linux/device.h              |   4 +-
>  include/linux/of.h                  |   1 +
>  include/linux/of_device.h           |   3 +
>  21 files changed, 386 insertions(+), 150 deletions(-)
> 
