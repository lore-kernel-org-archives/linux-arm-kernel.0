From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:11:37 +0200
Subject: [PATCH v3 0/18] On-demand device probing
Message-ID: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a problem with the panel on my Tegra Chromebook taking longer
than expected to be ready during boot (St?phane Marchesin reported what
is basically the same issue in [0]), and have looked into ordered
probing as a better way of solving this than moving nodes around in the
DT or playing with initcall levels and linking order.

While reading the thread [1] that Alexander Holler started with his
series to make probing order deterministic, it occurred to me that it
should be possible to achieve the same by probing devices as they are
referenced by other devices.

This basically reuses the information that is already implicit in the
probe() implementations, saving us from refactoring existing drivers or
adding information to DTBs.

During review of v1 of this series Linus Walleij suggested that it
should be the device driver core to make sure that dependencies are
ready before probing a device. I gave this idea a try [2] but Mark Brown
pointed out to the logic duplication between the resource acquisition
and dependency discovery code paths (though I think it's fairly minor).

To address that code duplication I experimented with Arnd's devm_probe
[3] concept of having drivers declare their dependencies instead of
acquiring them during probe, and while it worked [4], I don't think we
end up winning anything when compared to just probing devices on-demand
from resource getters.

One remaining objection is to the "sprinkling" of calls to
fwnode_ensure_device() in the resource getters of each subsystem, but I
think it's the right thing to do given that the storage of resources is
currently subsystem-specific.

We could avoid the above by moving resource storage into the core, but I
don't think there's a compelling case for that.

I have tested this on boards with Tegra, iMX.6, Exynos and OMAP SoCs,
and these patches were enough to eliminate all the deferred probes
(except one in PandaBoard because omap_dma_system doesn't have a
firmware node as of yet).

Have submitted a branch [5] with these patches to kernelci.org and I'm
currently trying to fix all regressions, usually due to code assuming
that devices will be probed in a specific order. Current results [6] are
348 passes, 30 fails and 42 unknowns (linux-next [7] is currently
387/3/23).

With this series I get the kernel to output to the panel in 0.5s,
instead of 2.8s.

Regards,

Tomeu

[0] http://lists.freedesktop.org/archives/dri-devel/2014-August/066527.html

[1] https://lkml.org/lkml/2014/5/12/452

[2] https://lkml.org/lkml/2015/6/17/305

[3] http://article.gmane.org/gmane.linux.ports.arm.kernel/277689

[4] https://lkml.org/lkml/2015/7/21/441a

[5] https://git.collabora.com/cgit/user/tomeu/linux.git/log/?h=on-demand-probes-v5

[6] http://kernelci.org/boot/all/job/collabora/kernel/v4.2-rc5-6548-g632b98c83840/

[7] http://kernelci.org/boot/all/job/next/kernel/next-20150806/

Changes in v3:
- Only delay platform devices with OF nodes
- Set and use device_node.platform_dev instead of reversing the logic to
  find the platform device that encloses a device node.
- Drop the fwnode API to probe firmware nodes and add OF-only API for
  now. I think this same scheme could be used for machines with ACPI,
  but I haven't been able to find one that had to defer its probes because
  of the device probe order.
- Avoid unlocking the regulator device's mutex if we don't have a device

Changes in v2:
- Move delay to platform.c
- Acquire regulator device lock before returning from regulator_dev_lookup()

Tomeu Vizoso (18):
  platform: delay OF device-driver matches until late_initcall
  of/platform: add of_platform_probe
  gpio: Probe GPIO drivers on demand
  gpio: Probe pinctrl devices on demand
  regulator: core: Reduce critical area in _regulator_get
  regulator: core: Probe regulators on demand
  drm: Probe panels on demand
  drm/tegra: Probe dpaux devices on demand
  i2c: core: Probe i2c adapters and devices on demand
  pwm: Probe PWM chip devices on demand
  backlight: Probe backlight devices on demand
  usb: phy: Probe phy devices on demand
  clk: Probe clk providers on demand
  pinctrl: Probe pinctrl devices on demand
  phy: core: Probe phy providers on demand
  dma: of: Probe DMA controllers on demand
  power-supply: Probe power supplies on demand
  ASoC: core: Probe components on demand

 drivers/base/platform.c             |  29 ++++++++++
 drivers/clk/clk.c                   |   3 +
 drivers/dma/of-dma.c                |   3 +
 drivers/gpio/gpiolib-of.c           |   5 ++
 drivers/gpu/drm/drm_panel.c         |   3 +
 drivers/gpu/drm/tegra/dpaux.c       |   3 +
 drivers/i2c/i2c-core.c              |   5 ++
 drivers/of/platform.c               |  61 +++++++++++++++++++++
 drivers/phy/phy-core.c              |   3 +
 drivers/pinctrl/devicetree.c        |   3 +
 drivers/power/power_supply_core.c   |   3 +
 drivers/pwm/core.c                  |   3 +
 drivers/regulator/core.c            | 106 +++++++++++++++++++++---------------
 drivers/usb/phy/phy.c               |   3 +
 drivers/video/backlight/backlight.c |   3 +
 include/linux/of.h                  |   1 +
 include/linux/of_platform.h         |   2 +
 sound/soc/soc-core.c                |   7 ++-
 18 files changed, 200 insertions(+), 46 deletions(-)

-- 
2.4.3
