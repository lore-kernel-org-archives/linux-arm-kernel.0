From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:10 +0200
Subject: [PATCH 00/13] Discover and probe dependencies
Message-ID: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is another attempt at preventing deferred probe from obscuring why your
devices aren't probing and from delaying to the end of the boot process the
probe of the device you care the most.

The major differences with my previous approach [0] are:

* Dependencies are probed before the target is probed, so we don't have nested
  probe() calls, avoiding a series of deadlock situations.

* Dependencies could be stored and reused for other purposes such as for
  passing resources to drivers ala devm_probe, or for warning when a device is
  going to be unbound and has dependencies active, etc.

* I have tried to keep it firmware-agnostic. The previous approach (on-demand
  probing) could be done like this as well, but would require adding fwnode
  APIs to all affected subsystems first.

I have only implemented the class.get_dependencies() callback for the GPIO
subsystem and for the host1x bus because that's all that was needed on my Tegra
Chromebook to avoid deferred probes, but if this approach is deemed worthwhile
I will add more implementations so that deferred probes are avoided on the
other boards I have access to.

[0] http://thread.gmane.org/gmane.linux.kernel.gpio/8465

Thanks,

Tomeu

Tomeu Vizoso (13):
  gpiolib: Fix docs for gpiochip_add_pingroup_range
  driver-core: defer all probes until late_initcall
  ARM: tegra: Add gpio-ranges property
  pinctrl: tegra: Only set the gpio range if needed
  driver core: fix docbook for device_private.device
  of/platform: Set fwnode field for new devices
  driver-core: Add class.get_dependencies() callback
  gpio: sysfs: implement class.get_dependencies()
  gpu: host1x: implement class.get_dependencies()
  driver-core: add for_each_class()
  device property: add fwnode_get_parent()
  device property: add fwnode_get_name()
  driver-core: probe dependencies before probing

 arch/arm/boot/dts/tegra114.dtsi |   1 +
 arch/arm/boot/dts/tegra124.dtsi |   1 +
 arch/arm/boot/dts/tegra20.dtsi  |   1 +
 arch/arm/boot/dts/tegra30.dtsi  |   1 +
 drivers/base/base.h             |   4 +-
 drivers/base/class.c            |  16 +++++
 drivers/base/dd.c               | 128 +++++++++++++++++++++++++++++++++++++++-
 drivers/base/property.c         |  38 ++++++++++++
 drivers/gpio/gpiolib-sysfs.c    |  81 +++++++++++++++++++++++++
 drivers/gpio/gpiolib.c          |   2 +-
 drivers/gpu/host1x/dev.c        |  47 +++++++++++++++
 drivers/of/platform.c           |   1 +
 drivers/pinctrl/pinctrl-tegra.c |  19 +++++-
 include/acpi/acpi_bus.h         |   5 ++
 include/linux/acpi.h            |   5 ++
 include/linux/device.h          |   6 ++
 include/linux/fwnode.h          |   5 ++
 include/linux/property.h        |   4 ++
 18 files changed, 361 insertions(+), 4 deletions(-)

-- 
2.4.1
